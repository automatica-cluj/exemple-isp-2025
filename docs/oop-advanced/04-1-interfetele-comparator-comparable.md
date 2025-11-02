# Interfețele Comparator și Comparable

## Interfața Comparable

Interfața `Comparable` face parte din pachetul `java.lang` și permite obiectelor unei clase să definească ordinea lor "naturală". Implementând această interfață, obiectele unei clase pot fi sortate automat folosind metodele de sortare din `Collections` sau `Arrays`.

### Semnătura interfeței:

```java
public interface Comparable<T> {
    public int compareTo(T o);
}
```

### Metoda compareTo():

- Returnează un număr negativ dacă obiectul curent este mai mic decât obiectul furnizat ca parametru
- Returnează zero dacă obiectul curent este egal cu obiectul furnizat
- Returnează un număr pozitiv dacă obiectul curent este mai mare decât obiectul furnizat

### Exemplu de implementare:

```java
public class Student implements Comparable<Student> {
    private String nume;
    private int varsta;
    private double medie;
    
    public Student(String nume, int varsta, double medie) {
        this.nume = nume;
        this.varsta = varsta;
        this.medie = medie;
    }
    
    // Getteri și setteri
    public String getNume() { return nume; }
    public int getVarsta() { return varsta; }
    public double getMedie() { return medie; }
    
    @Override
    public int compareTo(Student altStudent) {
        // Comparăm după medie (ordinea naturală)
        return Double.compare(this.medie, altStudent.medie);
        
        // Alternativ, pentru comparare descrescătoare:
        // return Double.compare(altStudent.medie, this.medie);
    }
    
    @Override
    public String toString() {
        return nume + " (vârsta: " + varsta + ", medie: " + medie + ")";
    }
}
```

### Utilizare:

```java
List<Student> studenti = new ArrayList<>();
studenti.add(new Student("Ana", 20, 8.5));
studenti.add(new Student("Mihai", 22, 9.2));
studenti.add(new Student("Elena", 21, 7.8));

// Sortare folosind ordinea naturală definită în compareTo
Collections.sort(studenti);

// Afișare studenti sortați după medie
studenti.forEach(System.out::println);
```

## Interfața Comparator

Interfața `Comparator` face parte din pachetul `java.util` și oferă un mecanism de comparare extern pentru obiectele unei clase. Spre deosebire de `Comparable`, un `Comparator` nu necesită modificarea clasei obiectelor pe care le compară.

### Semnătura interfeței:

```java
public interface Comparator<T> {
    int compare(T o1, T o2);
}
```

### Metoda compare():

- Returnează un număr negativ dacă primul obiect este mai mic decât al doilea
- Returnează zero dacă obiectele sunt egale
- Returnează un număr pozitiv dacă primul obiect este mai mare decât al doilea

### Exemplu de implementare:

```java
// Comparator pentru sortarea studenților după nume
public class StudentNumeComparator implements Comparator<Student> {
    @Override
    public int compare(Student s1, Student s2) {
        return s1.getNume().compareTo(s2.getNume());
    }
}

// Comparator pentru sortarea studenților după vârstă
public class StudentVarstaComparator implements Comparator<Student> {
    @Override
    public int compare(Student s1, Student s2) {
        return Integer.compare(s1.getVarsta(), s2.getVarsta());
    }
}
```

### Utilizare:

```java
List<Student> studenti = new ArrayList<>();
studenti.add(new Student("Ana", 20, 8.5));
studenti.add(new Student("Mihai", 22, 9.2));
studenti.add(new Student("Elena", 21, 7.8));

// Sortare folosind un Comparator pentru nume
Collections.sort(studenti, new StudentNumeComparator());
System.out.println("Sortați după nume:");
studenti.forEach(System.out::println);

// Sortare folosind un Comparator pentru vârstă
Collections.sort(studenti, new StudentVarstaComparator());
System.out.println("\nSortați după vârstă:");
studenti.forEach(System.out::println);
```

## Diferențe între Comparable și Comparator

| Criteriu | Comparable | Comparator |
|----------|------------|------------|
| Pachet | java.lang | java.util |
| Metoda | compareTo() | compare() |
| Modifică clasa | Da | Nu |
| Ordine | Definește o singură ordine naturală | Permite multiple criterii de sortare |
| Utilizare | Integrată cu clasa | Externă, independentă de clasă |
| Sintaxă | obj1.compareTo(obj2) | comparator.compare(obj1, obj2) |

## Utilizarea Comparator cu colecții

### Comparatori anonimi

În Java modern, putem folosi clase anonime sau expresii lambda pentru a crea comparatori:

```java
// Folosind clasă anonimă
Collections.sort(studenti, new Comparator<Student>() {
    @Override
    public int compare(Student s1, Student s2) {
        return Double.compare(s1.getMedie(), s2.getMedie());
    }
});

// Folosind expresie lambda (Java 8+)
Collections.sort(studenti, (s1, s2) -> Double.compare(s1.getMedie(), s2.getMedie()));

// Folosind referințe de metode și Comparator.comparing()
Collections.sort(studenti, Comparator.comparing(Student::getMedie));
```

