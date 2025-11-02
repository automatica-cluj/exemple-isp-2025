# Șabloane Structurale de Proiectare

Aceasta sectiune cuprinde cateva șabloane structurale de proiectare care sunt utilizate frecvent în dezvoltarea software-ului. Aceste șabloane ajută la organizarea și gestionarea relațiilor dintre clase și obiecte, facilitând reutilizarea codului și reducerea complexității.

# Șablon de proiectare Adapter

**Nume**: Adapter

**Problemă**:
Necesitatea de a face compatibile interfețe care nu sunt compatibile în mod nativ. Apare când trebuie să utilizăm o clasă existentă, dar interfața sa nu se potrivește cu ceea ce avem nevoie în aplicația noastră.

**Soluție**:
Crearea unei clase intermediare (Adapter) care convertește interfața unei clase în altă interfață pe care clientul o așteaptă. Permite claselor cu interfețe incompatibile să lucreze împreună.

**Structură**:
- O interfață Target (interfața pe care clientul o așteaptă)
- Clasa Adaptee (clasa existentă cu interfața incompatibilă)
- Clasa Adapter care implementează interfața Target și utilizează Adaptee

**Implementare**:

```java
// Interfața Target pe care clientul o așteaptă
interface MediaPlayer {
    void play(String audioType, String fileName);
}

// Adaptee - clasa existentă cu interfața incompatibilă
class AdvancedMediaPlayer {
    public void playMp4(String fileName) {
        System.out.println("Redare fișier MP4: " + fileName);
    }
    
    public void playVlc(String fileName) {
        System.out.println("Redare fișier VLC: " + fileName);
    }
}

// Adapter - convertește interfața AdvancedMediaPlayer la MediaPlayer
class MediaAdapter implements MediaPlayer {
    private AdvancedMediaPlayer advancedMusicPlayer;
    
    public MediaAdapter(String audioType) {
        advancedMusicPlayer = new AdvancedMediaPlayer();
    }
    
    @Override
    public void play(String audioType, String fileName) {
        if(audioType.equalsIgnoreCase("vlc")) {
            advancedMusicPlayer.playVlc(fileName);
        } 
        else if(audioType.equalsIgnoreCase("mp4")) {
            advancedMusicPlayer.playMp4(fileName);
        }
    }
}

// Client care utilizează MediaPlayer
class AudioPlayer implements MediaPlayer {
    private MediaAdapter mediaAdapter;
    
    @Override
    public void play(String audioType, String fileName) {
        // Suport nativ pentru mp3
        if(audioType.equalsIgnoreCase("mp3")) {
            System.out.println("Redare fișier MP3: " + fileName);
        }
        // Suport pentru alte formate prin adapter
        else if(audioType.equalsIgnoreCase("vlc") || audioType.equalsIgnoreCase("mp4")) {
            mediaAdapter = new MediaAdapter(audioType);
            mediaAdapter.play(audioType, fileName);
        }
        else {
            System.out.println("Format " + audioType + " nesuportat");
        }
    }
}
```

**Consecințe**:
- **Avantaje**: Permite claselor cu interfețe incompatibile să colaboreze, promovează reutilizarea claselor existente, facilitează implementarea principiului responsabilității unice.
- **Dezavantaje**: Poate introduce complexitate suplimentară prin adăugarea de noi clase, uneori poate fi mai complicat decât rescrierea clasei Adaptee pentru a se conforma interfeței Target.

# Șablon de proiectare Proxy

**Nume**: Proxy

**Problemă**:
Necesitatea de a controla accesul la un obiect, adăugând funcționalități suplimentare fără a modifica obiectul original. Util când crearea obiectelor este costisitoare, când este nevoie de control al accesului sau când trebuie adăugată funcționalitate adițională la apelul metodelor unui obiect.

**Soluție**:
Crearea unui obiect reprezentant (proxy) care controlează accesul la obiectul original. Proxy-ul implementează aceeași interfață ca obiectul real, astfel încât clientul să nu observe diferența, dar adaugă un nivel suplimentar de indirectare.

**Structură**:
- O interfață Subject comună pentru RealSubject și Proxy
- Clasa RealSubject care implementează funcționalitatea reală
- Clasa Proxy care implementează același interfață și conține o referință către RealSubject

**Implementare**:

