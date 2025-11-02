# Clasa si Obiect, Concepte de Baza

## Clasa și Obiect

### Clasa
Clasa este un _șablon_ sau o _structură_ care definește:
- Atributele (variabilele)
- Comportamentul (metodele)

Clasa reprezintă conceptul abstract al unui tip de obiect, definind structura și comportamentul obiectelor care vor fi create bazate pe această clasă.

```java
public class Student {
    // Atribute
    private String nume;
    private int varsta;
    
    // Constructor
    public Student(String nume, int varsta) {
        this.nume = nume;
        this.varsta = varsta;
    }
    
    // Metode
    public void studiere() {
        System.out.println(nume + " studiază");
    }
}
```

### Obiect
Obiectul este o _instanță_ a unei clase. Reprezintă implementarea concretă a unui șablon definit de clasă.

```java
// Crearea unui obiect de tip Student
Student student1 = new Student("Ion", 20);
Student student2 = new Student("Maria", 21);

// Apelarea metodelor obiectului
student1.studiere(); // Output: Ion studiază
student2.studiere(); // Output: Maria studiază
```

## Constructori

Constructorii sunt metode speciale care sunt apelate automat la crearea unui obiect și sunt folosite pentru:
- Inițializarea atributelor
- Alocarea resurselor necesare

Caracteristici:
- Au același nume ca și clasa
- Nu au tip de retur, nici măcar `void`
- Pot fi supraîncărcați (overloaded)

```java
public class Carte {
    private String titlu;
    private String autor;
    private int anPublicatie;
    
    // Constructor implicit
    public Carte() {
        titlu = "Necunoscut";
        autor = "Anonim";
        anPublicatie = 2000;
    }
    
    // Constructor cu parametri
    public Carte(String titlu, String autor) {
        this.titlu = titlu;
        this.autor = autor;
        this.anPublicatie = 2000; // valoare implicită
    }
    
    // Constructor cu toți parametrii
    public Carte(String titlu, String autor, int anPublicatie) {
        this.titlu = titlu;
        this.autor = autor;
        this.anPublicatie = anPublicatie;
    }
}
```

## Atribute

Atributele sunt variabilele definite într-o clasă, reprezentând _starea_ sau _datele_ unui obiect.

```java
public class Persoana {
    // Atribute
    private String nume;            // atribut de instanță
    private String prenume;         // atribut de instanță
    private int varsta;             // atribut de instanță
    private static int numarPersoane; // atribut static (de clasă)
    private final String CNP;       // atribut constant (final)
    
    // Constructor
    public Persoana(String nume, String prenume, int varsta, String CNP) {
        this.nume = nume;
        this.prenume = prenume;
        this.varsta = varsta;
        this.CNP = CNP;
        numarPersoane++;
    }
}
```

Clasificarea atributelor:
- **Atribute de instanță**: aparțin fiecărui obiect și pot avea valori diferite pentru fiecare instanță
- **Atribute statice** (de clasă): aparțin clasei, nu instanțelor; sunt comune pentru toate obiectele de acel tip
- **Atribute finale** (constante): nu pot fi modificate după inițializare

## Metode

Metodele definesc _comportamentul_ unui obiect și reprezintă acțiunile pe care obiectul le poate executa.

```java
public class Calculator {
    // Atribute
    private double rezultat;
    
    // Metode
    public void aduna(double a, double b) {
        rezultat = a + b;
    }
    
    public void scade(double a, double b) {
        rezultat = a - b;
    }
    
    public double getRezultat() {
        return rezultat;
    }
    
    // Metodă statică
    public static double patrat(double numar) {
        return numar * numar;
    }
}
```

Clasificarea metodelor:
- **Metode de instanță**: aparțin fiecărui obiect și pot accesa atributele și alte metode ale instanței
- **Metode statice** (de clasă): aparțin clasei, nu instanțelor; nu pot accesa atributele non-statice sau metodele de instanță
- **Metode finale**: nu pot fi suprascrise în subclase

## Convenții Java

### Convenții de numire
Java folosește următoarele convenții de numire:

