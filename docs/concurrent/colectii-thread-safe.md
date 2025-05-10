# Colecții Blocking și Thread-Safe în Java

## Introducere

În programarea concurentă Java, colecțiile standard (ArrayList, HashMap, etc.) nu sunt sigure pentru utilizarea simultană de către mai multe fire de execuție. Pentru a rezolva această problemă, Java oferă două categorii principale de colecții pentru medii multi-threading:

1. **Colecții Thread-Safe** - garantează operații corecte în medii concurente
2. **Colecții Blocking** - oferă operații care pot bloca firul de execuție până la îndeplinirea anumitor condiții

## Colecții Thread-Safe

Colecțiile thread-safe garantează că operațiile efectuate asupra lor sunt corecte și sigure în medii multi-threading. Modificările făcute de un fir sunt vizibile pentru alte fire, iar structura internă a colecției rămâne validă chiar și când mai multe fire o accesează simultan.

### Exemple de colecții thread-safe:

1. **Colecții sincronizate** (metode din clasa Collections):
   ```java
   List<String> syncList = Collections.synchronizedList(new ArrayList<>());
   Map<String, Integer> syncMap = Collections.synchronizedMap(new HashMap<>());
   ```

2. **ConcurrentHashMap**:
   ```java
   ConcurrentHashMap<String, Integer> map = new ConcurrentHashMap<>();
   map.put("cheie", 1);
   map.putIfAbsent("cheie2", 2);
   ```

3. **CopyOnWriteArrayList**:
   ```java
   CopyOnWriteArrayList<String> list = new CopyOnWriteArrayList<>();
   list.add("element"); // Creează o copie internă la fiecare modificare
   ```

4. **ConcurrentSkipListMap** și **ConcurrentSkipListSet**:
   ```java
   ConcurrentSkipListMap<String, Integer> sortedMap = new ConcurrentSkipListMap<>();
   ```

### Caracteristici cheie ale colecțiilor thread-safe:

1. **Atomicitate** - Operațiile individuale sunt atomice
2. **Vizibilitate** - Modificările sunt vizibile tuturor firelor
3. **Ordonare** - Asigură ordinea corectă a operațiilor

## Colecții Blocking

Colecțiile blocking adaugă operații care pot bloca (pune în așteptare) un fir de execuție până când o anumită condiție este îndeplinită. Acestea sunt extrem de utile pentru scenarii de tip producător-consumator, unde un fir produce date și altul le consumă.

### Exemple de colecții blocking:

1. **BlockingQueue** (și implementările sale):
   ```java
   BlockingQueue<Task> queue = new ArrayBlockingQueue<>(100);
   
   // Producător
   queue.put(task); // Blochează până când există spațiu disponibil
   
   // Consumator
   Task task = queue.take(); // Blochează până când există un element disponibil
   ```

2. **BlockingDeque**:
   ```java
   BlockingDeque<String> deque = new LinkedBlockingDeque<>();
   deque.putFirst("element"); // Blochează dacă deque e plin
   String first = deque.takeFirst(); // Blochează dacă deque e gol
   ```

3. **TransferQueue**:
   ```java
   TransferQueue<Data> queue = new LinkedTransferQueue<>();
   queue.transfer(data); // Blochează până când un consumator preia elementul
   ```

### Operații blocking principale:

1. **put(e)** - Adaugă un element, blochează dacă colecția e plină
2. **take()** - Extrage un element, blochează dacă colecția e goală
3. **offer(e, time, unit)** - Adaugă un element cu timeout
4. **poll(time, unit)** - Extrage un element cu timeout

## Diferențe cheie între colecții thread-safe și blocking

| **Caracteristică** | **Colecții Thread-Safe** | **Colecții Blocking** |
|-------------------|----------------------|---------------------|
| **Scop principal** | Siguranță în operații concurente | Coordonare între fire (producător-consumator) |
| **Comportament** | Nu blochează firele (exceptând sincronizarea internă) | Are operații special concepute pentru a bloca firele |
| **Operații speciale** | Operații atomic compuse (putIfAbsent, compute) | Operații blocante (put, take) |
| **Utilizare tipică** | Acces concurent la date partajate | Transferul datelor între fire |
| **Performanță** | Optimizat pentru acces concurent | Optimizat pentru coordonare între fire |

## Avantaje ale colecțiilor thread-safe

1. **Siguranță** - Garantează consistența datelor în medii concurente
2. **Flexibilitate** - Operații non-blocking pentru majoritatea metodelor
3. **Performanță** - Implementări optimizate pentru concurență (ex: ConcurrentHashMap)
4. **Varietate** - Disponibile pentru multe tipuri de colecții (liste, seturi, hărți)

## Avantaje ale colecțiilor blocking

1. **Coordonare între fire** - Facilitează comunicarea între producători și consumatori
2. **Control al fluxului** - Implementează natural back-pressure (limitarea ratei de producție)
3. **Simplitate** - Reduce necesitatea sincronizării manuale
4. **Predictibilitate** - Comportament clar în scenarii de așteptare

## Când să folosiți colecții thread-safe

Folosiți colecții thread-safe când:

1. **Aveți nevoie de acces concurent la date partajate** fără necesitatea coordonării între fire
2. **Operațiile ar trebui să fie mereu non-blocking**
3. **Modelul de acces include mai multe citiri decât scrieri** (CopyOnWriteArrayList)
4. **Trebuie să modificați o colecție în timp ce o parcurgeți** (ConcurrentHashMap)

