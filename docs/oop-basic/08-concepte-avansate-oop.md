# Documentație: Concepte Avansate în Programarea Orientată pe Obiecte

## Cuprins
1. [Agregarea și Compoziția](#agregarea-și-compoziția)
2. [Moștenirea](#moștenirea)
3. [Clasa de Bază](#clasa-de-bază)
4. [Clasa Derivată](#clasa-derivată)
5. [Polimorfismul](#polimorfismul)
6. [Suprascrierea Metodelor](#suprascrierea-metodelor)
7. [Cuvântul Cheie super](#cuvântul-cheie-super)
8. [Cuvântul Cheie final](#cuvântul-cheie-final)
9. [Cuvântul Cheie extends](#cuvântul-cheie-extends)
10. [Clasa Object](#clasa-object)
11. [Conversii de Tip](#conversii-de-tip)

## Agregarea și Compoziția

Agregarea și compoziția sunt două forme de asociere între clase care reprezintă relații de tip "are un" (*has-a*). Ambele sunt fundamentale pentru crearea de structuri complexe utilizând obiecte simple.

### Agregarea

**Agregarea** reprezintă o relație slabă *"are un"* între două clase, în care:
- Un obiect (containerul) poate conține unul sau mai multe obiecte de alt tip
- Obiectele conținute pot exista independent de obiectul container
- Există o relație de tip "parte din", dar părțile pot exista separat

```java
// Exemplu de agregare
public class Departament {
    private String nume;
    private List<Angajat> angajati; // Relație de agregare
    
    public Departament(String nume) {
        this.nume = nume;
        this.angajati = new ArrayList<>();
    }
    
    public void adaugaAngajat(Angajat angajat) {
        angajati.add(angajat);
    }
    
    public void eliminaAngajat(Angajat angajat) {
        angajati.remove(angajat);
    }
}

public class Angajat {
    private String nume;
    private String functie;
    
    public Angajat(String nume, String functie) {
        this.nume = nume;
        this.functie = functie;
    }
    
    // Getteri și setteri
}
```

În acest exemplu:
- Un `Departament` are mai mulți `Angajat`
- Un `Angajat` poate exista fără a fi atribuit unui `Departament`
- Dacă `Departament` este șters, obiectele `Angajat` pot continua să existe

### Compoziția

**Compoziția** reprezintă o relație puternică *"are un"* între două clase, în care:
- Obiectul conținut (parte) nu poate exista fără obiectul container (întreg)
- Ciclul de viață al părții este strict legat de ciclul de viață al întregului
- Când containerul este distrus, părțile componente sunt și ele distruse

```java
// Exemplu de compoziție
public class Motor {
    private String tip;
    private int putere;
    
    public Motor(String tip, int putere) {
        this.tip = tip;
        this.putere = putere;
    }
}

public class Masina {
    private String marca;
    private String model;
    private final Motor motor; // Relație de compoziție
    
    public Masina(String marca, String model, String tipMotor, int putereMotor) {
        this.marca = marca;
        this.model = model;
        this.motor = new Motor(tipMotor, putereMotor); // Creat și gestionat de Masina
    }
    
    // Getteri (fără setteri pentru motor - nu poate fi înlocuit)
}
```

În acest exemplu:
- O `Masina` are un `Motor`
- `Motor` este creat în constructorul `Masina` și nu poate exista în afara unei instanțe `Masina`
- Când `Masina` este distrusă (garbage collected), `Motor` este și el distrus

### Diferențe cheie

| Agregare | Compoziție |
|----------|------------|
| Relație slabă "are un" | Relație puternică "are un" |
| Obiectele pot exista independent | Obiectele componente nu pot exista independent |
| Obiectul container nu controlează ciclul de viață al componentelor | Ciclul de viață al componentelor este controlat de container |
| Poate fi reprezentată ca "folosește" | Este reprezentată ca "conține" |
| Relație de tip "parte-din" | Relație de tip "parte-de" |

## Moștenirea

**Moștenirea** este un mecanism fundamental al OOP care permite unei clase (subclasă) să moștenească atributele și metodele unei alte clase (superclasă). Acest mecanism implementează o relație de tip "este un" (*is-a*).

Caracteristici cheie ale moștenirii:
- Suportă reutilizarea codului
- Facilitează extinderea funcționalității
- Permite dezvoltarea ierarhiilor de clase
- Reprezintă un concept central al polimorfismului

```java
// Exemplu de moștenire
public class Vehicul {
    protected String marca;
    protected String model;
    protected int anFabricatie;
    
    public Vehicul(String marca, String model, int anFabricatie) {
        this.marca = marca;
        this.model = model;
        this.anFabricatie = anFabricatie;
    }
    
    public void afisareDetalii() {
        System.out.println("Vehicul: " + marca + " " + model + " (" + anFabricatie + ")");
    }
    
    public void deplasare() {
        System.out.println("Vehiculul se deplasează");
    }
}

public class Automobil extends Vehicul {
    private int numarUsi;
    private String tipCombustibil;
    
    public Automobil(String marca, String model, int anFabricatie, 
                    int numarUsi, String tipCombustibil) {
        super(marca, model, anFabricatie);
        this.numarUsi = numarUsi;
        this.tipCombustibil = tipCombustibil;
    }
    
    @Override
    public void afisareDetalii() {
        System.out.println("Automobil: " + marca + " " + model + " (" + anFabricatie + ")");
        System.out.println("  Număr uși: " + numarUsi);
        System.out.println("  Tip combustibil: " + tipCombustibil);
    }
    
    @Override
    public void deplasare() {
        System.out.println("Automobilul rulează pe șosea");
    }
    
    public void claxon() {
        System.out.println("Claxon!");
    }
}
```

În Java, o clasă poate moșteni o singură clasă (moștenire simplă), dar poate implementa mai multe interfețe.

### Tipuri de moștenire

1. **Moștenire simplă**: O clasă moștenește o singură clasă (supported în Java)
2. **Moștenire multiplă**: O clasă moștenește mai multe clase (nu este supported direct în Java, dar poate fi parțial implementată folosind interfețe)
3. **Moștenire pe niveluri/ierarhică**: O clasă moștenește o clasă, care la rândul ei moștenește o altă clasă
4. **Moștenire hibridă**: Combinație de mai multe tipuri de moștenire (implementată în Java folosind clase și interfețe)

## Clasa de Bază

**Clasa de bază** (sau superclasă, clasă părinte) este clasa care este moștenită de alte clase. Ea:
- Definește atributele și comportamentele comune
- Oferă implementarea de bază care poate fi extinsă sau modificată de subclase
- Este mai generală și mai abstractă decât subclasele sale

```java
// Exemplu de clasă de bază
public class Angajat {
    protected String nume;
    protected String prenume;
    protected double salariu;
    
    public Angajat(String nume, String prenume, double salariu) {
        this.nume = nume;
        this.prenume = prenume;
        this.salariu = salariu;
    }
    
    public void afisareDetalii() {
        System.out.println("Angajat: " + nume + " " + prenume);
        System.out.println("Salariu: " + salariu);
    }
    
    public double calculeazaSalariu() {
        return salariu;
    }
}
```

### Atribute și metode moștenite

Subclasele moștenesc:
- Toți membrii **public** și **protected** ai clasei de bază
- Membrii cu acces **default** (package-private) dacă subclasa este în același pachet
- Membrii **private** ai superclase nu sunt accesibili direct de subclase

## Clasa Derivată

**Clasa derivată** (sau subclasă, clasă copil) este o clasă care moștenește o altă clasă. Aceasta:
- Extinde funcționalitatea clasei de bază
- Moștenește și poate refolosi codul clasei de bază
- Poate adăuga noi atribute și metode
- Poate suprascrie (override) metodele moștenite pentru a le modifica comportamentul

```java
// Exemplu de clasă derivată
public class Manager extends Angajat {
    private double bonus;
    private int numarSubordonati;
    
    public Manager(String nume, String prenume, double salariu, 
                  double bonus, int numarSubordonati) {
        super(nume, prenume, salariu);  // Apelăm constructorul superclasei
        this.bonus = bonus;
        this.numarSubordonati = numarSubordonati;
    }
    
    @Override
    public void afisareDetalii() {
        super.afisareDetalii();  // Apelăm metoda superclasei
        System.out.println("Bonus: " + bonus);
        System.out.println("Număr subordonați: " + numarSubordonati);
    }
    
    @Override
    public double calculeazaSalariu() {
        return salariu + bonus;  // Suprascriem formula de calcul
    }
    
    // Metodă specifică clasei Manager
    public void organizeazaIntalnire() {
        System.out.println("Managerul " + nume + " organizează o întâlnire");
    }
}
```

## Polimorfismul

**Polimorfismul** ("multe forme") este abilitatea unui obiect de a se comporta diferit în funcție de context. Este unul dintre cele mai puternice concepte din programarea orientată pe obiecte.

Există două tipuri principale de polimorfism în Java:

### 1. Polimorfism la compilare (Static)

- Supraîncărcarea metodelor (method overloading)
- Rezolvat în timpul compilării
- Bazat pe numărul și tipul parametrilor

```java
public class Calculator {
    // Metodă supraîncărcată pentru adunarea a două numere
    public int aduna(int a, int b) {
        return a + b;
    }
    
    // Aceeași metodă supraîncărcată pentru adunarea a trei numere
    public int aduna(int a, int b, int c) {
        return a + b + c;
    }
    
    // Aceeași metodă supraîncărcată pentru numere reale
    public double aduna(double a, double b) {
        return a + b;
    }
}
```

### 2. Polimorfism la rulare (Dinamic)

- Suprascrierea metodelor (method overriding)
- Rezolvat în timpul rulării
- Permite unui obiect de tip superclasă să se comporte ca un obiect al subclaselor sale

```java
// Exemplu de polimorfism la rulare
public class ExempluPolimorfism {
    public static void main(String[] args) {
        // Declarăm un array de tip Angajat
        Angajat[] angajati = new Angajat[3];
        
        // Populăm array-ul cu obiecte de diferite tipuri
        angajati[0] = new Angajat("Popescu", "Ion", 3000);
        angajati[1] = new Manager("Ionescu", "Maria", 5000, 1000, 5);
        angajati[2] = new Programator("Vasilescu", "Ana", 4500, "Java", 3);
        
        // Polimorfismul în acțiune
        for (Angajat angajat : angajati) {
            // Metoda apelată depinde de tipul real al obiectului
            System.out.println("Salariu calculat: " + angajat.calculeazaSalariu());
            angajat.afisareDetalii();
            System.out.println("----------");
        }
    }
}

class Programator extends Angajat {
    private String limbajPrincipal;
    private int aniExperienta;
    
    public Programator(String nume, String prenume, double salariu,
                       String limbajPrincipal, int aniExperienta) {
        super(nume, prenume, salariu);
        this.limbajPrincipal = limbajPrincipal;
        this.aniExperienta = aniExperienta;
    }
    
    @Override
    public void afisareDetalii() {
        super.afisareDetalii();
        System.out.println("Limbaj principal: " + limbajPrincipal);
        System.out.println("Ani experiență: " + aniExperienta);
    }
    
    @Override
    public double calculeazaSalariu() {
        return salariu + (salariu * 0.1 * aniExperienta);
    }
}
```

### Beneficii ale polimorfismului

- Permite tratarea obiectelor de diferite tipuri în mod uniform
- Facilitează extinderea sistemului cu noi funcționalități
- Reduce dependențele de tipuri specifice
- Promovează design-ul orientat pe interfețe, nu pe implementări

## Suprascrierea Metodelor

**Suprascrierea metodelor** (method overriding) permite unei subclase să ofere o implementare specifică pentru o metodă deja definită în superclasă.

Reguli pentru suprascrierea corectă a metodelor:
1. Metoda din subclasă trebuie să aibă aceeași semnătură (nume și parametri) ca metoda din superclasă
2. Metoda din subclasă trebuie să aibă același tip de retur sau un subtip al tipului de retur din superclasă (covariant return type)
3. Nivelul de acces al metodei din subclasă nu poate fi mai restrictiv decât cel al metodei din superclasă
4. Metoda din subclasă nu poate arunca excepții verificate (checked exceptions) mai largi sau noi față de cele definite în metoda din superclasă
5. Metodele statice, finale sau private nu pot fi suprascrise

```java
// Exemplu de suprascriere a metodelor
public class Animal {
    public void emiteSunet() {
        System.out.println("Animalul emite un sunet");
    }
    
    public Animal reproducere() {
        System.out.println("Creează un animal nou");
        return new Animal();
    }
}

public class Pisica extends Animal {
    @Override
    public void emiteSunet() {
        System.out.println("Pisica miaună");
    }
    
    // Exemplu de covariant return type
    @Override
    public Pisica reproducere() {
        System.out.println("Creează o pisică nouă");
        return new Pisica();
    }
}
```

### Adnotația @Override

- Nu este obligatorie, dar este recomandată
- Indică compilatorului că intenția este de a suprascrie o metodă
- Ajută la detectarea erorilor (dacă metoda supracrisă nu există în superclasă, compilatorul semnalează eroare)

## Cuvântul Cheie super

Cuvântul cheie **super** se referă la superclasa clasei curente și are două utilizări principale:

### 1. Apelarea constructorului superclasei

- Trebuie să fie primul statement într-un constructor al subclaselor
- Dacă nu este specificat explicit, compilatorul inserează `super()` (apel către constructorul fără parametri)
- Permite inițializarea membrilor moșteniți

```java
public class Vehicul {
    protected String marca;
    protected int anFabricatie;
    
    public Vehicul(String marca, int anFabricatie) {
        this.marca = marca;
        this.anFabricatie = anFabricatie;
    }
}

public class Motocicleta extends Vehicul {
    private int putere;
    
    public Motocicleta(String marca, int anFabricatie, int putere) {
        super(marca, anFabricatie); // Apelul constructorului din superclasă
        this.putere = putere;
    }
}
```

### 2. Apelarea metodelor din superclasă

- Permite accesul la metode suprascrise din superclasă
- Util când dorim să extindem comportamentul, nu să-l înlocuim complet

```java
public class Forma {
    public void desenare() {
        System.out.println("Desenează o formă");
    }
}

public class Cerc extends Forma {
    private double raza;
    
    public Cerc(double raza) {
        this.raza = raza;
    }
    
    @Override
    public void desenare() {
        super.desenare(); // Apelează metoda din superclasă
        System.out.println("Desenează un cerc cu raza " + raza);
    }
}
```

## Cuvântul Cheie final

Cuvântul cheie **final** în contextul moștenirii poate fi aplicat la trei niveluri:

### 1. Clase finale

- O clasă marcată ca `final` nu poate fi moștenită (extinsă)
- Folosită pentru a preveni modificarea claselor care trebuie să rămână neschimbate
- Exemple din Java: `String`, `Integer`, `System`

```java
public final class ContBancarSecurizat {
    // Implementare care nu poate fi extinsă
}

// Acest cod va genera eroare de compilare
// public class ContExtins extends ContBancarSecurizat { ... }
```

### 2. Metode finale

- O metodă marcată ca `final` nu poate fi suprascrisă în subclase
- Asigură că comportamentul metodei rămâne constant în întreaga ierarhie de moștenire
- Adesea folosită pentru metode critice care nu trebuie modificate

```java
public class ContBancar {
    private double sold;
    
    public final void transferSecurizat(ContBancar destinatie, double suma) {
        // Implementare care nu poate fi modificată de subclase
        if (suma > 0 && suma <= sold) {
            this.sold -= suma;
            destinatie.depunere(suma);
        }
    }
    
    public void depunere(double suma) {
        if (suma > 0) {
            this.sold += suma;
        }
    }
}
```

### 3. Variabile finale

- O variabilă marcată ca `final` devine constantă și nu poate fi reatribuită
- În contextul moștenirii, asigură că valoarea atributului nu poate fi modificată de subclase

```java
public class ConfiguratieSistem {
    protected final int TIMEOUT_SECUNDE = 30;
    protected final String VERSIUNE;
    
    public ConfiguratieSistem(String versiune) {
        this.VERSIUNE = versiune; // Inițializare în constructor
    }
}
```

## Cuvântul Cheie extends

Cuvântul cheie **extends** este folosit pentru a indica faptul că o clasă moștenește o altă clasă:

```java
// Sintaxa de bază
public class SubClasa extends SuperClasa {
    // Implementarea subclasei
}
```

Utilizări ale cuvântului cheie `extends`:

### 1. Moștenirea claselor

```java
public class Animal {
    protected String nume;
    
    public void mananca() {
        System.out.println(nume + " mănâncă");
    }
}

public class Caine extends Animal {
    public Caine(String nume) {
        this.nume = nume;
    }
    
    public void latra() {
        System.out.println(nume + " latră");
    }
}
```

### 2. Moștenirea claselor abstracte

```java
public abstract class InstrumentMuzical {
    protected String nume;
    
    public abstract void canta();
    
    public void afisareInstrument() {
        System.out.println("Instrument: " + nume);
    }
}

public class Vioara extends InstrumentMuzical {
    public Vioara() {
        this.nume = "Vioara";
    }
    
    @Override
    public void canta() {
        System.out.println("Vioara cântă melodios");
    }
}
```

### 3. În definirea tipurilor generice (generic types)

```java
// Definirea unei metode care acceptă orice tip care extinde Comparable
public <T extends Comparable<T>> T maxim(T a, T b) {
    if (a.compareTo(b) > 0) {
        return a;
    }
    return b;
}
```

## Clasa Object

**Object** (`java.lang.Object`) este superclasa tuturor claselor în Java. Fiecare clasă moștenește implicit `Object` dacă nu extinde explicit o altă clasă.

```java
// Aceste două declarații sunt echivalente
public class ExempluClasa { }
public class ExempluClasa extends Object { }
```

### Metode importante din clasa Object

1. **toString()** - Returnează o reprezentare textuală a obiectului
   ```java
   @Override
   public String toString() {
       return "ExempluClasa{" +
              "atribut1=" + atribut1 +
              ", atribut2='" + atribut2 + '\'' +
              '}';
   }
   ```

2. **equals(Object obj)** - Compară obiectul curent cu un alt obiect
   ```java
   @Override
   public boolean equals(Object obj) {
       if (this == obj) return true;
       if (obj == null || getClass() != obj.getClass()) return false;
       
       ExempluClasa that = (ExempluClasa) obj;
       return atribut1 == that.atribut1 && 
              Objects.equals(atribut2, that.atribut2);
   }
   ```

3. **hashCode()** - Returnează un cod hash pentru obiect
   ```java
   @Override
   public int hashCode() {
       return Objects.hash(atribut1, atribut2);
   }
   ```

4. **clone()** - Creează și returnează o copie a obiectului
   ```java
   @Override
   protected Object clone() throws CloneNotSupportedException {
       return super.clone();
   }
   ```

5. **getClass()** - Returnează clasa runtime a obiectului
   ```java
   public void afisareTipObiect() {
       System.out.println("Tipul obiectului: " + this.getClass().getName());
   }
   ```

6. **finalize()** - Apelat de garbage collector înainte de a elibera memoria
   ```java
   @Override
   protected void finalize() throws Throwable {
       // Eliberare resurse
       System.out.println("Obiect finalizat");
       super.finalize();
   }
   ```

## Conversii de Tip

Conversiile de tip (type casting) în contextul programării orientate pe obiecte se referă la schimbarea tipului aparent al unei referințe. Există două tipuri principale:

### 1. Upcasting (Conversie către superclasă)

- Conversia unui obiect de la o subclasă la o superclasă
- Este întotdeauna sigură și se face implicit
- Restricționează accesul la membrii specifici subclasei

```java
// Upcasting
Animal animal = new Caine("Rex"); // Upcasting implicit
animal.mananca();  // OK - metoda din clasa Animal
// animal.latra(); // Eroare - metoda specifică clasei Caine nu este accesibilă
```

### 2. Downcasting (Conversie către subclasă)

- Conversia unui obiect de la o superclasă la o subclasă
- Trebuie făcută explicit și poate genera `ClassCastException` dacă este incorectă
- Permite accesul la membrii specifici subclasei

```java
// Downcasting
Animal animalGeneric = new Caine("Rex");
// Verificare înainte de downcasting
if (animalGeneric instanceof Caine) {
    Caine caine = (Caine) animalGeneric; // Downcasting explicit
    caine.latra(); // Acum putem accesa metoda specifică
}
```

### Operatorul instanceof

- Verifică dacă un obiect este o instanță a unei anumite clase
- Folosit adesea înainte de downcasting pentru a evita excepțiile
- Returnează `true` și dacă obiectul este instanță a unei subclase a clasei specificate

```java
Animal animal = new Caine("Rex");

if (animal instanceof Animal) {
    System.out.println("Este un Animal"); // Se va afișa
}

if (animal instanceof Caine) {
    System.out.println("Este un Caine"); // Se va afișa
}

if (animal instanceof Pisica) {
    System.out.println("Este o Pisica"); // Nu se va afișa
}
```

### Conversii și polimorfism

Conversiile de tip sunt esențiale pentru implementarea polimorfismului:

```java
public void tratareAnimal(Animal animal) {
    animal.mananca(); // Comportament polimorfic
    
    // Tratare specifică în funcție de tipul concret
    if (animal instanceof Caine) {
        Caine caine = (Caine) animal;
        caine.latra();
    } else if (animal instanceof Pisica) {
        Pisica pisica = (Pisica) animal;
        pisica.toarce();
    }
}
```

### Pattern Matching pentru instanceof (Java 16+)

În versiunile recente de Java, există o sintaxă îmbunătățită pentru instanceof combinată cu casting:

```java
if (animal instanceof Caine caine) {
    // Variabila 'caine' este disponibilă automat aici
    caine.latra();
} else if (animal instanceof Pisica pisica) {
    pisica.toarce();
}
```

Această funcționalitate simplifica codul și reduce riscul de erori.