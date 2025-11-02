# Fire de Execuție în Java

## Introducere

Firele de execuție (threads) reprezintă mecanismul prin care pot fi implementate în cadrul unui program secvențe de cod ce se execută virtual în paralel. Acest concept este esențial pentru dezvoltarea aplicațiilor moderne care necesită execuția simultană a mai multor activități, cum ar fi serverele care trebuie să deservească mai mulți clienți în același timp.

## Diferența între fire de execuție și procese

Deși ambele concepte implică execuția în paralel a unor secvențe de cod, există diferențe fundamentale între ele:

| **Fire de execuție** | **Procese** |
|----------------------|-------------|
| Secvențe ale unui program (proces) ce se execută aparent în paralel | Entități independente ce se execută independent |
| Există în cadrul unui singur proces | Gestionate de către nucleul sistemului de operare |
| Partajează resursele procesului părinte | Au propriile resurse alocate |

## Stările unui fir de execuție

Un fir de execuție poate exista în una dintre următoarele patru stări:

1. **New** - obiectul fir de execuție a fost creat dar încă nu a fost pornit
2. **Runnable** - firul se află în starea în care poate fi rulat în momentul în care procesorul devine disponibil
3. **Dead** - firul s-a terminat, fie prin ieșirea din metoda run() (calea normală), fie forțat
4. **Blocked** - firul de execuție este blocat și nu poate fi rulat, chiar dacă procesorul este disponibil

## Construirea și pornirea firelor de execuție

În Java, există două modalități principale de a crea fire de execuție:

### 1. Prin extinderea clasei Thread

```java
public class Counter extends Thread {
    
    Counter(String name){
        super(name);
    }
    
    public void run(){
        for(int i=0; i<20; i++){
            System.out.println(getName() + " i = " + i);
            try {
                Thread.sleep((int)(Math.random() * 1000));
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        System.out.println(getName() + " job finalizat.");
    }
    
    public static void main(String[] args) {
        Counter c1 = new Counter("counter1");
        Counter c2 = new Counter("counter2");
        Counter c3 = new Counter("counter3");
        
        c1.start();
        c2.start();
        c3.start();
    }
}
```

### 2. Prin implementarea interfeței Runnable

Această metodă este utilă când clasa noastră extinde deja o altă clasă (Java nu permite moștenire multiplă).

```java
public class CounterRunnable implements Runnable {
    
    public void run(){
        Thread t = Thread.currentThread();
        for(int i=0; i<20; i++){
            System.out.println(t.getName() + " i = " + i);
            try {
                Thread.sleep((int)(Math.random() * 1000));
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        System.out.println(t.getName() + " job finalizat.");
    }
    
    public static void main(String[] args) {
        CounterRunnable c1 = new CounterRunnable();
        CounterRunnable c2 = new CounterRunnable();
        CounterRunnable c3 = new CounterRunnable();
        
        Thread t1 = new Thread(c1, "counter1");
        Thread t2 = new Thread(c2, "counter2");
        Thread t3 = new Thread(c3, "counter3");
        
        t1.start();
        t2.start();
        t3.start();
    }
}
```

**Important:** Metoda `run()` nu trebuie apelată direct de către programator. Aceasta va fi invocată automat când firul este pornit prin metoda `start()`.

## Terminarea firelor de execuție

Un fir de execuție se poate termina în următoarele moduri:

1. **Terminare normală** - prin ieșirea naturală din metoda `run()` (recomandată)
2. **Folosind metoda `stop()`** - nu este recomandată, fiind marcată ca "deprecated" în Java 2
3. **Întrerupere** - folosind metoda `interrupt()` care generează o excepție `InterruptedException` ce poate fi capturată

Cea mai bună practică este să adăugați condiții în metoda `run()` care să determine ieșirea din aceasta.

## Prioritatea firelor de execuție

Prioritatea unui fir indică planificatorului (scheduler) cât de important este acesta. Firele cu prioritate mai mare vor fi alese cu precădere pentru execuție când procesorul devine disponibil.

Pentru a seta și obține prioritatea, puteți folosi metodele:
- `setPriority(int priority)`
- `getPriority()`

Valorile priorității pot fi între `Thread.MIN_PRIORITY` și `Thread.MAX_PRIORITY`.

