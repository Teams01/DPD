import { Component, OnInit } from "@angular/core";
import Chart from "chart.js";
import { AuthService } from "../services/auth.service";
import { NgbModal, NgbModalConfig } from "@ng-bootstrap/ng-bootstrap";
import { FormBuilder, FormGroup, Validators } from "@angular/forms";
import { Router } from "@angular/router";
import { HttpClient,HttpHeaders  } from '@angular/common/http';
// core components
import {
  chartOptions,
  parseOptions,
  chartExample1,
  chartExample2,
} from "../../variables/charts";

@Component({
  selector: "app-dashboard",
  templateUrl: "./dashboard.component.html",
  styleUrls: ["./dashboard.component.scss"],
  providers: [NgbModalConfig, NgbModal],
})
export class DashboardComponent  {

  repoUrl: string = '';
  result: any;
  loading: boolean = false; // Variable de chargement
  error: string = ''; // Message d'erreur
  state: 'idle' | 'cloning' | 'analyzing' | 'generating' | 'complete' = 'idle'; // State pour suivre les étapes



  constructor(private apiService: AuthService) {}

  // Ajoute un en-tête d'autorisation avec le JWT
  private createAuthorizationHeader(): HttpHeaders | null {
    const jwtToken = localStorage.getItem("jwt");
    if (jwtToken) {
      console.log("JWT token found in local storage:", jwtToken);
      return new HttpHeaders({
        "Authorization": `Bearer ${jwtToken}`,
        "Content-Type": "text/plain"
      });
    } else {
      console.log("JWT token not found in local storage.");
      return null;
    }
  }
  
  analyzeRepo( repo) {
    this.state = 'cloning'; // Changer l'état à 'cloning'
    this.loading = true; // Activer le chargement
    this.error = ''; // Réinitialiser les erreurs précédentes
    if (this.repoUrl.trim() === '') {
      alert('Veuillez entrer une URL valide du dépôt GitHub.');
      return;
    }

    this.apiService.analyzeRepo(repo).subscribe(
      (data) => {
        this.state = 'analyzing'; // Changer à 'analyzing' après clonage
        setTimeout(() => {
          this.result = data; // Stocker le résultat après clonage et analyse
          this.state = 'generating'; // Changer à 'generating' après l'analyse
          setTimeout(() => {
            this.state = 'complete'; // Étape finale
          }, 5000); // 5 secondes après génération pour montrer le message "Terminé"
        }, 10000); // Attendre 10 secondes pour le clonage
        this.loading = false;
      },
      (error) => {
        this.loading = false;
        console.error('Erreur lors de l\'analyse du repo :', error);
      }
    );
  }


  

}
