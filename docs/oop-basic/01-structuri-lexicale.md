# Introducere în Structurile Lexicale în Java

## Cuprins
1. Ce sunt structurile lexicale?
2. Identificatori
3. Cuvinte cheie (Keywords)
4. Literali (Literals)
5. Operatori
6. Separatori
7. Comentarii
8. Exemple practice
9. Exerciții

---

## 1. Ce sunt structurile lexicale?

Structurile lexicale reprezintă elementele fundamentale ale limbajului Java. Acestea sunt blocurile de bază din care se construiesc programele Java.

Principalele structuri lexicale în Java sunt:
- Identificatori
- Cuvinte cheie (Keywords)
- Literali (Literals)
- Operatori
- Separatori
- Comentarii

---

## 2. Identificatori

**Identificatorii** sunt nume date claselor, metodelor, variabilelor și altor elemente din programele Java.

### Reguli pentru crearea identificatorilor:
- Pot conține litere, cifre, caracterele '_' și '$'
- Trebuie să înceapă cu o literă, '_' sau '$'
- Nu pot fi cuvinte cheie Java
- Java face distincție între majuscule și minuscule (case-sensitive)

### Exemple de identificatori valizi:
```java
suma
numarStudenti
_valoare
$pret
numar1
```

### Exemple de identificatori nevalizi:
```java
123abc     // începe cu o cifră
for        // este cuvânt cheie
nume-student // conține caracterul '-'
```

### Convenții de denumire în Java:
- **camelCase** pentru variabile și metode: `numarStudenti`, `calculeazaMedie()`
- **PascalCase** pentru clase: `Student`, `ContBancar`
- **UPPER_SNAKE_CASE** pentru constante: `PI`, `RATA_DOBANDA`

---

## 3. Cuvinte cheie (Keywords)

**Cuvintele cheie** sunt termeni rezervați în Java cu o semnificație specială. Nu pot fi folosite ca identificatori.

### Exemple de cuvinte cheie în Java:

```
abstract    assert      boolean     break       byte        case
catch       char        class       const*      continue    default
do          double      else        enum        extends     final
finally     float       for         goto*       if          implements
import      instanceof  int         interface   long        native
new         package     private     protected   public      return
short       static      strictfp    super       switch      synchronized
this        throw       throws      transient   try         void
volatile    while       _          
```
\* `const` și `goto` sunt rezervate dar neutilizate

---

## 4. Literali (Literals)

**Literalii** sunt valori constante care apar direct în cod.

### Tipuri de literali:

#### a) Literali întregi:
```java
int decimal = 10;      // decimal
int octal = 012;       // octal (cu prefixul 0)
int hexa = 0xA;        // hexadecimal (cu prefixul 0x)
int binar = 0b1010;    // binar (cu prefixul 0b) - din Java 7
long numarLung = 10L;  // cu sufixul L pentru long
```

#### b) Literali cu virgulă mobilă:
```java
float f = 3.14F;       // cu sufixul F pentru float
double d = 3.14;       // implicit double
double scientific = 3.14e2;  // notație științifică (314.0)
```

#### c) Literali caractere:
```java
char c1 = 'A';         // un caracter
char c2 = '\u0041';    // reprezentare Unicode pentru 'A'
char c3 = '\t';        // caracter special (tab)
```

#### d) Literali șiruri de caractere:
```java
String s = "Hello, Java!";
String multiline = """
                  Text pe
                  mai multe
                  linii
                  """;  // text block - din Java 15
```

#### e) Literali booleani:
```java
boolean adevarat = true;
boolean fals = false;
```

#### f) Literal null:
```java
Object obj = null;
```

---

## 5. Operatori

**Operatorii** sunt simboluri speciale care efectuează operații pe operanzi.

### Categorii principale de operatori:

#### a) Operatori aritmetici:
```java
+    // adunare sau concatenare pentru String
-    // scădere
*    // înmulțire
/    // împărțire
%    // modulo (restul împărțirii)
++   // incrementare
--   // decrementare
```

#### b) Operatori relaționali:
```java
==   // egal cu
!=   // diferit de
>    // mai mare decât
<    // mai mic decât
>=   // mai mare sau egal cu
<=   // mai mic sau egal cu
```

#### c) Operatori logici:
```java
&&   // AND logic
||   // OR logic
!    // NOT logic
```

#### d) Operatori de atribuire:
```java
=    // atribuire simplă
+=   // adunare și atribuire
-=   // scădere și atribuire
*=   // înmulțire și atribuire
/=   // împărțire și atribuire
%=   // modulo și atribuire
```

#### e) Operatori pe biți:
```java
&    // AND pe biți
|    // OR pe biți
^    // XOR pe biți
~    // NOT pe biți
<<   // deplasare la stânga
>>   // deplasare la dreapta cu semn
>>>  // deplasare la dreapta fără semn
```

#### f) Alți operatori:
```java
? :  // operator ternar
instanceof  // verifică tipul obiectului
```

