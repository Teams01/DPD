from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json
from .analyze_code import JavaCodeAnalyzer
import logging

# Configure logging
logger = logging.getLogger(__name__)

@csrf_exempt
def analyze_java_code(request):
    if request.method != 'POST':
        return JsonResponse(
            {"status": "error", "message": "Invalid request method."},
            status=405
        )

    try:
        # Parse JSON request body
        data = json.loads(request.body)
        java_code = data.get('java_code', '').strip()

        if not java_code:
            return JsonResponse(
                {"status": "error", "message": "No Java code provided."},
                status=400
            )

        # Analyze Java code
        analyzer = JavaCodeAnalyzer(java_code)
        recommendations = analyzer.recommend_patterns()

        # Return successful response
        return JsonResponse(
            {"status": "success", "recommendations": recommendations},
            status=200
        )

    except json.JSONDecodeError:
        logger.error("Invalid JSON format in request.")
        return JsonResponse(
            {"status": "error", "message": "Invalid JSON format."},
            status=400
        )
    except ValueError as e:
        logger.error(f"ValueError during analysis: {str(e)}")
        return JsonResponse(
            {"status": "error", "message": str(e)},
            status=400
        )
    except Exception as e:
        logger.exception("Unexpected error during Java code analysis.")
        return JsonResponse(
            {"status": "error", "message": "An unexpected error occurred."},
            status=500
        )

@csrf_exempt
def generate_java_classes(request):
    if request.method != 'POST':
        return JsonResponse(
            {"status": "error", "message": "Invalid request method."},
            status=405
        )

    try:
        data = json.loads(request.body)
        java_code = data.get('java_code', '').strip()

        if not java_code:
            return JsonResponse(
                {"status": "error", "message": "No Java code provided."},
                status=400
            )

        analyzer = JavaCodeAnalyzer(java_code)
        new_code = analyzer.generate_classes_based_on_patterns()

        return JsonResponse(
            {"status": "success", "new_code": new_code},
            status=200
        )

    except json.JSONDecodeError:
        logger.error("Invalid JSON format in request.")
        return JsonResponse(
            {"status": "error", "message": "Invalid JSON format."},
            status=400
        )
    except ValueError as e:
        logger.error(f"ValueError during analysis: {str(e)}")
        return JsonResponse(
            {"status": "error", "message": str(e)},
            status=400
        )
    except Exception as e:
        logger.exception("Unexpected error during Java code generation.")
        return JsonResponse(
            {"status": "error", "message": "An unexpected error occurred."},
            status=500
        )