```java
// Interfața comună
interface Image {
    void display();
}

// RealSubject - implementarea reală, costisitoare
class RealImage implements Image {
    private String fileName;
    
    public RealImage(String fileName) {
        this.fileName = fileName;
        loadFromDisk();
    }
    
    private void loadFromDisk() {
        System.out.println("Încărcare imagine: " + fileName);
    }
    
    @Override
    public void display() {
        System.out.println("Afișare imagine: " + fileName);
    }
}

// Proxy - controlează accesul la RealImage
class ProxyImage implements Image {
    private RealImage realImage;
    private String fileName;
    
    public ProxyImage(String fileName) {
        this.fileName = fileName;
    }
    
    @Override
    public void display() {
        // Lazy initialization - creează obiectul real doar când este necesar
        if(realImage == null) {
            realImage = new RealImage(fileName);
        }
        realImage.display();
    }
}

// Client
class ProxyDemo {
    public static void main(String[] args) {
        Image image = new ProxyImage("imagine_mare.jpg");
        
        // Imaginea va fi încărcată și afișată la primul apel
        System.out.println("Prima afișare:");
        image.display();
        
        // Imaginea nu va fi încărcată din nou la apelurile ulterioare
        System.out.println("\nA doua afișare:");
        image.display();
    }
}
```

**Consecințe**:
- **Avantaje**:
    - Permite încărcarea leneșă (lazy loading) a obiectelor costisitoare
    - Implementează controlul accesului la obiectul original
    - Adaugă funcționalități suplimentare fără a modifica codul original (caching, logging, etc.)
    - Separă preocupările transversale (cross-cutting concerns) de logica de business
- **Dezavantaje**:
    - Adaugă un nivel suplimentar de indirectare care poate complica codul
    - Poate introduce o latență în răspunsul obiectului din cauza procesării suplimentare

# Șablon de proiectare Decorator

**Nume**: Decorator

**Problemă**:
Necesitatea de a adăuga responsabilități sau comportamente suplimentare unui obiect în mod dinamic, fără a modifica codul original. Este util când extinderea prin moștenire nu este practică sau flexibilă.

**Soluție**:
Atașarea responsabilităților suplimentare unui obiect prin plasarea acestuia într-un obiect învelitor (wrapper) care adaugă comportamentul. Decoratorul implementează aceeași interfață ca și componenta originală, permițând înlănțuirea mai multor decoratori.

**Structură**:
- O interfață Component care definește comportamentul de bază
- Clasa ConcreteComponent care implementează interfața Component
- Clasa abstractă Decorator care implementează Component și conține o referință la un Component
- Diverse clase ConcreteDecorator care extind Decorator și adaugă comportamente

**Implementare**:

```java
// Interfața Component
interface Coffee {
    String getDescription();
    double getCost();
}

// ConcreteComponent
class SimpleCoffee implements Coffee {
    @Override
    public String getDescription() {
        return "Cafea simplă";
    }

    @Override
    public double getCost() {
        return 5.0;
    }
}

// Decorator abstract
abstract class CoffeeDecorator implements Coffee {
    protected Coffee decoratedCoffee;
    
    public CoffeeDecorator(Coffee coffee) {
        this.decoratedCoffee = coffee;
    }
    
    @Override
    public String getDescription() {
        return decoratedCoffee.getDescription();
    }
    
    @Override
    public double getCost() {
        return decoratedCoffee.getCost();
    }
}

// ConcreteDecorator 1
class MilkDecorator extends CoffeeDecorator {
    public MilkDecorator(Coffee coffee) {
        super(coffee);
    }
    
    @Override
    public String getDescription() {
        return decoratedCoffee.getDescription() + ", cu lapte";
    }
    
    @Override
    public double getCost() {
        return decoratedCoffee.getCost() + 2.0;
    }
}

// ConcreteDecorator 2
class SugarDecorator extends CoffeeDecorator {
    public SugarDecorator(Coffee coffee) {
        super(coffee);
    }
    
    @Override
    public String getDescription() {
        return decoratedCoffee.getDescription() + ", cu zahăr";
    }
    
    @Override
    public double getCost() {
        return decoratedCoffee.getCost() + 1.0;
    }
}

// ConcreteDecorator 3
class WhippedCreamDecorator extends CoffeeDecorator {
    public WhippedCreamDecorator(Coffee coffee) {
        super(coffee);
    }
    
    @Override
    public String getDescription() {
        return decoratedCoffee.getDescription() + ", cu frișcă";
    }
    
    @Override
    public double getCost() {
        return decoratedCoffee.getCost() + 3.0;
    }
}

// Client
class DecoratorDemo {
    public static void main(String[] args) {
        // Cafea simplă
        Coffee simpleCoffee = new SimpleCoffee();
        System.out.println(simpleCoffee.getDescription() + " costă: " + simpleCoffee.getCost() + " lei");
        
        // Cafea cu lapte
        Coffee milkCoffee = new MilkDecorator(simpleCoffee);
        System.out.println(milkCoffee.getDescription() + " costă: " + milkCoffee.getCost() + " lei");
        
        // Cafea cu lapte și zahăr
        Coffee sweetMilkCoffee = new SugarDecorator(milkCoffee);
        System.out.println(sweetMilkCoffee.getDescription() + " costă: " + sweetMilkCoffee.getCost() + " lei");
        
        // Cafea cu lapte, zahăr și frișcă
        Coffee deluxeCoffee = new WhippedCreamDecorator(sweetMilkCoffee);
        System.out.println(deluxeCoffee.getDescription() + " costă: " + deluxeCoffee.getCost() + " lei");
    }
}
```

