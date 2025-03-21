---
layout: default
title: Introduction to Git
---

# Git: Esențial în Dezvoltarea Software Modernă

## Ce este Git?

Git este un sistem de control al versiunilor distribuit, creat de Linus Torvalds în 2005. Este proiectat pentru a gestiona proiecte de orice dimensiune cu viteză și eficiență.

## Concepte fundamentale

- **Repository (repo)**: Locul unde sunt stocate toate fișierele și istoricul proiectului
- **Commit**: O înregistrare a modificărilor făcute la fișierele din repository
- **Branch**: O linie independentă de dezvoltare
- **Merge**: Combinarea modificărilor din două branch-uri diferite
- **Clone**: Copierea unui repository de la distanță pe calculatorul local
- **Push**: Trimiterea modificărilor locale către repository-ul de la distanță
- **Pull**: Preluarea modificărilor din repository-ul de la distanță
- **Fork**: Copierea unui repository pentru a face modificări proprii

## De ce este Git util?

### 1. Istoricul complet al modificărilor
- Fiecare schimbare este înregistrată și poate fi consultată oricând
- Posibilitatea de a reveni la versiuni anterioare ale proiectului
- Înțelegerea evoluției proiectului în timp

### 2. Lucrul în echipă
- Mulți dezvoltatori pot lucra simultan la același proiect
- Fiecare poate lucra independent, fără a afecta munca celorlalți
- Conflictele de cod sunt gestionate eficient

### 3. Ramificație și experimentare
- Crearea de branch-uri pentru testarea de noi funcționalități
- Dezvoltarea paralelă a mai multor funcționalități
- Izolarea modificărilor experimentale de codul stabil

### 4. Backup și siguranță
- Codul este stocat în mai multe locații (local și la distanță)
- Reducerea riscului de pierdere a codului
- Restaurarea facilă în caz de erori sau probleme

## Platforme bazate pe Git

- **GitHub**: Cea mai populară platformă pentru găzduirea proiectelor Git
- **GitLab**: O alternativă care oferă și CI/CD integrat
- **Bitbucket**: Popular pentru echipele mici și integrarea cu alte produse Atlassian

## Fluxul de lucru tipic cu Git

1. **Clone/Init**: Începerea unui proiect nou sau clonarea unuia existent
2. **Branch**: Crearea unui branch pentru o funcționalitate nouă
3. **Modificare**: Realizarea schimbărilor dorite în cod
4. **Stage**: Pregătirea modificărilor pentru commit
5. **Commit**: Salvarea modificărilor în repository
6. **Push**: Trimiterea modificărilor către repository-ul de la distanță
7. **Pull Request/Merge Request**: Solicitarea integrării modificărilor în branch-ul principal
8. **Review**: Verificarea codului de către colegii de echipă
9. **Merge**: Combinarea modificărilor aprobate în branch-ul principal

## Comenzi Git esențiale

```bash
# Inițializarea unui repository
git init

# Clonarea unui repository
git clone URL_REPOSITORY

# Verificarea statusului
git status

# Adăugarea modificărilor
git add nume_fisier
git add .  # toate fișierele

# Salvarea modificărilor (commit)
git commit -m "Mesaj descriptiv"

# Crearea unui branch nou
git branch nume_branch
git checkout -b nume_branch  # creare și comutare

# Comutarea între branch-uri
git checkout nume_branch

# Trimiterea modificărilor (push)
git push origin nume_branch

# Preluarea modificărilor (pull)
git pull origin nume_branch

# Combinarea branch-urilor (merge)
git merge nume_branch
```

## Git vs. Alte sisteme de control al versiunilor

- **SVN (Subversion)**: Centralizat, mai puțin flexibil pentru branch-uri
- **Mercurial**: Similar cu Git, dar cu o complexitate mai redusă
- **CVS**: Mai vechi, cu limitări în gestionarea branch-urilor și rename-urilor

## Resurse pentru învățare

