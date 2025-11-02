# Interfete si Clase Abstracte

## Enum

**Enum** (enumerare) este un tip special de clasă care reprezintă un grup de constante (variabile care nu-și pot schimba valoarea după ce au fost declarate).

### Caracteristici ale Enum-urilor

- Sunt implicite `public static final`
- Moștenesc implicit clasa `java.lang.Enum`
- Nu pot fi extinse (sunt implicit `final`)
- Pot avea constructori, metode și câmpuri
- Sunt comparabile și serializabile
- Se pot utiliza în instrucțiuni `switch`

### Sintaxa de Bază

```java
public enum ZiSaptamana {
    LUNI, MARTI, MIERCURI, JOI, VINERI, SAMBATA, DUMINICA
}
```

### Utilizarea Enum

```java
ZiSaptamana zi = ZiSaptamana.LUNI;

// Verificare
if (zi == ZiSaptamana.SAMBATA || zi == ZiSaptamana.DUMINICA) {
    System.out.println("Este weekend!");
} else {
    System.out.println("Este zi lucrătoare.");
}

// Utilizare în switch
switch (zi) {
    case LUNI:
        System.out.println("Prima zi a săptămânii");
        break;
    case VINERI:
        System.out.println("Ultima zi lucrătoare");
        break;
    default:
        System.out.println("Altă zi");
}
```

### Enum cu Proprietăți și Metode

```java
public enum Planet {
    MERCURY(3.303e+23, 2.4397e6),
    VENUS(4.869e+24, 6.0518e6),
    EARTH(5.976e+24, 6.37814e6),
    MARS(6.421e+23, 3.3972e6),
    JUPITER(1.9e+27, 7.1492e7),
    SATURN(5.688e+26, 6.0268e7),
    URANUS(8.686e+25, 2.5559e7),
    NEPTUNE(1.024e+26, 2.4746e7);

    private final double mass;   // în kilograme
    private final double radius; // în metri

    // Constructor privat
    Planet(double mass, double radius) {
        this.mass = mass;
        this.radius = radius;
    }

    // Metode de acces
    public double getMass() {
        return mass;
    }

    public double getRadius() {
        return radius;
    }

    // Metode custom
    public double gravitationalAcceleration() {
        double G = 6.67300E-11; // Constanta gravitațională
        return G * mass / (radius * radius);
    }
}
```

### Metode Utile Moștenite

- `values()` - returnează un array cu toate valorile enum-ului
- `valueOf(String)` - returnează valoarea enum corespunzătoare șirului dat
- `name()` - returnează numele valorii enum ca șir
- `ordinal()` - returnează poziția valorii în declarația enum (începând de la 0)

```java
// Iterează prin toate valorile enum-ului
for (ZiSaptamana zi : ZiSaptamana.values()) {
    System.out.println(zi.name() + " - poziția " + zi.ordinal());
}

// Obține valoarea pe baza unui șir
ZiSaptamana zi = ZiSaptamana.valueOf("LUNI");
```

## Clase Abstracte

**Clasa abstractă** este o clasă care nu poate fi instanțiată direct și este destinată să fie subclasată de alte clase. Poate conține atât metode abstracte (declarate, dar fără implementare), cât și metode concrete (cu implementare).

### Caracteristici ale Claselor Abstracte

- Declarate cu modificatorul `abstract`
- Nu pot fi instanțiate direct (`new ClasaAbstracta()` va da eroare)
- Pot conține metode abstracte și non-abstracte
- Pot conține constructori, deși nu pot fi utilizați pentru instanțiere directă
- Pot conține câmpuri (atribute)
- Subclasele trebuie să implementeze toate metodele abstracte sau să fie, la rândul lor, declarate abstracte

### Declararea unei Clase Abstracte

```java
public abstract class FormaGeometrica {
    // Câmpuri
    protected String nume;
    protected String culoare;
    
    // Constructor
    public FormaGeometrica(String nume, String culoare) {
        this.nume = nume;
        this.culoare = culoare;
    }
    
    // Metodă abstractă - fără implementare
    public abstract double aria();
    
    // Metodă concretă - cu implementare
    public void afisareDetalii() {
        System.out.println("Formă: " + nume);
        System.out.println("Culoare: " + culoare);
        System.out.println("Aria: " + aria());
    }
}
```

