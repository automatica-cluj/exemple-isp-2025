# Gestionarea Erorilor și Excepțiilor

## Introducere în Gestionarea Erorilor

Gestionarea erorilor este o parte esențială a dezvoltării software robuste. În Java, sistemul de gestionare a erorilor se bazează pe mecanismul de excepții, care oferă o modalitate structurată și elegantă de a detecta, propaga și trata situațiile excepționale.

### Ce este o Excepție?

O excepție este un eveniment care apare în timpul execuției unui program și perturbă fluxul normal de instrucțiuni. Când apare o eroare, Java creează un obiect de excepție și "aruncă" (throws) această excepție. Codul poate "prinde" (catch) aceste excepții și le poate trata corespunzător.

### De ce să folosim Excepții?

Mecanismul de excepții oferă mai multe avantaje:

1. **Separarea codului de gestionare a erorilor** de logica principală a aplicației
2. **Propagarea erorilor** prin stiva de apeluri, fără a fi nevoie de verificarea explicită a valorilor de retur
3. **Gruparea și clasificarea diferitelor tipuri de erori**
4. **Colectarea contextului detaliat** despre eroare prin stack trace
5. **Gestionare centralizată a erorilor** pentru aplicații complexe

## Ierarhia de Excepții în Java

În Java, toate excepțiile sunt subclase ale clasei `Throwable`. Ierarhia principală este:

```
Throwable
├── Error
│   ├── OutOfMemoryError
│   ├── StackOverflowError
│   ├── ... (alte erori)
│
└── Exception
    ├── IOException
    ├── SQLException
    ├── ... (alte excepții verificate)
    │
    └── RuntimeException
        ├── NullPointerException
        ├── ArrayIndexOutOfBoundsException
        ├── ArithmeticException
        ├── ... (alte excepții neverficate)
```

### Throwable

Clasa de bază pentru toate erorile și excepțiile în Java. Oferă metode comune precum:

- `getMessage()` - returnează un mesaj detaliat
- `getStackTrace()` - returnează array cu informații despre stack trace
- `printStackTrace()` - afișează stack trace-ul la standard error stream
- `getCause()` - returnează cauza excepției, dacă există

### Error

Clasa `Error` reprezintă erori grave la nivel de sistem sau JVM care, în general, nu ar trebui să fie prinse sau tratate de aplicație. Exemple:

- `OutOfMemoryError` - când JVM nu poate aloca mai multă memorie
- `StackOverflowError` - când stiva de apeluri depășește limita (recursivitate infinită)
- `LinkageError` - când o clasă are dependențe incompatibile

### Exception

Clasa `Exception` este baza pentru excepțiile care pot și ar trebui să fie tratate de aplicație.

## Tipuri de Excepții

În Java, există două tipuri principale de excepții:

### 1. Excepții Verificate (Checked Exceptions)

- Derivă direct din clasa `Exception` (dar nu din `RuntimeException`)
- Trebuie declarate în clauza `throws` a metodei sau trebuie prinse explicit
- Reprezintă condiții excepționale pe care o aplicație bine scrisă ar trebui să le anticipeze și să le recupereze
- Exemple: `IOException`, `SQLException`, `ClassNotFoundException`

```java
// Exemplu de excepție verificată
public void readFile(String path) throws IOException {
    FileReader file = new FileReader(path);
    // ... cod pentru citire
    file.close();
}
```

### 2. Excepții Neverificate (Unchecked Exceptions)

- Derivă din clasa `RuntimeException`
- Nu trebuie declarate sau prinse explicit
- De obicei, indică erori de programare sau condiții din care recuperarea este dificilă
- Exemple: `NullPointerException`, `ArrayIndexOutOfBoundsException`, `IllegalArgumentException`

```java
// Exemplu de excepție neverificată
public int divide(int a, int b) {
    // Aruncă ArithmeticException dacă b este 0
    return a / b;
}
```