---

## 6. Separatori

**Separatorii** sunt simboluri care separă diferite părți ale codului.

```java
()   // paranteze rotunde (pentru parametri, expresii)
{}   // acolade (pentru blocuri de cod)
[]   // paranteze pătrate (pentru array-uri)
;    // punct și virgulă (termină o instrucțiune)
,    // virgulă (separă elemente din liste)
.    // punct (acces la membri)
```

---

## 7. Comentarii

**Comentariile** sunt note pentru programatori, ignorate de compilator.

```java
// Acesta este un comentariu pe o singură linie

/* Acesta este un comentariu
   pe mai multe linii */

/**
 * Acesta este un comentariu de documentație (Javadoc)
 * @param nume Numele persoanei
 * @return Un mesaj de salut
 */
```

---

## 8. Exemple practice

### Exemplu 1: Utilizarea structurilor lexicale de bază

```java
public class ExempluStructuriLexicale {
    public static void main(String[] args) {
        // Declarare și inițializare de variabile
        int numar = 10;          // literal întreg
        double pi = 3.14159;     // literal cu virgulă mobilă
        char litera = 'A';       // literal caracter
        String mesaj = "Hello";  // literal șir de caractere
        boolean estePar = true;  // literal boolean

        // Utilizare operatori
        int suma = numar + 5;
        double produs = numar * pi;
        numar++;  // incrementare
        
        // Structuri de control
        if (numar % 2 == 0) {
            estePar = true;
        } else {
            estePar = false;
        }
        
        // Operatorul ternar
        String rezultat = estePar ? "par" : "impar";
        
        // Afișare rezultate
        System.out.println("Numărul " + numar + " este " + rezultat);
        System.out.println("Suma: " + suma);
        System.out.println("Produsul: " + produs);
    }
}
```

### Exemplu 2: Program complet utilizând diverse structuri lexicale

```java
/**
 * Această clasă demonstrează utilizarea structurilor lexicale în Java
 * @author Profesor Java
 */
public class CalculatorStudent {
    // Constante
    private static final double NOTA_DE_TRECERE = 5.0;
    
    // Variabile de instanță
    private String numeStudent;
    private double[] note;
    
    /**
     * Constructor pentru clasa CalculatorStudent
     * @param nume Numele studentului
     * @param noteStudent Notele studentului
     */
    public CalculatorStudent(String nume, double[] noteStudent) {
        this.numeStudent = nume;
        this.note = noteStudent;
    }
    
    /**
     * Calculează media notelor
     * @return Media calculată
     */
    public double calculeazaMedie() {
        double suma = 0;
        
        // Calculăm suma notelor
        for (int i = 0; i < note.length; i++) {
            suma += note[i];
        }
        
        // Returnăm media
        return suma / note.length;
    }
    
    /**
     * Verifică dacă studentul a promovat
     * @return true dacă media este >= NOTA_DE_TRECERE, false altfel
     */
    public boolean estePromovat() {
        return calculeazaMedie() >= NOTA_DE_TRECERE;
    }
    
    /**
     * Metoda principală de execuție
     */
    public static void main(String[] args) {
        // Cream un array cu notele studentului
        double[] noteMaria = {8.5, 7.0, 9.3, 6.5, 8.0};
        
        // Instantiem un obiect pentru student
        CalculatorStudent student = new CalculatorStudent("Maria", noteMaria);
        
        // Calculăm și afișăm rezultatele
        double medie = student.calculeazaMedie();
        boolean promovat = student.estePromovat();
        
        System.out.println("Studentul: " + student.numeStudent);
        System.out.println("Media: " + medie);
        System.out.println("Situație: " + (promovat ? "Promovat" : "Nepromovat"));
    }
}
```

---

## 9. Exerciții

1. Identificați toate structurile lexicale din următorul fragment de cod:
   ```java
   int suma = 0;
   for (int i = 1; i <= 10; i++) {
       suma += i;
   }
   System.out.println("Suma primelor 10 numere este: " + suma);
   ```

2. Scrieți un program simplu care utilizează toate tipurile de literali prezentate.

3. Creați identificatori valizi pentru următoarele situații:
   - O clasă care reprezintă un cont bancar
   - O metodă care calculează dobânda
   - O variabilă care stochează soldul contului
   - O constantă pentru rata dobânzii

4. Scrieți un program care utilizează fiecare tip de operator prezentat.

5. Identificați și corectați erorile lexicale din următorul cod:
   ```java
   public class Test {
       public void calcul() {
           int 1numar = 10;
           int if = 20;
           double rezultat = 1numar + if;
           System.out.println("Rezultat: " + rezultat)
       }
   }
   ```

---

## Resurse suplimentare

- [Documentația oficială Java](https://docs.oracle.com/javase/specs/)
- [Oracle Java Tutorials](https://docs.oracle.com/javase/tutorial/)
- [W3Schools Java Tutorial](https://www.w3schools.com/java/)