Exemple de utilizare:
- Cache-uri partajate
- Registry-uri de servicii
- Date de configurare citite de multiple fire
- Contoare și statistici

```java
// Exemplu: Cache thread-safe
ConcurrentHashMap<String, User> userCache = new ConcurrentHashMap<>();
userCache.computeIfAbsent(userId, id -> fetchUserFromDatabase(id));
```

## Când să folosiți colecții blocking

Folosiți colecții blocking când:

1. **Aveți nevoie de coordonare între fire producătoare și consumatoare**
2. **Trebuie să limitați rata de procesare** sau numărul de elemente în așteptare
3. **Trebuie să așteptați până când sunt disponibile date** pentru procesare
4. **Implementați un pipeline de procesare** cu mai multe etape

Exemple de utilizare:
- Cozi de task-uri
- Buffer-e pentru procesare în etape
- Sisteme de mesagerie
- Thread pools

```java
// Exemplu: Procesare task-uri în etape
class TaskProcessor {
    private final BlockingQueue<Task> inputQueue = new LinkedBlockingQueue<>();
    
    public void submitTask(Task task) throws InterruptedException {
        inputQueue.put(task); // Blochează dacă coada e plină
    }
    
    void processTasksAsync() {
        new Thread(() -> {
            try {
                while (true) {
                    Task task = inputQueue.take(); // Blochează dacă coada e goală
                    processTask(task);
                }
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }).start();
    }
}
```

## Exemplu practic: Comparație directă

### Scenariu: Procesarea unor date

#### Cu colecție thread-safe:

```java
// Folosind o colecție thread-safe
ConcurrentHashMap<String, Integer> results = new ConcurrentHashMap<>();

// Multiple fire adaugă rezultate
executorService.submit(() -> {
    // Procesare
    results.put("rezultat1", calculație());
});

// Alt fir verifică periodic rezultatele - Nu blochează dacă nu există rezultate
Integer result = results.get("rezultat1");
if (result != null) {
    // Folosește rezultatul
} else {
    // Rezultatul nu e disponibil încă
}
```

#### Cu colecție blocking:

```java
// Folosind o colecție blocking
BlockingQueue<Result> resultQueue = new LinkedBlockingQueue<>();

// Multiple fire adaugă rezultate
executorService.submit(() -> {
    // Procesare
    resultQueue.put(new Result("rezultat1", calculație()));
});

// Alt fir așteaptă rezultatele - Blochează până când există un rezultat
Result result = resultQueue.take();
// Folosește result - garantat că avem un rezultat
```

## Hibridizarea abordărilor

În aplicațiile complexe, deseori veți combina ambele tipuri de colecții:

```java
// Exemplu: Sistem de procesare cu rate limiter
public class ProcessingSystem {
    // Coada blocking pentru task-uri de intrare
    private final BlockingQueue<Task> inputQueue = new ArrayBlockingQueue<>(1000);
    
    // Mapă thread-safe pentru rezultate
    private final ConcurrentHashMap<String, Result> results = new ConcurrentHashMap<>();
    
    // Adaugă task-uri cu back-pressure
    public void submitTask(Task task) throws InterruptedException {
        inputQueue.put(task);
    }
    
    // Pornește procesarea
    public void startProcessing() {
        new Thread(() -> {
            try {
                while (!Thread.currentThread().isInterrupted()) {
                    // Extrage task (blochează dacă nu există)
                    Task task = inputQueue.take();
                    
                    // Procesează și stochează rezultatul
                    Result result = processTask(task);
                    results.put(task.getId(), result);
                }
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }).start();
    }
    
    // Verifică rezultatul (non-blocking)
    public Result getResult(String taskId) {
        return results.get(taskId);
    }
}
```

## Cele mai bune practici

1. **Alegeți colecția potrivită pentru scenariul dvs.:**
   - Pentru coordonare producător-consumator → BlockingQueue
   - Pentru acces concurent la date partajate → ConcurrentHashMap
   - Pentru liste cu multe citiri și puține scrieri → CopyOnWriteArrayList

2. **Dimensionați adecvat colecțiile blocking:**
   - Limitarea capacității ajută la implementarea back-pressure

3. **Gestionați corect excepțiile InterruptedException:**
   - Restaurați întotdeauna flag-ul de întrerupere: `Thread.currentThread().interrupt();`

4. **Preferați operațiile cu timeout:**
   - `offer(e, timeout, unit)` și `poll(timeout, unit)` în loc de `put()` și `take()`

5. **Evitați amestecarea sincronizării manuale cu colecții thread-safe:**
   - Se pot produce deadlock-uri sau comportamente nedorite

## Concluzii

Atât colecțiile thread-safe cât și cele blocking sunt esențiale în programarea concurentă Java, dar servesc scopuri diferite:

- **Colecțiile thread-safe** sunt ideale pentru accesul sigur la date partajate, fără necesitatea blocării explicite.

- **Colecțiile blocking** excelează în coordonarea între fire, oferind mecanisme naturale pentru scenarii producător-consumator.

Alegerea corectă între acestea depinde de cerințele specifice ale aplicației și de modelul de concurență utilizat. Pentru scenarii complexe, nu ezitați să combinați ambele tipuri de colecții pentru a obține cel mai bun comportament.