```java
CounterX c1 = new CounterX(1000, 1);   // prioritate minimă
CounterX c2 = new CounterX(1000, 5);   // prioritate medie
CounterX c3 = new CounterX(1000, 10);  // prioritate maximă
```

**Atenție!** Nu vă bazați pe priorități în construirea logicii programului, deoarece acestea pot da rezultate diferite pe sisteme diferite.

## Metoda join()

Metoda `join()` din clasa Thread determină un fir de execuție să aștepte terminarea unui alt fir:

```java
class JoinTest extends Thread {
    String n;
    Thread t;
    JoinTest(String n, Thread t) {
        this.n = n;
        this.t = t;
    }

    public void run() {
        System.out.println("Firul " + n + " a intrat în metoda run()");
        try {                
            if (t != null) t.join();  // Așteaptă terminarea firului t
            System.out.println("Firul " + n + " execută operație.");
            Thread.sleep(3000);
            System.out.println("Firul " + n + " a terminat operația.");
        }
        catch(Exception e) {
            e.printStackTrace();
        } 
    }
}
```

## Sincronizarea firelor

Când mai multe fire accesează aceleași resurse, pot apărea probleme de concurență. Java oferă mecanisme de sincronizare pentru a preveni accesul simultan la aceleași resurse.

### Metode și blocuri sincronizate

Sincronizarea se realizează prin:

1. **Metode sincronizate**:
```java
synchronized void metodaSincronizata() { 
    // cod sincronizat 
}
```

2. **Blocuri sincronizate**:
```java
synchronized(obiect) {
    // cod sincronizat
}
```

Fiecare obiect în Java are un monitor (sau zăvor) asociat. Când un fir accesează o metodă sau un bloc sincronizat, acesta obține monitorul obiectului. Alte fire care încearcă să acceseze metode sincronizate ale aceluiași obiect vor fi blocate până când monitorul este eliberat.

```java
public class TestSincronizare {
public static void main(String[] args) {
    Punct p = new Punct();
    FirSet fs1 = new FirSet(p);
    FirGet fg1 = new FirGet(p);
 
    fs1.start();
    fg1.start();
}
}
 
class FirGet extends Thread {
    Punct p;
 
    public FirGet(Punct p){
        this.p = p;
    }
 
    public void run(){
        int i=0;
        int a,b;
        while(++i<15){         
           // synchronized(p){
            a= p.getX();          
            try {
                sleep(50);
            } catch (InterruptedException e) {  
                e.printStackTrace();
            }         
            b = p.getY();
           // }
            System.out.println("Am citit: ["+a+","+b+"]");
        }
    }
}//.class
 
 
class FirSet extends Thread {
    Punct p;
    public FirSet(Punct p){
        this.p = p;
    } 
    public void run(){
        int i =0;
        while(++i<15){
            int a = (int)Math.round(10*Math.random()+10);
            int b = (int)Math.round(10*Math.random()+10);
 
            //synchronized(p){
            p.setXY(a,b);
            // }
 
            try {
                sleep(10);
            } catch (InterruptedException e) {
 
                e.printStackTrace();
            }
            System.out.println("Am scris: ["+a+","+b+"]");
        }
    }
}//.class
 
class Punct {
    int x,y;
    public void setXY(int a,int b){
        x = a;y = b;
    }  
    public int getX(){return x;}
    public int getY(){return y;}   
}
```

### Interblocaje (Deadlocks)

Folosirea necorespunzătoare a blocurilor sincronizate poate duce la situații de interblocaj, când două sau mai multe fire sunt blocate, fiecare așteptând după celălalt să elibereze un monitor.

```java
// Exemplu de cod care poate genera un interblocaj
public class Deadlock {

    public static void main(String[] args) {
        final Robot alphonse = new Robot("Alphonse");
        final Robot gaston = new Robot("Gaston");
        new Thread(new Runnable() {
            public void run() { alphonse.proceseazaPiesa(gaston); }
        }).start();
        new Thread(new Runnable() {
            public void run() { gaston.proceseazaPiesa(alphonse); }
        }).start();
    }
}

class Robot {
    private final String name;
    Piesa piesa;
    public Robot(String name) {
        this.name = name;
        this.piesa = new Piesa();
    }
    public String getName() {
        return this.name;
    }
    public synchronized void proceseazaPiesa(Robot r) {
        System.out.println(name+" proceseaza piesa ");
        piesa.procesare();
        r.primestePiesa(this);
    }
    public synchronized void primestePiesa(Robot r) {
        System.out.println(r.getName()+ " a transmis piesa catre "+name);
        this.piesa = r.getPiesa();
    }

    private Piesa getPiesa() {
        return piesa;
    }
}

class Piesa{
    public void procesare(){
        System.out.println("Piesa se proceseaza");
        try {
            Thread.sleep(100);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
```

