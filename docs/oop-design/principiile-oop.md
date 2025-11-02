# Principiile de baza OOP

## Principiul Încapsulării

Încapsularea este unul dintre principiile fundamentale ale OOP care:
- Ascunde implementarea internă a unui obiect
- Expune doar o interfață publică pentru interacțiune
- Protejează integritatea datelor

Implementarea încapsulării:
1. Declararea atributelor ca `private`
2. Furnizarea metodelor publice de acces (getteri) și modificare (setteri)

```java
public class ContBancar {
    // Atribute private (ascunse față de exterior)
    private String numarCont;
    private double sold;
    private String proprietar;

    // Constructor
    public ContBancar(String numarCont, String proprietar) {
        this.numarCont = numarCont;
        this.proprietar = proprietar;
        this.sold = 0.0;
    }

    // Metode Getter - permit citirea atributelor
    public String getNumarCont() {
        return numarCont;
    }

    public String getProprietar() {
        return proprietar;
    }

    public double getSold() {
        return sold;
    }

    // Metode Setter - permit modificarea controlată a atributelor
    public void setProprietar(String proprietar) {
        this.proprietar = proprietar;
    }

    // Nu oferim setter pentru numarCont - nu dorim să permitem modificarea

    // Metode de business - implementează logica de modificare a soldului
    public void depunere(double suma) {
        if (suma > 0) {
            sold += suma;
        }
    }

    public boolean retragere(double suma) {
        if (suma > 0 && suma <= sold) {
            sold -= suma;
            return true;
        }
        return false;
    }
}
```

Avantajele încapsulării:
- Controlul asupra modului în care datele sunt accesate și modificate
- Validarea datelor la intrare
- Posibilitatea modificării implementării interne fără a afecta codul client
- Ascunderea detaliilor de implementare

## Principiul Moștenirii

Moștenirea permite crearea de noi clase (clase derivate) bazate pe clase existente (clase de bază), preluând și extinzând funcționalitățile acestora.

Implementarea moștenirii:
1. Utilizarea cuvântului cheie `extends` în Java (sau echivalent în alte limbaje)
2. Crearea de subclase specializate

```java
public class ContEconomii extends ContBancar {
    // Atribut adițional
    private double rataDobanzii;
    
    // Constructor
    public ContEconomii(String numarCont, String proprietar, double rataDobanzii) {
        super(numarCont, proprietar); // Apel constructor clasa părinte
        this.rataDobanzii = rataDobanzii;
    }
    
    // Getter și Setter pentru noul atribut
    public double getRataDobanzii() {
        return rataDobanzii;
    }
    
    public void setRataDobanzii(double rataDobanzii) {
        this.rataDobanzii = rataDobanzii;
    }
    
    // Metodă specifică pentru calculul dobânzii
    public void aplicaDobanda() {
        double dobanda = getSold() * rataDobanzii / 100;
        depunere(dobanda); // Folosim metoda moștenită
    }
}
```

Avantajele moștenirii:
- Reutilizarea codului existent
- Extinderea funcționalităților claselor existente
- Ierarhizarea claselor conform relațiilor "este un" (is-a)
- Reducerea duplicării codului

## Principiul Polimorfismului

Polimorfismul permite obiectelor de diferite tipuri să răspundă la aceeași interfață în moduri specifice fiecărui tip.

### Polimorfism static (suprascrierea metodelor)

```java
public class ContCurent extends ContBancar {
    private double limitaDescoperire;
    
    public ContCurent(String numarCont, String proprietar, double limitaDescoperire) {
        super(numarCont, proprietar);
        this.limitaDescoperire = limitaDescoperire;
    }
    
    // Suprascrierea metodei din clasa părinte
    @Override
    public boolean retragere(double suma) {
        if (suma > 0 && suma <= (getSold() + limitaDescoperire)) {
            // Putem retrage până la limita descoperire
            if (super.retragere(suma)) {
                return true;
            } else {
                double soldNou = getSold() - suma;
                // Logică diferită pentru cont curent
                return true;
            }
        }
        return false;
    }
}
```

