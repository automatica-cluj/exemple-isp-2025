# Documentație Azure Container Apps

## Introducere

Azure Container Apps este un serviciu serverless complet gestionat de Microsoft Azure pentru implementarea aplicațiilor containerizate. Acest serviciu elimină necesitatea gestionării infrastructurii subiacente sau a orchestrării containerelor, permițând dezvoltatorilor să se concentreze pe codul aplicației.

### Caracteristici principale

- **Arhitectură serverless** - scalare automată de la 0 la N instanțe, plătind doar pentru resursele utilizate efectiv
- **Integrare cu tehnologii open-source** - KEDA pentru scalare bazată pe evenimente, Dapr pentru microservicii
- **Revizii multiple** - posibilitatea de a rula versiuni diferite ale aplicației simultan
- **Rețelistică avansată** - suport pentru rețele virtuale personalizate și service discovery
- **Monitorizare integrată** - cu Azure Log Analytics pentru diagnosticare și depanare

## Implementarea aplicațiilor în Azure Container Apps

În secțiunile următoare, vom prezenta abordarea pentru implementarea unei aplicații în Azure Container Apps utilizând GitHub Actions pentru CI/CD și Docker pentru containerizare. Vom analiza un exemplu concret al unei aplicații de tip quiz, detaliind fluxul complet de la build până la deploy în Azure.

