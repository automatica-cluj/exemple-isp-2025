# Principiile OOP

# Cuprins

## Principiile de baza OOP 
1. [Principiul Încapsulării](#principiul-încapsulării)
2. [Principiul Moștenirii](#principiul-moștenirii)
3. [Principiul Polimorfismului](#principiul-polimorfismului)
4. [Principiul Abstractizării](#principiul-abstractizării)

## Principiile avansate OOP (S.O.L.I.D.)

5. [Principiul Segregării Interfețelor](#principiul-segregării-interfețelor)
6. [Principiul Responsabilității Unice](#principiul-responsabilității-unice)
7. [Principiul Deschis-Închis](#principiul-deschis-închis)
8. [Principiul Substituției Liskov](#principiul-substituției-liskov)
9. [Principiul Inversiunii Dependențelor](#principiul-inversiunii-dependențelor)

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

Abstractizarea este procesul de identificare a caracteristicilor esențiale ale unui obiect și ignorarea detaliilor nerelevante.

```java
// Clasa abstractă
public abstract class ContAbstract {
    private String numarCont;
    private double sold;
    
    public ContAbstract(String numarCont) {
        this.numarCont = numarCont;
        this.sold = 0.0;
    }
    
    // Metode concrete
    public double getSold() {
        return sold;
    }
    
    protected void modificaSold(double suma) {
        this.sold += suma;
    }
    
    // Metode abstracte - trebuie implementate de subclase
    public abstract boolean retragere(double suma);
    public abstract boolean transfer(ContAbstract destinatie, double suma);
}
```

Avantajele abstractizării:
- Simplificarea modelării obiectelor complexe
- Concentrarea pe caracteristicile esențiale
- Oferirea unui cadru pentru implementări viitoare
- Reducerea complexității pentru utilizatorii clasei

## Principiul Segregării Interfețelor

Acest principiu susține că o clasă nu ar trebui să fie forțată să implementeze interfețe care nu îi sunt necesare. Interfețele trebuie să fie granulare și specifice.

```java
// Interfațe segregate
public interface Depozitabil {
    void depunere(double suma);
}

public interface Retragibil {
    boolean retragere(double suma);
}

public interface Transferabil {
    boolean transfer(ContBancar destinatie, double suma);
}

// Implementare care folosește doar interfețele necesare
public class ContDepozit implements Depozitabil {
    private double sold;
    
    @Override
    public void depunere(double suma) {
        if (suma > 0) {
            sold += suma;
        }
    }
    
    // Nu implementează retragere, deoarece nu permite retrageri
}
```

## Principiul Responsabilității Unice

Acest principiu afirmă că o clasă ar trebui să aibă un singur motiv pentru a fi modificată, respectiv să aibă o singură responsabilitate.

```java
// Clasă pentru operațiuni bancare
public class ContBancar {
    // Atribute și operațiuni bancare de bază
}

// Clasă separată pentru raportare
public class RaportareCont {
    public String genereazaExtras(ContBancar cont) {
        // Cod pentru generarea extrasului
    }
    
    public void trimiteNotificare(ContBancar cont, String mesaj) {
        // Cod pentru trimiterea notificărilor
    }
}

// Clasă separată pentru securitate
public class SecuritateCont {
    public boolean verificaAutorizare(String idCont, String codAutorizare) {
        // Verifică autorizarea operațiunilor
    }
}
```

## Principiul Deschis-Închis

Acest principiu afirmă că entitățile software (clase, module, funcții etc.) ar trebui să fie deschise pentru extindere, dar închise pentru modificare.

```java
// Interfață pentru strategii de calculare a comisioanelor
public interface StrategieComision {
    double calculeazaComision(double suma);
}

// Implementări concrete ale strategiilor
public class ComisionStandard implements StrategieComision {
    @Override
    public double calculeazaComision(double suma) {
        return suma * 0.01; // 1%
    }
}

public class ComisionPremium implements StrategieComision {
    @Override
    public double calculeazaComision(double suma) {
        return suma * 0.005; // 0.5%
    }
}

// Clasa client este închisă pentru modificare, dar comportamentul poate fi extins
public class ProcesorTranzactii {
    private StrategieComision strategieComision;
    
    public ProcesorTranzactii(StrategieComision strategieComision) {
        this.strategieComision = strategieComision;
    }
    
    public double proceseazaTranzactie(double suma) {
        double comision = strategieComision.calculeazaComision(suma);
        // Procesare tranzacție
        return suma - comision;
    }
}
```

## Principiul Substituției Liskov

Acest principiu afirmă că obiectele unei clase derivate trebuie să poată înlocui obiectele clasei de bază fără a afecta corectitudinea programului.

```java
public class Forma {
    public double getArie() {
        // Implementare
        return 0;
    }
}

public class Dreptunghi extends Forma {
    private double lungime;
    private double latime;
    
    // Constructor și getteri/setteri
    
    @Override
    public double getArie() {
        return lungime * latime;
    }
}

public class Cerc extends Forma {
    private double raza;
    
    // Constructor și getteri/setteri
    
    @Override
    public double getArie() {
        return Math.PI * raza * raza;
    }
}

// Funcție care respectă principiul Liskov
public void afiseazaArii(List<Forma> forme) {
    for (Forma forma : forme) {
        System.out.println("Aria: " + forma.getArie());
    }
}
```

## Principiul Inversiunii Dependențelor

Acest principiu afirmă că modulele de nivel înalt nu ar trebui să depindă de modulele de nivel scăzut. Ambele ar trebui să depindă de abstracții.

```java
// Abordare incorectă
public class ServiciuNotificare {
    private EmailSender emailSender;
    
    public ServiciuNotificare() {
        this.emailSender = new EmailSender();
    }
    
    public void trimiteNotificare(String destinatar, String mesaj) {
        emailSender.trimiteEmail(destinatar, mesaj);
    }
}

// Abordare corectă conform principiului
public interface MesajeSender {
    void trimite(String destinatar, String mesaj);
}

public class EmailSender implements MesajeSender {
    @Override
    public void trimite(String destinatar, String mesaj) {
        // Trimitere email
    }
}

public class SMSSender implements MesajeSender {
    @Override
    public void trimite(String destinatar, String mesaj) {
        // Trimitere SMS
    }
}

public class ServiciuNotificare {
    private MesajeSender mesajeSender;
    
    // Injectare dependență
    public ServiciuNotificare(MesajeSender mesajeSender) {
        this.mesajeSender = mesajeSender;
    }
    
    public void trimiteNotificare(String destinatar, String mesaj) {
        mesajeSender.trimite(destinatar, mesaj);
    }
}
```

Aplicarea corectă a acestor principii conduce la cod mai modular, mai ușor de întreținut și extins, reducând duplicarea și îmbunătățind claritatea și flexibilitatea sistemului.