1. **Clase**:
   - Substantive
   - CamelCase cu prima literă mare (PascalCase)
   - Exemple: `Student`, `ContBancar`, `GestiuneAngajati`

2. **Atribute și Metode**:
   - Verbe pentru metode (acțiuni)
   - camelCase cu prima literă mică
   - Exemple: `nume`, `adresaEmail`, `calculeazaSalariu()`

3. **Constante**:
   - Toate literele majuscule, cu subliniere între cuvinte
   - Exemple: `MAX_SIZE`, `PI`, `DATABASE_URL`

4. **Pachete**:
   - Toate literele mici
   - De obicei folosește domeniul inversat (ex: `org.example.proiect`)
   - Exemple: `java.util`, `com.companie.proiect`

### Bune practici
- Numele ar trebui să fie descriptive și să indice scopul
- Evitați abrevierile ambigue
- Folosiți pluralul pentru colecții (ex: `List<Student> studenti`)
- Utilizați prefixe pentru variabile boolean: `is`, `has`, `can` (ex: `isActive`, `hasChildren`)

## Cuvinte Cheie

### new
Cuvântul cheie `new` este utilizat pentru a **instanția** un obiect (a crea o instanță a unei clase).

```java
// Sintaxă: TipClasa numeVariabila = new TipClasa(parametri);
String text = new String("Hello World");
ArrayList<Integer> numere = new ArrayList<>();
Student student = new Student("Ana", 22);
```

Procesul când se folosește `new`:
1. Se alocă memorie pentru noul obiect
2. Se apelează constructorul clasei
3. Se returnează o referință către obiectul nou creat

### null
`null` reprezintă o valoare specială care indică faptul că o variabilă de tip referință **nu referă niciun obiect**.

```java
// Declararea unei variabile fără a o inițializa
Student student;          // valoarea implicită este null

// Atribuirea explicită a valorii null
String mesaj = null;

// Verificarea pentru null
if (mesaj == null) {
    System.out.println("Mesajul este null!");
}
```

Pericole:
- Apelarea metodelor pe o referință `null` generează `NullPointerException`
- Este considerată o bună practică verificarea valorilor pentru `null` înainte de a le utiliza

### this
Cuvântul cheie `this` se referă la **obiectul curent** (instanța curentă a clasei).

Utilizări:
1. Rezolvarea ambiguității între atributele clasei și parametrii metodei/constructorului:

```java
public class Persoana {
    private String nume;
    
    public Persoana(String nume) {
        this.nume = nume; // this.nume se referă la atributul clasei
    }
}
```

2. Apelarea unui alt constructor din același clasă:

```java
public class Persoana {
    private String nume;
    private int varsta;
    
    public Persoana() {
        this("Necunoscut", 0); // Apelează celălalt constructor
    }
    
    public Persoana(String nume, int varsta) {
        this.nume = nume;
        this.varsta = varsta;
    }
}
```

3. Pentru returnarea obiectului curent (permite înlănțuirea metodelor):

```java
public class Builder {
    private int valoare;
    
    public Builder adauga(int x) {
        valoare += x;
        return this; // Returnează obiectul curent
    }
    
    public Builder scade(int x) {
        valoare -= x;
        return this;
    }
}

// Utilizare:
Builder b = new Builder();
b.adauga(5).scade(2).adauga(10); // Înlănțuire de metode
```

### static
Cuvântul cheie `static` este folosit pentru a declara membri (atribute sau metode) care aparțin **clasei înseși**, nu instanțelor individuale.

Atribute statice:
- Sunt comune tuturor instanțelor clasei
- Sunt inițializate o singură dată, la încărcarea clasei
- Pot fi accesate direct prin numele clasei

```java
public class Contor {
    private static int numar = 0; // atribut static
    
    public Contor() {
        numar++; // incrementat la fiecare instanțiere
    }
    
    public static int getNumar() { // metodă statică
        return numar;
    }
}

// Utilizare:
Contor c1 = new Contor();
Contor c2 = new Contor();
System.out.println(Contor.getNumar()); // Output: 2
```

