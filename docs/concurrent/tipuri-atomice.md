# Introducere în Tipurile Atomice Java

## Ce sunt tipurile atomice?

Tipurile atomice sunt clase speciale din pachetul `java.util.concurrent.atomic` care permit efectuarea operațiilor thread-safe pe variabile individuale, fără a necesita blocuri `synchronized` sau alte mecanisme de blocare. O operație atomică este completă și indivizibilă - fie se execută complet, fie nu se execută deloc, fără a putea fi întreruptă de alte fire de execuție.

Aceste clase au fost introduse în Java 5 pentru a simplifica programarea concurentă și pentru a îmbunătăți performanța aplicațiilor multi-threading.

## De ce avem nevoie de tipuri atomice?

Când mai multe fire de execuție încearcă să modifice simultan aceeași variabilă, pot apărea rezultate neașteptate. Să analizăm un exemplu simplu:

```java
// Problemă clasică în mediu multi-threading
int counter = 0;

// Thread 1
counter++; // Această operație nu este atomică!

// Thread 2 (simultan)
counter++; // Poate interfera cu Thread 1
```

Incrementarea (`counter++`) nu este o operație atomică, ci constă din trei operații separate:
1. Citirea valorii curente
2. Incrementarea valorii
3. Scrierea valorii înapoi în variabilă

Dacă două fire execută aceste operații în același timp, este posibil ca valoarea finală să fie incrementată doar o dată, nu de două ori cum ar fi de așteptat.

## Tipurile atomice de bază

### AtomicInteger

Permite operații atomice pe valori de tip int:

```java
import java.util.concurrent.atomic.AtomicInteger;

AtomicInteger counter = new AtomicInteger(0); // Inițializare cu valoarea 0

// Incrementare atomică
counter.incrementAndGet(); // Echivalent atomic pentru ++counter
counter.getAndIncrement(); // Echivalent atomic pentru counter++

// Setare și obținere
counter.set(10);
int value = counter.get(); // Obține valoarea curentă

// Adunare atomică
counter.addAndGet(5); // Adaugă 5 și returnează noua valoare
```

### AtomicLong

Similar cu AtomicInteger, dar pentru valori de tip long:

```java
AtomicLong longCounter = new AtomicLong(0);
longCounter.incrementAndGet();
long result = longCounter.get();
```

### AtomicBoolean

Operații atomice pe valori boolean:

```java
AtomicBoolean flag = new AtomicBoolean(false);
flag.set(true);
boolean value = flag.get();

// Schimbă valoarea și returnează vechea valoare
boolean oldValue = flag.getAndSet(true);

// Schimbă valoarea doar dacă este cea așteptată
boolean success = flag.compareAndSet(false, true);
```

### AtomicReference

Permite operații atomice pe referințe la obiecte:

```java
User user = new User("John");
AtomicReference<User> userRef = new AtomicReference<>(user);

User oldUser = userRef.get();
User newUser = new User("Alice");

// Actualizează referința doar dacă este cea așteptată
userRef.compareAndSet(oldUser, newUser);
```

## Operații atomice fundamentale

### get() și set()

Citirea și scrierea atomică a valorilor:

```java
AtomicInteger ai = new AtomicInteger(5);
int value = ai.get(); // Obține valoarea curentă atomic
ai.set(10); // Setează valoarea atomic
```

### compareAndSet()

Actualizează valoarea doar dacă valoarea curentă este cea așteptată:

```java
AtomicInteger ai = new AtomicInteger(5);
boolean success = ai.compareAndSet(5, 10); // Va returna true și va actualiza la 10
boolean fail = ai.compareAndSet(5, 20); // Va returna false (valoarea e acum 10)
```

Aceasta este operația fundamentală pe care se bazează majoritatea celorlalte operații atomice.

### getAndUpdate() și updateAndGet()

Actualizează valoarea folosind o funcție și returnează valoarea veche sau nouă:

```java
AtomicInteger ai = new AtomicInteger(5);
int oldValue = ai.getAndUpdate(x -> x * 2); // oldValue = 5, ai = 10
int newValue = ai.updateAndGet(x -> x + 1); // newValue = 11, ai = 11
```

## Exemplu practic: Contor thread-safe

```java
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

public class SimpleCounter {
    private final AtomicInteger count = new AtomicInteger(0);
    
    public void increment() {
        count.incrementAndGet();
    }
    
    public int getCount() {
        return count.get();
    }
    
    public static void main(String[] args) throws InterruptedException {
        SimpleCounter counter = new SimpleCounter();
        ExecutorService executor = Executors.newFixedThreadPool(5);
        
        // Lansăm 1000 de task-uri care incrementează contorul
        for (int i = 0; i < 1000; i++) {
            executor.submit(counter::increment);
        }
        
        executor.shutdown();
        executor.awaitTermination(5, TimeUnit.SECONDS);
        
        System.out.println("Valoare finală: " + counter.getCount());
        // Va afișa întotdeauna 1000, fiind thread-safe
    }
}
```

## Avantajele utilizării tipurilor atomice

1. **Simplitate** - Cod mai clar și mai succint față de sincronizarea tradițională
2. **Performanță** - Operații non-blocking, mai rapide decât blocurile synchronized
3. **Siguranță** - Garantează operații corecte în medii multi-threading
4. **Scalabilitate** - Permit un grad mai mare de concurență în aplicații

## Când să folosiți tipurile atomice

Tipurile atomice sunt potrivite pentru:

1. **Contoare simple și acumulatori** în medii concurente
2. **Flags și management de stare** pentru sincronizarea între fire
3. **Operații de citire-actualizare-scriere** care trebuie să fie atomice
4. **Valori partajate** între mai multe fire de execuție

Pentru operații mai complexe care implică mai multe variabile, sau pentru sincronizarea între secvențe mai lungi de cod, ar putea fi necesare alte mecanisme precum blocurile sincronizate, lock-urile explicite sau colecțiile concurente.

## Limitări

Tipurile atomice garantează atomicitatea doar pentru operații pe valori individuale. Pentru operații care implică mai multe variabile, ar trebui utilizate alte mecanisme de sincronizare.

## Concluzii

Tipurile atomice din Java sunt instrumente esențiale pentru programarea concurentă, oferind operații thread-safe pe variabile individuale fără overhead-ul sincronizării tradiționale. Ele simplifică implementarea algoritmilor concurenți și îmbunătățesc performanța aplicațiilor multi-threading.

Utilizarea adecvată a acestor clase poate reduce substanțial complexitatea codului concurent și poate elimina multe erori asociate cu sincronizarea tradițională.