### 3. Erori (Errors)

- Derivă din clasa `Error`
- Nu sunt nici verificate, nici neverificate
- Reprezintă probleme grave, de obicei la nivel de sistem
- Nu sunt menite să fie prinse sau tratate de aplicație

```java
// Exemplu de eroare
public void recursiveMethod() {
    // Va genera StackOverflowError
    recursiveMethod();
}
```

## Blocurile try-catch-finally

Mecanismul principal pentru gestionarea excepțiilor în Java constă în blocurile `try`, `catch` și `finally`.

### Blocul try

Încapsulează codul care ar putea genera o excepție:

```java
try {
    // Cod care poate arunca excepții
    int result = 10 / 0; // Aruncă ArithmeticException
}
```

### Blocul catch

Prinde și tratează excepțiile aruncate în blocul `try`:

```java
try {
    int result = 10 / 0;
} catch (ArithmeticException e) {
    // Cod pentru tratarea excepției
    System.out.println("Nu se poate împărți la zero: " + e.getMessage());
}
```

### Blocul finally

Conține cod care se execută întotdeauna, indiferent dacă a fost aruncată o excepție sau nu:

```java
FileReader reader = null;
try {
    reader = new FileReader("file.txt");
    // Procesare fișier
} catch (IOException e) {
    System.out.println("Eroare la citirea fișierului: " + e.getMessage());
} finally {
    // Acest bloc se execută întotdeauna
    if (reader != null) {
        try {
            reader.close();
        } catch (IOException e) {
            System.out.println("Eroare la închiderea fișierului");
        }
    }
}
```

### Combinarea blocurilor

Puteți avea mai multe blocuri `catch` pentru a trata diferite tipuri de excepții:

```java
try {
    // Cod care poate arunca mai multe tipuri de excepții
    FileReader file = new FileReader("missing.txt");
    int result = Integer.parseInt(file.read() + "");
} catch (FileNotFoundException e) {
    System.out.println("Fișierul nu a fost găsit");
} catch (NumberFormatException e) {
    System.out.println("Format numeric invalid");
} catch (IOException e) {
    System.out.println("Eroare I/O: " + e.getMessage());
} finally {
    System.out.println("Operație finalizată");
}
```

## Lansarea Excepțiilor

Excepțiile pot fi aruncate explicit folosind cuvântul cheie `throw`:

```java
public void checkAge(int age) {
    if (age < 0) {
        throw new IllegalArgumentException("Vârsta nu poate fi negativă");
    }
    if (age > 120) {
        throw new IllegalArgumentException("Vârsta pare nerealistă");
    }
    // Procesare vârstă validă
}
```

### Declararea Excepțiilor

Metodele care pot arunca excepții verificate trebuie să le declare folosind clauza `throws`:

```java
public void readFile(String path) throws IOException, FileNotFoundException {
    // Cod care poate arunca excepții verificate
}
```

### Re-aruncarea Excepțiilor

Puteți prinde o excepție, efectua unele operațiuni și apoi o puteți re-arunca:

```java
public void processFile(String path) throws IOException {
    try {
        // Cod pentru procesarea fișierului
    } catch (IOException e) {
        System.out.println("Logging error: " + e.getMessage());
        throw e; // Re-aruncă excepția pentru a fi tratată în altă parte
    }
}
```

### Încapsularea Excepțiilor

Puteți încapsula o excepție într-un alt tip de excepție, păstrând informația despre cauza originală:

```java
public void processData() throws ServiceException {
    try {
        // Cod care poate arunca IOException
        readFile("data.txt");
    } catch (IOException e) {
        // Încapsulează excepția originală într-o excepție specifică aplicației
        throw new ServiceException("Eroare la procesarea datelor", e);
    }
}
```

## Propagarea Excepțiilor

Când o excepție este aruncată într-o metodă și nu este tratată, ea se propagă în sus pe stiva de apeluri până când este prinsă sau până ajunge la începutul programului (care termină programul).