Metode statice:
- Nu pot accesa atribute non-statice sau metode non-statice direct
- Nu pot utiliza cuvântul cheie `this`
- Pot fi apelate direct prin numele clasei fără a crea o instanță
- Exemple comune: `Math.sqrt()`, `Arrays.sort()`, `Collections.sort()`

### final
Cuvântul cheie `final` poate fi aplicat variabilelor, metodelor și claselor pentru a impune restricții.

1. Variabile finale (constante):
   - Nu pot fi modificate după inițializare
   - Trebuie inițializate la declarare sau în constructor

```java
public class Constante {
    final int MAX_UTILIZATORI = 100; // inițializat la declarare
    final String PREFIX;
    
    public Constante(String prefix) {
        this.PREFIX = prefix; // inițializat în constructor
    }
}
```

2. Metode finale:
   - Nu pot fi suprascrise în subclase

```java
public class Parinte {
    public final void metodaFinala() {
        // implementare care nu poate fi modificată în subclase
    }
}
```

3. Clase finale:
   - Nu pot fi extinse (nu pot avea subclase)
   - Exemple: `String`, `Integer`, `Math`

```java
public final class ClasaFinala {
    // Această clasă nu poate fi extinsă
}
```

## Supraîncărcarea Metodelor

Supraîncărcarea metodelor (method overloading) este abilitatea de a defini mai multe metode cu **același nume** dar cu **parametri diferiți** în aceeași clasă.

Criteriile pentru supraîncărcarea metodelor:
- Trebuie să difere prin numărul parametrilor și/sau
- Trebuie să difere prin tipul parametrilor

Tipul de retur NU este luat în considerare pentru determinarea supraîncărcării.

```java
public class Calculator {
    // Supraîncărcarea metodei de adunare
    
    // Versiunea pentru două numere întregi
    public int aduna(int a, int b) {
        return a + b;
    }
    
    // Versiunea pentru trei numere întregi
    public int aduna(int a, int b, int c) {
        return a + b + c;
    }
    
    // Versiunea pentru două numere reale
    public double aduna(double a, double b) {
        return a + b;
    }
    
    // Versiunea pentru un număr întreg și unul real
    public double aduna(int a, double b) {
        return a + b;
    }
}
```

Avantajele supraîncărcării metodelor:
- Îmbunătățește lizibilitatea și reutilizarea codului
- Permite utilizarea aceluiași nume pentru operații similare
- Metodele pot fi apelate cu tipuri diferite de parametri

## Compararea Obiectelor

În Java, există două metode principale pentru a compara obiecte:
1. Operatorul `==` compară referințele (dacă două variabile referă același obiect)
2. Metoda `equals()` compară conținutul obiectelor (valorile)

### Metoda equals()

Semnătură: `public boolean equals(Object obj)`

- Este moștenită din clasa `Object`
- Implementarea implicită compară referințele (identic cu `==`)
- Pentru compararea corectă a conținutului, trebuie suprascrisă

```java
public class Persoana {
    private String nume;
    private String CNP;
    
    public Persoana(String nume, String CNP) {
        this.nume = nume;
        this.CNP = CNP;
    }
    
    // Getteri și setteri
    
    // Suprascriere metoda equals
    @Override
    public boolean equals(Object obj) {
        // Verificare dacă obiectul este aceeași instanță
        if (this == obj) {
            return true;
        }
        
        // Verificare dacă obiectul este null sau de alt tip
        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }
        
        // Conversie la tipul corect
        Persoana altaPersoana = (Persoana) obj;
        
        // Compararea atributelor relevante
        return CNP != null && CNP.equals(altaPersoana.CNP);
    }
    
    // De obicei, hashCode() este suprascrisa împreună cu equals()
    @Override
    public int hashCode() {
        return CNP != null ? CNP.hashCode() : 0;
    }
}
```

