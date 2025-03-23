# Colecții de obiecte

## Cuprins
1. [Introducere în Colecții](#introducere-în-colecții)
2. [Interfața Collection](#interfața-collection)
3. [Ierarhia Colecțiilor](#ierarhia-colecțiilor)
4. [Tipuri de Colecții](#tipuri-de-colecții)
    - [Liste (Lists)](#liste-lists)
    - [Seturi (Sets)](#seturi-sets)
    - [Cozi (Queues)](#cozi-queues)
    - [Maps](#maps)
5. [Algoritmi și Utilitare pentru Colecții](#algoritmi-și-utilitare-pentru-colecții)
6. [Operații Comune](#operații-comune)
7. [Colecții Thread-Safe](#colecții-thread-safe)
8. [Colecții în Java 8+](#colecții-în-java-8)
9. [Bune Practici](#bune-practici)
10. [Exemplu Complet](#exemplu-complet)
11. [Exerciții Practice](#exerciții-practice)

## Introducere în Colecții

Colecțiile reprezintă unul dintre cele mai importante concepte în programarea Java, oferind structuri de date flexibile pentru stocarea și manipularea grupurilor de obiecte. Framework-ul Java Collections a fost introdus în Java 1.2 și a evoluat constant, devenind o componentă esențială a limbajului.

### Ce sunt colecțiile?

Colecțiile sunt containere care grupează multiple elemente într-o singură unitate. Ele sunt folosite pentru:
- Stocarea, recuperarea și manipularea datelor
- Transmiterea datelor de la o metodă la alta
- Reprezentarea datelor în formă de stivă, coadă, listă sau hartă

### Avantajele utilizării colecțiilor:

- Reducerea efortului de programare prin utilizarea implementărilor predefinite
- Îmbunătățirea performanței programului prin utilizarea unor algoritmi eficienți
- Creșterea calității prin utilizarea unor implementări complet testate
- Reutilizabilitate și interoperabilitate între API-uri diferite
- Extinderea ușoară pentru a adapta comportamentul la cerințe specifice

## Interfața Collection

La baza framework-ului se află interfața `Collection`, care definește operațiile de bază ce pot fi efectuate pe orice colecție:

```java
public interface Collection<E> extends Iterable<E> {
    // Operații de bază
    boolean add(E element);
    boolean remove(Object element);
    boolean contains(Object element);
    int size();
    boolean isEmpty();
    void clear();
    
    // Conversii
    Iterator<E> iterator();
    Object[] toArray();
    <T> T[] toArray(T[] a);
    
    // Operații bulk
    boolean containsAll(Collection<?> c);
    boolean addAll(Collection<? extends E> c);
    boolean removeAll(Collection<?> c);
    boolean retainAll(Collection<?> c);
}
```

Fiind o interfață, `Collection` nu poate fi instanțiată direct, ci trebuie utilizate clasele concrete care o implementează.

## Ierarhia Colecțiilor

Framework-ul Java Collections este organizat într-o ierarhie de interfețe și clase:

```
Iterable
  └── Collection
       ├── List
       │    ├── ArrayList
       │    ├── LinkedList
       │    └── Vector
       │         └── Stack
       │
       ├── Set
       │    ├── HashSet
       │    │    └── LinkedHashSet
       │    └── SortedSet
       │         └── TreeSet
       │
       └── Queue
            ├── PriorityQueue
            └── Deque
                 ├── ArrayDeque
                 └── LinkedList
```

Separat de interfața `Collection`, există și interfața `Map` care formează o ierarhie paralelă:

```
Map
 ├── HashMap
 │    └── LinkedHashMap
 ├── SortedMap
 │    └── TreeMap
 ├── Hashtable
 └── WeakHashMap
```

## Tipuri de Colecții

### Liste (Lists)

Listele sunt colecții ordonate care pot conține elemente duplicate. Elementele sunt indexate numeric, începând de la 0, și pot fi accesate prin poziția lor în listă.

#### ArrayList

`ArrayList` este implementarea cea mai utilizată a interfeței `List`, bazată pe un array dinamic:

```java
List<String> lista = new ArrayList<>();
lista.add("primul");
lista.add("al doilea");
lista.add("primul");  // Permite duplicate

String element = lista.get(1);  // Returnează "al doilea"
lista.set(1, "modificat");      // Modifică elementul de la index 1
lista.remove(0);                // Elimină primul element
```

**Caracteristici:**
- Acces rapid la elemente (timp constant O(1))
- Operații lente de inserare/ștergere în mijlocul listei (O(n))
- Utilizare eficientă a memoriei pentru liste mari
- Creștere dinamică a capacității când este necesar

#### LinkedList

`LinkedList` implementează atât interfața `List`, cât și `Deque`, utilizând o listă dublu înlănțuită:

```java
List<String> lista = new LinkedList<>();
lista.add("primul");
lista.add("al doilea");

// LinkedList poate fi și utilizată ca o coadă sau stivă
LinkedList<String> linkedList = new LinkedList<>(lista);
linkedList.addFirst("nou primul");
linkedList.addLast("ultimul");
String primul = linkedList.getFirst();
String ultimul = linkedList.removeLast();
```

**Caracteristici:**
- Inserări și ștergeri rapide oriunde în listă (O(1), dar necesită găsirea poziției)
- Acces mai lent la elemente aleatorii (O(n))
- Consum mai mare de memorie decât ArrayList
- Implementează și `Deque`, permițând utilizarea ca stivă sau coadă

### Seturi (Sets)

Seturile sunt colecții care nu permit elemente duplicate. Acestea modelează conceptul matematic de mulțime.

#### HashSet

`HashSet` este implementarea cea mai comună a interfeței `Set`, folosind tabele hash pentru stocarea elementelor:

```java
Set<String> set = new HashSet<>();
set.add("unu");
set.add("doi");
set.add("unu");  // Nu va fi adăugat, fiind duplicat

boolean contine = set.contains("doi");  // true
set.remove("unu");
```

**Caracteristici:**
- Operații foarte rapide (add, remove, contains) - în general O(1)
- Nu garantează ordinea elementelor
- Permite un singur element null
- Bazat pe `HashMap`

#### LinkedHashSet

`LinkedHashSet` extinde `HashSet` menținând ordinea de inserare a elementelor:

```java
Set<String> set = new LinkedHashSet<>();
set.add("unu");
set.add("doi");
set.add("trei");

// Iterarea va păstra ordinea: "unu", "doi", "trei"
for (String element : set) {
    System.out.println(element);
}
```

**Caracteristici:**
- Păstrează ordinea de inserare
- Operații puțin mai lente decât `HashSet`, dar tot foarte eficiente
- Util când ordinea de inserare este importantă

#### TreeSet

`TreeSet` implementează interfața `SortedSet` și stochează elementele într-un arbore roșu-negru:

```java
SortedSet<String> set = new TreeSet<>();
set.add("c");
set.add("a");
set.add("b");

// Iterarea va afișa elementele sortate: "a", "b", "c"
for (String element : set) {
    System.out.println(element);
}

String primul = set.first();  // "a"
String ultimul = set.last();  // "c"
```

**Caracteristici:**
- Menține elementele sortate (natural ordering sau comparator specific)
- Operații mai lente decât `HashSet` - O(log n)
- Oferă operații specifice precum `first()`, `last()`, `headSet()`, `tailSet()`
- Nu permite elemente null

### Cozi (Queues)

Cozile sunt colecții proiectate pentru a ține elemente înainte de procesare, de obicei în ordinea FIFO (first-in-first-out).

#### PriorityQueue

`PriorityQueue` este o coadă în care elementele sunt ordonate după prioritate:

```java
Queue<Integer> coada = new PriorityQueue<>();
coada.offer(3);
coada.offer(1);
coada.offer(2);

// Va extrage elementele în ordinea: 1, 2, 3
while (!coada.isEmpty()) {
    System.out.println(coada.poll());
}
```

**Caracteristici:**
- Ordinea elementelor este determinată de comparator sau ordinea naturală
- Operația `peek()` returnează elementul cu cea mai mare prioritate fără a-l elimina
- Operația `poll()` returnează și elimină elementul cu cea mai mare prioritate
- Implementată ca un heap binar

#### ArrayDeque

`ArrayDeque` implementează interfața `Deque` (double-ended queue) folosind un array redimensionabil:

```java
Deque<String> deque = new ArrayDeque<>();
deque.addFirst("primul");
deque.addLast("ultimul");

String primul = deque.removeFirst();
String ultimul = deque.removeLast();

// Poate fi folosită și ca stivă
deque.push("nou");
String element = deque.pop();
```

**Caracteristici:**
- Mai rapidă decât `Stack` când este folosită ca stivă
- Mai rapidă decât `LinkedList` când este folosită ca coadă
- Nu permite elemente null
- Nu are limitări de capacitate

### Maps

`Map` nu extinde interfața `Collection`, dar este parte din framework-ul Collections. Un Map asociază chei cu valori și nu permite chei duplicate.

#### HashMap

`HashMap` implementează interfața `Map` folosind o tabelă hash:

```java
Map<String, Integer> map = new HashMap<>();
map.put("unu", 1);
map.put("doi", 2);
map.put("trei", 3);

Integer valoare = map.get("doi");  // 2
map.remove("unu");
boolean contine = map.containsKey("trei");  // true
```

**Caracteristici:**
- Operații foarte rapide (put, get, remove) - în general O(1)
- Nu garantează ordinea elementelor
- Permite o singură cheie null și multiple valori null
- Nu este sincronizat (thread-safe)

#### LinkedHashMap

`LinkedHashMap` extinde `HashMap` menținând ordinea de inserare sau ordinea de acces:

```java
Map<String, String> map = new LinkedHashMap<>();
map.put("c", "valoare c");
map.put("a", "valoare a");
map.put("b", "valoare b");

// Iterarea va păstra ordinea de inserare
for (Map.Entry<String, String> entry : map.entrySet()) {
    System.out.println(entry.getKey() + ": " + entry.getValue());
}
```

**Caracteristici:**
- Păstrează ordinea de inserare sau ordinea de acces (LRU - least recently used)
- Operații puțin mai lente decât `HashMap`
- Utilă pentru implementarea cache-urilor LRU

#### TreeMap

`TreeMap` implementează interfața `SortedMap` și stochează cheile într-un arbore roșu-negru:

```java
SortedMap<String, Integer> map = new TreeMap<>();
map.put("c", 3);
map.put("a", 1);
map.put("b", 2);

// Cheile vor fi sortate: "a", "b", "c"
for (String key : map.keySet()) {
    System.out.println(key + ": " + map.get(key));
}
```

**Caracteristici:**
- Menține cheile sortate (natural ordering sau comparator specific)
- Operații mai lente decât `HashMap` - O(log n)
- Oferă operații specifice precum `firstKey()`, `lastKey()`, `headMap()`, `tailMap()`
- Nu permite chei null

## Algoritmi și Utilitare pentru Colecții

Clasa `Collections` oferă metode statice pentru operații comune pe colecții:

### Sortare

```java
List<String> lista = new ArrayList<>();
lista.add("banana");
lista.add("măr");
lista.add("portocală");

// Sortare folosind ordinea naturală
Collections.sort(lista);

// Sortare folosind un comparator
Collections.sort(lista, (s1, s2) -> s1.length() - s2.length());
```

### Amestecare și Rotire

```java
// Amestecă elementele în ordine aleatoare
Collections.shuffle(lista);

// Rotește elementele cu 2 poziții
Collections.rotate(lista, 2);
```

### Căutare

```java
// Căutare binară (lista trebuie să fie sortată)
int index = Collections.binarySearch(lista, "măr");

// Frecvența unui element
int frecventa = Collections.frequency(lista, "măr");
```

### Colecții Sincronizate și Nemodificabile

```java
// Colecție sincronizată (thread-safe)
List<String> syncList = Collections.synchronizedList(new ArrayList<>());

// Colecție nemodificabilă
List<String> immutableList = Collections.unmodifiableList(lista);
```

### Min/Max

```java
String min = Collections.min(lista);
String max = Collections.max(lista);
```

## Operații Comune

### Iterarea Colecțiilor

Sunt multiple modalități de a itera prin colecții:

#### 1. Folosind for-each

```java
List<String> lista = Arrays.asList("unu", "doi", "trei");
for (String element : lista) {
    System.out.println(element);
}
```

#### 2. Folosind Iterator

```java
Iterator<String> iterator = lista.iterator();
while (iterator.hasNext()) {
    String element = iterator.next();
    System.out.println(element);
    // iterator.remove(); // Permite eliminarea în timpul iterării
}
```

#### 3. Folosind expresii lambda (Java 8+)

```java
lista.forEach(element -> System.out.println(element));
// Sau mai simplu
lista.forEach(System.out::println);
```

### Filtrarea Colecțiilor

#### Folosind removeIf() (Java 8+)

```java
List<Integer> numere = new ArrayList<>(Arrays.asList(1, 2, 3, 4, 5));
numere.removeIf(n -> n % 2 == 0); // Elimină numerele pare
```

#### Folosind Streams (Java 8+)

```java
List<Integer> numere = Arrays.asList(1, 2, 3, 4, 5);
List<Integer> numerePare = numere.stream()
                                .filter(n -> n % 2 == 0)
                                .collect(Collectors.toList());
```

### Conversie între Tipuri de Colecții

```java
// Din List în Set (elimină duplicatele)
List<String> lista = Arrays.asList("unu", "doi", "unu", "trei");
Set<String> set = new HashSet<>(lista);

// Din Set în List
List<String> nouaLista = new ArrayList<>(set);

// Din List în Array
String[] array = lista.toArray(new String[0]);

// Din Array în List
List<String> listaDeArray = Arrays.asList(array);
```

## Colecții Thread-Safe

Majoritatea claselor din framework-ul Collections nu sunt sincronizate (thread-safe). Pentru medii multi-thread, Java oferă alternative:

### Collections sincronizate

```java
List<String> syncList = Collections.synchronizedList(new ArrayList<>());
Set<String> syncSet = Collections.synchronizedSet(new HashSet<>());
Map<String, String> syncMap = Collections.synchronizedMap(new HashMap<>());
```

### Concurrent Collections

Pachetul `java.util.concurrent` oferă implementări optimizate pentru medii concurente:

```java
// ConcurrentHashMap - performanță mai bună decât HashMap sincronizat
Map<String, String> concurrentMap = new ConcurrentHashMap<>();

// CopyOnWriteArrayList - optimizat pentru scenarii cu multe citiri și puține scrieri
List<String> cowList = new CopyOnWriteArrayList<>();

// BlockingQueue - pentru producător-consumator
BlockingQueue<String> queue = new LinkedBlockingQueue<>();
```

## Colecții în Java 8+

Java 8 a introdus Streams API care oferă operații funcționale pe colecții:

```java
List<String> lista = Arrays.asList("aa", "bbb", "c", "dddd");

// Filtrare, transformare și colectare
List<String> rezultat = lista.stream()
                           .filter(s -> s.length() > 1)
                           .map(String::toUpperCase)
                           .collect(Collectors.toList());

// Agregare
int totalLungime = lista.stream()
                       .mapToInt(String::length)
                       .sum();

// Grupare
Map<Integer, List<String>> grupeDupăLungime = lista.stream()
                                                 .collect(Collectors.groupingBy(String::length));
```

## Bune Practici

1. **Folosiți interfețe pentru declarații:**
   ```java
   // Recomandabil
   List<String> lista = new ArrayList<>();
   
   // Evitați
   ArrayList<String> lista = new ArrayList<>();
   ```

2. **Specificați capacitatea inițială când se cunoaște dimensiunea aproximativă:**
   ```java
   List<String> lista = new ArrayList<>(10000);
   ```

3. **Folosiți colecția potrivită pentru scenariu:**
    - `ArrayList` pentru acces aleatoriu frecvent
    - `LinkedList` pentru inserări/ștergeri frecvente
    - `HashSet` pentru verificarea existenței rapide
    - `TreeSet` pentru date sortate
    - `HashMap` pentru lookup rapid
    - `LinkedHashMap` pentru păstrarea ordinii
    - `ConcurrentHashMap` pentru medii multi-thread

4. **Evitați modificarea colecțiilor în timpul iterării:**
   ```java
   // Incorect - poate cauza ConcurrentModificationException
   for (String element : lista) {
       if (element.startsWith("a")) {
           lista.remove(element);
       }
   }
   
   // Corect - folosește Iterator.remove()
   Iterator<String> it = lista.iterator();
   while (it.hasNext()) {
       if (it.next().startsWith("a")) {
           it.remove();
       }
   }
   
   // Alternativ - Java 8+
   lista.removeIf(element -> element.startsWith("a"));
   ```

5. **Considerați colecții imutabile pentru date constante:**
   ```java
   List<String> constante = Collections.unmodifiableList(Arrays.asList("A", "B", "C"));
   ```

6. **Folosiți operații bulk când este posibil:**
   ```java
   // Mai eficient decât adăugarea pe rând
   lista.addAll(Arrays.asList("a", "b", "c"));
   ```

## Exemplu Complet

Iată un exemplu complet care utilizează diverse tipuri de colecții:

```java
import java.util.*;
import java.util.stream.Collectors;

public class ExempluColectii {
    public static void main(String[] args) {
        // Exemplu List
        List<String> fructe = new ArrayList<>();
        fructe.add("Măr");
        fructe.add("Banană");
        fructe.add("Portocală");
        fructe.add("Măr");  // Duplicat permis

        System.out.println("Lista de fructe: " + fructe);
        System.out.println("Al doilea fruct: " + fructe.get(1));
        
        // Sortare
        Collections.sort(fructe);
        System.out.println("Fructe sortate: " + fructe);
        
        // Exemplu Set
        Set<String> setFructe = new HashSet<>(fructe);
        System.out.println("Set fructe (fără duplicate): " + setFructe);
        
        // TreeSet - sortat
        Set<String> fructeSortate = new TreeSet<>(fructe);
        System.out.println("TreeSet (sortat): " + fructeSortate);
        
        // Exemplu Map
        Map<String, Integer> pretFructe = new HashMap<>();
        pretFructe.put("Măr", 2);
        pretFructe.put("Banană", 3);
        pretFructe.put("Portocală", 4);
        
        System.out.println("Preț banană: " + pretFructe.get("Banană"));
        
        // Iterare prin Map
        for (Map.Entry<String, Integer> entry : pretFructe.entrySet()) {
            System.out.println(entry.getKey() + ": " + entry.getValue() + " lei");
        }
        
        // Folosirea Queue
        Queue<String> coada = new LinkedList<>();
        coada.offer("Primul");
        coada.offer("Al doilea");
        coada.offer("Al treilea");
        
        System.out.println("Elementul din față: " + coada.peek());
        System.out.println("Extragere element: " + coada.poll());
        System.out.println("Nou element din față: " + coada.peek());
        
        // Stream API (Java 8+)
        List<String> fructeLungi = fructe.stream()
                                        .filter(f -> f.length() > 5)
                                        .collect(Collectors.toList());
        
        System.out.println("Fructe cu nume lungi: " + fructeLungi);
        
        // Map cu funcții lambda
        Map<String, Integer> lungimiFructe = fructe.stream()
                                                  .distinct()
                                                  .collect(Collectors.toMap(
                                                      f -> f,
                                                      String::length
                                                  ));
        
        System.out.println("Lungimile numelor de fructe: " + lungimiFructe);
    }
}
```

## Exerciții Practice

1. **Gestiunea unei liste de studenți:**
    - Creați o clasă `Student` cu atributele: id, nume, vârstă, medie
    - Implementați o metodă care folosește `ArrayList` pentru a stoca studenți
    - Sortați studenții după medie folosind un comparator personalizat
    - Filtrați studenții care au media peste 8

2. **Procesarea cuvintelor dintr-un text:**
    - Citiți un text dintr-un fișier
    - Folosiți un `Set` pentru a găsi toate cuvintele unice
    - Folosiți un `Map` pentru a număra frecvența fiecărui cuvânt
    - Afișați cele mai frecvente 5 cuvinte

3. **Simularea unui sistem de gestionare a comenzilor:**
    - Creați clase pentru `Produs`, `Comanda` și `Client`
    - Folosiți `HashMap` pentru a stoca produse (key: cod produs, value: obiect Produs)
    - Folosiți `Queue` pentru a gestiona comenzile în ordinea sosirii
    - Implementați metode pentru adăugarea, procesarea și raportarea comenzilor