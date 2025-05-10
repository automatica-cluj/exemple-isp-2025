# Introducere în Virtual Threads Java

## Ce sunt Virtual Threads?

Virtual Threads (firele virtuale) reprezintă o nouă facilitate în Java, introdusă oficial în JDK 21 (septembrie 2023), care revoluționează modul în care este abordată programarea concurentă în Java. Acestea sunt implementări ușoare ale interfeței `java.lang.Thread` care permit crearea și executarea eficientă a milioane de fire de execuție în cadrul unei singure aplicații Java.

În limbaj simplu, Virtual Threads sunt fire de execuție care consumă foarte puține resurse, permițând dezvoltatorilor să creeze aplicații mult mai scalabile, în special pentru sarcini care implică așteptarea după operațiile I/O (rețea, baze de date, fișiere, etc.).

## Virtual Threads vs. Platform Threads

În Java tradițional, fiecare Thread este asociat direct cu un fir de execuție la nivelul sistemului de operare, ceea ce limitează numărul de fire ce pot fi create și gestionate eficient. Aceste fire tradiționale se numesc acum "Platform Threads".

| **Caracteristică** | **Platform Threads** | **Virtual Threads** |
|-------------------|----------------------|---------------------|
| **Creare** | Costisitoare | Foarte ieftină |
| **Număr maxim practic** | Mii | Milioane |
| **Mapare la OS** | 1:1 (un thread Java = un thread OS) | Multe Virtual Threads folosesc câteva Platform Threads |
| **Utilizare memorie** | Mare (~1MB per thread) | Mică (câțiva KB per thread) |
| **Potrivit pentru** | Task-uri CPU-intensive | Task-uri care așteptă (I/O-bound) |

## Cum funcționează Virtual Threads?

Virtual Threads folosesc un model de execuție numit "mounting/unmounting":

1. Când un Virtual Thread trebuie să execute cod, este "montat" pe un Platform Thread
2. Când Virtual Thread-ul execută o operație blocantă (ex: așteptare I/O), este "demontat" și Platform Thread-ul devine disponibil pentru a executa alt Virtual Thread
3. Când operația blocantă se finalizează, Virtual Thread-ul este "remontat" pe un Platform Thread (posibil diferit) și continuă execuția

Acest mecanism permite unui număr limitat de Platform Threads să susțină milioane de Virtual Threads, fără a bloca resursele sistemului în timpul operațiilor de așteptare.

## Cum să creezi și să folosești Virtual Threads

### Crearea unui Virtual Thread

```java
// Metoda 1: Creare și pornire directă (recomandată)
Thread vThread = Thread.ofVirtual().start(() -> {
    System.out.println("Acesta rulează într-un Virtual Thread");
});

// Metoda 2: Creare și pornire separată
Thread vThread2 = Thread.ofVirtual().unstarted(() -> {
    System.out.println("Alt Virtual Thread");
});
vThread2.start();

// Metoda 3: Folosind un Executor specializat
try (var executor = Executors.newVirtualThreadPerTaskExecutor()) {
    executor.submit(() -> {
        System.out.println("Task într-un Virtual Thread");
        return "Rezultat";
    });
}
```

### Verificarea tipului de thread

```java
Thread thread = Thread.currentThread();
System.out.println("Este Virtual Thread? " + thread.isVirtual());
```

### Executarea mai multor task-uri în Virtual Threads

```java
// Execută 10,000 de task-uri concurente, fiecare în propriul Virtual Thread
try (var executor = Executors.newVirtualThreadPerTaskExecutor()) {
    List<Future<String>> futures = new ArrayList<>();
    
    for (int i = 0; i < 10_000; i++) {
        int taskId = i;
        futures.add(executor.submit(() -> {
            // Simulăm o operație I/O
            Thread.sleep(100);
            return "Task " + taskId + " finalizat";
        }));
    }
    
    // Colectăm rezultatele
    for (Future<String> future : futures) {
        System.out.println(future.get());
    }
}
```

## Beneficii cheie

### 1. Scalabilitate masivă

Virtual Threads permit aplicațiilor să gestioneze mult mai multe conexiuni concurente și operații blocante fără a consuma excesiv resursele sistemului.