```java
public void metoda1() {
    metoda2();
}

public void metoda2() {
    metoda3();
}

public void metoda3() throws IOException {
    throw new IOException("A apărut o eroare");
}
```

În acest exemplu, excepția aruncată în `metoda3()` se va propaga la `metoda2()`, apoi la `metoda1()`, și în sus pe stivă până când este prinsă sau ajunge la `main()`.

## Try-with-Resources

Java 7 a introdus constructul `try-with-resources` pentru a simplifica gestionarea resurselor care trebuie închise:

```java
// Înainte de Java 7
BufferedReader br = null;
try {
    br = new BufferedReader(new FileReader("file.txt"));
    String line = br.readLine();
    // Procesare linie
} catch (IOException e) {
    e.printStackTrace();
} finally {
    if (br != null) {
        try {
            br.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

// Cu try-with-resources (Java 7+)
try (BufferedReader br = new BufferedReader(new FileReader("file.txt"))) {
    String line = br.readLine();
    // Procesare linie
} catch (IOException e) {
    e.printStackTrace();
}
```

Resursele declarate în parantezele `try` vor fi închise automat la finalul blocului, indiferent dacă apar excepții sau nu.

### Multiple Resurse

Puteți gestiona multiple resurse în același bloc try-with-resources:

```java
try (FileInputStream input = new FileInputStream("input.txt");
     FileOutputStream output = new FileOutputStream("output.txt")) {
    // Cod pentru citirea din input și scrierea în output
} catch (IOException e) {
    e.printStackTrace();
}
```

### Excepții Suprimate

Dacă apar excepții atât în blocul try, cât și la închiderea resurselor, excepția din blocul try este cea aruncată, iar excepțiile de la închidere sunt suprimate și adăugate la prima excepție. Acestea pot fi accesate prin metoda `getSuppressed()`:

```java
try {
    try (AutoCloseable resource = getResource()) {
        throw new Exception("Excepție în blocul try");
    }
} catch (Exception e) {
    System.out.println("Excepție principală: " + e.getMessage());
    
    // Afișarea excepțiilor suprimate, dacă există
    Throwable[] suppressed = e.getSuppressed();
    for (Throwable t : suppressed) {
        System.out.println("Excepție suprimată: " + t.getMessage());
    }
}
```

## Excepții Personalizate

Pentru aplicații complexe, este util să creați propriile clase de excepții pentru a captura condițiile specifice de eroare ale aplicației.

### Crearea unei Excepții Verificate

```java
// Excepție verificată personalizată
public class InsufficientFundsException extends Exception {
    private final double amount;
    private final double balance;
    
    public InsufficientFundsException(String message, double amount, double balance) {
        super(message);
        this.amount = amount;
        this.balance = balance;
    }
    
    public double getAmount() {
        return amount;
    }
    
    public double getBalance() {
        return balance;
    }
    
    public double getDeficit() {
        return amount - balance;
    }
}
```

### Crearea unei Excepții Neverificate

```java
// Excepție neverificată personalizată
public class UserNotFoundException extends RuntimeException {
    private final String userId;
    
    public UserNotFoundException(String message, String userId) {
        super(message);
        this.userId = userId;
    }
    
    public String getUserId() {
        return userId;
    }
}
```

### Utilizare

```java
public class BankAccount {
    private double balance;
    private String accountId;
    
    // Constructor și getteri/setteri
    
    public void withdraw(double amount) throws InsufficientFundsException {
        if (amount > balance) {
            throw new InsufficientFundsException(
                "Fonduri insuficiente pentru retragere", amount, balance);
        }
        balance -= amount;
    }
}

public class UserService {
    public User findUser(String userId) {
        User user = database.findById(userId);
        if (user == null) {
            throw new UserNotFoundException("Utilizatorul nu a fost găsit", userId);
        }
        return user;
    }
}
```

