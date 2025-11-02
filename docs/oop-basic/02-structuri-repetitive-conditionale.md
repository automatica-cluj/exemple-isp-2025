# Structuri Repetitive și Condiționale

## 1. Introducere

Structurile de control permit programatorilor să controleze fluxul de execuție al programului. Există două categorii principale:

- **Structuri condiționale**: permit executarea de cod în funcție de anumite condiții
- **Structuri repetitive**: permit executarea de cod în mod repetat atât timp cât o condiție este îndeplinită

Aceste structuri reprezintă fundația algoritmilor și procesării datelor în Java.

---

## 2. Structuri Condiționale

### Instrucțiunea if

**Sintaxă**:
```java
if (condiție) {
    // cod executat dacă condiția este adevărată
}
```

**Exemplu**:
```java
int varsta = 18;
if (varsta >= 18) {
    System.out.println("Persoană adultă");
}
```

### Instrucțiunea if-else

**Sintaxă**:
```java
if (condiție) {
    // cod executat dacă condiția este adevărată
} else {
    // cod executat dacă condiția este falsă
}
```

**Exemplu**:
```java
int varsta = 16;
if (varsta >= 18) {
    System.out.println("Persoană adultă");
} else {
    System.out.println("Minor");
}
```

### Instrucțiunea if-else if-else

**Sintaxă**:
```java
if (condiție1) {
    // cod executat dacă condiția1 este adevărată
} else if (condiție2) {
    // cod executat dacă condiția1 este falsă și condiția2 este adevărată
} else {
    // cod executat dacă toate condițiile anterioare sunt false
}
```

**Exemplu**:
```java
int nota = 8;
if (nota >= 9) {
    System.out.println("Excelent");
} else if (nota >= 7) {
    System.out.println("Bine");
} else if (nota >= 5) {
    System.out.println("Satisfăcător");
} else {
    System.out.println("Nesatisfăcător");
}
```

### Instrucțiunea switch

**Sintaxă**:
```java
switch (expresie) {
    case valoare1:
        // cod executat dacă expresie == valoare1
        break;
    case valoare2:
        // cod executat dacă expresie == valoare2
        break;
    default:
        // cod executat dacă expresia nu se potrivește cu nicio valoare
}
```

**Exemplu**:
```java
int zi = 3;
switch (zi) {
    case 1:
        System.out.println("Luni");
        break;
    case 2:
        System.out.println("Marți");
        break;
    case 3:
        System.out.println("Miercuri");
        break;
    case 4:
        System.out.println("Joi");
        break;
    case 5:
        System.out.println("Vineri");
        break;
    case 6:
    case 7:
        System.out.println("Weekend");
        break;
    default:
        System.out.println("Zi invalidă");
}
```

**Switch cu expresii (Java 12+)**:
```java
String rezultat = switch (zi) {
    case 1 -> "Luni";
    case 2 -> "Marți";
    case 3 -> "Miercuri";
    case 4 -> "Joi";
    case 5 -> "Vineri";
    case 6, 7 -> "Weekend";
    default -> "Zi invalidă";
};
```

### Operatorul ternar (? :)

**Sintaxă**:
```java
rezultat = condiție ? valoare_dacă_adevărat : valoare_dacă_fals;
```

**Exemplu**:
```java
int varsta = 20;
String status = (varsta >= 18) ? "adult" : "minor";
```

---

## 3. Structuri Repetitive

### Bucla while

Execută blocul de cod atât timp cât condiția este adevărată. Verifică condiția înainte de execuție.

**Sintaxă**:
```java
while (condiție) {
    // cod executat repetat atât timp cât condiția este adevărată
}
```

**Exemplu**:
```java
int i = 1;
while (i <= 5) {
    System.out.println("Numărul: " + i);
    i++;
}
```

### Bucla do-while

Execută blocul de cod cel puțin o dată, apoi repetă execuția atât timp cât condiția este adevărată. Verifică condiția după execuție.

**Sintaxă**:
```java
do {
    // cod executat cel puțin o dată, apoi repetat atât timp cât condiția este adevărată
} while (condiție);
```

**Exemplu**:
```java
int i = 1;
do {
    System.out.println("Numărul: " + i);
    i++;
} while (i <= 5);
```

### Bucla for

O structură compactă care include inițializarea, condiția și incrementarea într-o singură linie.

**Sintaxă**:
```java
for (inițializare; condiție; incrementare) {
    // cod executat repetat
}
```

**Exemplu**:
```java
for (int i = 1; i <= 5; i++) {
    System.out.println("Numărul: " + i);
}
```

### Bucla for-each (enhanced for)

Folosită pentru iterarea prin colecții și array-uri într-un mod simplificat.

**Sintaxă**:
```java
for (tip element : colecție) {
    // cod care utilizează elementul
}
```

**Exemplu**:
```java
int[] numere = {1, 2, 3, 4, 5};
for (int numar : numere) {
    System.out.println("Numărul: " + numar);
}
```

---

## 4. Instrucțiuni de control al buclelor

### Instrucțiunea break

Termină execuția celei mai apropiate bucle sau structuri switch.

**Exemplu**:
```java
for (int i = 1; i <= 10; i++) {
    if (i == 5) {
        break; // ieșire din buclă când i ajunge la 5
    }
    System.out.println("Numărul: " + i);
}
```

### Instrucțiunea continue

Sare peste restul iterației curente și trece la următoarea iterație.

