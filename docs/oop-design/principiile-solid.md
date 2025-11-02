# Principiile avansate OOP (S.O.L.I.D.)

## Introducere

Acronimul S.O.L.I.D. reprezintă un set de 5 principii fundamentale pentru proiectarea aplicațiilor în programarea orientată pe obiecte. Fiecare literă din cuvântul SOLID corespunde unui principiu:

S – Single Responsibility Principle (Principiul responsabilității unice)
O clasă trebuie să aibă un singur motiv de a se schimba, adică să aibă o singură responsabilitate.

O – Open/Closed Principle (Principiul deschis/închis)
Componentele software ar trebui să fie deschise pentru extindere, dar închise pentru modificare. Se obține prin moștenire, interfețe și polimorfism.

L – Liskov Substitution Principle (Principiul substituției Liskov)
Obiectele unei clase derivate trebuie să poată înlocui obiectele clasei de bază fără a afecta corectitudinea programului.

I – Interface Segregation Principle (Principiul segregării interfețelor)
Este mai bine să existe interfețe mici și specifice, decât o interfață mare și generală. Clienții nu ar trebui să fie forțați să implementeze metode pe care nu le folosesc.

D – Dependency Inversion Principle (Principiul inversării dependențelor)
Modulele de nivel înalt nu ar trebui să depindă de cele de nivel jos; ambele ar trebui să depindă de abstracții (ex. interfețe). Detaliile trebuie să depindă de abstracții, nu invers.

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