Reguli pentru implementarea corectă a metodei `equals()`:
1. Reflexivitate: Pentru orice obiect `x`, `x.equals(x)` trebuie să returneze `true`
2. Simetrie: Pentru orice obiect `x` și `y`, dacă `x.equals(y)` returnează `true`, atunci `y.equals(x)` trebuie să returneze `true`
3. Tranzitivitate: Pentru orice obiecte `x`, `y` și `z`, dacă `x.equals(y)` și `y.equals(z)` returnează `true`, atunci `x.equals(z)` trebuie să returneze `true`
4. Consistență: Pentru orice obiecte `x` și `y`, apeluri multiple ale `x.equals(y)` trebuie să returneze constant `true` sau `false`, presupunând că nu s-a modificat nicio informație
5. Pentru orice obiect non-null `x`, `x.equals(null)` trebuie să returneze `false`

Notă: Când suprascriezi `equals()`, ar trebui să suprascrii și `hashCode()` pentru a menține contractul hashCode-equals.

## Specificatori de Acces

Specificatorii de acces controlează vizibilitatea (accesibilitatea) claselor, atributelor, metodelor și constructorilor.

| Specificator | Clasa | Pachet | Subclase | Global |
|--------------|-------|--------|----------|--------|
| `public`     | Da    | Da     | Da       | Da     |
| `protected`  | Da    | Da     | Da       | Nu     |
| *default*    | Da    | Da     | Nu       | Nu     |
| `private`    | Da    | Nu     | Nu       | Nu     |

### public
- Accesibil din orice loc
- Utilizat pentru interfețe publice și clase care vor fi folosite de alte pachete

```java
public class ContBancar {
    public void depunere(double suma) {
        // Metodă accesibilă din orice loc
    }
}
```

### protected
- Accesibil în același pachet și în subclase (chiar dacă subclasele sunt în alte pachete)
- Permite subclaselor să acceseze și să suprascrie membri

```java
public class Animal {
    protected void respira() {
        // Accesibil în același pachet și în subclase
    }
}
```

### default (fără specificator)
- Accesibil doar în același pachet
- Se numește și "package-private"

```java
class Helper {
    void ajuta() {
        // Accesibil doar în același pachet
    }
}
```

### private
- Accesibil doar în interiorul clasei
- Cel mai restrictiv nivel de acces
- Utilizat pentru detalii de implementare

```java
public class Utilizator {
    private String parola;
    
    private void schimbaParola(String parolaNoua) {
        // Accesibil doar în interiorul clasei
        this.parola = parolaNoua;
    }
}
```

## Garbage Collector

Garbage Collector (GC) este un proces automat în Java care:
- Identifică și elimină obiectele care nu mai sunt referite (inaccesibile)
- Eliberează memoria ocupată de acestea
- Rulează automat, fără intervenția programatorului

### Cum funcționează Garbage Collector
1. Identifică obiectele care nu mai sunt referite de nicio variabilă accesibilă
2. Apelează metoda `finalize()` (dacă este suprascrisă) înainte de ștergerea obiectului
3. Eliberează memoria ocupată de obiect

### Demonstrarea Garbage Collector-ului

```java
public class DemoGC {
    private String nume;
    
    public DemoGC(String nume) {
        this.nume = nume;
        System.out.println("Obiect creat: " + nume);
    }
    
    @Override
    protected void finalize() {
        System.out.println("Obiect eliminat: " + nume);
    }
    
    public static void main(String[] args) {
        // Crearea obiectelor
        DemoGC obj1 = new DemoGC("Obiect 1");
        DemoGC obj2 = new DemoGC("Obiect 2");
        
        // Eliminarea referințelor
        obj1 = null; // Obiect 1 devine eligibil pentru GC
        
        // Sugeram Garbage Collector să ruleze
        System.gc();
        
        // Așteptăm puțin pentru a vedea efectele
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        
        System.out.println("Program terminat");
    }
}
```

Notă: Apelarea `System.gc()` doar sugerează JVM să ruleze GC, dar nu garantează că va rula imediat sau că va colecta toate obiectele nereferenciate.

## Exemple 

Pentru a testa o parte din conceptele de mai sus incarcati in IDE urmatorul proiect Java: [exemple-curs-2-oop](../../exemple-curs-2-oop)