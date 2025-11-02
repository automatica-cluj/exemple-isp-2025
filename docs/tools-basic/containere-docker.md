# Containere Docker

## Introducere

**Docker** este un instrument care permite crearea, rularea și gestionarea aplicațiilor în containere – unități izolate care includ tot ce este necesar pentru ca aplicația să funcționeze (cod, biblioteci, runtime etc.). Acest lucru asigură portabilitate, consistență și eficiență în dezvoltare și testare.

**Docker Compose** este un instrument complementar care permite definirea și rularea unor aplicații multi-container. Cu ajutorul unui fișier YAML, se pot configura și porni simultan mai multe servicii (de exemplu: aplicație backend, bază de date, cache) într-un mod organizat și repetabil.

Într-un mediu de producție, pe lângă Docker și Docker Compose, sunt utilizate și alte unelte avansate precum Kubernetes (pentru orchestrarea containerelor), Helm (pentru managementul aplicațiilor Kubernetes), sau sistemele de monitorizare și logare precum Prometheus și Grafana. Totuși, Docker și Docker Compose reprezintă un punct de pornire minim și necesar pentru a înțelege mecanismele de bază ale containerizării și rulării serviciilor distribuite.

Pașii descriși mai jos au fost testați și validați pe o mașină virtuală Ubuntu găzduită în Azure. Pentru a crea o astfel de masina urmati pasii de aici: [azure-resources.md](azure-resources.md)

## Instalare Docker și Docker Compose