**Consecințe**:
- **Avantaje**:
    - Oferă mai multă flexibilitate decât moștenirea statică
    - Permite adăugarea și eliminarea responsabilităților în mod dinamic
    - Permite combinarea comportamentelor în diferite moduri
    - Respectă principiul Single Responsibility prin separarea responsabilităților
- **Dezavantaje**:
    - Poate rezulta în multe obiecte mici și similare care pot fi dificil de înțeles
    - Poate introduce complexitate când un client depinde de detalii specifice ale componentei

# Șablon de proiectare Facade

**Nume**: Facade

**Problemă**:
Necesitatea de a simplifica accesul la un subsistem complex, prin oferirea unei interfețe unificate și de nivel înalt. Este util când un sistem are multe componente cu interfețe complexe sau când se dorește decuplarea clientului de implementările specifice ale subsistemului.

**Soluție**:
Crearea unei clase care oferă o interfață simplificată pentru un set de interfețe din subsistem. Fațada definește o interfață de nivel superior care face subsistemul mai ușor de utilizat prin reducerea complexității și dependențelor.

**Structură**:
- Clasa Facade care oferă o interfață simplificată
- Subsisteme complexe cu multiple clase și relații
- Clienți care interacționează doar cu Facade

**Implementare**:

```java
// Clasele subsistemului complex
class VideoFile {
    private String name;
    private String codecType;

    public VideoFile(String name) {
        this.name = name;
        this.codecType = name.substring(name.indexOf(".") + 1);
    }

    public String getCodecType() {
        return codecType;
    }

    public String getName() {
        return name;
    }
}

class CodecFactory {
    public static Codec extract(VideoFile file) {
        String type = file.getCodecType();
        if (type.equals("mp4")) {
            System.out.println("CodecFactory: extragere codec mpeg4...");
            return new MPEG4CompressionCodec();
        } else {
            System.out.println("CodecFactory: extragere codec ogg...");
            return new OggCompressionCodec();
        }
    }
}

interface Codec {}

class MPEG4CompressionCodec implements Codec {
    public String type = "mp4";
}

class OggCompressionCodec implements Codec {
    public String type = "ogg";
}

class BitrateReader {
    public static VideoFile read(VideoFile file, Codec codec) {
        System.out.println("BitrateReader: citire fișier...");
        return file;
    }

    public static VideoFile convert(VideoFile buffer, Codec codec) {
        System.out.println("BitrateReader: convertire fișier video...");
        return buffer;
    }
}

class AudioMixer {
    public File fix(VideoFile result) {
        System.out.println("AudioMixer: procesare audio...");
        return new File("temp.mp4");
    }
}

class File {
    private String name;

    public File(String name) {
        this.name = name;
    }
}

// Facade
class VideoConversionFacade {
    public File convertVideo(String fileName, String format) {
        System.out.println("VideoConversionFacade: începere conversie...");
        VideoFile file = new VideoFile(fileName);
        Codec sourceCodec = CodecFactory.extract(file);
        Codec destinationCodec;
        
        if (format.equals("mp4")) {
            destinationCodec = new MPEG4CompressionCodec();
        } else {
            destinationCodec = new OggCompressionCodec();
        }
        
        VideoFile buffer = BitrateReader.read(file, sourceCodec);
        VideoFile intermediateResult = BitrateReader.convert(buffer, destinationCodec);
        File result = new AudioMixer().fix(intermediateResult);
        System.out.println("VideoConversionFacade: conversie completată.");
        
        return result;
    }
}

// Client
class FacadeDemo {
    public static void main(String[] args) {
        VideoConversionFacade converter = new VideoConversionFacade();
        File mp4Video = converter.convertVideo("youtubevideo.ogg", "mp4");
        // Clientul utilizează doar metoda simplă convertVideo()
    }
}
```

**Consecințe**:
- **Avantaje**:
    - Izolează clientul de componentele subsistemului, reducând dependențele
    - Promovează coeziunea slabă între subsistem și clienți
    - Simplifică utilizarea sistemului complex prin interfață unificată
    - Permite modificări în subsistem fără a afecta clientul
- **Dezavantaje**:
    - Poate deveni un "obiect Dumnezeu" (God object) care face prea multe dacă nu este proiectat corespunzător
    - Poate ascunde prea multe detalii, limitând flexibilitatea când este necesară interacțiunea directă cu subsistemul