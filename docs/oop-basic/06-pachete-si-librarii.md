# Pachete, Import și Classpath

## Pachete (Packages) în Java

Pachetele în Java reprezintă un mecanism de organizare a claselor și interfețelor în grupuri logice. Ele oferă:

- **Organizare ierarhică** a codului, similar cu directoarele într-un sistem de fișiere
- **Spațiu de nume** (namespace) pentru a evita conflictele de nume între clase
- **Encapsulare** la nivel de pachet prin modificatorul de acces implicit (package-private)

Declararea unui pachet se face în prima linie a fișierului sursă:

```java
package com.example.myapplication;

public class MyCLass {
    // implementare
}
```

## Importul claselor

Importul în Java permite utilizarea claselor din alte pachete fără a specifica calea completă de fiecare dată. Există două tipuri de import:

1. **Import specific** - importă o singură clasă:
   ```java
   import java.util.ArrayList;
   ```

2. **Import cu wildcard** - importă toate clasele dintr-un pachet:
   ```java
   import java.util.*;
   ```

Importurile se plasează după declarația pachetului și înainte de definirea clasei.

## Classpath și localizarea claselor

Classpath este un parametru care spune JVM și compilatorului Java unde să caute clasele și pachetele utilizate în aplicație. Classpath poate include:

- Directoare cu fișiere .class
- Arhive JAR sau ZIP
- Module (începând cu Java 9)

JVM caută clasele în următoarea ordine:

1. Clasele din pachetul `java.lang` (importate implicit)
2. Clasele importate explicit
3. Clasele din același pachet
4. Clasele importate cu wildcard

Classpath poate fi specificat în mai multe moduri:
- Variabila de mediu `CLASSPATH`
- Opțiunea `-classpath` sau `-cp` la compilare sau la lansarea aplicației
- În fișierele manifest ale arhivelor JAR

## Încărcarea claselor de către JVM

JVM încarcă clasele folosind un mecanism numit **Class Loading**. Acest proces include trei etape principale:

1. **Încărcare (Loading)** - Class Loader-ul citește bytecode-ul (.class) și creează o reprezentare a acestuia în memorie
2. **Legare (Linking)** - include verificarea, pregătirea și rezolvarea referințelor
3. **Inițializare (Initialization)** - execută blocurile statice și inițializează variabilele statice

JVM folosește trei Class Loadere principale:
- **Bootstrap Class Loader** - încarcă clasele de bază din JDK
- **Extension Class Loader** - încarcă clasele din directoarele de extensii
- **Application Class Loader** - încarcă clasele din classpath-ul aplicației

Clasele sunt încărcate "lazy" (la cerere), adică doar atunci când sunt referențiate pentru prima dată.

## Alte concepte relevante

### Numele complet al claselor (Fully Qualified Name)
Este numele complet al unei clase, incluzând pachetul (ex: `java.util.ArrayList`).

### Package-sealing
Permite "sigilarea" unui pachet, astfel încât toate clasele sale să provină din aceeași sursă (de obicei, același JAR).

### Sistemul modular (începând cu Java 9)
Introdus prin Project Jigsaw, sistemul modular oferă un nivel de încapsulare mai înalt decât pachetele, permițând definirea explicită a dependențelor și expunerea controlată a pachetelor.

### JAR files
Java Archive (JAR) sunt arhive care pot conține clase, resurse, metadate și un fișier manifest care specifică informații despre conținut.

