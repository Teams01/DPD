# AI Design Pattern Detector(DPD): An Innovative Approach to Simplifying Software Design

## Authors
Hamza Lachiq, Ayoub Aloan, Nada Akoubri, Salma Lemjad, Fatim Ezzahra Zahir

## Abstract
This paper introduces an AI-powered tool designed to recommend software design patterns based on the structural and functional requirements of developers' code. By combining advanced code analysis with intelligent pattern suggestions, this tool enhances software architectural quality, streamlines the design process, and supports developers in making efficient design decisions.

---

## Keywords
Design Patterns, Code Analysis, AI Tools, Software Architecture, Code Optimization, JWT Authentication, Angular, Spring Boot, Django

---

## Introduction
Design patterns are a fundamental aspect of software engineering, offering reusable solutions to common problems in software design. Selecting the appropriate pattern, however, can be challenging and time-consuming. This project seeks to alleviate these challenges by leveraging AI and robust backend technologies to provide intelligent design pattern recommendations.

---

## Methodology

### System Overview
The proposed application is divided into three primary components:

1. **Backend Services:**
   - **Django Service:**
     - Performs comprehensive code analysis.
     - Generates design pattern recommendations tailored to the developer's input.
   - **Spring Boot Service:**
     - Implements code parsing through JavaParser.
     - Provides secure authentication mechanisms, including JWT and role-based access.

2. **Frontend Application:**
   - Built with Angular, the frontend offers an intuitive interface for:
     - Uploading and analyzing code.
     - Generating and visualizing design pattern recommendations.
     - Identifying potential design patterns required, such as Singleton, Factory, or Observer.

---

## Results

### Features and Functionality
The application offers the following key features:
- **Automated Code Analysis:** The backend services analyze code to identify structural inefficiencies.
- **Pattern Detection:** Recommendations for patterns such as Singleton, Factory, and Observer are provided.
- **User Authentication:** Secure access through JWT-based authentication and role management.
- **Interactive Interface:** The Angular-based frontend facilitates seamless interaction and pattern generation.

### Technology Stack
- **Backend Technologies:** Django (Python) and Spring Boot (Java)
- **Frontend Technology:** Angular (TypeScript)
- **Database:** MySQL
- **Security:** JSON Web Tokens (JWT)

---
# App structer
![image](https://github.com/user-attachments/assets/7fef4ca4-11a5-4af8-bb7b-2cc40a47dec3)

## Experimental Setup

### Prerequisites
- **Backend Requirements:**
  - Python 3.x for Django Service
  - Java 17+ for Spring Boot Service
  - MySQL database setup
- **Frontend Requirements:**
  - Node.js 18+
  - Angular CLI 15+

### Implementation

#### Setting Up the Backend

##### Django Service
1. Navigate to the Django service directory:
   ```bash
   cd backend/django_service
   ```
2. Create and activate a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate
   ```
3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
4. Apply database migrations:
   ```bash
   python manage.py migrate
   ```
5. Start the Django server:
   ```bash
   python manage.py runserver
   ```

##### Spring Boot Service
1. Navigate to the Spring Boot service directory:
   ```bash
   cd backend/spring_service
   ```
2. Build and start the service:
   ```bash
   ./mvnw spring-boot:run
   ```

#### Setting Up the Frontend
1. Navigate to the Angular app directory:
   ```bash
   cd frontend
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Start the development server:
   ```bash
   ng serve
   ```

---

## Discussion

### User Workflow
1. **Code Upload:** Users upload their code via the Angular interface.
2. **Pattern Selection:** The system analyzes the code and provides design pattern recommendations based on user selection.
3. **Feedback:** The frontend displays detailed suggestions, including examples of pattern implementations.

### Challenges and Limitations
- Current functionality is limited to three design patterns.
- Code analysis relies heavily on the quality and structure of the input code.

---

## Future Work
- Expansion to support additional design patterns.
- Advanced AI integration for detecting complex software architecture issues.
- Collaboration features for team-based code analysis and design.
- Enhanced API integration for seamless tool interoperability.

---

## Conclusion
This AI-driven tool bridges the gap between code analysis and design pattern implementation. By integrating cutting-edge technologies across backend and frontend platforms, it empowers developers to optimize their software architecture efficiently and effectively.

---

## References
1. Gamma, E., Helm, R., Johnson, R., & Vlissides, J. (1994). *Design Patterns: Elements of Reusable Object-Oriented Software*.
2. Freeman, E., & Robson, E. (2004). *Head First Design Patterns*.
3. Fowler, M. (2002). *Patterns of Enterprise Application Architecture*.

