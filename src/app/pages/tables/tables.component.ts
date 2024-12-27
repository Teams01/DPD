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
  selector: 'app-tables',
  templateUrl: './tables.component.html',
  styleUrls: ['./tables.component.scss'],
  providers: [NgbModalConfig, NgbModal],

})
export class TablesComponent  {

  javaCode: string = '';
  responseMessage: string = '';
  recommendations: any[] = [];
  generatedCode: string = '';
  errorMessage: string = '';
  generatedCodeCoupling :string = '';

  constructor(private http: HttpClient) {}

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

  analyzeCode() {
    if (!this.javaCode.trim()) {
      this.errorMessage = "Please provide valid Java code.";
      this.recommendations = [];
      return;
    }
  
    this.errorMessage = '';
    const analyzeUrl = 'http://localhost:8080/api/analyze-java-code'; // API Spring pour analyser
    const headers = this.createAuthorizationHeader();
  
    if (!headers) {
      this.errorMessage = "Authorization header not set. Please log in.";
      return;
    }
  
    // Envoyer un objet JSON avec la clé "java_code"
    const requestBody = { java_code: this.javaCode };
  
    this.http.post<any>(analyzeUrl, requestBody, { headers })
      .subscribe({
        next: (response) => {
          this.responseMessage = response.status;
          this.recommendations = response.recommendations || [];
          this.generatedCode = ''; // Clear generated code on new analysis
          this.generatedCodeCoupling='';
        },
        error: (error) => {
          this.errorMessage = error.error?.message || 'An error occurred while analyzing the Java code.';
          this.recommendations = [];
        }
      });
  }
  
  generateCode() {
    if (!this.javaCode.trim()) {
      this.errorMessage = "Please provide valid Java code.";
      this.generatedCode = '';
      return;
    }
  
    this.errorMessage = '';
    const generateUrl = 'http://localhost:8080/api/generate-java-pattern'; // API Spring pour générer
    const headers = this.createAuthorizationHeader();
  
    if (!headers) {
      this.errorMessage = "Authorization header not set. Please log in.";
      return;
    }
  
    // Envoyer un objet JSON avec la clé "java_code"
    const requestBody = { java_code: this.javaCode };
  
    this.http.post<any>(generateUrl, requestBody, { headers })
      .subscribe({
        next: (response) => {
          this.generatedCode = response.new_code || 'No code generated.';
          this.recommendations = []; // Clear recommendations on new generation
          this.generatedCodeCoupling='';
        },
        error: (error) => {
          this.errorMessage = error.error?.message || 'An error occurred while generating the Java code.';
          this.generatedCode = '';
        }
      });
  }



  detectCoupling() {
    if (!this.javaCode.trim()) {
      this.errorMessage = "Please provide valid Java code.";
      this.generatedCode = '';
      return;
    }
  
    this.errorMessage = '';
    const generateUrl = 'http://localhost:8080/api/analyze_coupling'; // API Spring pour générer
    const headers = this.createAuthorizationHeader();
  
    if (!headers) {
      this.errorMessage = "Authorization header not set. Please log in.";
      return;
    }
  
    // Envoyer un objet JSON avec la clé "java_code"
    const requestBody = { java_code: this.javaCode };
  
    this.http.post<any>(generateUrl, requestBody, { headers })
      .subscribe({
        next: (response) => {
          this.generatedCodeCoupling = response.dependencies || 'No code generated.';
          this.recommendations = []; // Clear recommendations on new generation
          this.generatedCode=""
        },
        error: (error) => {
          this.errorMessage = error.error?.message || 'An error occurred while detect coupling in the Java code.';
          this.generatedCode = '';
          this.generatedCodeCoupling ='';
        }
      });
  }

}
