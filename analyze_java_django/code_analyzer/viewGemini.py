import os
import shutil
import git
import glob
import google.generativeai as genai
from rest_framework.decorators import api_view
from rest_framework.response import Response
import stat

# Configurer Gemini
def configure_gemini(api_key):
    genai.configure(api_key=api_key)
    generation_config = {
        "temperature": 0.7,
        "top_p": 1,
        "top_k": 1,
        "max_output_tokens": 2048,
    }
    return genai.GenerativeModel(model_name="gemini-pro", generation_config=generation_config)

def clone_github_repo(repo_url, target_dir="C:/Temp/temp_repo"):
    """Clone un dépôt GitHub"""
    if os.path.exists(target_dir):
        shutil.rmtree(target_dir)
    git.Repo.clone_from(repo_url, target_dir)
    return target_dir

def find_java_files(directory):
    """Trouve tous les fichiers Java dans un répertoire donné, en ignorant les fichiers non pertinents."""
    java_files = []
    for root, _, files in os.walk(directory):
        for file in files:
            # Inclure uniquement les fichiers Java
            if file.endswith(".java"):
                java_files.append(os.path.join(root, file))
    return java_files

def read_java_file(file_path):
    """Lire le contenu d'un fichier Java"""
    with open(file_path, 'r', encoding='utf-8') as file:
        return file.read()


def analyze_java_code(model, java_code, file_name):
    """Analyser un fichier Java pour recommander des patrons de conception adaptés"""
    # Instruction pour le modèle AI
    prompt = f"""
    Analyser ce code Java provenant du fichier '{file_name}' et identifier les problèmes récurrents tels que le couplage élevé, la duplication de code, et d'autres antipatterns courants.
    Proposez ensuite des patrons de conception appropriés pour résoudre ces problèmes.

    {java_code}

    Veuillez :
    1. Identifier les problèmes récurrents (par exemple : couplage élevé, duplication de code, etc.).
    2. Proposer un ou plusieurs patrons de conception pour chaque problème identifié.
    3. Fournir une explication brève pour chaque patron de conception proposé.
    4. Mentionner le nom du fichier analysé et le code généré.
    """

    # Appel au modèle pour obtenir des recommandations
    response = model.generate_content(prompt)
    return response.text
def remove_git_metadata(directory):
    """Supprime les fichiers Git inutiles pour l'analyse."""
    git_metadata = ['.git']
    for root, dirs, files in os.walk(directory):
        for dir_name in dirs:
            if dir_name in git_metadata:
                shutil.rmtree(os.path.join(root, dir_name), ignore_errors=True)


def ensure_permissions(directory):
    """
    Assure que tous les fichiers et dossiers dans le répertoire donné ont des permissions suffisantes
    pour être lus et écrits par l'application.
    """
    for root, dirs, files in os.walk(directory):
        # Vérifier les permissions des dossiers
        for dir_name in dirs:
            dir_path = os.path.join(root, dir_name)
            try:
                os.chmod(dir_path, stat.S_IRWXU)  # Lecture, écriture, exécution pour l'utilisateur
            except Exception as e:
                print(f"Impossible de modifier les permissions du dossier {dir_path}: {e}")

        # Vérifier les permissions des fichiers
        for file_name in files:
            file_path = os.path.join(root, file_name)
            try:
                os.chmod(file_path, stat.S_IRWXU)  # Lecture, écriture, exécution pour l'utilisateur
            except Exception as e:
                print(f"Impossible de modifier les permissions du fichier {file_path}: {e}")
@api_view(['POST'])
def analyze_repo(request):
    """API REST pour analyser un dépôt GitHub"""
    try:
        # Récupérer les données
        repo_url = request.data.get("repo_url")
        api_key = "AIzaSyC5EpVbNhZ3KIYRQXHSozpqE6IlGzRpXNE"

        if not repo_url or not api_key:
            return Response({"error": "L'URL du dépôt et l'API Key sont requises."}, status=400)

        # Configurer le modèle Gemini
        model = configure_gemini(api_key)

        # Cloner le dépôt
        repo_dir = clone_github_repo(repo_url)

        # Supprimer les métadonnées Git non nécessaires
        remove_git_metadata(repo_dir)

        # S'assurer des permissions
        ensure_permissions(repo_dir)

        # Analyser les fichiers Java
        java_files = find_java_files(repo_dir)
        results = []

        for file_path in java_files:
            try:
                java_code = read_java_file(file_path)
                relative_path = os.path.relpath(file_path, repo_dir)
                analysis = analyze_java_code(model, java_code, relative_path)
                results.append({"file_name": relative_path, "analysis": analysis})
            except Exception as e:
                results.append({"file_name": file_path, "error": f"Ignoré : {str(e)}"})
                print(f"Erreur ignorée pour le fichier {file_path}: {e}")

        # Nettoyer les fichiers temporaires
        shutil.rmtree(repo_dir, ignore_errors=True)

        return Response({
            "repo_url": repo_url,
            "file_count": len(java_files),
            "results": results,
        })

    except Exception as e:
        return Response({"error": str(e)}, status=500)