```java
// Exemplu: Gestionarea a 10,000 de conexiuni simultan
// Cu Platform Threads tradiționale, acest cod ar consuma foarte multe resurse
try (var executor = Executors.newVirtualThreadPerTaskExecutor()) {
    for (int i = 0; i < 10_000; i++) {
        executor.submit(() -> {
            // Conectare la server
            // Trimitere cerere
            // Așteptare răspuns
            // Procesare răspuns
        });
    }
}
```

### 2. Cod mai simplu și mai direct

Virtual Threads permit scrierea codului concurent într-un stil secvențial și direct, fără necesitatea unor modele complexe de async/callback sau programare reactivă:

```java
// Stil tradițional asincron (complex)
client.sendAsync(request)
      .thenApply(response -> processResponse(response))
      .thenAccept(result -> saveResult(result))
      .exceptionally(ex -> handleError(ex));

// Stil cu Virtual Threads (simplu, secvențial)
Thread.ofVirtual().start(() -> {
    try {
        HttpResponse response = client.send(request);
        Result result = processResponse(response);
        saveResult(result);
    } catch (Exception ex) {
        handleError(ex);
    }
});
```

### 3. Performanță îmbunătățită pentru aplicații I/O-bound

Aplicațiile care petrec mult timp așteptând operații I/O (baze de date, rețea, fișiere) pot beneficia enorm de Virtual Threads, permițând procesarea mai multor cereri cu aceleași resurse hardware.

## Exemplu practic: Server HTTP simplu

```java
import com.sun.net.httpserver.*;
import java.io.*;
import java.net.*;
import java.util.concurrent.*;

public class SimpleHttpServer {
    public static void main(String[] args) throws IOException {
        HttpServer server = HttpServer.create(new InetSocketAddress(8080), 0);
        
        // Configurăm server-ul să folosească Virtual Threads
        server.setExecutor(Executors.newVirtualThreadPerTaskExecutor());
        
        server.createContext("/hello", exchange -> {
            // Simulăm procesarea care durează
            try {
                Thread.sleep(100);
                
                String response = "Hello from " + Thread.currentThread();
                exchange.sendResponseHeaders(200, response.length());
                
                try (OutputStream os = exchange.getResponseBody()) {
                    os.write(response.getBytes());
                }
            } catch (InterruptedException e) {
                exchange.sendResponseHeaders(500, 0);
            }
        });
        
        server.start();
        System.out.println("Server pornit pe portul 8080");
    }
}
```

## Când să folosești Virtual Threads

Virtual Threads sunt ideale pentru:

1. **Aplicații cu multe operații I/O concurente**:
    - Servere web și API-uri
    - Aplicații care accesează baze de date
    - Servicii care integrează alte sisteme prin rețea

2. **Scenarii de așteptare**:
    - Orice situație în care codul așteaptă o resursă externă
    - Operații pe fișiere
    - Comunicații sincrone între servicii

Virtual Threads **nu** sunt recomandate pentru:

1. **Task-uri CPU-intensive** - Pentru calcule intense, Platform Threads rămân mai eficiente
2. **Operații pe durate foarte scurte** - Dacă operațiile sunt foarte rapide, overhead-ul schimbării thread-urilor poate fi inutil

## Limitări

- **Codul nativ** - Virtual Threads nu pot fi demontate când blocarea apare în cod nativ (JNI)
- **ThreadLocal** - Utilizarea excesivă a ThreadLocal cu milioane de Virtual Threads poate duce la consum mare de memorie
- **Blocuri synchronized** - Pot cauza "pinning" (blocarea thread-ului carrier)

## Migrarea la Virtual Threads

Migrarea unei aplicații existente la Virtual Threads poate fi relativ simplă:

```java
// Înainte
ExecutorService executor = Executors.newFixedThreadPool(100);

// După
ExecutorService executor = Executors.newVirtualThreadPerTaskExecutor();
```

## Concluzii

Virtual Threads reprezintă un pas major înainte pentru programarea concurentă în Java, oferind:

1. **Scalabilitate** - Posibilitatea de a gestiona milioane de task-uri concurente
2. **Simplitate** - Model de programare direct și intuitiv
3. **Eficiență** - Utilizare optimă a resurselor hardware disponibile
4. **Performanță** - Îmbunătățiri semnificative pentru aplicații I/O-bound

Cu Virtual Threads, Java oferă acum un mecanism modern și eficient pentru concurență, permițând aplicațiilor să scaleze mult mai bine pe hardware-ul existent, fără a necesita modele de programare complexe sau framework-uri reactive elaborate.