Pasii de instalare Docker și Docker Compose sunt similari pe majoritatea sistemelor de operare, dar pot varia ușor în funcție de distribuția Linux utilizată. În acest ghid, ne vom concentra pe instalarea Docker și Docker Compose pe Ubuntu 22.04 LTS. Pentru detalii cu privire la instalarea Docker pe alte sisteme de operare, consultați documentația oficială Docker: [Docker Installation](https://docs.docker.com/get-docker/).

Acesti pasi vor fi executati din linia de comanda (terminal) a sistemului de operare Ubuntu. Pentru a accesa terminalul executa comanda ssh:

```bash
ssh azureuser@<IP_PUBLIC_VM>
```

### 1. Instalare Docker

Execută comanda pentru instalarea Docker utilizând managerul de pachete Snap:

```bash
sudo snap install docker
```

Această comandă instalează ultima versiune stabilă Docker disponibilă prin Snap.

### 2. Actualizare Repository Ubuntu

Asigură-te că lista pachetelor disponibile este actualizată:

```bash
sudo apt-get update
```

### 3. Instalare Docker Compose (manual)

Dacă Docker Compose nu este disponibil prin repository-uri, se poate instala manual utilizand următoarele comenzi:

```bash
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.35.1/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
```

Aceste comenzi descarcă și configurează Docker Compose pentru a putea fi utilizat.

### 4. Verificare Instalare Docker Compose

Pentru a confirma instalarea cu succes, execută:

```bash
docker compose version
```

Aceasta afișează versiunea instalată de Docker Compose, confirmând instalarea cu succes.

### 5. Rulare aplicatiei de test

Pentru testarea mașinii virtuale configurate cu Docker și Docker Compose, vom utiliza aplicația creată pentru ilustrarea modului de lucru cu GitHub Actions, descrisă în fișierul `github-actions.md`. Repository-ul corespunzător este [automatica-cluj/demo-simple-app](https://github.com/automatica-cluj/demo-simple-app). Vom efectua următorii pași:

1. **Clonarea aplicației local**:
   - Clonăm repository-ul `demo-simple-app` pe mașina locală.

    ```bash
   git clone https://github.com/automatica-cluj/demo-simple-app.git 
   cd demo-simple-app
    ```

2. **Copierea fișierului `docker-compose.yaml` pe VM** si lansarea aplicatiei:

Creați un director pe mașina virtuală pentru a stoca fișierele aplicației:
```bash
ssh azureuser@<IP_PUBLIC_VM> "mkdir -p ~/demo-simple-app"
```

Copiați fișierul `docker-compose.yaml` de pe mașina locală pe mașina virtuală (inclocuiti path-ul corespunzator):
```bash
scp c:\\UTCN\\tmp\\demo-simple-app\\docker-compose.yaml azureuser@<IP_PUBLIC_VM>:~/demo-simple-app/
```

Conectați-vă la mașina virtuală:
```bash
ssh azureuser@<IP_PUBLIC_VM>
```

Navigați la directorul aplicației și porniți aplicația folosind Docker Compose:
```bash
cd ~/demo-simple-app 
docker compose up -d
```

3**Testarea aplicației**:

Deschidem un browser și accesăm endpoint-ul aplicației (ex. `http://<IP_PUBLIC_VM>:8080/hello`) pentru a verifica funcționarea corectă.

## Utilizarea imaginilor Docker din GitHub Container Registry (GHCR)

Clarificari cu privire la utilizarea imaginilor Docker din GitHub Container Registry (GHCR) și vizibilitatea acestora.

GitHub Container Registry (GHCR) este un serviciu care permite stocarea și gestionarea imaginilor Docker direct în GitHub. Acesta oferă o modalitate simplă de a partaja imagini între diferite proiecte și echipe, facilitând colaborarea și reutilizarea codului.

Proiectul `automatica-cluj/demo-simple-app` utilizează GitHub Container Registry (GHCR) pentru a stoca imaginile Docker. Acest lucru permite utilizarea ușoară a imaginilor Docker. Detalii cu privire la structura proiectului si modul de generare a acestei imagini sunt disponibile aici: [github-actions.md](github-actions.md)

### Vizibilitatea imaginilor Docker în GitHub

În exemplul nostru, depozitul `automatica-cluj/demo-simple-app` conține o imagine Docker care poate fi utilizată cu Docker Compose. Este important de menționat că, deși un depozit GitHub poate fi public, imaginile Docker publicate în GitHub Container Registry (GHCR) asociate acestui depozit sunt private în mod implicit. Această diferență de vizibilitate poate cauza probleme atunci când încercați să descărcați (pull) imaginea utilizând comanda `docker compose up`.

Pentru a utiliza cu succes imaginea Docker dintr-un depozit GHCR, aveți două opțiuni principale: să faceți imaginea publică (dacă aveți drepturi de administrare) sau să utilizați un token personal de acces (PAT) pentru autentificare. Secțiunile următoare vă explică pașii necesari pentru ambele abordări.

### Crearea unei imagini publice în GitHub Container Registry (GHCR)

Pentru a face publică imaginea din GitHub Container Registry, urmați acești pași:

#### 1. Accesați Depozitul GitHub
1. Navigați la depozitul GitHub care conține imaginea containerului (în acest caz, depozitul care găzduiește `automatica-cluj/demo-simple-app`)

2. Faceți clic pe fila **Packages** (Pachete) din bara de navigare a depozitului

#### 2. Configurați vizibilitatea pachetului
1. Faceți clic pe numele pachetului (`demo-simple-app`)
2. Pe pagina pachetului, faceți clic pe butonul **Package settings** (Setări pachet) (de obicei în partea dreaptă)
3. Derulați în jos până la secțiunea **Danger Zone** (Zonă periculoasă)
4. Găsiți opțiunea **Change visibility** (Modificare vizibilitate) și faceți clic pe butonul **Change visibility**
5. Selectați **Public** și confirmați alegerea

#### 3. Confirmați accesul public
După ce faceți pachetul public:
1. Oricine va putea descărca imaginea fără autentificare
2. Imaginea va fi vizibilă în rezultatele căutării GitHub
3. Pagina pachetului va arăta că este disponibil public

### Alternativă: Utilizați un token personal de acces GitHub

Dacă nu aveți permisiunea de a face depozitul public, dar trebuie să-l utilizați oricum:
1. Creați un token personal de acces GitHub cu permisiunea `read:packages`
2. Autentificați-vă în Docker cu:
   ```bash
   echo TOKEN_GITHUB_PERSONAL | docker login ghcr.io -u NUME_UTILIZATOR_GITHUB --password-stdin
   ```
3. Apoi încercați să rulați din nou comanda `docker compose up`

Dacă nu sunteți proprietarul depozitului, va trebui să contactați proprietarul depozitului pentru a face pachetul public sau pentru a vă oferi tokenul de acces necesar.