Aplicatia este disponibila de asemenea si [aici](https://github.com/automatica-cluj/isp-quiz-game) 


## Arhitectura aplicației

Aplicația de exemplu este un joc de tip quiz unde utilizatorul are un timp limitat pentru a răspunde la întrebări. Jocul se încheie când utilizatorul greșește sau când timpul expiră.

Aplicația de quiz prezentată în această documentație este în mod intenționat simplificată din perspectiva persistenței datelor. În loc să utilizeze un sistem de persistență complex și scalabil, cum ar fi o bază de date relațională (MySQL, PostgreSQL) sau NoSQL (MongoDB, Cosmos DB), aplicația folosește fișiere text simple pentru stocarea informațiilor.

Această abordare are următoarele implicații:

1. **Întrebările quiz-ului** sunt încărcate din fișierul `questions.txt` amplasat în resursele aplicației
2. **Clasamentul jucătorilor** este stocat în fișierul `leaderboard_data.txt`
3. **Datele completate** ale quiz-urilor finalizate sunt gestionate în memorie cu backup în fișierele text

Este important de menționat că această arhitectură simplificată este adecvată pentru un mediu demonstrativ sau educațional, dar nu ar fi recomandată pentru o aplicație de producție cu multe date sau mulți utilizatori concurenți. Într-un scenariu real, ar trebui:

- Implementată o bază de date adecvată (SQL sau NoSQL)
- Adăugate mecanisme de caching pentru performanță
- Implementate strategii de backup și recuperare
- Configurată o scalare corectă a layer-ului de persistență

Această simplificare a fost aleasă pentru a păstra focusul pe demonstrarea conceptelor de containerizare, CI/CD și deployment în Azure Container Apps, fără a complica arhitectura cu aspecte ce țin de persistența datelor.

### Structura generală

- **Backend**: Aplicația este construită cu Java 21 utilizând framework-ul Spring Boot, punctul principal de intrare fiind clasa `QuizApplication.java`.
- **Pattern MVC**: Proiectul urmează modelul Model-View-Controller:
    - **Model**: Clase precum `Question`, `QuizGame` și `User` reprezintă structurile de date principale
    - **View**: Template-uri HTML (ex. `index.html`, `quiz.html`, `gameOver.html`) pentru interfața utilizator
    - **Controller**: `QuizWebController` gestionează cererile HTTP și navigarea între pagini
- **Servicii**: Componente precum `QuizSessionService`, `Leaderboard` și `QuestionLoader` încapsulează logica de business
- **Persistență**: Întrebările și datele clasamentului sunt stocate în fișiere text

### Construcție și deployment

- **Maven**: Utilizat pentru construirea proiectului și gestionarea dependențelor
- **Docker**: Folosit pentru containerizare
- **GitHub Actions**: Configurate pentru CI/CD
- **Azure Container Apps**: Pentru găzduirea aplicației în cloud

## Proces de implementare în Azure Container Apps

Secțiunea de mai jos descrie pașii necesari pentru containerizarea și rularea aplicației în Azure Container Apps și se bazează pe următoarele dependențe și presupuneri:
- Aplicația este încărcată într-un repository GitHub public (funcționează și în varianta cu repository privat, dar în acest caz intervin mici modificări în comanda de lansare în execuție a containerului)
- Utilizatorul are un cont Azure activ cu o subscriere activă (pentru Universitatea Tehnică din Cluj-Napoca, contul Azure este disponibil pentru studenți)
- Utilizatorul are instalat Azure CLI pe calculatorul local

Detalierea pașilor de implementare este prezentată în secțiunea de mai jos, dar aceștia sunt disponibili și în repository-ul Git aferent aplicației [aici](https://github.com/automatica-cluj/isp-quiz-game).

Dacă doriți să replicați pașii, puteți crea un fork al repository-ului în contul vostru de GitHub. Atenție la eventuale "hardcodări" prezente în repository-ul original cu referire la contul 'automatica-cluj'.

### 1. Construirea aplicației cu Maven

Primul pas este compilarea aplicației Java folosind Maven:

```sh
./mvnw clean package
```

### 2. Construirea și rularea containerului Docker

Aplicația poate fi containerizată și rulată local folosind Docker Compose:

```sh
docker compose up --build 
```

După executarea acestei comenzi, aplicația este disponibilă la adresa [http://localhost:8888](http://localhost:8888).

### 3. Automatizare CI/CD cu GitHub Actions

Proiectul utilizează GitHub Actions pentru a construi automat o imagine Docker și a o publica în GitHub Container Registry (GHCR).

#### Funcționare

1. La fiecare push în branch-ul `main`, GitHub Actions execută un workflow definit în `.github/workflows/docker-ghcr.yml`
2. Workflow-ul:
    - Construiește imaginea Docker utilizând `Dockerfile`-ul proiectului
    - Se autentifică la GHCR folosind credențialele GitHub
    - Publică imaginea la `ghcr.io/<OWNER>/<REPO>:<TAG>`

După finalizarea cu succes a build-ului, imaginea este disponibilă la `ghcr.io/<OWNER>/<REPO>:latest` și poate fi vizualizată în interfața GHCR.

### 4. Deployment în Azure Container Apps (CLI)

Pentru a rula aplicația în Azure folosind Container Apps, se execută următoarele comenzi:

#### Crearea Grupului de Resurse
```bash
az group create --name cursIsp2025 --location westeurope
```

#### Crearea Mediului Container App
```bash
az containerapp env create --name my-quiz-env --resource-group cursIsp2025 --location westeurope
```

#### Crearea Aplicației Container
```bash
az containerapp create --name isp-quiz-app --resource-group cursIsp2025 --environment my-quiz-env --image ghcr.io/automatica-cluj/isp-quiz:latest --target-port 8888 --ingress external --transport http
```

#### Actualizarea Aplicației Container

Pentru a implementa o nouă versiune a imaginii container:

```sh
az containerapp update --name isp-quiz-app --resource-group cursIsp2025 --image ghcr.io/automatica-cluj/isp-quiz:latest
```

Alternativ, imaginea poate fi actualizată și aplicația repornită din portalul Azure folosind butonul de reîmprospătare.

#### Oprirea Aplicației Container

Oprirea și pornirea aplicației pot fi realizate prin intermediul dashboard-ului portalului Azure.

### 5. Economisirea costurilor

Pentru a evita generarea de costuri pentru resursele create, aplicația container poate fi oprită și grupul de resurse poate fi șters. Acest lucru se poate face din portalul Azure sau prin CLI.