## Multi-catch și Uniunea de Excepții

Java 7 a introdus capacitatea de a prinde mai multe tipuri de excepții într-un singur bloc catch:

```java
// Înainte de Java 7
try {
    // Cod
} catch (IOException e) {
    // Tratare
} catch (SQLException e) {
    // Cod identic pentru tratare
}

// Cu multi-catch (Java 7+)
try {
    // Cod
} catch (IOException | SQLException e) {
    // Tratare comună pentru ambele tipuri de excepții
}
```

Acest feature este util când tratarea mai multor excepții este identică, reducând duplicarea codului.

## Best Practices

### 1. Folosiți excepții pentru condiții excepționale, nu pentru flux de control normal

```java
// Incorect - folosire excepții pentru flux de control
public int getNextValue(int[] array, int index) {
    try {
        return array[index + 1];
    } catch (ArrayIndexOutOfBoundsException e) {
        return -1; // Valoare default dacă nu există next
    }
}

// Corect - verificare normală
public int getNextValue(int[] array, int index) {
    if (index + 1 < array.length) {
        return array[index + 1];
    }
    return -1; // Valoare default
}
```

### 2. Utilizați ierarhii de excepții pentru a modela domeniul

Creați o ierarhie de excepții care să reflecte modelul de erori specific domeniului aplicației:

```java
public class ServiceException extends Exception { /* ... */ }

public class DatabaseException extends ServiceException { /* ... */ }
public class NetworkException extends ServiceException { /* ... */ }

public class ConnectionPoolException extends DatabaseException { /* ... */ }
public class QueryException extends DatabaseException { /* ... */ }
```

### 3. Includeți informații relevante în excepțiile aruncate

```java
// Insuficient informativ
throw new SQLException("Database error");

// Mai informativ
throw new SQLException("Failed to execute query: SELECT * FROM users WHERE id = " + userId);
```

### 4. Alegeți corect între excepții verificate și neverificate

- **Excepții verificate**: pentru condiții recuperabile din care aplicația poate să-și revină
- **Excepții neverificate**: pentru erori de programare sau condiții irecuperabile

```java
// Verificată - utilizatorul poate furniza un fișier diferit
public void loadConfiguration(String path) throws FileNotFoundException {
    // ...
}

// Neverificată - argument invalid este o eroare de programare
public void processData(String data) {
    if (data == null) {
        throw new IllegalArgumentException("Data cannot be null");
    }
    // ...
}
```

### 5. Nu ignorați excepțiile prinse

```java
// Incorect - excepție ignorată
try {
    file.delete();
} catch (IOException e) {
    // Do nothing
}

// Corect - log excepția cel puțin
try {
    file.delete();
} catch (IOException e) {
    logger.warn("Failed to delete file", e);
    // Eventual oferă feedback utilizatorului sau ia măsuri alternative
}
```

### 6. Evitați try-catch excesiv pentru bucăți mici de cod

```java
// Prea granular și greu de urmărit
try {
    openConnection();
} catch (SQLException e) {
    handleSQLException(e);
}

try {
    executeQuery();
} catch (SQLException e) {
    handleSQLException(e);
}

// Mai bine - tratare mai generală
try {
    openConnection();
    executeQuery();
} catch (SQLException e) {
    handleSQLException(e);
}
```

### 7. Închideți întotdeauna resursele

Folosiți try-with-resources când lucrați cu resurse care trebuie închise:

```java
// Preferabil
try (Connection conn = getConnection();
     Statement stmt = conn.createStatement();
     ResultSet rs = stmt.executeQuery(query)) {
    // Procesare rezultate
}
```

### 8. Evitați capturarea Throwable

```java
// Evitați - prea general
try {
    // Cod
} catch (Throwable t) {
    // Tratare
}

// Mai bine - separă gestionarea excepțiilor și erorilor
try {
    // Cod
} catch (Exception e) {
    // Tratare excepții
}
```