**Exemplu**:
```java
for (int i = 1; i <= 10; i++) {
    if (i % 2 == 0) {
        continue; // sare peste numerele pare
    }
    System.out.println("Număr impar: " + i);
}
```

### Instrucțiunea return

Termină execuția metodei curente și poate returna o valoare.

**Exemplu**:
```java
public boolean estePar(int numar) {
    if (numar % 2 == 0) {
        return true;
    }
    return false;
}
```

---

## 5. Structuri imbricate

Structurile de control pot fi imbricate în interiorul altor structuri de control pentru a crea logică mai complexă.

### Exemple de structuri condiționale imbricate

```java
int varsta = 25;
boolean areDreptDeVot = true;

if (varsta >= 18) {
    if (areDreptDeVot) {
        System.out.println("Poate vota");
    } else {
        System.out.println("Nu poate vota deși are vârsta legală");
    }
} else {
    System.out.println("Nu are vârsta necesară pentru a vota");
}
```

### Exemple de bucle imbricate

```java
// Afișarea unui model de stele
for (int i = 1; i <= 5; i++) {
    for (int j = 1; j <= i; j++) {
        System.out.print("* ");
    }
    System.out.println();
}
```

Output:
```
* 
* * 
* * * 
* * * * 
* * * * * 
```

---

## 6. Bune practici

1. **Simplitate**: Păstrează structurile de control cât mai simple posibil.
2. **Indentare**: Folosește indentări consistente pentru a face codul mai lizibil.
3. **Acolade**: Folosește întotdeauna acolade, chiar și pentru blocuri de o singură linie.
4. **Evită blocurile adânc imbricate**: Mai mult de 3 niveluri de imbricare pot face codul greu de înțeles.
5. **Folosește switch** pentru variabile cu valori discrete și multiple căi de execuție.
6. **Alege bucla potrivită**:
    - `for` când știi numărul de iterații dinainte
    - `while` când iterezi până la îndeplinirea unei condiții
    - `do-while` când trebuie să execuți codul cel puțin o dată
    - `for-each` când iterezi prin colecții sau array-uri

---

## 7. Exemple complexe

### Exemplu 1: Verificarea unui număr prim

```java
public static boolean estePrim(int numar) {
    if (numar <= 1) {
        return false;
    }
    
    if (numar <= 3) {
        return true;
    }
    
    if (numar % 2 == 0 || numar % 3 == 0) {
        return false;
    }
    
    for (int i = 5; i * i <= numar; i += 6) {
        if (numar % i == 0 || numar % (i + 2) == 0) {
            return false;
        }
    }
    
    return true;
}
```

### Exemplu 2: Calculul factorialului

```java
public static long factorial(int n) {
    if (n < 0) {
        throw new IllegalArgumentException("Numărul trebuie să fie pozitiv");
    }
    
    long rezultat = 1;
    for (int i = 2; i <= n; i++) {
        rezultat *= i;
    }
    
    return rezultat;
}
```

### Exemplu 3: Afișarea numerelor din seria Fibonacci

```java
public static void afiseazaFibonacci(int n) {
    int a = 0, b = 1;
    
    System.out.print("Seria Fibonacci până la " + n + " termeni: ");
    
    for (int i = 1; i <= n; i++) {
        System.out.print(a + " ");
        int sum = a + b;
        a = b;
        b = sum;
    }
}
```

### Exemplu 4: Tabel de multiplicare

```java
public static void tabelMultiplicare(int n) {
    System.out.println("Tabel de multiplicare până la " + n + ":");
    
    // Afișare antet
    System.out.print("  |");
    for (int i = 1; i <= n; i++) {
        System.out.printf("%4d", i);
    }
    System.out.println("\n--+" + "-".repeat(4 * n));
    
    // Afișare tabel
    for (int i = 1; i <= n; i++) {
        System.out.printf("%2d|", i);
        for (int j = 1; j <= n; j++) {
            System.out.printf("%4d", i * j);
        }
        System.out.println();
    }
}
```

---

## 8. Exerciții practice

### Exercițiul 1
Scrieți un program care verifică dacă un an este bisect. Un an este bisect dacă este divizibil cu 4 dar nu cu 100, sau dacă este divizibil cu 400.

### Exercițiul 2
Implementați un program care afișează toate numerele prime din intervalul [1, 100].

### Exercițiul 3
Scrieți un program care calculează suma cifrelor unui număr întreg pozitiv.

### Exercițiul 4
Creați un program care afișează un triunghi Pascal cu n rânduri.

### Exercițiul 5
Implementați un program care convertește un număr din baza 10 în orice bază între 2 și 16.

### Exercițiul 6
Scrieți un program care să determine dacă un șir de caractere este palindrom (se citește la fel de la stânga la dreapta și de la dreapta la stânga).

### Exercițiul 7
Creați un joc simplu "Ghicește numărul" în care computerul generează un număr aleatoriu între 1 și 100, iar utilizatorul trebuie să-l ghicească. După fiecare încercare, programul va oferi indicii de tipul "prea mare" sau "prea mic".

---

## Resurse suplimentare

- [Oracle Java Documentation - Control Flow Statements](https://docs.oracle.com/javase/tutorial/java/nutsandbolts/flow.html)
- [W3Schools Java Control Statements](https://www.w3schools.com/java/java_conditions.asp)
- [Baeldung - Java Control Structures](https://www.baeldung.com/java-control-structures)
- [GeeksforGeeks - Control Statements in Java](https://www.geeksforgeeks.org/control-statements-in-java/)