### Comunicarea între fire: wait(), notify() și notifyAll()

Pentru o sincronizare avansată, Java oferă mecanisme de comunicare între fire:

- **wait()** - blochează firul curent până când un alt fir apelează notify() sau notifyAll() pe același obiect
- **notify()** - deblochează un singur fir care a apelat wait() pe același obiect
- **notifyAll()** - deblochează toate firele care au apelat wait() pe același obiect

Aceste metode aparțin clasei Object și pot fi apelate doar din interiorul unui bloc sau metodă sincronizată.

```java
synchronized double get() {
    try {
        while(content.size() == 0) wait();  // Așteaptă până există elemente
        // Procesează date...
    } catch(Exception e) {
        e.printStackTrace();
    }
    return rezultat;
}

synchronized void push(double d) {
    // Adaugă date...
    notify();  // Anunță un fir care așteaptă
}
```

## Exemplu practic: producător-consumator

Problema producător-consumator este un exemplu clasic de sincronizare între fire:

```java
public class Test {
    public static void main(String[] args){
        Buffer b = new Buffer();
        Producer pro = new Producer(b);
        Consumer c = new Consumer(b);
        Consumer c2 = new Consumer(b);
        //Lanseaza cele 3 fire de executie. Se observa ca cele 3 fire de executie
        // folosesc in comun obiectul b de tip Buffer. Exista un fir pro ce este
        // responsabil cu adaugarea de elemente in buffer si doua obiecte
        // responsabile cu extragerea elementelor din buffer.
        pro.start();
        c.start();
        c2.start();
    }
}

/**
 * Aceasta este o clasa de tip fir de executie. In cadrul unei bucle infinite sunt
 * generate numere de tip double si sunt adaugate in cadrul unui obiect de tip Buffer
 * apeland metoda put. Aduagare elementelor se face la intervale de 1 secunda.
 *
 */
class Producer implements Runnable
{
    private Buffer bf;
    private Thread thread;
    Producer(Buffer bf){this.bf=bf;}

    public void start()
    {
        if (thread==null)
        {
            thread = new Thread(this);
            thread.start();
        }
    }

    public void run()
    {
        while (true)
        {
            bf.push(Math.random());
            System.out.println("Am scris.");
            try
            {Thread.sleep(1000);}catch(Exception e){}
        }
    }
}

/**
 * Aceasta este o clasa de tip fir de executie. Intr-o bucla infinita sunt citite elemente
 * din cadrul unui obiect de tip Buffer.
 */

class Consumer extends Thread
{
    private Buffer bf;
    Consumer(Buffer bf){this.bf=bf;}

    public void run()
    {
        while (true)
        {
            System.out.println("Am citit : "+this+" >> "+bf.get());
        }
    }
}

class Buffer
{
    /*
     * Vector folosit pentru a inmagazina obiecte de tip Double.
     */
    ArrayList content = new ArrayList();

    /**
     * Prin intermediul acestei metode sunt adaugate elemente in containerul content.
     * Se observa ca aceasta metoda este sincronizata. Metoda fa fi apelata de firele
     * de executie de tip Producer.
     *
     * Dupa adaugarea unui element in container se apeleaza metoda notify() aceasta asigura
     * trezirea unui fir de executie ce a fost blocat prin apelul functiei wait().
     * @param d
     */
    synchronized void push(double d)
    {
        content.add(new Double(d));
        notify();
    }

    /**
     * Aceasta metoda este folosita pentru a extrage elemente din cadrul containerului
     * content. Se observa ca aceasta metoda este sincronizata.
     * Daca containerul este  gol se apeleaza metoda wait(). Aceasta va bloca firul
     * de executie apelant pana in momentul in care un fir de executie producator
     * va adauga in container un element si va apela metoda notify() (vezi metoda put(...))
     *
     * @return
     */
    synchronized double get()
    {
        double d=-1;
        try
        {
            while(content.size()==0) wait();
            d = (((Double)content.get(0))).doubleValue();
            content.remove(0);
        }catch(Exception e){e.printStackTrace();}
        return d;
    }
}
```