### Extinderea unei Clase Abstracte

```java
public class Cerc extends FormaGeometrica {
    private double raza;
    
    public Cerc(String culoare, double raza) {
        super("Cerc", culoare);
        this.raza = raza;
    }
    
    // Implementarea metodei abstracte
    @Override
    public double aria() {
        return Math.PI * raza * raza;
    }
}

public class Dreptunghi extends FormaGeometrica {
    private double lungime;
    private double latime;
    
    public Dreptunghi(String culoare, double lungime, double latime) {
        super("Dreptunghi", culoare);
        this.lungime = lungime;
        this.latime = latime;
    }
    
    // Implementarea metodei abstracte
    @Override
    public double aria() {
        return lungime * latime;
    }
}
```

### Utilizarea Claselor Abstracte

```java
// Nu este permis: FormaGeometrica forma = new FormaGeometrica();

FormaGeometrica cerc = new Cerc("roșu", 5.0);
FormaGeometrica dreptunghi = new Dreptunghi("albastru", 4.0, 6.0);

cerc.afisareDetalii();
dreptunghi.afisareDetalii();
```

### Când se Utilizează Clasele Abstracte

- Când dorim să oferim o implementare parțială pe care subclasele o pot extinde
- Când clasele derivate au multe caracteristici comune (atribute și metode)
- Când dorim să definim un tip care nu poate fi instanțiat direct
- Când dorim să permitem accesul la membrii protected sau private

## Interfețe

**Interfața** este un tip de referință în Java care conține doar constante și metode abstracte (până la Java 8), oferind o "schiță" pentru clasele care o implementează.

### Caracteristici ale Interfețelor

- Nu pot conține implementări de metode (înainte de Java 8)
- Toate metodele sunt implicit `public abstract`
- Toate câmpurile sunt implicit `public static final`
- O clasă poate implementa mai multe interfețe (spre deosebire de moștenire)
- Oferă o formă de "moștenire multiplă" în Java

### Declararea unei Interfețe

```java
public interface Platibil {
    // Constantă (implicit public static final)
    double TAXA_TRANSFER = 0.01;
    
    // Metode abstracte (implicit public abstract)
    double calculeazaSuma();
    void efectueazaPlata();
}
```

### Implementarea unei Interfețe

```java
public class Factura implements Platibil {
    private double suma;
    private String beneficiar;
    
    public Factura(double suma, String beneficiar) {
        this.suma = suma;
        this.beneficiar = beneficiar;
    }
    
    @Override
    public double calculeazaSuma() {
        return suma + (suma * TAXA_TRANSFER);
    }
    
    @Override
    public void efectueazaPlata() {
        System.out.println("Plătesc factura de " + suma + 
                           " lei către " + beneficiar);
    }
}
```

### Interfețe Multiple

```java
public interface Imprimabil {
    void imprima();
}

public class Factura implements Platibil, Imprimabil {
    // ... (codul de mai sus)
    
    @Override
    public void imprima() {
        System.out.println("Imprimare factură pentru " + beneficiar + 
                           " în valoare de " + suma + " lei");
    }
}
```

### Când se Utilizează Interfețele

- Când dorim să definim un contract pe care clasele trebuie să-l respecte
- Când avem nevoie de "moștenire multiplă"
- Când dorim să specificăm comportamentul fără a impune o anumită implementare
- Pentru a realiza un design slab cuplat (decuplat)

## Interfețe Funcționale

**Interfața funcțională** este o interfață care conține exact o metodă abstractă. Acestea sunt folosite ca bază pentru expresiile lambda și referințele la metode în Java 8+.

### Caracteristici ale Interfețelor Funcționale

- Conțin exact o metodă abstractă
- Pot conține metode default și statice
- Pot fi marcate cu adnotarea `@FunctionalInterface` (opțional, dar recomandată)
- Sunt folosite pentru programarea funcțională în Java