### Polimorfism dinamic (interfețe și clase abstracte)

```java
public interface Tranzactionabil {
    boolean proceseazaTranzactie(double suma);
    String getIdentificator();
}

public class ContBancar implements Tranzactionabil {
    // ... implementarea clasei de bază
    
    @Override
    public boolean proceseazaTranzactie(double suma) {
        return retragere(suma);
    }
    
    @Override
    public String getIdentificator() {
        return getNumarCont();
    }
}
```

Avantajele polimorfismului:
- Flexibilitate în implementare
- Posibilitatea de a trata obiecte diverse în mod unitar
- Extensibilitate a codului
- Facilitarea implementării de comportamente specializate

## Principiul Abstractizării

**Abstractizarea** este procesul de **ascundere a detaliilor de implementare** și de **expunere a funcționalității esențiale**. În OOP, abstractizarea înseamnă să arătăm *ce face* un obiect, nu *cum o face*.

Scopul abstractizării
- Simplifică utilizarea claselor și obiectelor.
- Ascunde complexitatea internă.
- Permite programarea orientată spre interfețe și concepte generale.

Cum realizăm abstractizarea în Java?

Java oferă două mecanisme principale:
1. **Clase abstracte** (`abstract class`)
2. **Interfețe** (`interface`)


Exemplu cu `abstract class`

```java
abstract class Animal {
    abstract void makeSound(); // metodă abstractă

    void breathe() { // metodă concretă
        System.out.println("Breathing...");
    }
}

class Dog extends Animal {
    @Override
    void makeSound() {
        System.out.println("Woof!");
    }
}
```

Explicație
- `Animal` definește comportamentul abstract `makeSound()`.
- `Dog` implementează detaliile concrete.
- Utilizatorul clasei `Animal` nu are nevoie să știe cum face sunetul un câine.

Exemplu cu `interface`

```java
interface Shape {
    double area();
}

class Circle implements Shape {
    double radius;

    Circle(double r) {
        this.radius = r;
    }

    public double area() {
        return Math.PI * radius * radius;
    }
}
```

Explicație
- `Shape` definește metoda `area()` fără implementare.
- `Circle` implementează metoda și oferă calculul concret.


Beneficiile abstractizării

- Cod mai curat, modular și ușor de întreținut.
- Separare clară între „interfață” și „implementare”.
- Favorizează reutilizarea și testarea mai ușoară a componentelor.

## 💳 Exemplu real: Sistem de Plată

Să presupunem că ai o aplicație care permite efectuarea de plăți prin mai multe metode: Card bancar, PayPal și Crypto.

### 1. Interfață de abstractizare

```java
public interface PaymentMethod {
    void pay(double amount);
}
```

### 2. Implementări concrete

```java
public class CreditCardPayment implements PaymentMethod {
    public void pay(double amount) {
        System.out.println("Paid " + amount + " via Credit Card.");
    }
}

public class PayPalPayment implements PaymentMethod {
    public void pay(double amount) {
        System.out.println("Paid " + amount + " via PayPal.");
    }
}

public class CryptoPayment implements PaymentMethod {
    public void pay(double amount) {
        System.out.println("Paid " + amount + " via Cryptocurrency.");
    }
}
```

### 3. Clasa care folosește abstractizarea

```java
public class PaymentProcessor {
    public void processPayment(PaymentMethod method, double amount) {
        method.pay(amount);
    }
}
```

### 4. Exemplu de utilizare

```java
public class Main {
    public static void main(String[] args) {
        PaymentProcessor processor = new PaymentProcessor();

        processor.processPayment(new CreditCardPayment(), 150.0);
        processor.processPayment(new PayPalPayment(), 75.0);
        processor.processPayment(new CryptoPayment(), 300.0);
    }
}
```

### Ce demonstrează acest exemplu?
- `PaymentProcessor` este complet decuplat de metodele de plată concrete.
- Se poate adăuga o nouă metodă de plată (ex: Apple Pay) fără a modifica clasele existente.
- Abstractizarea face codul flexibil, extensibil și ușor de întreținut.