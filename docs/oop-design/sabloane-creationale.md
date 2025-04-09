# Cuprins

Aceasta sectiune cuprinde cateva dintre cele mai utilizate sabloane de proiectare de tipul "Creational" (creare de obiecte). Aceste sabloane sunt esentiale pentru a intelege cum sa gestionam instantierea si ciclul de viata al obiectelor in aplicatiile noastre.

1. [Șablon de proiectare Singleton](#șablon-de-proiectare-singleton)
2. [Șablon de proiectare Factory Method](#șablon-de-proiectare-factory-method)
3. [Șablon de proiectare Abstract Factory](#șablon-de-proiectare-abstract-factory)
4. [Șablon de proiectare Builder](#șablon-de-proiectare-builder)

# Șablon de proiectare Singleton

**Nume**: Singleton

**Problemă**:
Este necesară existența unei singure instanțe a unei clase în întreaga aplicație, cu acces global la această instanță. Situații tipice sunt: gestionarea conexiunilor la baze de date, configurații globale, sau servicii care trebuie să fie disponibile într-un singur exemplar.

**Soluție**:
Asigurarea că o clasă are o singură instanță și oferirea unui punct global de acces la aceasta. Se implementează prin: constructori privați care previn instantierea externă, o metodă statică care returnează instanța unică și o variabilă statică care stochează instanța.

**Structură**:
- O clasă cu constructor privat
- O metodă statică publică (`getInstance()`)
- O variabilă statică privată care păstrează instanța unică

**Implementare**:

```java
public class Singleton {
    // Variabila statică privată pentru stocarea instanței
    private static Singleton instance;
    
    // Constructor privat pentru a preveni instanțierea din exterior
    private Singleton() {
        // Inițializări necesare
    }
    
    // Metoda statică publică pentru obținerea instanței
    public static Singleton getInstance() {
        if (instance == null) {
            instance = new Singleton();
        }
        return instance;
    }
    
    // Alte metode publice
    public void serviceMethod() {
        // Funcționalitate oferită de Singleton
    }
}
```

**Consecințe**:
- **Avantaje**: Control strict asupra instanței unice, reducerea utilizării memoriei, evitarea variabilelor globale.
- **Dezavantaje**: Poate ascunde dependențe între componente, poate fi mai dificil de testat, potențiale probleme în medii multi-thread dacă nu e implementat corect.

# Șablon de proiectare Factory Method

**Nume**: Factory Method

**Problemă**:
Necesitatea de a crea obiecte fără a specifica exact clasa obiectului care va fi creat. Se dorește delegarea instantierii către subclase, permițând aplicației să determine dinamic ce tipuri de obiecte să creeze în funcție de context sau configurație.

**Soluție**:
Definirea unei interfețe pentru crearea unui obiect, dar lăsarea subclaselor să decidă ce clasă să instanțieze. Factory Method permite unei clase să delege instantierea către subclase și elimină dependențele directe de implementări concrete.

**Structură**:
- O interfață sau clasă abstractă Creator cu o metodă abstractă de fabrică
- Subclase ConcreteCreator care implementează metoda de fabrică
- O interfață sau clasă abstractă Product
- Subclase ConcreteProduct care sunt create de metodele de fabrică

**Implementare**:

```java
// Interfața produsului
interface Product {
    void operation();
}

// Implementări concrete ale produsului
class ConcreteProductA implements Product {
    @Override
    public void operation() {
        System.out.println("Operație executată de Produsul A");
    }
}

class ConcreteProductB implements Product {
    @Override
    public void operation() {
        System.out.println("Operație executată de Produsul B");
    }
}

// Clasa Creator cu metoda Factory
abstract class Creator {
    // Factory Method
    public abstract Product createProduct();
    
    // Metodă care utilizează produsul
    public void anOperation() {
        Product product = createProduct();
        product.operation();
    }
}

// Implementări concrete ale creatorului
class ConcreteCreatorA extends Creator {
    @Override
    public Product createProduct() {
        return new ConcreteProductA();
    }
}

class ConcreteCreatorB extends Creator {
    @Override
    public Product createProduct() {
        return new ConcreteProductB();
    }
}
```

**Consecințe**:
- **Avantaje**: Elimină dependența de clase concrete specifice, oferă flexibilitate în crearea obiectelor, promovează principiul deschis-închis prin permiterea extinderii fără modificarea codului existent.
- **Dezavantaje**: Poate rezulta în crearea multor subclase pentru implementarea diferențelor minore, complexitate suplimentară în comparație cu crearea directă a obiectelor.

# Șablon de proiectare Abstract Factory

**Nume**: Abstract Factory

**Problemă**:
Necesitatea de a crea familii de obiecte înrudite sau dependente fără a specifica clasele lor concrete. Este utilă când sistemul trebuie să fie independent de modul în care produsele sale sunt create, compuse și reprezentate.

**Soluție**:
Furnizarea unei interfețe pentru crearea de familii de obiecte înrudite sau dependente, fără a specifica clasele lor concrete. Abstract Factory permite crearea de obiecte care urmează un model comun și care sunt proiectate să lucreze împreună.

**Structură**:
- O interfață AbstractFactory care declară metode pentru crearea fiecărui tip de produs
- Clase ConcreteFactory care implementează metodele de creare
- Interfețe de produs pentru fiecare tip de produs din familie
- Clase concrete pentru fiecare variație de produs

**Implementare**:

```java
// Interfețe pentru produse
interface ButtonProduct {
    void render();
}

interface CheckboxProduct {
    void check();
}

// Implementări concrete pentru familia "Windows"
class WindowsButton implements ButtonProduct {
    @Override
    public void render() {
        System.out.println("Renderizare buton Windows");
    }
}

class WindowsCheckbox implements CheckboxProduct {
    @Override
    public void check() {
        System.out.println("Bifat checkbox Windows");
    }
}

// Implementări concrete pentru familia "MacOS"
class MacOSButton implements ButtonProduct {
    @Override
    public void render() {
        System.out.println("Renderizare buton MacOS");
    }
}

class MacOSCheckbox implements CheckboxProduct {
    @Override
    public void check() {
        System.out.println("Bifat checkbox MacOS");
    }
}

// Abstract Factory
interface GUIFactory {
    ButtonProduct createButton();
    CheckboxProduct createCheckbox();
}

// Fabrici concrete pentru fiecare familie
class WindowsFactory implements GUIFactory {
    @Override
    public ButtonProduct createButton() {
        return new WindowsButton();
    }

    @Override
    public CheckboxProduct createCheckbox() {
        return new WindowsCheckbox();
    }
}

class MacOSFactory implements GUIFactory {
    @Override
    public ButtonProduct createButton() {
        return new MacOSButton();
    }

    @Override
    public CheckboxProduct createCheckbox() {
        return new MacOSCheckbox();
    }
}

// Cod client
class Application {
    private ButtonProduct button;
    private CheckboxProduct checkbox;

    public Application(GUIFactory factory) {
        button = factory.createButton();
        checkbox = factory.createCheckbox();
    }

    public void render() {
        button.render();
        checkbox.check();
    }
}
```

**Consecințe**:
- **Avantaje**: Izolează codurile concrete, promovează coerența între produse, facilitează schimbarea familiilor de produse, asigură compatibilitatea produselor din aceeași familie.
- **Dezavantaje**: Adăugarea de noi tipuri de produse este dificilă (trebuie modificate toate fabricile), poate introduce complexitate suplimentară dacă familia de produse este mică.

# Șablon de proiectare Builder

**Nume**: Builder

**Problemă**:
Necesitatea de a construi obiecte complexe pas cu pas, separând procesul de construcție de reprezentarea finală. Este util când un obiect trebuie creat cu numeroase parametri opționali sau când procesul de construcție implică mai mulți pași.

**Soluție**:
Separarea construcției unui obiect complex de reprezentarea sa, astfel încât același proces de construcție să poată crea reprezentări diferite. Permite crearea obiectelor în etape și oferă control fin asupra procesului de construcție.

**Structură**:
- O interfață Builder care definește pașii de construcție
- Clase ConcreteBuilder care implementează pașii pentru crearea și asamblarea produsului
- Clasa Director care coordonează procesul de construcție
- Clasa Product care reprezintă obiectul complex creat

**Implementare**:

```java
// Produsul complex
class House {
    private String foundation;
    private String structure;
    private String roof;
    private boolean furnished;
    private boolean painted;

    @Override
    public String toString() {
        return "House [foundation=" + foundation + ", structure=" + structure + ", roof=" + roof +
               ", furnished=" + furnished + ", painted=" + painted + "]";
    }

    // Setteri
    public void setFoundation(String foundation) { this.foundation = foundation; }
    public void setStructure(String structure) { this.structure = structure; }
    public void setRoof(String roof) { this.roof = roof; }
    public void setFurnished(boolean furnished) { this.furnished = furnished; }
    public void setPainted(boolean painted) { this.painted = painted; }
}

// Interfața Builder
interface HouseBuilder {
    void buildFoundation();
    void buildStructure();
    void buildRoof();
    void furnish();
    void paint();
    House getResult();
}

// Builder concret
class StandardHouseBuilder implements HouseBuilder {
    private House house;

    public StandardHouseBuilder() {
        this.house = new House();
    }

    @Override
    public void buildFoundation() {
        house.setFoundation("Standard Foundation");
    }

    @Override
    public void buildStructure() {
        house.setStructure("Brick Walls");
    }

    @Override
    public void buildRoof() {
        house.setRoof("Standard Roof");
    }

    @Override
    public void furnish() {
        house.setFurnished(true);
    }

    @Override
    public void paint() {
        house.setPainted(true);
    }

    @Override
    public House getResult() {
        return house;
    }
}

// Director
class ConstructionDirector {
    public House constructStandardHouse(HouseBuilder builder) {
        builder.buildFoundation();
        builder.buildStructure();
        builder.buildRoof();
        return builder.getResult();
    }

    public House constructFullyFurnishedHouse(HouseBuilder builder) {
        builder.buildFoundation();
        builder.buildStructure();
        builder.buildRoof();
        builder.furnish();
        builder.paint();
        return builder.getResult();
    }
}

// Client
class BuilderDemo {
    public static void main(String[] args) {
        HouseBuilder builder = new StandardHouseBuilder();
        ConstructionDirector director = new ConstructionDirector();
        
        // Construiește o casă standard
        House standardHouse = director.constructStandardHouse(builder);
        System.out.println("Standard House: " + standardHouse);
        
        // Construiește o casă complet mobilată
        House furnishedHouse = director.constructFullyFurnishedHouse(builder);
        System.out.println("Fully Furnished House: " + furnishedHouse);
    }
}
```

**Consecințe**:
- **Avantaje**: Permite variații ale produselor, izolează codul pentru construcție de reprezentare, oferă control fin asupra procesului de construcție, ascunde detaliile interne ale produselor.
- **Dezavantaje**: Necesită crearea mai multor clase noi, poate fi prea complex pentru produse simple, uneori necesită mai mult cod decât alte alternative (cum ar fi constructori cu parametri).