### Declararea unei Interfețe Funcționale

```java
@FunctionalInterface
public interface Calculator {
    // Exact o metodă abstractă
    double calculeaza(double a, double b);
    
    // Pot exista metode default
    default void afiseazaOperatie() {
        System.out.println("Efectuez o operație matematică");
    }
}
```

### Interfețe Funcționale Predefinite

Java 8 a introdus mai multe interfețe funcționale predefinite în pachetul `java.util.function`:

1. **Function<T, R>** - primește un argument de tip T și returnează un rezultat de tip R
   ```java
   Function<String, Integer> lungime = s -> s.length();
   ```

2. **Predicate<T>** - primește un argument de tip T și returnează un boolean
   ```java
   Predicate<String> esteGol = s -> s.isEmpty();
   ```

3. **Consumer<T>** - primește un argument de tip T și nu returnează nimic
   ```java
   Consumer<String> afiseaza = s -> System.out.println(s);
   ```

4. **Supplier<T>** - nu primește niciun argument și returnează un rezultat de tip T
   ```java
   Supplier<Double> numarRandom = () -> Math.random();
   ```

### Utilizarea Interfețelor Funcționale cu Lambda

```java
@FunctionalInterface
interface Salut {
    void spuneSalut(String nume);
}

public class ExempluLambda {
    public static void main(String[] args) {
        // Implementare folosind expresie lambda
        Salut salutFormal = nume -> System.out.println("Bună ziua, " + nume + "!");
        Salut salutInformal = nume -> System.out.println("Salut, " + nume + "!");
        
        salutFormal.spuneSalut("Domnul Popescu");
        salutInformal.spuneSalut("Ion");
        
        // Utilizarea unei interfețe funcționale predefinite
        List<String> nume = Arrays.asList("Ana", "Ion", "Maria", "Andrei");
        
        // Consumer cu lambda
        Consumer<String> afiseazaMajuscule = s -> System.out.println(s.toUpperCase());
        nume.forEach(afiseazaMajuscule);
        
        // Predicate cu lambda
        Predicate<String> incepeCuA = s -> s.startsWith("A");
        nume.stream()
            .filter(incepeCuA)
            .forEach(System.out::println);
    }
}
```

## Metode Default

Începând cu Java 8, interfețele pot conține **metode default**, care oferă o implementare implicită ce poate fi moștenită sau suprascrisă de clasele care implementează interfața.

### Caracteristici ale Metodelor Default

- Declarate cu cuvântul cheie `default`
- Au o implementare în interfață
- Permit extinderea interfețelor fără a strica codul existent
- Pot fi suprascrise de clasele care implementează interfața

### Declararea Metodelor Default

```java
public interface Vehicul {
    // Metodă abstractă
    void accelereaza(int viteza);
    
    // Metodă default cu implementare
    default void opreste() {
        System.out.println("Vehiculul s-a oprit");
    }
    
    default String descriere() {
        return "Vehicul standard";
    }
}
```

### Implementarea și Suprascrierea Metodelor Default

```java
public class Masina implements Vehicul {
    private String marca;
    
    public Masina(String marca) {
        this.marca = marca;
    }
    
    @Override
    public void accelereaza(int viteza) {
        System.out.println(marca + " accelerează la " + viteza + " km/h");
    }
    
    // Suprascriem o metodă default
    @Override
    public String descriere() {
        return "Mașină marca " + marca;
    }
    
    // Nu suprascriem opreste(), va folosi implementarea din interfață
}

public class Bicicleta implements Vehicul {
    @Override
    public void accelereaza(int viteza) {
        System.out.println("Bicicleta atinge " + viteza + " km/h");
    }
    
    // Suprascriem ambele metode default
    @Override
    public void opreste() {
        System.out.println("Bicicleta a oprit pedalarea");
    }
    
    @Override
    public String descriere() {
        return "Bicicletă simplă";
    }
}
```

### Rezolvarea Conflictelor de Metode Default

Când o clasă implementează mai multe interfețe care au metode default cu aceeași semnătură, trebuie să rezolvăm acest conflict explicit:

```java
public interface Motor {
    default void porneste() {
        System.out.println("Motorul pornește");
    }
}

public interface Vehicul {
    default void porneste() {
        System.out.println("Vehiculul pornește");
    }
}

public class Automobil implements Motor, Vehicul {
    // Rezolvarea conflictului între metode default cu aceeași semnătură
    @Override
    public void porneste() {
        // Putem apela implementarea specifică dintr-o interfață
        Motor.super.porneste();
        // sau
        Vehicul.super.porneste();
        // sau o implementare complet nouă
        System.out.println("Automobilul pornește");
    }
}
```

## Metode Statice în Interfețe

Începând cu Java 8, interfețele pot conține și **metode statice**, care aparțin interfeței și nu instanțelor claselor care implementează interfața.

### Caracteristici ale Metodelor Statice în Interfețe

- Declarate cu modificatorul `static`
- Nu pot fi suprascrise de clase care implementează interfața
- Sunt apelate direct prin numele interfeței (nu prin instanțe)
- Utile pentru funcționalități auxiliare legate de interfață

### Declararea Metodelor Statice

```java
public interface OperatiiMatematice {
    // Metodă abstractă
    double calculeaza(double a, double b);
    
    // Metodă statică
    static double patrat(double numar) {
        return numar * numar;
    }
    
    static OperatiiMatematice adunare() {
        return (a, b) -> a + b;
    }
    
    static OperatiiMatematice scadere() {
        return (a, b) -> a - b;
    }
}
```

### Utilizarea Metodelor Statice

```java
public class CalculatorMatematic {
    public static void main(String[] args) {
        // Apelarea metodei statice direct prin interfață
        double rezultat = OperatiiMatematice.patrat(5);
        System.out.println("Pătratul lui 5 este: " + rezultat);
        
        // Utilizarea metodelor factory statice
        OperatiiMatematice adunare = OperatiiMatematice.adunare();
        OperatiiMatematice scadere = OperatiiMatematice.scadere();
        
        System.out.println("3 + 4 = " + adunare.calculeaza(3, 4));
        System.out.println("10 - 7 = " + scadere.calculeaza(10, 7));
    }
}
```

### Diferențe față de Metode Default

- Metodele default sunt legate de instanțele claselor care implementează interfața
- Metodele statice aparțin interfeței și nu pot fi suprascrise
- Metodele statice sunt apelate prin numele interfeței, nu prin instanțe

## Clase Interne

**Clasele interne** (inner classes) sunt clase definite în interiorul altor clase. Există patru tipuri principale de clase interne în Java.

### Avantajele Claselor Interne

- Gruparea claselor care sunt utilizate doar într-un singur loc
- Creșterea încapsulării
- Acces la membrii privați ai clasei exterioare
- Cod mai organizat și mai lizibil

## Clase Interne Statice

**Clasele interne statice** sunt clase definite în interiorul unei alte clase cu modificatorul `static`.

### Caracteristici ale Claselor Interne Statice

- Declarate cu modificatorul `static`
- Nu au acces la membrii non-statici ai clasei exterioare
- Pot fi instanțiate fără o instanță a clasei exterioare
- Pot conține membri statici și non-statici
- Sunt asociate cu clasa exterioară, nu cu instanțe ale acesteia

### Declararea Claselor Interne Statice

```java
public class ExteriorClasa {
    private static int dataMembra = 10;
    
    // Clasă internă statică
    public static class InteriorStatica {
        private int valoare;
        
        public InteriorStatica(int valoare) {
            this.valoare = valoare;
        }
        
        public void afiseaza() {
            // Poate accesa doar membri statici ai clasei exterioare
            System.out.println("Data membră statică: " + dataMembra);
            System.out.println("Valoare internă: " + valoare);
        }
    }
    
    public static void main(String[] args) {
        // Instanțierea directă, fără a instanția ExteriorClasa
        InteriorStatica obiect = new ExteriorClasa.InteriorStatica(5);
        obiect.afiseaza();
    }
}
```

### Utilizarea Claselor Interne Statice

