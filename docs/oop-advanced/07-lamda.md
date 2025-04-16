# Expresii Lambda

## Cuprins
1. [Introducere în Expresii Lambda](#introducere-în-expresii-lambda)
2. [Sintaxa Expresiilor Lambda](#sintaxa-expresiilor-lambda)
3. [Interfețe Funcționale](#interfețe-funcționale)
4. [Packagul java.util.function](#packageul-javautilfunction)
5. [Variabile și Scope în Lambda](#variabile-și-scope-în-lambda)
6. [Referințe la Metode](#referințe-la-metode)
7. [Expresii Lambda vs Clase Anonime](#expresii-lambda-vs-clase-anonime)
8. [Utilizarea Lambda cu Colecții](#utilizarea-lambda-cu-colecții)
9. [Utilizarea Lambda cu Streams](#utilizarea-lambda-cu-streams)
10. [Lambda în GUI și Evenimente](#lambda-în-gui-și-evenimente)
11. [Tehnici Avansate](#tehnici-avansate)
12. [Bune Practici](#bune-practici)
13. [Exemple Complete](#exemple-complete)
14. [Troubleshooting și Probleme Comune](#troubleshooting-și-probleme-comune)

## Introducere în Expresii Lambda

Expresiile lambda au fost introduse în Java 8 și reprezintă una dintre cele mai importante îmbunătățiri ale limbajului, facilitând programarea funcțională în Java. Lambda este, în esență, o funcție anonimă - un bloc de cod care poate fi transmis ca argument altor metode.

### Ce este o Expresie Lambda?

O expresie lambda este o funcție anonimă care poate fi transmisă ca un obiect. Are următoarele caracteristici:

- Nu are un nume (spre deosebire de o metodă)
- Poate fi transmisă ca argument unei metode
- Poate fi stocată într-o variabilă
- Nu are nevoie să aparțină unei clase
- Nu are nevoie să specifice un tip de retur
- Nu are nevoie să specifice tipuri pentru parametri (în majoritatea cazurilor)

### De ce să folosim Expresii Lambda?

Expresiile lambda oferă numeroase avantaje:

1. **Cod mai concis** - reduc cantitatea de cod boilerplate
2. **Cod mai clar** - fac intenția codului mai evidentă în multe cazuri
3. **Suport pentru programare funcțională** - permit tratarea funcțiilor ca date
4. **Paralelism ușor** - simplifică programarea concurentă
5. **API-uri mai expresive** - permit crearea și folosirea API-urilor în stil funcțional

### Evoluția spre Lambda

Pentru a înțelege valoarea lambda-urilor, să vedem cum a evoluat Java:

#### 1. Clase Anonime (Pre-Java 8)

```java
// Folosind o clasă anonimă pentru a sorta o listă
Collections.sort(list, new Comparator<String>() {
    @Override
    public int compare(String s1, String s2) {
        return s1.length() - s2.length();
    }
});
```

#### 2. Expresie Lambda (Java 8+)

```java
// Folosind lambda pentru aceeași sarcină
Collections.sort(list, (s1, s2) -> s1.length() - s2.length());
```

Diferența este evidentă - lambda elimină codul ceremonios, concentrându-se pe logica esențială.

## Sintaxa Expresiilor Lambda

Expresiile lambda în Java au o sintaxă flexibilă care poate fi adaptată la diferite situații.

### Forma de Bază

```
(parametri) -> expresie sau bloc de cod
```

### Variante de Sintaxă

#### 1. Lambda fără parametri

```java
() -> System.out.println("Hello, World!")
```

#### 2. Lambda cu un singur parametru (parantezele sunt opționale)

```java
// Cu paranteze
(s) -> s.length()

// Fără paranteze 
s -> s.length()
```

#### 3. Lambda cu mai mulți parametri

```java
(String s1, String s2) -> s1.length() - s2.length()
```

#### 4. Lambda cu tipuri inferați

```java
// Java poate infera tipurile din context
(s1, s2) -> s1.length() - s2.length()
```

#### 5. Lambda cu bloc de cod

```java
(s1, s2) -> {
    int diff = s1.length() - s2.length();
    return diff;
}
```

### Reguli pentru blocuri de cod Lambda

Când folosiți un bloc de cod (între acolade `{}`):
- Trebuie să includeți instrucțiunea `return` explicit (dacă funcția returnează o valoare)
- Fiecare instrucțiune trebuie să se termine cu `;`
- Puteți include mai multe instrucțiuni, variabile locale, etc.

### Inferența Tipurilor

În majoritatea cazurilor, compilatorul Java poate infera tipurile parametrilor lambda din context. Acest lucru face codul mai concis.

```java
// Cu tipuri specificate explicit
Comparator<String> comp = (String s1, String s2) -> s1.length() - s2.length();

// Cu tipuri inferaţi
Comparator<String> comp = (s1, s2) -> s1.length() - s2.length();
```

## Interfețe Funcționale

Expresiile lambda în Java sunt implementate folosind conceptul de **interfață funcțională**. O interfață funcțională este o interfață care conține exact o metodă abstractă (poate conține oricâte metode default sau statice).

### Definirea unei Interfețe Funcționale

```java
// Adnotarea @FunctionalInterface este opțională, dar recomandată
@FunctionalInterface
public interface Calculator {
    // Exact o metodă abstractă
    int calculate(int a, int b);
    
    // Poate avea metode default
    default void printInfo() {
        System.out.println("Calculator interface");
    }
    
    // Poate avea metode statice
    static Calculator addition() {
        return (a, b) -> a + b;
    }
}
```

Adnotarea `@FunctionalInterface` nu este obligatorie, dar ajută compilatorul să verifice că interfața respectă cerințele unei interfețe funcționale și semnalează intenția designului.

### Utilizarea Interfețelor Funcționale

```java
// Implementare folosind lambda
Calculator add = (a, b) -> a + b;
Calculator subtract = (a, b) -> a - b;
Calculator multiply = (a, b) -> a * b;

// Utilizare
int result1 = add.calculate(5, 3);      // 8
int result2 = subtract.calculate(5, 3);  // 2
int result3 = multiply.calculate(5, 3);  // 15

// Folosirea metodei statice factory
Calculator adder = Calculator.addition();
int result4 = adder.calculate(5, 3);    // 8
```

### Interfețe Funcționale Predefinite în Java

Java vine cu un set bogat de interfețe funcționale predefinite în pachetul `java.util.function`. Acestea acoperă majoritatea cazurilor de utilizare comune.

## Packageul java.util.function

Pachetul `java.util.function` conține interfețe funcționale standard pentru diverse scenarii. Iată cele mai importante:

### Interfețe de Bază

1. **Function<T, R>** - primește un argument de tip T și returnează un rezultat de tip R
   ```java
   Function<String, Integer> strlen = s -> s.length();
   Integer length = strlen.apply("Hello"); // 5
   ```

2. **Consumer<T>** - primește un argument de tip T și nu returnează nimic
   ```java
   Consumer<String> printer = s -> System.out.println(s);
   printer.accept("Hello"); // Afișează: Hello
   ```

3. **Supplier<T>** - nu primește niciun argument dar returnează un rezultat de tip T
   ```java
   Supplier<Double> random = () -> Math.random();
   Double value = random.get(); // Valoare aleatoare între 0.0 și 1.0
   ```

4. **Predicate<T>** - primește un argument de tip T și returnează un boolean
   ```java
   Predicate<String> isEmpty = s -> s.isEmpty();
   boolean result = isEmpty.test(""); // true
   ```

5. **UnaryOperator<T>** - primește un argument de tip T și returnează un rezultat de același tip T
   ```java
   UnaryOperator<String> toUpperCase = s -> s.toUpperCase();
   String result = toUpperCase.apply("hello"); // "HELLO"
   ```

6. **BinaryOperator<T>** - primește doi argumenti de tip T și returnează un rezultat de tip T
   ```java
   BinaryOperator<Integer> add = (a, b) -> a + b;
   Integer sum = add.apply(5, 3); // 8
   ```

### Interfețe Specializate pentru Primitive

Pentru a evita costul boxing/unboxing, Java oferă variante specializate pentru tipurile primitive:

1. **IntFunction<R>**, **LongFunction<R>**, **DoubleFunction<R>** - primesc un primitiv și returnează un obiect
   ```java
   IntFunction<String> intToString = i -> Integer.toString(i);
   String str = intToString.apply(42); // "42"
   ```

2. **ToIntFunction<T>**, **ToLongFunction<T>**, **ToDoubleFunction<T>** - primesc un obiect și returnează un primitiv
   ```java
   ToIntFunction<String> strlen = s -> s.length();
   int length = strlen.applyAsInt("Hello"); // 5
   ```

3. **IntPredicate**, **LongPredicate**, **DoublePredicate** - primesc un primitiv și returnează boolean
   ```java
   IntPredicate isEven = n -> n % 2 == 0;
   boolean result = isEven.test(4); // true
   ```

4. **BiFunction<T, U, R>** - primește două argumente de tipuri T și U și returnează un rezultat de tip R
   ```java
   BiFunction<String, Integer, String> repeat = (s, n) -> s.repeat(n);
   String result = repeat.apply("Ha", 3); // "HaHaHa"
   ```

### Interfețe Compuse

Multe dintre interfețele funcționale oferă metode default pentru compunerea funcțiilor:

1. **Function.andThen()** și **Function.compose()**
   ```java
   Function<String, Integer> strlen = s -> s.length();
   Function<Integer, Boolean> isEven = n -> n % 2 == 0;
   
   // Compose: aplică prima funcția din argument, apoi funcția curentă
   Function<String, Boolean> isLengthEven = isEven.compose(strlen);
   boolean result1 = isLengthEven.apply("Hello"); // false (5 is odd)
   
   // AndThen: aplică prima funcția curentă, apoi funcția din argument
   Function<String, Boolean> isLengthEven2 = strlen.andThen(isEven);
   boolean result2 = isLengthEven2.apply("Hello"); // false (5 is odd)
   ```

2. **Predicate.and()**, **Predicate.or()**, **Predicate.negate()**
   ```java
   Predicate<String> isNotEmpty = s -> !s.isEmpty();
   Predicate<String> isLongEnough = s -> s.length() > 5;
   
   // Combinarea predicatelor
   Predicate<String> isValidName = isNotEmpty.and(isLongEnough);
   boolean result = isValidName.test("John Doe"); // true
   
   // Negarea predicatului
   Predicate<String> isEmpty = isNotEmpty.negate();
   ```

## Variabile și Scope în Lambda

Expresiile lambda au un scop lexical special - ele pot accesa variabile din contextul în care sunt definite, dar cu anumite restricții.

### Capturarea Variabilelor

Lambda poate accesa:
- Variabile locale din scope-ul înconjurător
- Parametrii metodei
- Câmpuri de instanță și statice

```java
public class LambdaScope {
    private int instanceVar = 10; // câmp de instanță
    private static int staticVar = 20; // câmp static
    
    public void demo() {
        int localVar = 30; // variabilă locală
        
        // Lambda care accesează diferite tipuri de variabile
        Consumer<Integer> lambda = x -> {
            System.out.println("Instance var: " + instanceVar);
            System.out.println("Static var: " + staticVar);
            System.out.println("Local var: " + localVar);
            System.out.println("Parameter: " + x);
        };
        
        lambda.accept(40);
    }
}
```

### Restricția "Effectively Final"

Variabilele locale și parametrii metodei care sunt accesați în lambda trebuie să fie `final` sau "effectively final" (variabile care nu sunt modificate după inițializare).

```java
public void effectivelyFinalDemo() {
    int count = 0; // Effectively final
    
    // Corect - count nu este modificat după inițializare
    Consumer<Integer> lambda1 = x -> System.out.println(count + x);
    
    int mutableCount = 0;
    mutableCount++; // Modificare după inițializare
    
    // Incorect - generează eroare de compilare
    // Consumer<Integer> lambda2 = x -> System.out.println(mutableCount + x);
}
```

### Motivul Restricției

Această restricție există deoarece variabilele capturate nu sunt stocate în stivă ca variabilele locale obișnuite. În schimb, lambda creează o copie a valorii. Dacă variabila s-ar schimba după definirea lambda, acest lucru ar putea duce la confuzie și comportament neașteptat.

### Soluții pentru Variabile Mutabile

Dacă aveți nevoie să modificați o variabilă din lambda, puteți folosi:

1. **Câmpuri de instanță** - Care nu sunt supuse restricției effectively final
   ```java
   public class Counter {
       private int count = 0;
       
       public void increment() {
           Runnable r = () -> count++; // OK - count e câmp de instanță
           r.run();
       }
   }
   ```

2. **Wrappere** - Clase container precum `AtomicInteger`
   ```java
   public void incrementWithWrapper() {
       AtomicInteger counter = new AtomicInteger(0);
       
       Runnable r = () -> counter.incrementAndGet(); // OK - incrementăm obiectul, nu referința
       r.run();
   }
   ```

3. **Array-uri de un singur element** - Trick comun
   ```java
   public void incrementWithArray() {
       int[] counter = {0}; // Array cu un singur element
       
       Runnable r = () -> counter[0]++; // OK - modificăm conținutul, nu referința
       r.run();
   }
   ```

## Referințe la Metode

Referințele la metode sunt o formă specială de expresii lambda care fac codul și mai concis când expresia lambda doar apelează o metodă existentă.

### Sintaxa de Bază

```
ContainerClass::methodName
```

### Tipuri de Referințe la Metode

1. **Referință la metodă statică**
   ```java
   // Lambda normal:
   Function<String, Integer> parseInt = s -> Integer.parseInt(s);
   
   // Referință la metodă statică:
   Function<String, Integer> parseIntRef = Integer::parseInt;
   ```

2. **Referință la metodă de instanță a unui obiect particular**
   ```java
   String prefix = "Hello, ";
   
   // Lambda normal:
   Function<String, String> greet = name -> prefix.concat(name);
   
   // Referință la metodă:
   Function<String, String> greetRef = prefix::concat;
   ```

3. **Referință la metodă de instanță a unui tip arbitrar**
   ```java
   // Lambda normal:
   Function<String, Integer> strlen = s -> s.length();
   
   // Referință la metodă:
   Function<String, Integer> strlenRef = String::length;
   ```

4. **Referință la constructor**
   ```java
   // Lambda normal:
   Supplier<ArrayList<String>> listCreator = () -> new ArrayList<>();
   
   // Referință la constructor:
   Supplier<ArrayList<String>> listCreatorRef = ArrayList::new;
   ```

### Exemplu Complet

```java
public class MethodReferenceExample {
    public static void main(String[] args) {
        List<String> names = Arrays.asList("Alice", "Bob", "Charlie", "Dave");
        
        // 1. Referință la metodă statică
        names.forEach(System.out::println);
        
        // 2. Referință la metodă de instanță a unui obiect specific
        StringJoiner joiner = new StringJoiner(", ");
        names.forEach(joiner::add);
        System.out.println(joiner.toString());
        
        // 3. Referință la metodă de instanță a unui tip arbitrar
        List<String> uppercaseNames = names.stream()
                                         .map(String::toUpperCase)
                                         .collect(Collectors.toList());
        
        // 4. Referință la constructor
        List<Person> people = names.stream()
                                .map(Person::new)  // Person(String name)
                                .collect(Collectors.toList());
    }
    
    static class Person {
        private String name;
        
        public Person(String name) {
            this.name = name;
        }
        
        @Override
        public String toString() {
            return "Person: " + name;
        }
    }
}
```

### Avantajele Referințelor la Metode

- Cod mai concis
- Mai expresiv - numele metodei comunică intenția
- Mai ușor de refactorizat
- Poate fi mai eficient în unele cazuri

## Expresii Lambda vs Clase Anonime

Expresiile lambda și clasele anonime oferă ambele modalități de a crea implementări inline pentru interfețe, dar există diferențe importante între ele.

### Comparație Sintactică

```java
// Folosind o clasă anonimă
Runnable r1 = new Runnable() {
    @Override
    public void run() {
        System.out.println("Hello from anonymous class!");
    }
};

// Folosind o expresie lambda
Runnable r2 = () -> System.out.println("Hello from lambda!");
```

### Diferențe Cheie

1. **Sintaxă**: Lambda este mult mai concisă
2. **Scopul `this`**:
    - În lambda, `this` referă la instanța clasei înconjurătoare
    - În clasa anonimă, `this` referă la instanța clasei anonime
3. **Shadowing variabile**:
    - Lambda nu poate face shadowing variabilelor din scope-ul încojurător
    - Clasa anonimă poate declara variabile cu aceleași nume ca în scope-ul înconjurător
4. **Funcționalitate**:
    - Lambda implementează doar o singură metodă
    - Clasa anonimă poate implementa multiple metode și poate avea câmpuri și constructori
5. **Tipul**:
    - Lambda nu creează o clasă nouă la runtime
    - Clasa anonimă creează o nouă clasă la runtime

### Când să folosiți fiecare

Folosiți **lambda** atunci când:
- Implementați o interfață funcțională simplă
- Doriți să accesați contextul clasei înconjurătoare (this, super, câmpuri)
- Aveți nevoie de cod concis și expresiv
- Implementarea este scurtă și simplă

Folosiți **clase anonime** atunci când:
- Interfața are mai multe metode abstracte
- Aveți nevoie de câmpuri sau metode auxiliare
- Doriți să suprascrieți comportamentul implicit al metodelor moștenite
- Aveți nevoie să faceți shadowing la variabile

## Utilizarea Lambda cu Colecții

Una dintre cele mai comune utilizări ale expresiilor lambda este manipularea colecțiilor. Java 8 a îmbogățit interfețele de colecții cu metode default care folosesc avantajul expresiilor lambda.

### ForEach

Metoda `forEach()` permite parcurgerea și procesarea elementelor unei colecții:

```java
List<String> names = Arrays.asList("Alice", "Bob", "Charlie");

// Mod tradițional (pre-Java 8)
for (String name : names) {
    System.out.println(name);
}

// Folosind lambda
names.forEach(name -> System.out.println(name));

// Folosind referință la metodă
names.forEach(System.out::println);
```

### Removal Condiționat

Metoda `removeIf()` permite ștergerea elementelor care îndeplinesc un anumit criteriu:

```java
List<String> names = new ArrayList<>(Arrays.asList("Alice", "Bob", "Charlie"));

// Mod tradițional (pre-Java 8)
Iterator<String> iterator = names.iterator();
while (iterator.hasNext()) {
    if (iterator.next().startsWith("A")) {
        iterator.remove();
    }
}

// Folosind lambda
names.removeIf(name -> name.startsWith("A"));
```

### Sortare

Metodele `sort()` și `Comparator` beneficiază foarte mult de expresii lambda:

```java
List<String> names = new ArrayList<>(Arrays.asList("Charlie", "Alice", "Bob"));

// Sortare alfabetică
names.sort((s1, s2) -> s1.compareTo(s2));
// sau
names.sort(String::compareTo);

// Sortare după lungimea numelui
names.sort((s1, s2) -> Integer.compare(s1.length(), s2.length()));
// sau
names.sort(Comparator.comparingInt(String::length));

// Sortare complexă: după lungime, apoi alfabetic
names.sort(Comparator.comparingInt(String::length)
                  .thenComparing(String::compareTo));
```

### Înlocuire

Metoda `replaceAll()` permite transformarea elementelor unei liste:

```java
List<String> names = new ArrayList<>(Arrays.asList("alice", "bob", "charlie"));

// Conversie la uppercase
names.replaceAll(name -> name.toUpperCase());
// sau
names.replaceAll(String::toUpperCase);

// Rezultat: [ALICE, BOB, CHARLIE]
```

### Map Operații

Interfața `Map` are primit și ea metode care folosesc lambda:

```java
Map<String, Integer> scores = new HashMap<>();
scores.put("Alice", 95);
scores.put("Bob", 80);
scores.put("Charlie", 90);

// forEach pentru Map
scores.forEach((name, score) -> System.out.println(name + ": " + score));

// getOrDefault cu valoare calculată
int davidScore = scores.computeIfAbsent("David", name -> name.length() * 10);
// davidScore = 50, map conține acum și "David"=50

// Actualizarea valorilor
scores.replaceAll((name, score) -> score + 5);

// Operații condiționate
scores.compute("Alice", (name, score) -> score != null ? score + 10 : 50);
```

## Utilizarea Lambda cu Streams

Expresiile lambda sunt esențiale pentru API-ul Stream introdus în Java 8, care permite procesarea declarativă a datelor.

### Operații de Bază cu Streams

```java
List<String> names = Arrays.asList("Alice", "Bob", "Charlie", "David", "Eve");

// Filtrare și transformare
List<String> filteredNames = names.stream()
    .filter(name -> name.length() > 3)
    .map(String::toUpperCase)
    .collect(Collectors.toList());

// Rezultat: [ALICE, CHARLIE, DAVID]
```

### Stream Pipeline cu Lambda

Un pipeline Stream tipic folosește multiple expresii lambda:

```java
List<Person> people = Arrays.asList(
    new Person("Alice", 25),
    new Person("Bob", 30),
    new Person("Charlie", 35),
    new Person("David", 40)
);

// Găsește numele persoanelor peste 30 de ani, sortate alfabetic
List<String> result = people.stream()
    .filter(person -> person.getAge() > 30)
    .sorted(Comparator.comparing(Person::getName))
    .map(Person::getName)
    .collect(Collectors.toList());

// Rezultat: [Charlie, David]
```

### Operații Terminal Specializate

Multe operații de reducere folosesc expresii lambda:

```java
// Găsim suma vârstelor
int sumOfAges = people.stream()
    .mapToInt(Person::getAge)
    .sum();

// Găsim persoana cea mai în vârstă
Optional<Person> oldest = people.stream()
    .max(Comparator.comparing(Person::getAge));

// Grupare după grupă de vârstă
Map<Integer, List<Person>> peopleByAgeGroup = people.stream()
    .collect(Collectors.groupingBy(
        person -> person.getAge() / 10 * 10
    ));
```

### Streams Paralele

Lambda-urile facilitează paralelizarea operațiilor:

```java
// Procesare paralelă
long count = people.parallelStream()
    .filter(person -> person.getAge() > 30)
    .count();
```

### Compunerea Funcțiilor cu Streams

```java
// Compunerea mai multor operații
Function<String, String> cleanup = s -> s.trim().toLowerCase();
Function<String, Integer> counter = s -> s.length();

List<Integer> nameLengths = names.stream()
    .map(cleanup.andThen(counter))
    .collect(Collectors.toList());
```

## Lambda în GUI și Evenimente

Expresiile lambda sunt ideale pentru gestionarea evenimentelor în aplicațiile cu interfață grafică.

### Exemplu JavaFX

```java
Button button = new Button("Click Me");

// Înainte de Java 8
button.setOnAction(new EventHandler<ActionEvent>() {
    @Override
    public void handle(ActionEvent event) {
        System.out.println("Button clicked!");
    }
});

// Cu lambda
button.setOnAction(event -> System.out.println("Button clicked!"));
```

### Exemplu Swing

```java
JButton button = new JButton("Click Me");

// Înainte de Java 8
button.addActionListener(new ActionListener() {
    @Override
    public void actionPerformed(ActionEvent e) {
        System.out.println("Button clicked!");
    }
});

// Cu lambda
button.addActionListener(e -> System.out.println("Button clicked!"));
```

### Gestionarea Complexă a Evenimentelor

Lambda-urile pot fi folosite pentru scenarii mai complexe:

```java
TextField textField = new TextField();
Button submitButton = new Button("Submit");

// Validare de formular
submitButton.setOnAction(event -> {
    String text = textField.getText();
    if (text.isEmpty()) {
        showError("Please enter some text");
    } else {
        processInput(text);
        clearForm();
    }
});

// Combinarea mai multor handleri de evenimente
Runnable sharedTask = () -> System.out.println("Task executed");

button1.setOnAction(event -> {
    System.out.println("Button 1 clicked");
    sharedTask.run();
});

button2.setOnAction(event -> {
    System.out.println("Button 2 clicked");
    sharedTask.run();
});
```

## Tehnici Avansate

### Currying cu Lambda

Currying este o tehnică din programarea funcțională care transformă o funcție cu mai mulți parametri într-o secvență de funcții cu un singur parametru:

```java
// Implementarea currying în Java
public class Currying {
    public static void main(String[] args) {
        // Funcție tradițională cu doi parametri
        BiFunction<Integer, Integer, Integer> add = (a, b) -> a + b;
        System.out.println(add.apply(2, 3)); // 5
        
        // Versiunea curry - returnează o funcție care ia al doilea parametru
        Function<Integer, Function<Integer, Integer>> curriedAdd = 
            a -> b -> a + b;
        
        Function<Integer, Integer> add2 = curriedAdd.apply(2);
        System.out.println(add2.apply(3)); // 5
        
        // Folosire directă
        System.out.println(curriedAdd.apply(2).apply(3)); // 5
    }
}
```

### Closure-uri

În Java, expresiile lambda pot forma closure-uri, capturând variabile din scope-ul înconjurător:

```java
public class ClosureExample {
    public static Function<Integer, Integer> multiplier(int factor) {
        // Lambda capturează variabila factor, formând un closure
        return n -> n * factor;
    }
    
    public static void main(String[] args) {
        Function<Integer, Integer> timesFive = multiplier(5);
        Function<Integer, Integer> timesTen = multiplier(10);
        
        System.out.println(timesFive.apply(3)); // 15
        System.out.println(timesTen.apply(3));  // 30
    }
}
```

### Implementarea unui DSL (Domain Specific Language)

Lambda-urile permit crearea de API-uri fluente și DSL-uri expresive:

```java
public class QueryBuilderExample {
    public static void main(String[] args) {
        List<Person> people = Arrays.asList(
            new Person("John", 25),
            new Person("Alice", 30),
            new Person("Bob", 20)
        );
        
        // DSL pentru interogarea listei
        List<Person> result = Query.from(people)
                                  .where(p -> p.getAge() > 20)
                                  .orderBy(p -> p.getName())
                                  .select();
        
        result.forEach(p -> System.out.println(p.getName() + ": " + p.getAge()));
        // Output:
        // Alice: 30
        // John: 25
    }
    
    // Implementarea DSL-ului
    static class Query<T> {
        private final Collection<T> source;
        private Predicate<T> filter = t -> true;
        private Comparator<T> orderBy = null;
        
        private Query(Collection<T> source) {
            this.source = source;
        }
        
        public static <T> Query<T> from(Collection<T> source) {
            return new Query<>(source);
        }
        
        public Query<T> where(Predicate<T> predicate) {
            this.filter = predicate;
            return this;
        }
        
        public Query<T> orderBy(Function<T, Comparable> keyExtractor) {
            this.orderBy = Comparator.comparing(keyExtractor);
            return this;
        }
        
        public List<T> select() {
            return source.stream()
                      .filter(filter)
                      .sorted(orderBy)
                      .collect(Collectors.toList());
        }
    }
}
```

## Bune Practici

Iată câteva bune practici pentru utilizarea expresiilor lambda în Java:

### 1. Păstrați Lambda-urile Scurte și Claire

```java
// Bine - clar și concis
stream.filter(s -> s.length() > 5)
      .map(String::toUpperCase)
      .forEach(System.out::println);

// Evitați - prea complex pentru o singură lambda
stream.filter(s -> {
    if (s == null) return false;
    s = s.trim();
    return s.length() > 5 && Character.isUpperCase(s.charAt(0));
});
```

Dacă o expresie lambda devine prea complexă, extrage-o într-o metodă separată și folosește o referință la metodă.

### 2. Folosiți Referințe la Metode când este Posibil

```java
// Mai puțin expresiv
list.forEach(s -> System.out.println(s));

// Mai expresiv
list.forEach(System.out::println);
```

### 3. Evitați Efectele Secundare în Lambda-uri

```java
// Evitați - modifică starea externă
List<String> collected = new ArrayList<>();
stream.forEach(s -> collected.add(s)); // Efect secundar

// Preferabil - fără efecte secundare
List<String> collected = stream.collect(Collectors.toList());
```

### 4. Alegeți Interfețele Funcționale Adecvate

```java
// Mai puțin specific
BiFunction<Integer, Integer, Integer> add = (a, b) -> a + b;

// Mai specific și mai expresiv
IntBinaryOperator add = (a, b) -> a + b;
```

### 5. Folosiți Lambda-uri cu Tipuri Primitive când este Posibil

```java
// Ineficient - folosește boxing/unboxing
Stream<Integer> stream = Stream.of(1, 2, 3);
int sum = stream.reduce(0, (a, b) -> a + b);

// Eficient - evită boxing/unboxing
IntStream stream = IntStream.of(1, 2, 3);
int sum = stream.sum();
```

### 6. Tipuri clare pentru Citibilitate

Deși Java poate infera tipurile parametrilor lambda în majoritatea cazurilor, uneori adăugarea explicită a tipurilor poate îmbunătăți citibilitatea:

```java
// Dacă tipurile nu sunt clare din context
list.stream()
    .filter((Person p) -> p.getAge() > 30)
    .map((Person p) -> p.getName())
    .forEach(System.out::println);
```

### 7. Atenție la Paralelism

```java
// Poate fi contraproductiv pentru colecții mici
smallList.parallelStream().map(expensiveOperation).collect(Collectors.toList());

// Potențial util pentru colecții mari cu operații costisitoare
largeList.parallelStream().map(expensiveOperation).collect(Collectors.toList());
```

## Exemple Complete

### Exemplul 1: Procesarea unei Liste de Utilizatori

```java
import java.time.LocalDate;
import java.time.Period;
import java.util.*;
import java.util.function.Predicate;
import java.util.stream.Collectors;

public class UserProcessingExample {
    static class User {
        private String name;
        private String email;
        private LocalDate birthDate;
        private boolean active;
        
        // Constructor și getteri
        public User(String name, String email, LocalDate birthDate, boolean active) {
            this.name = name;
            this.email = email;
            this.birthDate = birthDate;
            this.active = active;
        }
        
        public String getName() { return name; }
        public String getEmail() { return email; }
        public LocalDate getBirthDate() { return birthDate; }
        public boolean isActive() { return active; }
        
        public int getAge() {
            return Period.between(birthDate, LocalDate.now()).getYears();
        }
        
        @Override
        public String toString() {
            return "User{name='" + name + "', email='" + email + "', age=" + getAge() + ", active=" + active + "}";
        }
    }
    
    public static void main(String[] args) {
        List<User> users = Arrays.asList(
            new User("John Doe", "john@example.com", LocalDate.of(1990, 5, 15), true),
            new User("Alice Smith", "alice@example.com", LocalDate.of(1985, 3, 20), true),
            new User("Bob Johnson", "bob@example.com", LocalDate.of(1995, 8, 10), false),
            new User("Emma Williams", "emma@example.com", LocalDate.of(1992, 11, 30), true),
            new User("Michael Brown", "michael@example.com", LocalDate.of(1988, 7, 25), false)
        );
        
        // 1. Filtru complex cu predicate compuse
        Predicate<User> isActive = User::isActive;
        Predicate<User> isAdult = user -> user.getAge() >= 18;
        Predicate<User> hasValidEmail = user -> user.getEmail().contains("@");
        
        List<User> eligibleUsers = users.stream()
            .filter(isActive.and(isAdult).and(hasValidEmail))
            .collect(Collectors.toList());
        
        System.out.println("Eligible users:");
        eligibleUsers.forEach(System.out::println);
        
        // 2. Transformare și formatare
        List<String> formattedNames = users.stream()
            .map(user -> user.getName().toUpperCase())
            .sorted()
            .collect(Collectors.toList());
        
        System.out.println("\nSorted names:");
        formattedNames.forEach(System.out::println);
        
        // 3. Grupare și agregare
        Map<Boolean, List<User>> usersByStatus = users.stream()
            .collect(Collectors.groupingBy(User::isActive));
        
        System.out.println("\nUsers by status:");
        usersByStatus.forEach((status, userList) -> {
            System.out.println(status ? "Active users:" : "Inactive users:");
            userList.forEach(user -> System.out.println("  - " + user.getName()));
        });
        
        // 4. Statistici
        OptionalDouble averageAge = users.stream()
            .mapToInt(User::getAge)
            .average();
        
        System.out.println("\nAverage age: " + 
            averageAge.orElse(0) + " years");
        
        // 5. Reducere personalizată
        String allNames = users.stream()
            .map(User::getName)
            .reduce("", (a, b) -> a.isEmpty() ? b : a + ", " + b);
        
        System.out.println("\nAll users: " + allNames);
    }
}
```

### Exemplul 2: Mini-framework pentru Procesare Asincronă

```java
import java.util.concurrent.*;
import java.util.function.*;

public class AsyncProcessingExample {
    // Clasa wrapper pentru rezultate asincrone
    public static class Async<T> {
        private final CompletableFuture<T> future;
        
        private Async(CompletableFuture<T> future) {
            this.future = future;
        }
        
        // Creare din valoare
        public static <T> Async<T> of(T value) {
            return new Async<>(CompletableFuture.completedFuture(value));
        }
        
        // Creare din operație asincronă
        public static <T> Async<T> supply(Supplier<T> supplier) {
            return new Async<>(CompletableFuture.supplyAsync(supplier));
        }
        
        // Transformare
        public <R> Async<R> map(Function<T, R> mapper) {
            return new Async<>(future.thenApply(mapper));
        }
        
        // Transformare asincronă
        public <R> Async<R> flatMap(Function<T, Async<R>> mapper) {
            return new Async<>(future.thenCompose(t -> mapper.apply(t).future));
        }
        
        // Recuperare din erori
        public Async<T> recover(Function<Throwable, T> handler) {
            return new Async<>(future.exceptionally(handler));
        }
        
        // Obținere rezultat (blocant)
        public T get() throws InterruptedException, ExecutionException {
            return future.get();
        }
        
        // Handler pentru rezultat
        public void onComplete(Consumer<T> success, Consumer<Throwable> error) {
            future.whenComplete((result, throwable) -> {
                if (throwable != null) {
                    error.accept(throwable);
                } else {
                    success.accept(result);
                }
            });
        }
    }
    
    // Simulează o operație de durată
    public static String fetchData(String url) throws Exception {
        // Simulare întârziere rețea
        Thread.sleep(1000);
        if (url.contains("error")) {
            throw new RuntimeException("Failed to fetch data");
        }
        return "Data from " + url;
    }
    
    // Procesează date
    public static int processData(String data) {
        return data.length();
    }
    
    public static void main(String[] args) throws Exception {
        // Procesare asincronă folosind lambda-uri
        Async<String> dataAsync = Async.supply(() -> {
            try {
                return fetchData("https://example.com/data");
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        });
        
        // Transformare rezultat
        Async<Integer> lengthAsync = dataAsync
            .map(data -> processData(data))
            .recover(ex -> -1);
        
        // Handler pentru rezultat final
        lengthAsync.onComplete(
            length -> System.out.println("Result: " + length),
            error -> System.err.println("Error: " + error.getMessage())
        );
        
        // Așteaptă completarea (doar pentru exemplu)
        System.out.println("Final result: " + lengthAsync.get());
        
        // Exemplu cu eroare
        Async<String> errorAsync = Async.supply(() -> {
            try {
                return fetchData("https://example.com/error");
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        });
        
        // Recuperare din eroare
        Async<Integer> recoveredAsync = errorAsync
            .map(AsyncProcessingExample::processData)
            .recover(ex -> {
                System.err.println("Recovered from: " + ex.getMessage());
                return 0;
            });
        
        System.out.println("Recovered result: " + recoveredAsync.get());
    }
}
```

## Troubleshooting și Probleme Comune

### 1. Probleme de Inferență a Tipurilor

**Problemă**: Compilatorul nu poate determina tipul parametrilor lambda.

```java
// Eroare: Cannot resolve method
stream.map(x -> x.getValue())
      .forEach(System.out::println);
```

**Soluție**: Specifică tipul parametrilor sau asigură-te că contextul oferă suficiente informații.

```java
// Cu tip explicit
stream.map((MyType x) -> x.getValue())
      .forEach(System.out::println);

// Sau separă și atribuie stream-ul unui tip
Stream<MyType> typedStream = getMyTypeStream();
typedStream.map(x -> x.getValue())
          .forEach(System.out::println);
```

### 2. Incompatibilități de Tipuri

**Problemă**: Lambda nu este compatibil cu interfața funcțională așteptată.

```java
// Eroare: Incompatible types
Consumer<String> consumer = (s) -> { return s.length(); };
```

**Soluție**: Asigură-te că lambda-ul corespunde semnăturii metodei din interfața funcțională.

```java
// Corect
Consumer<String> consumer = (s) -> { System.out.println(s.length()); };

// Sau folosește interfața corectă
Function<String, Integer> function = (s) -> s.length();
```

### 3. Variabile Non-effectively Final

**Problemă**: Accesarea variabilelor locale modificabile într-o expresie lambda.

```java
int count = 0;
list.forEach(item -> {
    count++; // Eroare: Variable used in lambda should be final or effectively final
    System.out.println(item + count);
});
```

**Soluție**: Folosește variabile finale sau effectively final, sau mută starea într-un container.

```java
// Folosind array ca mutable container
int[] count = {0};
list.forEach(item -> {
    count[0]++;
    System.out.println(item + count[0]);
});

// Folosind un AtomicInteger
AtomicInteger counter = new AtomicInteger(0);
list.forEach(item -> {
    int current = counter.incrementAndGet();
    System.out.println(item + current);
});

// Alternativ, utilizează o abordare fără efecte secundare
int result = list.stream()
               .mapToInt(item -> 1)
               .sum();
```

### 4. Exceptii Verificate în Lambda

**Problemă**: Lambda-urile nu pot arunca excepții verificate dacă interfața funcțională nu le declară.

```java
// Eroare: Unhandled exception
Files.list(Paths.get("dir"))
     .map(path -> Files.readAllLines(path)) // IOException nu este declarat în Function.apply
     .forEach(System.out::println);
```

**Soluție**: Tratează excepția în lambda sau încapsuleaz-o într-o excepție necontrolată.

```java
// Tratare excepție în lambda
Files.list(Paths.get("dir"))
     .map(path -> {
         try {
             return Files.readAllLines(path);
         } catch (IOException e) {
             return Collections.<String>emptyList();
         }
     })
     .forEach(System.out::println);

// Sau definește o interfață funcțională care declară excepția
@FunctionalInterface
interface IOFunction<T, R> {
    R apply(T t) throws IOException;
}

// Sau folosește un wrapper de excepție
public static <T, R> Function<T, R> unchecked(IOFunction<T, R> f) {
    return t -> {
        try {
            return f.apply(t);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    };
}

// Utilizare
Files.list(Paths.get("dir"))
     .map(unchecked(Files::readAllLines))
     .forEach(System.out::println);
```

### 5. Probleme de Performance

**Problemă**: Utilizarea necorespunzătoare a stream-urilor paralele poate duce la degradarea performanței.

**Soluție**: Folosește paralelismul doar când este justificat și pe colecții suficient de mari.

```java
// Evită paralelismul pentru operații simple și colecții mici
List<String> result = smallList.parallelStream() // probabil ineficient
                              .map(String::toUpperCase)
                              .collect(Collectors.toList());

// Recomandabil pentru colecții mari și operații costisitoare
List<String> result = veryLargeList.parallelStream()
                                  .map(item -> costlyOperation(item))
                                  .collect(Collectors.toList());
```

### 6. Boxing/Unboxing Implicit

**Problemă**: Utilizarea tipurilor primitive în operații lambda poate duce la overhead de boxing/unboxing.

**Soluție**: Folosește specializing stream-uri și interfețe funcționale pentru primitive.

```java
// Ineficient - implică boxing/unboxing
List<Integer> ints = Arrays.asList(1, 2, 3, 4);
int sum = ints.stream()
             .filter(n -> n % 2 == 0)
             .map(n -> n * 2)
             .reduce(0, (a, b) -> a + b);

// Eficient - evită boxing/unboxing
int[] intsArray = {1, 2, 3, 4};
int sum = IntStream.of(intsArray)
                  .filter(n -> n % 2 == 0)
                  .map(n -> n * 2)
                  .sum();
```

Cu aceste exemple și tehnici, ești acum pregătit să utilizezi expresiile lambda în Java la potențialul lor maxim, scriind cod mai concis, expresiv și eficient.