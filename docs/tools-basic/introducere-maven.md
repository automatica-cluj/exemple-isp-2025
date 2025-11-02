# Introducere în Maven

## Ce este Maven?

Maven este un instrument de automatizare a construirii proiectelor software folosit în principal pentru proiectele Java. Dezvoltat de Apache Software Foundation, Maven folosește un concept cunoscut sub numele de Project Object Model (POM) pentru a gestiona construirea proiectului, raportarea și documentația.

## De ce să folosim Maven?

- **Gestionarea dependențelor** - Maven descarcă automat librăriile necesare proiectului
- **Standardizare** - Structură de proiect consistentă și ușor de înțeles
- **Automatizare** - Compilare, testare, packaging și deployment automatizate
- **Reutilizare** - Promovează reutilizarea codului și a componentelor

## Concepte de bază Maven

### 1. POM (Project Object Model)

Fișierul `pom.xml` este inima oricărui proiect Maven. Acesta conține:
- Informații despre proiect (nume, versiune, descriere)
- Dependențe
- Plugin-uri
- Configurații de build

```xml
<project>
    <modelVersion>4.0.0</modelVersion>
    <groupId>ro.universitate.curs</groupId>
    <artifactId>proiect-demo</artifactId>
    <version>1.0-SNAPSHOT</version>
</project>
```

### 2. Coordonate Maven

Fiecare artifact Maven este identificat prin 3 coordonate:
- **groupId**: Identificator al organizației (ex: `org.apache.maven`)
- **artifactId**: Numele proiectului (ex: `maven-core`)
- **version**: Versiunea specifică (ex: `3.8.4`)

### 3. Dependențe

```xml
<dependencies>
    <dependency>
        <groupId>junit</groupId>
        <artifactId>junit</artifactId>
        <version>4.13.2</version>
        <scope>test</scope>
    </dependency>
</dependencies>
```

### 4. Repository-uri

Maven descarcă dependențele din repository-uri:
- **Local** - Director `.m2` din computerul utilizatorului
- **Central** - Repository-ul central Maven (Maven Central)
- **Remote** - Repository-uri definite de utilizator

### 5. Ciclul de viață Maven

Maven definește un ciclu de viață standard pentru construirea și distribuirea proiectelor, format din faze:

- **clean**: Șterge fișierele generate anterior
- **validate**: Validează structura proiectului
- **compile**: Compilează codul sursă
- **test**: Rulează testele unitare
- **package**: Împachetează codul compilat (ex: în JAR)
- **verify**: Verifică integritatea pachetului
- **install**: Instalează pachetul în repository-ul local
- **deploy**: Publică pachetul într-un repository remote

## Structura standard a unui proiect Maven

```
proiect-maven/
├── pom.xml
├── src/
│   ├── main/
│   │   ├── java/        # Cod sursă Java
│   │   ├── resources/   # Resurse (configurații, etc.)
│   │   └── webapp/      # Fișiere web (pentru aplicații web)
│   └── test/
│       ├── java/        # Teste unitare
│       └── resources/   # Resurse pentru teste
└── target/              # Fișiere generate (JAR, WAR, etc.)
```

## Comenzi Maven de bază

- `mvn clean`: Curăță directorul `target/`
- `mvn compile`: Compilează codul sursă
- `mvn test`: Execută testele unitare
- `mvn package`: Construiește pachetul (JAR, WAR)
- `mvn install`: Instalează pachetul în repository-ul local
- `mvn clean install`: Combinație frecventă (curăță și instalează)

## Maven în IDE-uri populare

### Maven în IDE-uri: IntelliJ IDEA și NetBeans

Una dintre avantaje este că **Maven vine pre-instalat** în cele mai populare medii de dezvoltare Java:

### Avantajele utilizării Maven în IDE
- Studenții nu trebuie să instaleze Maven separat
- Configurare automată a classpath-ului bazat pe dependințe
- Actualizare automată a dependințelor
- Comenzile Maven pot fi executate direct din IDE

## Resurse utile

- [Documentația oficială Maven](https://maven.apache.org/guides/index.html)
- [Maven Central Repository](https://search.maven.org/)
- [Tutoriale Maven](https://www.baeldung.com/maven)
- [Maven în 5 minute](https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html)