Clasele interne statice sunt adesea utilizate pentru:
- Implementarea de modele de proiectare (cum ar fi Builder pattern)
- Gruparea tipurilor înrudite
- Clase ajutătoare care nu au nevoie de acces la starea instanței clasei exterioare

```java
public class ListaRezultate {
    // Clasă internă statică pentru reprezentarea unui rezultat
    public static class Rezultat {
        private String nume;
        private int scor;
        
        public Rezultat(String nume, int scor) {
            this.nume = nume;
            this.scor = scor;
        }
        
        public String getNume() {
            return nume;
        }
        
        public int getScor() {
            return scor;
        }
    }
    
    private List<Rezultat> rezultate = new ArrayList<>();
    
    public void adaugaRezultat(String nume, int scor) {
        rezultate.add(new Rezultat(nume, scor));
    }
    
    public List<Rezultat> getRezultate() {
        return rezultate;
    }
}

// Utilizare
ListaRezultate lista = new ListaRezultate();
lista.adaugaRezultat("Ana", 95);

// Instanțiere directă a clasei interne statice
ListaRezultate.Rezultat rezultatNou = new ListaRezultate.Rezultat("Ion", 87);
```

## Clase Interne de Instanță

**Clasele interne de instanță** (non-statice) sunt clase definite în interiorul unei alte clase fără modificatorul `static`.

### Caracteristici ale Claselor Interne de Instanță

- Nu sunt declarate cu `static`
- Au acces la toți membrii clasei exterioare (inclusiv cei privați)
- Necesită o instanță a clasei exterioare pentru a fi instanțiate
- Nu pot conține membri statici
- Sunt asociate cu instanțe ale clasei exterioare

### Declararea Claselor Interne de Instanță

```java
public class ClasaExterioara {
    private int x = 10;
    
    // Clasă internă de instanță
    public class ClasaInterioara {
        private int y = 5;
        
        public void afiseazaSuma() {
            // Poate accesa membri privați ai clasei exterioare
            System.out.println("Suma: " + (x + y));
        }
        
        public void setX(int valoare) {
            // Poate modifica membri privați ai clasei exterioare
            ClasaExterioara.this.x = valoare;
        }
    }
    
    public void creeazaClasaInterioara() {
        ClasaInterioara interior = new ClasaInterioara();
        interior.afiseazaSuma();
    }
}
```

### Utilizarea Claselor Interne de Instanță

```java
ClasaExterioara exterioara = new ClasaExterioara();
ClasaExterioara.ClasaInterioara interioara = exterioara.new ClasaInterioara();
interioara.afiseazaSuma();
```

### Exemple de Utilizare

Clasele interne de instanță sunt utile pentru:
- Încapsularea logicii care aparține doar unei instanțe a clasei exterioare
- Implementarea interfeței cu acces la starea instanței clasei exterioare
- Crearea de clase ajutătoare care sunt strâns legate de instanța clasei exterioare

```java
public class ListaGenerica<T> {
    private Node first;
    private int size = 0;
    
    // Clasă internă de instanță pentru implementarea nodurilor listei
    private class Node {
        T data;
        Node next;
        
        Node(T data) {
            this.data = data;
            this.next = null;
        }
    }
    
    public void add(T item) {
        Node newNode = new Node(item);
        
        if (first == null) {
            first = newNode;
        } else {
            Node current = first;
            while (current.next != null) {
                current = current.next;
            }
            current.next = newNode;
        }
        
        size++;
    }
    
    public int size() {
        return size;
    }
    
    // Implementarea unui iterator folosind o clasă internă
    public Iterator<T> iterator() {
        return new ListaIterator();
    }
    
    private class ListaIterator implements Iterator<T> {
        private Node current = first;
        
        @Override
        public boolean hasNext() {
            return current != null;
        }
        
        @Override
        public T next() {
            if (!hasNext()) {
                throw new NoSuchElementException();
            }
            
            T data = current.data;
            current = current.next;
            return data;
        }
    }
}
```

## Clase Interne Locale

**Clasele interne locale** sunt clase definite în interiorul unei metode sau bloc.

### Caracteristici ale Claselor Interne Locale