## Pachetul java.util.concurrent

În această documentație am prezentat conceptele de bază ale firelor de execuție în Java, folosind mecanismele primitive oferite de limbaj (Thread și synchronized). Este important de menționat că începând cu Java 1.5 (Java 5), a fost introdusă librăria `java.util.concurrent`, care oferă implementări de nivel înalt pentru concurență, mult mai robuste și mai ușor de folosit.

### Funcționalități oferite de java.util.concurrent

#### 1. Executors și Thread Pools

Pachetul introduce conceptul de executoare (Executors) și pool-uri de fire, care gestionează automat crearea, reutilizarea și terminarea firelor de execuție:

```java
// Crearea unui pool cu număr fix de fire
ExecutorService executor = Executors.newFixedThreadPool(5);

// Trimiterea unei sarcini spre execuție
executor.submit(() -> {
    System.out.println("Sarcină executată de " + Thread.currentThread().getName());
});

// Închiderea pool-ului
executor.shutdown();
```

#### 2. Future și Callable

Interfețele `Future` și `Callable` permit executarea asincronă a operațiilor care returnează rezultate:

```java
Callable<String> task = () -> {
    // Operație de lungă durată
    Thread.sleep(2000);
    return "Rezultatul operației";
};

Future<String> future = executor.submit(task);
String result = future.get(); // Așteaptă finalizarea și obține rezultatul
```

#### 3. Colecții concurente

Pachetul include implementări thread-safe ale colecțiilor standard:
- `ConcurrentHashMap` - versiune optimizată pentru concurență a HashMap-ului
- `CopyOnWriteArrayList` - implementare care creează copii la modificare
- `BlockingQueue` - cozi care suportă operații de așteptare

```java
BlockingQueue<String> queue = new ArrayBlockingQueue<>(10);
producer.submit(() -> queue.put("element")); // Blochează dacă e plină
consumer.submit(() -> queue.take());        // Blochează dacă e goală
```

#### 4. Clase de sincronizare avansată

Librăria oferă primitive de sincronizare mai flexibile:
- `CountDownLatch` - permite unui fir să aștepte până când un număr de operații s-au încheiat
- `CyclicBarrier` - permite unui grup de fire să aștepte unele după altele
- `Semaphore` - controlează accesul la resurse limitate
- `ReadWriteLock` - permite accesul concurent pentru citire, dar exclusiv pentru scriere

#### 5. Atomic Variables

Clase pentru operații atomice pe variabile, fără a fi nevoie de blocuri synchronized:

```java
AtomicInteger counter = new AtomicInteger(0);
counter.incrementAndGet(); // Operație atomică (thread-safe)
```

### Avantajele pachetului java.util.concurrent

1. **Performanță crescută**: Implementările din acest pachet sunt optimizate pentru scalabilitate și performanță
2. **Cod mai clar și mai ușor de întreținut**: API-urile de nivel înalt reduc complexitatea codului
3. **Reducerea riscurilor de erori**: Multe probleme clasice (deadlock, race condition) sunt evitate prin design
4. **Flexibilitate**: Oferă control fin asupra comportamentului concurent
5. **Testabilitate**: Clasele sunt concepute pentru a fi mai ușor de testat
6. **Scalabilitate**: Suport pentru aplicații cu grad înalt de paralelism


## Recomandări finale

1. Evitați utilizarea metodelor deprecated precum `stop()` și `suspend()`
2. Folosiți terminarea normală a firelor prin ieșirea din metoda `run()` si nu folosiți `stop()`
3. Fiți atenți la potențialele interblocaje când folosiți blocuri sincronizate
4. Testați aplicațiile multi-threading în diverse condiții, deoarece comportamentul poate varia
5. Pentru aplicații moderne, preferați clasele din pachetul `java.util.concurrent` în locul mecanismelor primitive