### Comparatori compuși

Începând cu Java 8, interfața `Comparator` include metode default pentru combinarea comparatorilor:

```java
// Sortare după medie (descrescător) și apoi după nume (crescător)
Comparator<Student> comparator = Comparator.comparing(Student::getMedie).reversed()
                                         .thenComparing(Student::getNume);

Collections.sort(studenti, comparator);
```

### Comparatori cu TreeSet și TreeMap

`TreeSet` și `TreeMap` folosesc comparatori pentru a sorta elementele:

```java
// TreeSet cu comparator personalizat
Set<Student> studentSet = new TreeSet<>(Comparator.comparing(Student::getNume));
studentSet.addAll(studenti);

// TreeMap cu comparator personalizat
Map<Student, String> studentMap = new TreeMap<>(Comparator.comparing(Student::getVarsta));
for (Student s : studenti) {
    studentMap.put(s, s.getNume() + " - Grupa A");
}
```

## Exemple practice

### Exemplu complet cu Comparable:

```java
import java.util.*;

class Carte implements Comparable<Carte> {
    private String titlu;
    private String autor;
    private int anPublicare;
    
    public Carte(String titlu, String autor, int anPublicare) {
        this.titlu = titlu;
        this.autor = autor;
        this.anPublicare = anPublicare;
    }
    
    // Getteri
    public String getTitlu() { return titlu; }
    public String getAutor() { return autor; }
    public int getAnPublicare() { return anPublicare; }
    
    @Override
    public int compareTo(Carte altaCarte) {
        // Sortare după an de publicare
        return Integer.compare(this.anPublicare, altaCarte.anPublicare);
    }
    
    @Override
    public String toString() {
        return titlu + " de " + autor + " (" + anPublicare + ")";
    }
}

public class ExempluComparable {
    public static void main(String[] args) {
        List<Carte> carti = new ArrayList<>();
        carti.add(new Carte("Moara cu noroc", "Ioan Slavici", 1881));
        carti.add(new Carte("Ion", "Liviu Rebreanu", 1920));
        carti.add(new Carte("Enigma Otiliei", "George Călinescu", 1938));
        carti.add(new Carte("Baltagul", "Mihail Sadoveanu", 1930));
        
        Collections.sort(carti);
        
        System.out.println("Cărți sortate după anul publicării:");
        for (Carte carte : carti) {
            System.out.println(carte);
        }
    }
}
```

### Exemplu complet cu Comparator:

```java
import java.util.*;

class Produs {
    private String nume;
    private double pret;
    private int cantitate;
    
    public Produs(String nume, double pret, int cantitate) {
        this.nume = nume;
        this.pret = pret;
        this.cantitate = cantitate;
    }
    
    // Getteri
    public String getNume() { return nume; }
    public double getPret() { return pret; }
    public int getCantitate() { return cantitate; }
    
    @Override
    public String toString() {
        return nume + " - " + pret + " lei (stoc: " + cantitate + ")";
    }
}

// Comparator pentru sortare după preț
class PretComparator implements Comparator<Produs> {
    @Override
    public int compare(Produs p1, Produs p2) {
        return Double.compare(p1.getPret(), p2.getPret());
    }
}

// Comparator pentru sortare după cantitate
class CantitateComparator implements Comparator<Produs> {
    @Override
    public int compare(Produs p1, Produs p2) {
        return Integer.compare(p1.getCantitate(), p2.getCantitate());
    }
}

public class ExempluComparator {
    public static void main(String[] args) {
        List<Produs> produse = new ArrayList<>();
        produse.add(new Produs("Laptop", 3200.50, 5));
        produse.add(new Produs("Telefon", 1500.00, 10));
        produse.add(new Produs("Tabletă", 900.75, 7));
        produse.add(new Produs("Căști", 150.99, 20));
        
        // Sortare folosind PretComparator
        Collections.sort(produse, new PretComparator());
        System.out.println("Produse sortate după preț:");
        for (Produs p : produse) {
            System.out.println(p);
        }
        
        System.out.println();
        
        // Sortare folosind CantitateComparator
        Collections.sort(produse, new CantitateComparator());
        System.out.println("Produse sortate după cantitate:");
        for (Produs p : produse) {
            System.out.println(p);
        }
        
        System.out.println();
        
        // Sortare folosind comparator lambda (Java 8+)
        produse.sort((p1, p2) -> p1.getNume().compareTo(p2.getNume()));
        System.out.println("Produse sortate după nume (lambda):");
        produse.forEach(System.out::println);
        
        System.out.println();
        
        // Sortare folosind Comparator.comparing (Java 8+)
        produse.sort(
            Comparator.comparing(Produs::getPret)
                      .reversed()
                      .thenComparing(Produs::getNume)
        );
        System.out.println("Produse sortate după preț (descrescător) și apoi după nume:");
        produse.forEach(System.out::println);
    }
}
```