- Definite în interiorul unei metode sau bloc (nu în corpul clasei)
- Vizibile doar în cadrul metodei sau blocului în care sunt definite
- Pot accesa membrii clasei exterioare și variabilele locale care sunt finale sau efectiv finale (nu se modifică după inițializare)
- Nu pot conține membri statici
- Nu pot avea modificatori de acces (public, private, protected)

### Declararea Claselor Interne Locale

```java
public class ClasaExterioara {
    private int x = 10;
    
    public void metoda(final int parametru) {
        final int variabilaLocala = 20;
        int variabilaEfectivFinala = 30; // efectiv finală - nu se modifică
        
        // Clasă internă locală
        class ClasaLocala {
            private int y = 5;
            
            public void afiseaza() {
                // Poate accesa membri ai clasei exterioare
                System.out.println("x: " + x);
                
                // Poate accesa variabile locale finale sau efectiv finale
                System.out.println("parametru: " + parametru);
                System.out.println("variabilaLocala: " + variabilaLocala);
                System.out.println("variabilaEfectivFinala: " + variabilaEfectivFinala);
                
                System.out.println("y: " + y);
            }
        }
        
        // Creează o instanță a clasei locale
        ClasaLocala obiect = new ClasaLocala();
        obiect.afiseaza();
        
        // variabilaEfectivFinala = 40; // Ar face variabila să nu mai fie efectiv finală
    }
}
```

### Utilizarea Claselor Interne Locale

Clasele interne locale sunt utile pentru:
- Implementarea logicii specifice doar unei metode
- Implementarea interfeței pentru un callback local
- Încapsularea codului care va fi utilizat doar într-un singur context

```java
public class Sortator {
    public void sorteazaDupaLungime(String[] siruri) {
        // Clasa locală pentru comparare
        class ComparatorLungime implements Comparator<String> {
            @Override
            public int compare(String s1, String s2) {
                return s1.length() - s2.length();
            }
        }
        
        Arrays.sort(siruri, new ComparatorLungime());
    }
    
    public void afiseazaSortate(String[] siruri) {
        sorteazaDupaLungime(siruri);
        for (String s : siruri) {
            System.out.println(s);
        }
    }
}
```

## Clase Interne Anonime

**Clasele interne anonime** sunt clase locale fără nume, definite și instanțiate într-o singură expresie.

### Caracteristici ale Claselor Interne Anonime

- Nu au nume
- Sunt declarate și instanțiate în același timp
- Pot extinde o clasă sau implementa o interfață, dar nu ambele
- Nu pot avea constructori expliciți (deoarece nu au nume)
- Pot accesa membri ai clasei exterioare și variabile locale finale sau efectiv finale
- Nu pot avea membri statici
- Sunt definite în expresii, nu în declarații

### Sintaxa pentru Clasele Interne Anonime

```java
// Extinderea unei clase
ObiectClasa obiect = new ObiectClasa() {
    // Implementare
};

// Implementarea unei interfețe
InterfataExemplu obiect = new InterfataExemplu() {
    // Implementare
};
```

### Exemple de Clase Interne Anonime

```java
public class ExempluAnonime {
    public void exemplu() {
        // Clasă anonimă care extinde Thread
        Thread thread = new Thread() {
            @Override
            public void run() {
                System.out.println("Thread rulează");
            }
        };
        thread.start();
        
        // Clasă anonimă care implementează Runnable
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                System.out.println("Runnable rulează");
            }
        };
        new Thread(runnable).start();
        
        // Clasă anonimă pentru un ascultător de evenimente (event listener)
        button.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                System.out.println("Butonul a fost apăsat");
            }
        });
    }
}
```

### Clasă Anonimă vs. Expresie Lambda

Începând cu Java 8, expresiile lambda pot înlocui multe clase anonime pentru interfețe funcționale:

```java
// Clasă anonimă
Comparator<String> compAnonym = new Comparator<String>() {
    @Override
    public int compare(String s1, String s2) {
        return s1.length() - s2.length();
    }
};

// Echivalent cu expresie lambda
Comparator<String> compLambda = (s1, s2