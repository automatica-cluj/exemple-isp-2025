# Java Streams API

## Cuprins
1. [Introducere în Streams API](#introducere-în-streams-api)
2. [Crearea Stream-urilor](#crearea-stream-urilor)
3. [Operații Intermediare](#operații-intermediare)
4. [Operații Terminale](#operații-terminale)
5. [Stream-uri Specializate](#stream-uri-specializate)
6. [Paralelizarea Stream-urilor](#paralelizarea-stream-urilor)
7. [Colectori](#colectori)
8. [Exemple Practice](#exemple-practice)
9. [Bune Practici](#bune-practici)
10. [Comparație cu Metodele Tradiționale](#comparație-cu-metodele-tradiționale)
11. [Probleme Uzuale și Soluții](#probleme-uzuale-și-soluții)
12. [Referințe](#referințe)

## Introducere în Streams API

Stream API a fost introdus în Java 8 și reprezintă un mod nou și puternic de a procesa colecții de date. Un stream reprezintă o secvență de elemente asupra cărora se pot aplica diverse operații în mod agregat.

### Ce este un Stream?

- Un stream **nu este o structură de date**, ci un flux de date care poate fi procesat
- Operează pe o sursă de date (cum ar fi colecții, array-uri, generatori etc.)
- Nu modifică sursa de date originală
- Este proiectat pentru a fi utilizat în operații de tip pipeline
- Poate fi procesate în mod secvențial sau paralel

### Caracteristici cheie ale Stream-urilor

- **Procesare în pipeline** - operațiile pe stream-uri pot fi înlănțuite, creând un pipeline de procesare
- **Procesare internă** - spre deosebire de colecții care necesită iterare externă, stream-urile sunt iterate intern
- **Procesare lazy** - multe operații pe stream-uri nu sunt executate până când nu se întâlnește o operație terminală
- **Consumabile o singură dată** - un stream poate fi parcurs o singură dată; odată consumat, trebuie creat unul nou
- **Paralelism fără efort** - stream-urile pot fi paralelizate cu o singură operație, fără a necesita gestionarea manuală a thread-urilor

### Diferența dintre Stream și Colecție

| Aspect | Colecție | Stream |
|--------|----------|--------|
| Scopul principal | Stocarea datelor | Procesarea datelor |
| Iterare | Externă (controlată de utilizator) | Internă (controlată de stream) |
| Modificarea datelor | Permite modificarea directă | Nu permite modificarea sursă |
| Accesarea elementelor | Acces aleatoriu | Acces secvențial |
| Consumul | Poate fi utilizat de mai multe ori | Poate fi consumat o singură dată |
| Evaluare | Imediată | Lazy (amânată) |
| Paralelism | Necesită cod adițional | Suport nativ (parallelStream()) |

## Crearea Stream-urilor

Există mai multe moduri de a crea stream-uri:

### 1. Din Colecții

```java
List<String> lista = Arrays.asList("Java", "Python", "C++");
Stream<String> streamDinLista = lista.stream();

// Pentru stream-uri paralele
Stream<String> streamParalel = lista.parallelStream();
```

### 2. Din Array-uri

```java
String[] array = {"Java", "Python", "C++"};
Stream<String> streamDinArray = Arrays.stream(array);

// Stream din porțiune de array
Stream<String> streamParte = Arrays.stream(array, 0, 2); // doar "Java" și "Python"
```

### 3. Din Valori Individuale

```java
Stream<String> streamDeValori = Stream.of("Java", "Python", "C++");
```

### 4. Stream-uri Infinite

```java
// Stream infinit de numere aleatorii
Stream<Double> randomStream = Stream.generate(Math::random);

// Stream infinit de valori incrementate
Stream<Integer> incrementStream = Stream.iterate(0, n -> n + 1);

// Stream infinit cu predicat (Java 9+)
Stream<Integer> numereSubZece = Stream.iterate(0, n -> n < 10, n -> n + 1);
```

### 5. Stream-uri Goale

```java
Stream<String> streamGol = Stream.empty();
```

### 6. Din Fișiere (java.nio.file)

```java
try {
    Stream<String> liniiDinFisier = Files.lines(Paths.get("fisier.txt"));
    // ...
} catch (IOException e) {
    // tratare excepție
}
```

### 7. Din String-uri

```java
IntStream streamCaractere = "Hello".chars();

// Split string și creare stream
Stream<String> streamCuvinte = Pattern.compile("\\s+").splitAsStream("Hello Java World");
```

## Operații Intermediare

Operațiile intermediare sunt operații care returnează un nou stream și pot fi înlănțuite. Ele sunt lazy - nu sunt executate până când nu se întâlnește o operație terminală.

### Filtrare

```java
// Filtrare bazată pe predicat
Stream<String> filtrat = stream.filter(s -> s.startsWith("J"));
```

### Transformare

```java
// Transformare element cu element
Stream<String> uppercase = stream.map(String::toUpperCase);

// Transformare cu aplatizare (pentru stream-uri de stream-uri)
Stream<String> aplatizat = listaDeListe.stream().flatMap(List::stream);
```

### Limitare

```java
// Limitare la primele n elemente
Stream<String> primeleN = stream.limit(10);

// Ignorarea primelor n elemente
Stream<String> faraEle = stream.skip(5);
```

### Sortare

```java
// Sortare folosind ordinea naturală
Stream<String> sortatNatural = stream.sorted();

// Sortare cu comparator specific
Stream<String> sortatPersonalizat = stream.sorted(Comparator.comparing(String::length));
```

### Distincte

```java
// Elimină elementele duplicate
Stream<String> faraDuplicate = stream.distinct();
```

### Peek

```java
// Utilizat pentru debugging, execută o acțiune pentru fiecare element fără a modifica stream-ul
Stream<String> debug = stream.peek(System.out::println);
```

### Conversie Tip (Map To)

```java
// Conversie la stream primitiv
IntStream lungimi = stream.mapToInt(String::length);
```

## Operații Terminale

Operațiile terminale consumă stream-ul și produc un rezultat. După o operație terminală, stream-ul este considerat consumat și nu mai poate fi utilizat.

### Colectare

```java
// Colectare într-o listă
List<String> lista = stream.collect(Collectors.toList());

// Colectare într-un set
Set<String> set = stream.collect(Collectors.toSet());

// Colectare într-un string
String string = stream.collect(Collectors.joining(", "));
```

### Reducere

```java
// Reducere cu valoare inițială și operator
int suma = stream.mapToInt(String::length).reduce(0, Integer::sum);

// Reducere fără valoare inițială (returnează Optional)
Optional<String> concatenate = stream.reduce((s1, s2) -> s1 + s2);
```

### ForEach

```java
// Execută o acțiune pentru fiecare element
stream.forEach(System.out::println);

// ForEach ordonat (respectă ordinea pentru stream-uri paralele)
stream.forEachOrdered(System.out::println);
```

### Min/Max

```java
// Găsește valoarea minimă (returnează Optional)
Optional<String> min = stream.min(Comparator.comparing(String::length));

// Găsește valoarea maximă (returnează Optional)
Optional<String> max = stream.max(Comparator.comparing(String::length));
```

### Count

```java
// Numără elementele din stream
long count = stream.count();
```

### Verificare

```java
// Verifică dacă toate elementele satisfac predicatul
boolean toateAuA = stream.allMatch(s -> s.contains("a"));

// Verifică dacă cel puțin un element satisface predicatul
boolean celPutinUnul = stream.anyMatch(s -> s.contains("a"));

// Verifică dacă niciun element nu satisface predicatul
boolean nici = stream.noneMatch(s -> s.contains("z"));
```

### Găsire

```java
// Găsește orice element care satisface predicatul (Optional)
Optional<String> gasit = stream.filter(s -> s.length() > 10).findAny();

// Găsește primul element care satisface predicatul (Optional)
Optional<String> primul = stream.filter(s -> s.length() > 10).findFirst();
```

### toArray

```java
// Conversie la array de Object
Object[] arr = stream.toArray();

// Conversie la array de tip specific
String[] arrString = stream.toArray(String[]::new);
```

## Stream-uri Specializate

Java oferă variante specializate pentru tipurile primitive pentru a evita boxing/unboxing:

### IntStream

```java
// Creare
IntStream intStream = IntStream.range(1, 10); // 1-9
IntStream intStreamClosed = IntStream.rangeClosed(1, 10); // 1-10

// Operații specifice
int sum = intStream.sum();
OptionalDouble avg = intStream.average();
OptionalInt max = intStream.max();
OptionalInt min = intStream.min();
```

### LongStream

```java
LongStream longStream = LongStream.rangeClosed(1L, 1000000L);
long sum = longStream.sum();
```

### DoubleStream

```java
DoubleStream doubleStream = DoubleStream.of(1.1, 2.2, 3.3);
double sum = doubleStream.sum();
```

### Conversii

```java
// De la Stream<T> la stream primitiv
IntStream intStream = lista.stream().mapToInt(String::length);

// De la stream primitiv la Stream<T>
Stream<Integer> boxed = intStream.boxed();
```

## Paralelizarea Stream-urilor

Stream-urile pot fi procesate paralel pentru a îmbunătăți performanța pe seturi mari de date:

```java
// Creare stream paralel dintr-o colecție
Stream<String> parallelStream = lista.parallelStream();

// Conversie stream secvențial la paralel
Stream<String> parallelStream2 = stream.parallel();

// Verificare dacă un stream este paralel
boolean isParallel = stream.isParallel();

// Conversie stream paralel la secvențial
Stream<String> sequentialStream = parallelStream.sequential();
```

### Considerații pentru stream-uri paralele:

- Utile pentru seturi mari de date
- Eficiente pentru operații costisitoare
- Pot fi mai lente decât stream-urile secvențiale pentru seturi mici de date
- Ordinea nu este garantată (cu excepția `forEachOrdered`)
- Necesită operații stateless și non-interfering
- Performanța depinde de hardware (număr de core-uri CPU)

## Colectori

Clasa `Collectors` oferă numeroase metode factory pentru operațiuni comune de reducere:

### Colectori de bază

```java
// Colectare în colecții
List<String> list = stream.collect(Collectors.toList());
Set<String> set = stream.collect(Collectors.toSet());
Collection<String> coll = stream.collect(Collectors.toCollection(LinkedList::new));

// Conversie la String
String joined = stream.collect(Collectors.joining(", "));
```

### Agregări

```java
// Numărare
long count = stream.collect(Collectors.counting());

// Sumă, medie, minim, maxim
int sum = stream.collect(Collectors.summingInt(String::length));
double avg = stream.collect(Collectors.averagingInt(String::length));
Optional<String> min = stream.collect(Collectors.minBy(Comparator.naturalOrder()));

// Statistici
IntSummaryStatistics stats = stream.collect(Collectors.summarizingInt(String::length));
System.out.println("Count: " + stats.getCount());
System.out.println("Min: " + stats.getMin());
System.out.println("Max: " + stats.getMax());
System.out.println("Sum: " + stats.getSum());
System.out.println("Average: " + stats.getAverage());
```

### Grupare și Partiționare

```java
// Grupare după lungime
Map<Integer, List<String>> grupate = 
    stream.collect(Collectors.groupingBy(String::length));

// Grupare și transformare downstream
Map<Integer, Set<String>> grupateInSet = 
    stream.collect(Collectors.groupingBy(String::length, Collectors.toSet()));

// Grupare cu calcul statistic
Map<Integer, Double> avgLengthByFirstChar = 
    stream.collect(Collectors.groupingBy(
        s -> s.charAt(0), 
        Collectors.averagingInt(String::length)));

// Partiționare (grupare binară bazată pe predicat)
Map<Boolean, List<String>> partitionat = 
    stream.collect(Collectors.partitioningBy(s -> s.length() > 5));
```

### Colectori compuși

```java
// Grupare cu numărare
Map<Character, Long> countByFirstChar = 
    stream.collect(Collectors.groupingBy(
        s -> s.charAt(0), 
        Collectors.counting()));

// Grupare cu joining
Map<Integer, String> stringsByLength = 
    stream.collect(Collectors.groupingBy(
        String::length, 
        Collectors.joining("-")));
```

## Exemple Practice

### Exemplul 1: Filtrare și Transformare

```java
List<String> rezultat = lista.stream()
    .filter(s -> s.length() > 3)
    .map(String::toUpperCase)
    .collect(Collectors.toList());
```

### Exemplul 2: Procesare de Obiecte

```java
class Produs {
    private String nume;
    private double pret;
    private String categorie;
    
    // constructor, getteri, setteri
}

List<Produs> produse = // ...

// Suma prețurilor produselor dintr-o anumită categorie
double total = produse.stream()
    .filter(p -> "Electronice".equals(p.getCategorie()))
    .mapToDouble(Produs::getPret)
    .sum();

// Produsul cel mai scump per categorie
Map<String, Optional<Produs>> celMaiScump = produse.stream()
    .collect(Collectors.groupingBy(
        Produs::getCategorie,
        Collectors.maxBy(Comparator.comparing(Produs::getPret))));
```

### Exemplul 3: Procesare Numerică

```java
// Generare și procesare numere
List<Integer> numere = IntStream.rangeClosed(1, 100)
    .boxed()
    .collect(Collectors.toList());

// Numere prime
List<Integer> prime = numere.stream()
    .filter(n -> n > 1 && IntStream.range(2, n)
        .noneMatch(i -> n % i == 0))
    .collect(Collectors.toList());

// Suma pătratelor numerelor pare
int sumaPătrate = numere.stream()
    .filter(n -> n % 2 == 0)
    .mapToInt(n -> n * n)
    .sum();
```

### Exemplul 4: Operațiuni pe Fișiere

```java
// Numărare cuvinte unice într-un fișier
try {
    long cuvinte = Files.lines(Paths.get("fisier.txt"))
        .flatMap(line -> Arrays.stream(line.split("\\s+")))
        .map(String::toLowerCase)
        .distinct()
        .count();
    
    System.out.println("Număr de cuvinte unice: " + cuvinte);
} catch (IOException e) {
    e.printStackTrace();
}
```

### Exemplul 5: Grouping Complex

```java
// Grupare studenți după calificativ și calcul statistici
class Student {
    private String nume;
    private int varsta;
    private double nota;
    // constructor, getteri, setteri
    
    public String getCalificativ() {
        if (nota >= 9) return "Excelent";
        if (nota >= 7) return "Bine";
        if (nota >= 5) return "Satisfăcător";
        return "Nesatisfăcător";
    }
}

List<Student> studenti = // ...

Map<String, DoubleSummaryStatistics> statisticiPeCalificative = studenti.stream()
    .collect(Collectors.groupingBy(
        Student::getCalificativ,
        Collectors.summarizingDouble(Student::getNota)));
```

## Bune Practici

1. **Folosiți operații intermediare pentru a reduce dimensiunea stream-ului cât mai devreme posibil**
   ```java
   // Bine - filtrează mai întâi, apoi transformă
   stream.filter(s -> s.length() > 5).map(expensiveOperation);
   
   // Mai puțin eficient - transformă toate elementele, apoi filtrează
   stream.map(expensiveOperation).filter(s -> s.length() > 5);
   ```

2. **Evitați operațiile cu efecte secundare în stream-uri**
   ```java
   // Evitați - modifică o variabilă externă
   List<String> rezultate = new ArrayList<>();
   stream.forEach(s -> rezultate.add(s.toUpperCase())); // NU FACEȚI ASTA
   
   // Corect - folosiți collect
   List<String> rezultate = stream.map(String::toUpperCase).collect(Collectors.toList());
   ```

3. **Folosiți stream-uri specializate pentru tipuri primitive**
   ```java
   // Mai eficient - evită boxing/unboxing
   int sum = IntStream.rangeClosed(1, 1000).sum();
   
   // Mai puțin eficient
   int sum = Stream.iterate(1, n -> n + 1)
               .limit(1000)
               .mapToInt(Integer::intValue)
               .sum();
   ```

4. **Aveți grijă la stream-uri infinite**
   ```java
   // Corect - limitează stream-ul infinit
   Stream.iterate(0, n -> n + 1)
       .limit(100)
       .forEach(System.out::println);
   
   // GREȘIT - va executa la infinit
   // Stream.iterate(0, n -> n + 1).forEach(System.out::println);
   ```

5. **Folosiți parallel() cu precauție**
   ```java
   // Potrivit pentru paralelizare - operație costisitoare pe date mari
   List<String> rezultat = lista.parallelStream()
       .filter(s -> s.length() > 3)
       .map(s -> procesareCostisitoare(s))
       .collect(Collectors.toList());
   
   // Nu se justifică paralelizarea - operație simplă pe date puține
   List<String> rezultat = lista.stream() // fără parallelStream()
       .filter(s -> s.length() > 3)
       .map(String::toUpperCase)
       .collect(Collectors.toList());
   ```

6. **Folosiți colectori predefiniti când este posibil**
   ```java
   // Mai expresiv și probabil mai eficient
   Map<Boolean, List<String>> partitionat = 
       stream.collect(Collectors.partitioningBy(s -> s.length() > 5));
   
   // Mai puțin expresiv
   Map<Boolean, List<String>> manual = new HashMap<>();
   manual.put(true, new ArrayList<>());
   manual.put(false, new ArrayList<>());
   stream.forEach(s -> {
       if (s.length() > 5) {
           manual.get(true).add(s);
       } else {
           manual.get(false).add(s);
       }
   });
   ```

7. **Împărțiți lanțurile lungi de stream-uri pentru lizibilitate**
   ```java
   // Mai greu de citit
   List<String> rezultat = persoane.stream()
       .filter(p -> p.getVarsta() > 18)
       .map(Persoana::getNume)
       .map(String::toUpperCase)
       .filter(n -> n.startsWith("A"))
       .sorted()
       .limit(10)
       .collect(Collectors.toList());
   
   // Mai ușor de citit și înțeles
   Stream<Persoana> adulti = persoane.stream()
       .filter(p -> p.getVarsta() > 18);
       
   Stream<String> nume = adulti
       .map(Persoana::getNume)
       .map(String::toUpperCase);
       
   List<String> rezultat = nume
       .filter(n -> n.startsWith("A"))
       .sorted()
       .limit(10)
       .collect(Collectors.toList());
   ```

## Comparație cu Metodele Tradiționale

### Iterare Tradițională vs Stream

```java
// Abordare tradițională (iterare externă)
List<String> rezultat = new ArrayList<>();
for (String s : lista) {
    if (s.length() > 3) {
        String upper = s.toUpperCase();
        rezultat.add(upper);
    }
}

// Abordare cu stream (iterare internă)
List<String> rezultat = lista.stream()
    .filter(s -> s.length() > 3)
    .map(String::toUpperCase)
    .collect(Collectors.toList());
```

### Avantajele Stream-urilor

1. **Cod mai concis și declarativ**
2. **Operațiile pot fi paralelizate ușor**
3. **Lazy evaluation** - poate îmbunătăți performanța
4. **Compoziție mai simplă a operațiilor**
5. **Mai puțin cod boilerplate** - mai puține variabile temporare

### Dezavantaje ale Stream-urilor

1. **Pot fi mai greu de debugat**
2. **Pot avea o ușoară penalizare de performanță pentru operații simple**
3. **Curba de învățare pentru programatori obișnuiți cu stilul imperativ**

## Probleme Uzuale și Soluții

### Problema 1: Stream-uri consumate

```java
Stream<String> stream = lista.stream();
stream.forEach(System.out::println);
// Următoarea linie va arunca o excepție
stream.count(); // IllegalStateException: stream has already been operated upon or closed
```

**Soluție:** Creați un nou stream când aveți nevoie să procesați din nou aceleași date.

### Problema 2: Operații stateful

```java
// Poate avea comportament nedorit în stream-uri paralele
List<String> rezultat = lista.parallelStream()
    .sorted() // operație stateful costisitoare în stream-uri paralele
    .collect(Collectors.toList());
```

**Soluție:** Evaluați dacă paralelizarea este cu adevărat necesară. Uneori, un stream secvențial cu operații stateful este mai eficient.

### Problema 3: Efecte secundare

```java
// Anti-pattern: efecte secundare în operații de stream
List<Integer> numere = new ArrayList<>();
IntStream.range(1, 10).forEach(numere::add); // Efect secundar

// Abordare corectă
List<Integer> numere = IntStream.range(1, 10).boxed().collect(Collectors.toList());
```

### Problema 4: Stream-uri și excepții verificate

```java
// Nu compilează - lambda-urile nu pot arunca excepții verificate
List<String> linii = Files.list(Paths.get("director"))
    .map(path -> Files.readAllLines(path)) // Compile error: excepție verificată
    .collect(Collectors.toList());
```

**Soluție:** Încapsulați codul care poate arunca excepții într-o metodă separată sau folosiți un wrapper pentru excepții:

```java
List<List<String>> linii = Files.list(Paths.get("director"))
    .map(path -> {
        try {
            return Files.readAllLines(path);
        } catch (IOException e) {
            throw new UncheckedIOException(e);
        }
    })
    .collect(Collectors.toList());
```

## Referințe

- [Java API Documentation - Stream](https://docs.oracle.com/javase/8/docs/api/java/util/stream/Stream.html)
- [Java API Documentation - Collectors](https://docs.oracle.com/javase/8/docs/api/java/util/stream/Collectors.html)
- [Java Documentation - Stream Operations](https://docs.oracle.com/javase/tutorial/collections/streams/)