- [Git Official Documentation](https://git-scm.com/doc)
- [GitHub Learning Lab](https://lab.github.com/)
- [Atlassian Git Tutorials](https://www.atlassian.com/git/tutorials)
- Cărți: "Pro Git" de Scott Chacon și Ben Straub (disponibilă gratuit online) https://git-scm.com/book/en/v2


## Workflow Git într-o echipă reală - Scenariu practic

Să considerăm un scenariu concret: o echipă de 5 dezvoltatori lucrează la o aplicație web pentru gestionarea unui magazin online.

### Organizarea repository-ului

- **Branch principal**: `main` - conține codul stabil, gata de producție
- **Branch de dezvoltare**: `develop` - integrează toate funcționalitățile noi
- **Branch-uri de funcționalități**: `feature/nume-funcționalitate` - pentru dezvoltarea individuală
- **Branch-uri de rezolvare bug-uri**: `bugfix/id-bug` - pentru repararea problemelor
- **Branch-uri de lansare**: `release/v1.x` - pentru pregătirea versiunilor noi

### Scenariu pas cu pas

#### 1. Începutul sprint-ului (perioada de lucru de 2 săptămâni)

- Echipa se întâlnește și decide funcționalitățile pentru următorul sprint
- Fiecare dezvoltator primește sarcini specifice (implementare coș de cumpărături, sistem de plată, etc.)

#### 2. Ana începe să lucreze la sistemul de coș de cumpărături

```bash
# Ana se asigură că are ultima versiune a branch-ului develop
git checkout develop
git pull origin develop

# Ana creează un branch nou pentru funcționalitatea sa
git checkout -b feature/shopping-cart

# Ana lucrează la cod și face commit-uri regulate
git add .
git commit -m "Adaugă structura de bază a coșului"
git add .
git commit -m "Implementează funcția de adăugare produse"
```

#### 3. Mihai descoperă un bug în sistemul de login

```bash
# Mihai creează un branch pentru rezolvarea bug-ului
git checkout develop
git checkout -b bugfix/login-error

# Mihai rezolvă bug-ul și face commit
git add auth-controller.js
git commit -m "Rezolvă eroarea de autentificare la folosirea caracterelor speciale"

# Mihai trimite modificările în repository-ul remote
git push origin bugfix/login-error
```

#### 4. Mihai creează un Pull Request

- Mihai deschide un Pull Request (PR) pe GitHub/GitLab pentru `bugfix/login-error` către `develop`
- Colegii de echipă (Ion și Maria) revizuiesc codul
- După aprobare, branch-ul este integrat în `develop`

#### 5. Ana continuă să lucreze la coșul de cumpărături

- După câteva zile, Ana termină funcționalitatea
- Ana actualizează branch-ul cu ultimele modificări din develop:

```bash
git checkout develop
git pull origin develop
git checkout feature/shopping-cart
git merge develop  # Integrează schimbările din develop în branch-ul său
git push origin feature/shopping-cart
```

#### 6. Ana creează un Pull Request pentru coșul de cumpărături

- Echipa revizuiește codul
- Se descoperă câteva probleme și se cer modificări
- Ana face modificările necesare:

```bash
git add .
git commit -m "Rezolvă problemele identificate în review"
git push origin feature/shopping-cart
```

#### 7. La mijlocul sprint-ului, echipa face o integrare intermediară

- Toate funcționalitățile terminate sunt integrate în `develop`
- Se rulează testele automate pentru a verifica stabilitatea
- Fiecare dezvoltator își actualizează branch-urile:

```bash
git checkout develop
git pull origin develop
git checkout feature/mea
git merge develop
```

#### 8. Pregătirea pentru lansare

- La sfârșitul sprint-ului, echipa creează un branch de lansare:

```bash
git checkout develop
git checkout -b release/v1.2
```

- Pe acest branch se fac doar corecții minore și ajustări
- Se actualizează numărul versiunii și documentația

#### 9. Testare finală și lansare

- După testarea completă, branch-ul de lansare este integrat atât în `main`, cât și în `develop`:

```bash
# Integrare în main
git checkout main
git merge release/v1.2
git tag -a v1.2.0 -m "Versiunea 1.2.0"
git push origin main --tags

# Integrare înapoi în develop
git checkout develop
git merge release/v1.2
git push origin develop
```

#### 10. Începe un nou ciclu

- Echipa începe planificarea pentru următorul sprint
- Procesul se repetă pentru noile funcționalități

### Beneficiile acestui workflow

- **Izolare**: Fiecare funcționalitate este dezvoltată separat
- **Calitate**: Codul este revizuit de colegi înainte de integrare
- **Stabilitate**: Branch-ul `main` conține întotdeauna cod stabil
- **Colaborare**: Toți membrii echipei pot vedea progresul și pot oferi feedback
- **Trasabilitate**: Fiecare modificare este documentată și poate fi urmărită
- **Flexibilitate**: Urgențele (bug-urile) pot fi tratate rapid, fără a perturba dezvoltarea funcționalităților

## Concluzie

Git a revoluționat modul în care se dezvoltă software-ul modern, facilitând colaborarea, experimentarea și siguranța codului. Învățarea Git este o investiție esentiala pentru orice student în domeniul IT, reprezentând o abilitate fundamentală solicitată de majoritatea angajatorilor din industra IT.
