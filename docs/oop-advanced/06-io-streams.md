# Java I/O Streams 

## Cuprins
1. [Introducere în I/O Streams](#introducere-în-io-streams)
2. [Ierarhia claselor de Streams](#ierarhia-claselor-de-streams)
3. [Byte Streams - Fluxuri de Octeți](#byte-streams---fluxuri-de-octeți)
4. [Character Streams - Fluxuri de Caractere](#character-streams---fluxuri-de-caractere)
5. [Buffered Streams - Fluxuri Tampon](#buffered-streams---fluxuri-tampon)
6. [Data Streams și Object Streams](#data-streams-și-object-streams)
7. [Citirea și Scrierea Fișierelor de Text](#citirea-și-scrierea-fișierelor-de-text)
8. [Procesare I/O cu NIO și NIO.2](#procesare-io-cu-nio-și-nio2)
9. [Serializarea și Deserializarea](#serializarea-și-deserializarea)
10. [Tehnici Avansate](#tehnici-avansate)
11. [Gestionarea Resurselor și Try-with-Resources](#gestionarea-resurselor-și-try-with-resources)
12. [Exemple Practice](#exemple-practice)
13. [Bune Practici](#bune-practici)
14. [Probleme Comune și Soluții](#probleme-comune-și-soluții)

## Introducere în I/O Streams

În Java, un stream (flux) reprezintă o secvență de date care circulă între o sursă și o destinație. I/O Streams (Input/Output Streams) furnizează mecanisme pentru citirea și scrierea datelor, facilitând interacțiunea programelor Java cu diferite surse și destinații de date cum ar fi fișiere, rețea, memorie sau dispozitive.

### Concepte fundamentale

- **Stream (Flux)**: O succesiune ordonată de date disponibile în timp
- **Input Stream**: Citește date dintr-o sursă
- **Output Stream**: Scrie date într-o destinație
- **Byte Stream**: Procesează date la nivel de octet (8 biți)
- **Character Stream**: Procesează date la nivel de caracter (conform standardului Unicode)

### Caracteristicile Streams

- **Unidirecționale**: Un stream este fie de intrare, fie de ieșire, niciodată ambele
- **Secvențiale**: Datele sunt procesate în ordinea în care sunt primite
- **Blocante**: Operațiile de citire sau scriere pot bloca execuția până când datele sunt disponibile sau pot fi scrise
- **Închidere manuală**: Majoritatea stream-urilor trebuie închise explicit pentru a elibera resursele

### Avantajele utilizării Streams

- Abstracție consistentă indiferent de sursa sau destinația datelor
- Ierarhie flexibilă care permite extindere și personalizare
- Capacitatea de a înlănțui stream-uri pentru funcționalități avansate (pattern Decorator)
- Mecanism standard pentru I/O în întregul ecosistem Java

## Ierarhia claselor de Streams

Java I/O este organizat într-o ierarhie de clase și interfețe care oferă funcționalitate specializată pentru diferite scenarii.

### Clase de bază pentru Byte Streams

```
InputStream (abstract)
 ├── FileInputStream
 ├── ByteArrayInputStream
 ├── PipedInputStream
 ├── FilterInputStream
 │    ├── BufferedInputStream
 │    ├── DataInputStream
 │    └── ...
 └── ObjectInputStream
 
OutputStream (abstract)
 ├── FileOutputStream
 ├── ByteArrayOutputStream
 ├── PipedOutputStream
 ├── FilterOutputStream
 │    ├── BufferedOutputStream
 │    ├── DataOutputStream
 │    └── ...
 └── ObjectOutputStream
```

### Clase de bază pentru Character Streams

```
Reader (abstract)
 ├── InputStreamReader
 │    └── FileReader
 ├── StringReader
 ├── CharArrayReader
 ├── PipedReader
 └── BufferedReader
 
Writer (abstract)
 ├── OutputStreamWriter
 │    └── FileWriter
 ├── StringWriter
 ├── CharArrayWriter
 ├── PipedWriter
 └── BufferedWriter
 └── PrintWriter
```

### Relația între Byte și Character Streams

Character Streams sunt adesea construite pe baza Byte Streams:

```java
// InputStreamReader convertește un InputStream (bytes) într-un Reader (caractere)
Reader reader = new InputStreamReader(inputStream, StandardCharsets.UTF_8);

// OutputStreamWriter convertește caractere în bytes pentru un OutputStream
Writer writer = new OutputStreamWriter(outputStream, StandardCharsets.UTF_8);
```

## Byte Streams - Fluxuri de Octeți

Byte Streams procesează datele la cel mai jos nivel - fluxuri de octeți (8 biți). Aceste stream-uri sunt potrivite pentru toate tipurile de date binare.

### InputStream

Clasa abstractă `InputStream` este baza tuturor stream-urilor de intrare care operează pe bytes. Metodele sale principale includ:

```java
public abstract int read() throws IOException;    // Citește un singur byte
public int read(byte[] b) throws IOException;     // Citește bytes într-un array
public int read(byte[] b, int off, int len) throws IOException;  // Citește bytes într-o porțiune de array
public long skip(long n) throws IOException;      // Sare peste n bytes
public int available() throws IOException;        // Estimează bytes disponibili
public void close() throws IOException;           // Închide stream-ul și eliberează resursele
public synchronized void mark(int readlimit);     // Marchează poziția curentă (dacă este suportat)
public synchronized void reset() throws IOException;  // Resetează la ultima marcă
public boolean markSupported();                   // Verifică dacă mark() și reset() sunt suportate
```

### OutputStream

Clasa abstractă `OutputStream` este baza tuturor stream-urilor de ieșire care operează pe bytes. Metodele sale principale includ:

```java
public abstract void write(int b) throws IOException;    // Scrie un singur byte
public void write(byte[] b) throws IOException;          // Scrie un array de bytes
public void write(byte[] b, int off, int len) throws IOException;  // Scrie o porțiune din array
public void flush() throws IOException;                  // Forțează scrierea datelor tampon
public void close() throws IOException;                  // Închide stream-ul și eliberează resursele
```

### Exemple de Byte Streams

#### FileInputStream și FileOutputStream

```java
// Citirea unui fișier byte cu byte
try (FileInputStream fis = new FileInputStream("fisier.dat")) {
    int byteData;
    while ((byteData = fis.read()) != -1) {
        // Procesează fiecare byte
        System.out.print(byteData + " ");
    }
} catch (IOException e) {
    e.printStackTrace();
}

// Scrierea în fișier
try (FileOutputStream fos = new FileOutputStream("output.dat")) {
    byte[] data = {65, 66, 67, 68, 69}; // ABCDE în ASCII
    fos.write(data);
} catch (IOException e) {
    e.printStackTrace();
}
```

#### ByteArrayInputStream și ByteArrayOutputStream

```java
// Citirea din un array de bytes
byte[] data = {1, 2, 3, 4, 5};
try (ByteArrayInputStream bais = new ByteArrayInputStream(data)) {
    int byteValue;
    while ((byteValue = bais.read()) != -1) {
        System.out.println(byteValue);
    }
}

// Scrierea într-un ByteArrayOutputStream
try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
    baos.write(new byte[]{10, 20, 30});
    baos.write(40);
    
    byte[] result = baos.toByteArray();
    System.out.println(Arrays.toString(result)); // [10, 20, 30, 40]
}
```

## Character Streams - Fluxuri de Caractere

Character Streams sunt proiectate pentru a procesa date text (Unicode). Acestea gestionează automat conversiile între bytes și caractere folosind codificări specifice.

### Reader

Clasa abstractă `Reader` este baza tuturor stream-urilor de intrare care operează cu caractere. Metodele principale includ:

```java
public int read() throws IOException;    // Citește un singur caracter
public int read(char[] cbuf) throws IOException;    // Citește caractere într-un array
public abstract int read(char[] cbuf, int off, int len) throws IOException;    // Citește într-o porțiune de array
public long skip(long n) throws IOException;    // Sare peste n caractere
public boolean ready() throws IOException;    // Verifică dacă stream-ul este pregătit pentru citire
public boolean markSupported();    // Verifică dacă mark() și reset() sunt suportate
public void mark(int readAheadLimit) throws IOException;    // Marchează poziția curentă
public void reset() throws IOException;    // Resetează la ultima marcă
public abstract void close() throws IOException;    // Închide stream-ul
```

### Writer

Clasa abstractă `Writer` este baza tuturor stream-urilor de ieșire care operează cu caractere. Metodele principale includ:

```java
public void write(int c) throws IOException;    // Scrie un singur caracter
public void write(char[] cbuf) throws IOException;    // Scrie un array de caractere
public abstract void write(char[] cbuf, int off, int len) throws IOException;    // Scrie o porțiune din array
public void write(String str) throws IOException;    // Scrie un String
public void write(String str, int off, int len) throws IOException;    // Scrie o porțiune din String
public abstract void flush() throws IOException;    // Forțează scrierea datelor tampon
public abstract void close() throws IOException;    // Închide stream-ul
```

### Exemple de Character Streams

#### FileReader și FileWriter

```java
// Citirea unui fișier text caracter cu caracter
try (FileReader fr = new FileReader("fisier.txt")) {
    int charData;
    while ((charData = fr.read()) != -1) {
        System.out.print((char) charData);
    }
} catch (IOException e) {
    e.printStackTrace();
}

// Scrierea textului în fișier
try (FileWriter fw = new FileWriter("output.txt")) {
    fw.write("Hello, Java I/O!");
} catch (IOException e) {
    e.printStackTrace();
}
```

#### InputStreamReader și OutputStreamWriter

```java
// Convertirea unui InputStream în Reader cu codificare specifică
try (InputStreamReader isr = new InputStreamReader(
        new FileInputStream("data.txt"), StandardCharsets.UTF_8)) {
    char[] buffer = new char[1024];
    int charsRead;
    while ((charsRead = isr.read(buffer)) != -1) {
        System.out.print(new String(buffer, 0, charsRead));
    }
}

// Scrierea caracterelor cu codificare specifică
try (OutputStreamWriter osw = new OutputStreamWriter(
        new FileOutputStream("output.txt"), StandardCharsets.UTF_8)) {
    osw.write("Text cu caractere speciale: åäö");
}
```

#### StringReader și StringWriter

```java
// Citirea din String ca sursă
try (StringReader sr = new StringReader("Hello, StringReader!")) {
    int charValue;
    while ((charValue = sr.read()) != -1) {
        System.out.print((char) charValue);
    }
}

// Scrierea în un StringWriter
try (StringWriter sw = new StringWriter()) {
    sw.write("Hello, ");
    sw.write("StringWriter!");
    
    String result = sw.toString();
    System.out.println(result); // Hello, StringWriter!
}
```

## Buffered Streams - Fluxuri Tampon

Buffered Streams îmbunătățesc performanța prin reducerea numărului de operații I/O, acumulând date într-un buffer intern înainte de a le citi sau scrie efectiv.

### BufferedInputStream și BufferedOutputStream

```java
// Citire tamponată din fișier
try (BufferedInputStream bis = new BufferedInputStream(
        new FileInputStream("fisier.dat"), 8192)) {  // Buffer de 8KB
    byte[] buffer = new byte[1024];
    int bytesRead;
    while ((bytesRead = bis.read(buffer)) != -1) {
        // Procesează datele din buffer
    }
}

// Scriere tamponată în fișier
try (BufferedOutputStream bos = new BufferedOutputStream(
        new FileOutputStream("output.dat"))) {
    byte[] data = new byte[10000];
    // Umple data cu valori
    bos.write(data);
    // Nu este nevoie să apelăm flush() explicit - close() o va face
}
```

### BufferedReader și BufferedWriter

Acestea sunt echivalentele tampon pentru Character Streams și oferă metode suplimentare utile:

```java
// Citire tamponată linie cu linie
try (BufferedReader br = new BufferedReader(
        new FileReader("fisier.txt"))) {
    String line;
    while ((line = br.readLine()) != null) {  // readLine() este o metodă foarte utilă!
        System.out.println(line);
    }
}

// Scriere tamponată cu suport pentru newline
try (BufferedWriter bw = new BufferedWriter(
        new FileWriter("output.txt"))) {
    bw.write("Prima linie");
    bw.newLine();  // Adaugă separator de linie specific platformei
    bw.write("A doua linie");
}
```

### Avantajele folosirii Buffered Streams

- Performanță semnificativ îmbunătățită, mai ales pentru operații frecvente cu volume mici de date
- Reducerea apelurilor de sistem care sunt costisitoare în timp
- Metode suplimentare utile (ex: `readLine()` în `BufferedReader`)
- Operații de mark/reset mai eficiente (unde sunt suportate)

## Data Streams și Object Streams

Aceste stream-uri permit citirea și scrierea tipurilor de date primitive și a obiectelor.

### DataInputStream și DataOutputStream

Aceste clase permit citirea și scrierea tipurilor primitive de date Java în format binar:

```java
// Scrierea valorilor primitive
try (DataOutputStream dos = new DataOutputStream(
        new FileOutputStream("data.bin"))) {
    dos.writeInt(42);
    dos.writeDouble(3.14);
    dos.writeUTF("Hello, DataStream!");  // UTF-8 encoded String
    dos.writeBoolean(true);
}

// Citirea valorilor primitive
try (DataInputStream dis = new DataInputStream(
        new FileInputStream("data.bin"))) {
    int intValue = dis.readInt();
    double doubleValue = dis.readDouble();
    String stringValue = dis.readUTF();
    boolean boolValue = dis.readBoolean();
    
    System.out.println(intValue + ", " + doubleValue + ", " + 
                      stringValue + ", " + boolValue);
}
```

Este important să citiți datele în exact aceeași ordine în care au fost scrise.

### ObjectInputStream și ObjectOutputStream

Aceste clase permit serializarea și deserializarea obiectelor Java:

```java
// Clasa care va fi serializată trebuie să implementeze Serializable
class Person implements Serializable {
    private static final long serialVersionUID = 1L; // Recomandat pentru controlul versiunilor
    private String name;
    private int age;
    
    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }
    
    @Override
    public String toString() {
        return "Person [name=" + name + ", age=" + age + "]";
    }
}

// Serializarea unui obiect
try (ObjectOutputStream oos = new ObjectOutputStream(
        new FileOutputStream("person.ser"))) {
    Person person = new Person("John Doe", 30);
    oos.writeObject(person);
}

// Deserializarea unui obiect
try (ObjectInputStream ois = new ObjectInputStream(
        new FileInputStream("person.ser"))) {
    Person person = (Person) ois.readObject();
    System.out.println(person);
} catch (ClassNotFoundException e) {
    e.printStackTrace();
}
```

## Citirea și Scrierea Fișierelor de Text

Java oferă mai multe modalități de a lucra cu fișiere text, de la cele tradiționale la cele moderne introduse în Java 7 și versiunile ulterioare.

### Abordare Tradițională

```java
// Citirea unui fișier text
try (BufferedReader br = new BufferedReader(new FileReader("input.txt"))) {
    StringBuilder content = new StringBuilder();
    String line;
    while ((line = br.readLine()) != null) {
        content.append(line).append(System.lineSeparator());
    }
    String fileContent = content.toString();
}

// Scrierea unui fișier text
try (BufferedWriter bw = new BufferedWriter(new FileWriter("output.txt"))) {
    bw.write("Prima linie a fișierului");
    bw.newLine();
    bw.write("A doua linie a fișierului");
}
```

### Abordare Modernă (Java 7+)

Java 7 a introdus clasa `Files` care simplifică multe operații I/O:

```java
import java.nio.file.*;

// Citirea întregului fișier într-un String
String content = Files.readString(Path.of("input.txt"));

// Citirea tuturor liniilor într-o listă
List<String> lines = Files.readAllLines(Path.of("input.txt"));

// Scrierea unui String într-un fișier
Files.writeString(Path.of("output.txt"), "Conținutul fișierului");

// Scrierea unei liste de linii
List<String> outputLines = Arrays.asList("Linia 1", "Linia 2", "Linia 3");
Files.write(Path.of("output.txt"), outputLines);
```

### PrintWriter pentru Formatarea Ieșirii

`PrintWriter` oferă metode convenabile pentru formatarea datelor de ieșire:

```java
try (PrintWriter pw = new PrintWriter(new FileWriter("raport.txt"))) {
    pw.println("Raport Zilnic");
    pw.println("-------------");
    pw.printf("Data: %tF%n", new Date());
    pw.printf("Vânzări: %.2f lei%n", 1234.56);
    pw.print("Status: ");
    pw.println("Complet");
}
```

## Procesare I/O cu NIO și NIO.2

Java NIO (New I/O) și NIO.2 (Java 7+) oferă API-uri alternative pentru operații I/O, inclusiv I/O non-blocant și suport îmbunătățit pentru fișiere.

### Lucrul cu Buffer și Channel (NIO)

```java
// Citirea unui fișier folosind Channel și Buffer
try (FileChannel channel = FileChannel.open(
        Path.of("fisier.txt"), StandardOpenOption.READ)) {
    ByteBuffer buffer = ByteBuffer.allocate(1024);
    
    while (channel.read(buffer) != -1) {
        buffer.flip();  // Pregătește buffer-ul pentru citire
        
        while (buffer.hasRemaining()) {
            byte b = buffer.get();
            // Procesează fiecare byte
        }
        
        buffer.clear();  // Pregătește buffer-ul pentru următoarea scriere
    }
}

// Scrierea într-un fișier folosind Channel și Buffer
try (FileChannel channel = FileChannel.open(
        Path.of("output.txt"), 
        StandardOpenOption.CREATE, 
        StandardOpenOption.WRITE)) {
    ByteBuffer buffer = ByteBuffer.allocate(1024);
    
    buffer.put("Hello, Channel!".getBytes());
    buffer.flip();  // Pregătește buffer-ul pentru citire
    
    channel.write(buffer);
}
```

### API-ul Path (NIO.2)

Java 7 a introdus API-ul Path pentru manipularea mai ușoară a căilor de fișiere:

```java
// Crearea unei referințe Path
Path path = Paths.get("director/subdirector/fisier.txt");

// Informații despre path
System.out.println("Nume fișier: " + path.getFileName());
System.out.println("Părinte: " + path.getParent());
System.out.println("Număr componente: " + path.getNameCount());

// Manipularea path-urilor
Path absolut = path.toAbsolutePath();
Path normalizat = path.normalize();
Path rezolvat = Paths.get("director").resolve("fisier.txt");
```

### Operații pe Fișiere și Directoare (NIO.2)

Clasa `Files` oferă metode statice pentru operații comune:

```java
// Verificări
boolean exists = Files.exists(path);
boolean isDirectory = Files.isDirectory(path);
boolean isReadable = Files.isReadable(path);

// Creare
Files.createFile(path);
Files.createDirectories(path.getParent());

// Copiere și mutare
Files.copy(sursaPath, destinatiePath, StandardCopyOption.REPLACE_EXISTING);
Files.move(sursaPath, destinatiePath);

// Ștergere
Files.delete(path);
Files.deleteIfExists(path);

// Parcurgerea unui director
try (DirectoryStream<Path> stream = Files.newDirectoryStream(dirPath)) {
    for (Path entry : stream) {
        System.out.println(entry.getFileName());
    }
}

// Parcurgerea unui arbore de directoare
Files.walkFileTree(dirPath, new SimpleFileVisitor<Path>() {
    @Override
    public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) {
        System.out.println("Fișier: " + file);
        return FileVisitResult.CONTINUE;
    }
    
    @Override
    public FileVisitResult preVisitDirectory(Path dir, BasicFileAttributes attrs) {
        System.out.println("Director: " + dir);
        return FileVisitResult.CONTINUE;
    }
});
```

## Serializarea și Deserializarea

Serializarea este procesul de conversie a unui obiect într-un flux de bytes, care poate fi apoi stocat sau transmis. Deserializarea este procesul invers.

### Serializarea de Bază

```java
class Person implements Serializable {
    private static final long serialVersionUID = 1L;
    private String name;
    private int age;
    private transient String tempData; // câmpurile transient nu sunt serializate
    
    // constructori, getteri, setteri, etc.
}

// Serializare
Person person = new Person("Alice", 30);
try (ObjectOutputStream oos = new ObjectOutputStream(
        new FileOutputStream("person.ser"))) {
    oos.writeObject(person);
}

// Deserializare
try (ObjectInputStream ois = new ObjectInputStream(
        new FileInputStream("person.ser"))) {
    Person deserializedPerson = (Person) ois.readObject();
    System.out.println(deserializedPerson);
}
```

### Personalizarea Serializării

```java
class CustomPerson implements Serializable {
    private static final long serialVersionUID = 1L;
    private String name;
    private transient char[] password; // Nu dorim să serializăm parola direct
    
    // Metodă apelată la serializare
    private void writeObject(ObjectOutputStream oos) throws IOException {
        oos.defaultWriteObject(); // Efectuează serializarea standard
        
        // Serializăm manual câmpuri sensibile (ex: o versiune criptată)
        if (password != null) {
            oos.writeInt(password.length);
            // Aici ar trebui să criptăm parola într-un scenariu real
            for (char c : password) {
                oos.writeChar(c + 1); // "Criptare" simplă pentru exemplu
            }
        } else {
            oos.writeInt(0);
        }
    }
    
    // Metodă apelată la deserializare
    private void readObject(ObjectInputStream ois) 
            throws IOException, ClassNotFoundException {
        ois.defaultReadObject(); // Efectuează deserializarea standard
        
        // Deserializăm manual câmpurile personalizate
        int len = ois.readInt();
        if (len > 0) {
            password = new char[len];
            for (int i = 0; i < len; i++) {
                password[i] = (char)(ois.readChar() - 1); // "Decriptare"
            }
        }
    }
}
```

### Considerații pentru Serializare

- Toate câmpurile non-transient trebuie să fie serializabile
- `static` și `transient` nu sunt serializate
- Controlul versiunilor cu `serialVersionUID` este important pentru compatibilitate
- Serializarea are implicații de securitate - nu deserializa date din surse neîncredere
- Mecanisme alternative: JSON, XML, Protocol Buffers, etc.

## Tehnici Avansate

### Stream-uri pentru Compresia Datelor

Java oferă clase pentru comprimarea și decomprimarea datelor:

```java
// Comprimarea datelor cu GZIP
try (GZIPOutputStream gzos = new GZIPOutputStream(
        new FileOutputStream("data.gz"))) {
    gzos.write("Text care va fi comprimat.".getBytes());
}

// Decomprimarea datelor GZIP
try (GZIPInputStream gzis = new GZIPInputStream(
        new FileInputStream("data.gz"))) {
    byte[] buffer = new byte[1024];
    int len;
    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    while ((len = gzis.read(buffer)) != -1) {
        baos.write(buffer, 0, len);
    }
    System.out.println(baos.toString());
}

// Folosirea ZipOutputStream pentru arhive ZIP
try (ZipOutputStream zos = new ZipOutputStream(
        new FileOutputStream("archive.zip"))) {
    
    // Adaugă primul fișier în arhivă
    ZipEntry entry = new ZipEntry("fisier1.txt");
    zos.putNextEntry(entry);
    zos.write("Conținutul primului fișier".getBytes());
    zos.closeEntry();
    
    // Adaugă al doilea fișier în arhivă
    entry = new ZipEntry("fisier2.txt");
    zos.putNextEntry(entry);
    zos.write("Conținutul celui de-al doilea fișier".getBytes());
    zos.closeEntry();
}
```

### Concatenarea Stream-urilor

`SequenceInputSt