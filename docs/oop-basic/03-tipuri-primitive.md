# Introducere în tipuri primitive de date și array-uri în Java

## Tipuri primitive de date în Java

Java este un limbaj de programare puternic tipizat, ceea ce înseamnă că fiecare variabilă trebuie să aibă un tip de date declarat.

### Cele 8 tipuri primitive

| Tip | Dimensiune | Valori | Valoare implicită | Exemplu |
|-----|------------|--------|-------------------|---------|
| `byte` | 8 biți | -128 la 127 | 0 | `byte varsta = 25;` |
| `short` | 16 biți | -32,768 la 32,767 | 0 | `short populatie = 10000;` |
| `int` | 32 biți | -2^31 la 2^31-1 | 0 | `int numere = 123456;` |
| `long` | 64 biți | -2^63 la 2^63-1 | 0L | `long distanta = 9876543210L;` |
| `float` | 32 biți | Aproximativ ±3.40282347E+38F | 0.0f | `float temperatura = 36.6f;` |
| `double` | 64 biți | Aproximativ ±1.79769313486231570E+308 | 0.0d | `double PI = 3.14159265359;` |
| `char` | 16 biți | 0 la 65,535 | '\u0000' | `char litera = 'A';` |
| `boolean` | 1 bit | true sau false | false | `boolean esteCorect = true;` |

### Caracteristici ale tipurilor primitive

- Nu sunt obiecte, deci nu au metode asociate
- Sunt stocate direct în stiva de memorie (nu pe heap)
- Sunt mai eficiente din punct de vedere al performanței
- Numele tipurilor primitive încep cu literă mică
- Au valori implicite când sunt declarate ca variabile de instanță

### Exemple de declarare și inițializare

```java
// Declarare
int numar;
double medie;

// Inițializare
numar = 10;
medie = 8.75;

// Declarare și inițializare în același timp
int varsta = 20;
char gen = 'M';
boolean esteStudent = true;
```

### Conversii între tipuri primitive (casting)

#### Conversii implicite (widening)
```java
byte b = 100;
int i = b;  // Un byte poate fi automat convertit la int
```

#### Conversii explicite (narrowing)
```java
int i = 100;
byte b = (byte)i;  // Necesită cast explicit
```

## Array-uri în Java

Array-urile sunt structuri de date care stochează mai multe valori de același tip.

### Caracteristici ale array-urilor

- Sunt obiecte în Java
- Au lungime fixă (nu poate fi modificată după creare)
- Indexarea începe de la 0
- Pot stoca tipuri primitive sau referințe la obiecte
- Pot fi unidimensionale sau multidimensionale

### Declarare și inițializare a array-urilor

#### Unidimensionale

```java
// Declarare
int[] numere;
String[] nume;

// Creare (alocare memorie)
numere = new int[5];  // Array de 5 elemente de tip int
nume = new String[3];  // Array de 3 elemente de tip String

// Declarare și creare în același timp
double[] preturi = new double[10];

// Declarare, creare și inițializare cu valori specifice
char[] vocale = {'a', 'e', 'i', 'o', 'u'};
int[] puncte = {10, 20, 30, 40, 50};
```

#### Multidimensionale

```java
// Declarare și creare
int[][] matrice = new int[3][4];  // Matrice 3x4

// Declarare, creare și inițializare
int[][] tabla = {
    {1, 2, 3},
    {4, 5, 6},
    {7, 8, 9}
};
```

### Accesarea elementelor dintr-un array

```java
int[] numere = {10, 20, 30, 40, 50};

// Accesarea elementelor
int primulElement = numere[0];  // 10
int ultimulElement = numere[4];  // 50

// Modificarea valorilor
numere[2] = 35;  // Acum array-ul este {10, 20, 35, 40, 50}
```

### Parcurgerea array-urilor

#### Folosind bucla for tradițională

```java
int[] numere = {10, 20, 30, 40, 50};

for (int i = 0; i < numere.length; i++) {
    System.out.println("Elementul " + i + ": " + numere[i]);
}
```

#### Folosind bucla for-each (enhanced for)

```java
int[] numere = {10, 20, 30, 40, 50};

for (int numar : numere) {
    System.out.println("Valoare: " + numar);
}
```

### Manipularea array-urilor cu clasa Arrays

Java oferă clasa utilitară `java.util.Arrays` pentru diverse operații pe array-uri:

```java
import java.util.Arrays;

int[] numere = {30, 10, 50, 20, 40};

// Sortare
Arrays.sort(numere);  // Acum array-ul este {10, 20, 30, 40, 50}

// Căutare binară (doar în array-uri sortate)
int pozitie = Arrays.binarySearch(numere, 30);  // Returnează 2

// Umplere cu o valoare
Arrays.fill(numere, 0);  // Acum array-ul este {0, 0, 0, 0, 0}

// Comparare
int[] a = {1, 2, 3};
int[] b = {1, 2, 3};
boolean suntEgale = Arrays.equals(a, b);  // true

// Conversie la String
String sir = Arrays.toString(numere);  // "[0, 0, 0, 0, 0]"
```

## Exemplu complet

```java
public class ExempluTipuriSiArrayuri {
    public static void main(String[] args) {
        // Tipuri primitive
        int varsta = 20;
        double medie = 9.5;
        char grupa = 'A';
        boolean absolvent = false;
        
        System.out.println("Vârsta: " + varsta);
        System.out.println("Media: " + medie);
        System.out.println("Grupa: " + grupa);
        System.out.println("Absolvent: " + absolvent);
        
        // Array de numere
        int[] note = {8, 9, 10, 7, 9};
        
        // Calcularea sumei și mediei notelor
        int suma = 0;
        for (int nota : note) {
            suma += nota;
        }
        double mediaNote = (double) suma / note.length;
        
        System.out.println("\nNotele: " + Arrays.toString(note));
        System.out.println("Media notelor: " + mediaNote);
        
        // Array bidimensional - orar săptămânal
        String[][] orar = {
            {"Matematică", "Fizică", "Informatică"},
            {"Engleză", "Istorie", "Sport"},
            {"Programare", "Baze de date", "Rețele"}
        };
        
        System.out.println("\nOrarul pentru primele 3 zile:");
        for (int i = 0; i < orar.length; i++) {
            System.out.print("Ziua " + (i + 1) + ": ");
            for (int j = 0; j < orar[i].length; j++) {
                System.out.print(orar[i][j]);
                if (j < orar[i].length - 1) {
                    System.out.print(", ");
                }
            }
            System.out.println();
        }
    }
}
```

## Sfaturi pentru folosirea tipurilor primitive și a array-urilor

1. Alegeți întotdeauna tipul primitiv potrivit pentru a economisi memorie
2. Folosiți `final` pentru constantele care nu se vor schimba
3. Verificați întotdeauna limitele array-ului pentru a evita excepțiile `ArrayIndexOutOfBoundsException`
4. Folosiți Arrays.toString() pentru afișarea rapidă a conținutului unui array
5. În aplicații reale, considerați folosirea colecțiilor (ArrayList, HashMap) în locul array-urilor simple pentru mai multă flexibilitate

## Exerciții practice

1. Creați un array de 5 numere întregi și calculați suma lor
2. Creați un array de string-uri cu numele prietenilor voștri și afișați-le în ordine alfabetică
3. Creați o matrice 3x3 de numere întregi și calculați suma pe diagonala principală
4. Implementați un program care inversează elementele unui array
5. Creați un program care găsește elementul maxim și minim dintr-un array de numere