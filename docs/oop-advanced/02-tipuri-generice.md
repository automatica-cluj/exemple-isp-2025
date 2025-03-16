# Documentație: Tipuri Generice (Generics) în Java

## Cuprins
1. [Introducere](#introducere)
2. [Motivație și Avantaje](#motivație-și-avantaje)
3. [Sintaxa de Bază](#sintaxa-de-bază)
    - [Clase Generice](#clase-generice)
    - [Interfețe Generice](#interfețe-generice)
    - [Metode Generice](#metode-generice)
4. [Parametri de Tip](#parametri-de-tip)
    - [Convenții de Denumire](#convenții-de-denumire)
    - [Parametri de Tip Multipli](#parametri-de-tip-multipli)
5. [Wildcard Types (Tipuri Joker)](#wildcard-types-tipuri-joker)
    - [Unbounded Wildcards (?)](#unbounded-wildcards)
    - [Upper Bounded Wildcards (? extends T)](#upper-bounded-wildcards--extends-t)
    - [Lower Bounded Wildcards (? super T)](#lower-bounded-wildcards--super-t)
6. [Type Erasure](#type-erasure)
7. [Restricții și Limitări](#restricții-și-limitări)
8. [Exemple Practice](#exemple-practice)
    - [Container Generic](#container-generic)
    - [Metode Utilitare Generice](#metode-utilitare-generice)
    - [Perechi și Tuple](#perechi-și-tuple)
9. [Design Patterns cu Generics](#design-patterns-cu-generics)
10. [Bune Practici](#bune-practici)

## Introducere

Tipurile generice (generics) reprezintă o facilitate a limbajului Java introdusă în versiunea 5.0 care permite crearea de clase, interfețe și metode parametrizate cu tipuri. Acestea oferă un mecanism pentru a defini structuri și algoritmi independenți de tip, păstrând în același timp siguranța tipurilor la compilare.

Genericele permit scrierea codului o singură dată, dar utilizarea acestuia cu diferite tipuri de date, fără a face conversii explicite (casting) și fără a pierde siguranța tipurilor.

## Motivație și Avantaje

Înainte de introducerea genericelor, colecțiile din Java stocau elemente de tip `Object`, ceea ce necesita conversii explicite la tipul dorit și permitea introducerea erorilor de tip în timpul rulării.

**Avantajele genericelor:**

1. **Siguranța tipurilor la compilare**: Erorile de tip sunt detectate în timpul compilării, nu la rulare.
2. **Eliminarea conversiilor explicite (casting)**: Nu mai este necesar să facem conversii explicite când recuperăm elemente.
3. **Posibilitatea implementării de algoritmi generici**: Aceleași metode pot fi aplicate pe diferite tipuri de date.
4. **Cod mai curat și mai ușor de întreținut**: Codul este mai expresiv și mai puțin predispus la erori.

Exemplu fără generice (Java pre-5.0):
```java
List lista = new ArrayList();
lista.add("Hello");
lista.add(123); // Legal, dar conceptual greșit dacă lista ar trebui să conțină doar șiruri
String s = (String) lista.get(0); // Conversie explicită necesară
String s2 = (String) lista.get(1); // Aruncă ClassCastException la rulare
```

Exemplu cu generice:
```java
List<String> lista = new ArrayList<>();
lista.add("Hello");
// lista.add(123); // Eroare la compilare - tipul este verificat
String s = lista.get(0); // Nu este necesară conversie explicită
```

## Sintaxa de Bază

### Clase Generice

O clasă generică este definită cu unul sau mai mulți parametri de tip între paranteze unghiulare (`<>`):

```java
public class Container<T> {
    private T element;
    
    public Container(T element) {
        this.element = element;
    }
    
    public T getElement() {
        return element;
    }
    
    public void setElement(T element) {
        this.element = element;
    }
}
```

Utilizare:
```java
Container<String> stringContainer = new Container<>("Hello");
String str = stringContainer.getElement(); // Nu este necesară conversie

Container<Integer> intContainer = new Container<>(42);
int value = intContainer.getElement(); // Auto-unboxing
```

Începând cu Java 7, putem folosi diamond operator (`<>`) pentru a simplifica declarațiile:
```java
Container<String> stringContainer = new Container<>("Hello");
```

### Interfețe Generice

Similar cu clasele, interfețele pot fi și ele generice:

```java
public interface Pair<K, V> {
    K getKey();
    V getValue();
    void setKey(K key);
    void setValue(V value);
}

public class OrderedPair<K, V> implements Pair<K, V> {
    private K key;
    private V value;
    
    public OrderedPair(K key, V value) {
        this.key = key;
        this.value = value;
    }
    
    @Override
    public K getKey() { return key; }
    
    @Override
    public V getValue() { return value; }
    
    @Override
    public void setKey(K key) { this.key = key; }
    
    @Override
    public void setValue(V value) { this.value = value; }
}
```

### Metode Generice

Metodele pot fi și ele generice, chiar și când sunt definite în clase non-generice:

```java
public class Utils {
    // Metodă generică
    public static <T> void printArray(T[] array) {
        for (T element : array) {
            System.out.println(element);
        }
    }
    
    // Metodă generică cu mai mulți parametri de tip
    public static <K, V> boolean compare(Pair<K, V> p1, Pair<K, V> p2) {
        return p1.getKey().equals(p2.getKey()) &&
               p1.getValue().equals(p2.getValue());
    }
}
```

Utilizare:
```java
Integer[] intArray = {1, 2, 3, 4, 5};
String[] stringArray = {"Hello", "World"};

Utils.printArray(intArray);
Utils.printArray(stringArray);
```

## Parametri de Tip

### Convenții de Denumire

În Java, există convenții standard pentru denumirea parametrilor de tip:

- `T` - Tip (Type)
- `E` - Element (Element)
- `K` - Cheie (Key)
- `V` - Valoare (Value)
- `N` - Număr (Number)
- `S` - Al doilea tip/parametru
- `U`, `V`, etc. - Tipuri suplimentare

Aceste convenții nu sunt obligatorii, dar sunt larg utilizate pentru a face codul mai ușor de înțeles.

### Parametri de Tip Multipli

Clasele și metodele generice pot avea mai mulți parametri de tip:

```java
public class Mapping<K, V> {
    private K key;
    private V value;
    
    public Mapping(K key, V value) {
        this.key = key;
        this.value = value;
    }
    
    // Getteri și setteri
}

// Utilizare
Mapping<String, Integer> mapare = new Mapping<>("vârstă", 30);
```

## Wildcard Types (Tipuri Joker)

Wildcards (caracterul joker `?`) permit crearea de tipuri generice mai flexibile.

### Unbounded Wildcards (?)

Reprezintă "orice tip" și se folosește când operațiile sunt independente de tipul specificat:

```java
public static void printList(List<?> list) {
    for (Object elem: list) {
        System.out.println(elem);
    }
}
```

Acest cod poate procesa orice fel de listă, indiferent de tipul elementelor.

### Upper Bounded Wildcards (? extends T)

Limitează wildcards la un anumit tip sau orice subtip al acestuia:

```java
public static double sumOfList(List<? extends Number> list) {
    double sum = 0.0;
    for (Number n : list) {
        sum += n.doubleValue();
    }
    return sum;
}
```

Acest cod poate procesa liste de `Integer`, `Double`, sau orice alt subtip al lui `Number`.

### Lower Bounded Wildcards (? super T)

Limitează wildcards la un anumit tip sau orice supertip al acestuia:

```java
public static void addNumbers(List<? super Integer> list) {
    for (int i = 1; i <= 10; i++) {
        list.add(i);
    }
}
```

Acest cod poate adăuga `Integer` la o listă de `Integer`, `Number`, sau `Object`.

### Principiul PECS (Producer Extends, Consumer Super)

O regulă importantă pentru utilizarea wildcards este principiul PECS:

- Utilizează `? extends T` când colecția este un **producer** (citești din ea)
- Utilizează `? super T` când colecția este un **consumer** (scrii în ea)
- Utilizează tipuri exacte (`T`) când colecția este atât producer cât și consumer

```java
// Producer - citim din sursă
public static <T> void copy(List<? extends T> sursă, List<? super T> destinație) {
    for (T element : sursă) {
        destinație.add(element); // Adaugă în destinație
    }
}
```

## Type Erasure

La compilare, compilatorul Java efectuează un proces numit "type erasure" (ștergere de tip), care:

1. Înlocuiește parametrii de tip generici cu limitele lor sau cu `Object` dacă nu există limite
2. Inserează conversii (casting) unde e necesar
3. Generează metode bridge pentru a păstra polimorfismul în moștenire

Acest proces există pentru a asigura compatibilitatea cu codul pre-generic și pentru a implementa generics fără a modifica Java Virtual Machine (JVM).

Exemplu:
```java
// Cod scris
public class Container<T> {
    private T element;
    public void setElement(T element) { this.element = element; }
    public T getElement() { return element; }
}

// După type erasure
public class Container {
    private Object element;
    public void setElement(Object element) { this.element = element; }
    public Object getElement() { return element; }
}
```

Acest proces explică unele limitări ale genericelor în Java.

## Restricții și Limitări

Genericele în Java au unele restricții importante:

1. **Nu se pot crea instanțe ale parametrilor de tip**:
   ```java
   public class Container<T> {
       private T element;
       
       public Container() {
           // element = new T();  // Eroare de compilare
       }
   }
   ```

2. **Nu se pot crea array-uri de tipuri generice parametrizate**:
   ```java
   // Eroare de compilare
   List<Integer>[] arrayOfLists = new List<Integer>[10];
   ```

3. **Nu se pot folosi primitivele ca parametri de tip**:
   ```java
   // Eroare de compilare
   Container<int> container = new Container<>(5);
   
   // Corect - folosim wrapper class
   Container<Integer> container = new Container<>(5);
   ```

4. **Nu se pot folosi operatorii instanceof cu tipuri generice**:
   ```java
   public static <T> boolean isTypeMatch(Object obj, List<T> list) {
       // Eroare de compilare
       // return obj instanceof T;
       
       // sau
       // return obj instanceof List<T>;
   }
   ```

5. **Nu se pot crea, captura sau arunca obiecte de tip generic**:
   ```java
   // Eroare de compilare
   // public class MathException<T> extends Exception { ... }
   
   // Incorect
   // public static <T extends Exception> void doWork() throws T { ... }
   ```

Aceste limitări vin din cauza implementării prin type erasure.

## Exemple Practice

### Container Generic

Un container simplu pentru orice tip de obiect:

```java
public class Box<T> {
    private T content;
    
    public Box() { }
    
    public Box(T content) {
        this.content = content;
    }
    
    public T getContent() {
        return content;
    }
    
    public void setContent(T content) {
        this.content = content;
    }
    
    public boolean hasContent() {
        return content != null;
    }
    
    @Override
    public String toString() {
        if (content == null) {
            return "Empty Box";
        }
        return "Box containing " + content.toString();
    }
}
```

### Metode Utilitare Generice

Metode utilitare pentru manipularea colecțiilor generice:

```java
public class CollectionUtils {
    
    // Găsește elementul maxim dintr-o colecție
    public static <T extends Comparable<T>> T findMax(Collection<T> collection) {
        if (collection == null || collection.isEmpty()) {
            return null;
        }
        
        Iterator<T> iterator = collection.iterator();
        T max = iterator.next();
        
        while (iterator.hasNext()) {
            T current = iterator.next();
            if (current.compareTo(max) > 0) {
                max = current;
            }
        }
        
        return max;
    }
    
    // Convertește o colecție într-o altă colecție folosind un transformator
    public static <T, R> List<R> transform(Collection<T> collection, Function<T, R> transformer) {
        List<R> result = new ArrayList<>(collection.size());
        
        for (T element : collection) {
            result.add(transformer.apply(element));
        }
        
        return result;
    }
    
    // Filtrează o colecție folosind un predicat
    public static <T> List<T> filter(Collection<T> collection, Predicate<T> predicate) {
        List<T> result = new ArrayList<>();
        
        for (T element : collection) {
            if (predicate.test(element)) {
                result.add(element);
            }
        }
        
        return result;
    }
}
```

### Perechi și Tuple

Implementarea generică a unei perechi și a unui tuplu:

```java
// Pereche generică (key-value)
public class Pair<K, V> {
    private final K key;
    private final V value;
    
    public Pair(K key, V value) {
        this.key = key;
        this.value = value;
    }
    
    public K getKey() { return key; }
    public V getValue() { return value; }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        
        Pair<?, ?> pair = (Pair<?, ?>) o;
        return Objects.equals(key, pair.key) &&
               Objects.equals(value, pair.value);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(key, value);
    }
    
    @Override
    public String toString() {
        return "(" + key + ", " + value + ")";
    }
    
    // Factory method
    public static <K, V> Pair<K, V> of(K key, V value) {
        return new Pair<>(key, value);
    }
}

// Triplet generic
public class Triplet<T, U, V> {
    private final T first;
    private final U second;
    private final V third;
    
    public Triplet(T first, U second, V third) {
        this.first = first;
        this.second = second;
        this.third = third;
    }
    
    public T getFirst() { return first; }
    public U getSecond() { return second; }
    public V getThird() { return third; }
    
    // Metodele equals, hashCode, toString și factory method similar cu Pair
}
```

## Design Patterns cu Generics

Genericele sunt folosite frecvent în design patterns pentru a crea soluții mai flexibile și reutilizabile:

### Builder Pattern Generic

```java
public class GenericBuilder<T> {
    private final Supplier<T> instantiator;
    private final List<Consumer<T>> modifiers = new ArrayList<>();
    
    public GenericBuilder(Supplier<T> instantiator) {
        this.instantiator = instantiator;
    }
    
    public <V> GenericBuilder<T> with(BiConsumer<T, V> consumer, V value) {
        Consumer<T> modifier = instance -> consumer.accept(instance, value);
        modifiers.add(modifier);
        return this;
    }
    
    public T build() {
        T instance = instantiator.get();
        modifiers.forEach(modifier -> modifier.accept(instance));
        return instance;
    }
    
    public static <T> GenericBuilder<T> of(Supplier<T> instantiator) {
        return new GenericBuilder<>(instantiator);
    }
}

// Utilizare
Person person = GenericBuilder.of(Person::new)
                .with(Person::setName, "John")
                .with(Person::setAge, 30)
                .with(Person::setEmail, "john@example.com")
                .build();
```

### Repository Pattern Generic

```java
public interface GenericRepository<T, ID> {
    Optional<T> findById(ID id);
    List<T> findAll();
    T save(T entity);
    void delete(T entity);
    void deleteById(ID id);
    long count();
    boolean exists(ID id);
}

public abstract class JpaGenericRepository<T, ID> implements GenericRepository<T, ID> {
    protected final Class<T> entityClass;
    protected final EntityManager entityManager;
    
    public JpaGenericRepository(Class<T> entityClass, EntityManager entityManager) {
        this.entityClass = entityClass;
        this.entityManager = entityManager;
    }
    
    @Override
    public Optional<T> findById(ID id) {
        return Optional.ofNullable(entityManager.find(entityClass, id));
    }
    
    @Override
    public List<T> findAll() {
        CriteriaBuilder cb = entityManager.getCriteriaBuilder();
        CriteriaQuery<T> cq = cb.createQuery(entityClass);
        Root<T> rootEntry = cq.from(entityClass);
        CriteriaQuery<T> all = cq.select(rootEntry);
        
        return entityManager.createQuery(all).getResultList();
    }
    
    // Implementarea celorlalte metode
}
```

## Bune Practici

Câteva bune practici pentru utilizarea genericelor în Java:

1. **Prefă parametrizarea fara limitarea**:
   ```java
   // Mai bine
   public <T extends Comparable<T>> T findMax(List<T> list)
   
   // Decât
   public Comparable findMax(List<? extends Comparable> list)
   ```

2. **Utilizează paramteri de tip pentru expresivitate**:
   ```java
   // Mai expresiv
   public <K, V> V getValue(Map<K, V> map, K key)
   
   // Decât
   public Object getValue(Map map, Object key)
   ```

3. **Ține cont de principiul PECS**:
    - `? extends T` pentru producători (read)
    - `? super T` pentru consumatori (write)

4. **Evită utilizarea raw types (tipuri brute)**:
   ```java
   // Evită
   List lista = new ArrayList();
   
   // Preferă
   List<Object> lista = new ArrayList<>();
   ```

5. **Nu crea array-uri de tipuri generice**:
   ```java
   // Evită
   List<String>[] arrayOfLists = new List<String>[10]; // Nu compilează
   
   // Preferă
   List<List<String>> listOfLists = new ArrayList<>();
   ```

6. **Limitează scopul parametrilor de tip**:
   ```java
   // Mai bine
   public <T extends Comparable<T>> int compareTo(T o1, T o2)
   
   // Decât
   public <T> int compareTo(T o1, T o2) // Eroare dacă T nu implementează Comparable
   ```

7. **Folosește factory methods pentru a simplifica crearea de obiecte generice**:
   ```java
   public static <K, V> Pair<K, V> of(K key, V value) {
       return new Pair<>(key, value);
   }
   
   // Utilizare
   Pair<String, Integer> pair = Pair.of("Cheie", 42);
   ```

8. **Preferă interfețe generice pentru API-uri publice**:
   ```java
   public interface Repository<T, ID> {
       T findById(ID id);
       List<T> findAll();
       // ...
   }
   ```

9. **Documentează parametrii de tip în Javadoc**:
   ```java
   /**
    * Găsește elementul maxim dintr-o colecție.
    *
    * @param <T> tipul elementelor din colecție
    * @param collection colecția de elemente
    * @return elementul maxim sau null dacă colecția este goală
    */
   public static <T extends Comparable<T>> T findMax(Collection<T> collection) {
       // ...
   }
   ```