### 9. Folosiți blocuri finally pentru curățare, nu pentru logică de business

```java
// Incorect
try {
    processBusinessLogic();
} finally {
    // Logică de business suplimentară
    completeTransaction();
}

// Corect
try {
    processBusinessLogic();
    completeTransaction();
} finally {
    // Doar curățare resurse
    closeResources();
}
```

## Excepțiile și Performanța

Mecanismul de excepții în Java are un cost de performanță datorită:

1. **Creării obiectului de excepție** - care include captarea stack trace-ului
2. **Căutării handler-ului** - JVM trebuie să parcurgă stiva de apeluri
3. **Unwinding stack-ului** - eliminarea cadrelor de stivă până la handler

### Recomandări pentru performanță

1. **Nu folosiți excepții pentru flux de control normal**

```java
// Ineficient
public boolean stringContainsNumber(String s) {
    try {
        Integer.parseInt(s);
        return true;
    } catch (NumberFormatException e) {
        return false;
    }
}

// Eficient
public boolean stringContainsNumber(String s) {
    for (char c : s.toCharArray()) {
        if (Character.isDigit(c)) {
            return true;
        }
    }
    return false;
}
```

2. **Folosiți verificări preliminare pentru condițiile comune**

```java
// Ineficient
public int getElement(List<String> list, int index) {
    try {
        return Integer.parseInt(list.get(index));
    } catch (IndexOutOfBoundsException e) {
        return -1;
    } catch (NumberFormatException e) {
        return -1;
    }
}

// Eficient
public int getElement(List<String> list, int index) {
    if (index < 0 || index >= list.size()) {
        return -1;
    }
    
    String value = list.get(index);
    try {
        return Integer.parseInt(value);
    } catch (NumberFormatException e) {
        return -1;
    }
}
```

3. **Reutilizați excepțiile pentru cazuri speciale**

Pentru scenarii foarte specifice de performanță, se pot reutiliza obiecte de excepție, dar această practică este rară și necesită atenție la thread-safety:

```java
public class OptimizedParser {
    private static final NumberFormatException CACHED_NFE = 
        new NumberFormatException("Invalid number format");
    
    public int parseWithoutStackTrace(String s) {
        try {
            return Integer.parseInt(s);
        } catch (NumberFormatException e) {
            throw CACHED_NFE; // Nu captează stack trace nou
        }
    }
}
```

## Debugging și Logging

Excepțiile sunt vitale pentru debugging și logging. Iată câteva tehnici utile:

### 1. Logging adecvat la tratarea excepțiilor

```java
try {
    // Cod care poate arunca excepții
} catch (Exception e) {
    logger.error("Failed to process data: " + e.getMessage(), e);
    // e.printStackTrace(); // Evitați în cod de producție
}
```

### 2. Încapsularea cu informații contextuale

```java
try {
    processOrder(order);
} catch (Exception e) {
    throw new OrderProcessingException(
        "Failed to process order #" + order.getId(), e);
}
```

### 3. Utilizarea getMessage(), getStackTrace() și getCause()

```java
try {
    // Cod
} catch (Exception e) {
    System.err.println("Error message: " + e.getMessage());
    
    System.err.println("Stack trace:");
    StackTraceElement[] stackTrace = e.getStackTrace();
    for (StackTraceElement element : stackTrace) {
        System.err.println("\tat " + element);
    }
    
    Throwable cause = e.getCause();
    if (cause != null) {
        System.err.println("Caused by: " + cause.getMessage());
    }
}
```

### 4. Personalizarea printStackTrace()

```java
try {
    // Cod
} catch (Exception e) {
    // Afișare stack trace la un writer specific
    StringWriter sw = new StringWriter();
    PrintWriter pw = new PrintWriter(sw);
    e.printStackTrace(pw);
    String stackTraceString = sw.toString();
    
    // Utilizare pentru logging, mail, etc.
    logger.error(stackTraceString);
}
```
