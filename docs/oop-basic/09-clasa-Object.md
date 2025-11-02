# Clasa Object 

## Introducere în Clasa Object

**Object** (`java.lang.Object`) reprezintă fundamentul întregului sistem de clase în Java. Este superclasa tuturor claselor, ceea ce înseamnă că **orice clasă Java moștenește implicit această clasă** dacă nu extinde explicit o altă clasă (care la randul ei mosteneste Object, deci in cele din urma in varful ierarhiei vom gasi clasa Object).

```java
// Aceste două declarații sunt echivalente
public class ExempluClasa { }
public class ExempluClasa extends Object { }
```

Această moștenire universală asigură că toate obiectele din Java au un set minim de funcționalități comune.

## Metodele Fundamentale ale Clasei Object

### 1. toString()
Convertește obiectul într-o reprezentare textuală.

```java
@Override
public String toString() {
    return "ExempluClasa{" +
           "atribut1=" + atribut1 +
           ", atribut2='" + atribut2 + '\'' +
           '}';
}
```

**Utilizare**: Afișarea informațiilor despre obiect în mod lizibil.
**Când să suprascrii**: Când ai nevoie de o reprezentare personalizată a obiectului tău.

### 2. equals(Object obj)
Determină dacă obiectul curent este egal cu alt obiect.

```java
@Override
public boolean equals(Object obj) {
    if (this == obj) return true;
    if (obj == null || getClass() != obj.getClass()) return false;
    
    ExempluClasa that = (ExempluClasa) obj;
    return atribut1 == that.atribut1 && 
           Objects.equals(atribut2, that.atribut2);
}
```

**Utilizare**: Compararea obiectelor pentru egalitate logică, nu doar referințială.
**Când să suprascrii**: Când dorești să definești reguli proprii de egalitate între obiecte.

#### Contractul metodei equals()

Implementarea metodei equals() trebuie să respecte următoarele proprietăți:

1. **Reflexivitate**: Pentru orice referință non-null x, x.equals(x) trebuie să returneze true.
2. **Simetrie**: Pentru orice referințe non-null x și y, x.equals(y) trebuie să returneze true dacă și numai dacă y.equals(x) returnează true.
3. **Tranzitivitate**: Pentru orice referințe non-null x, y și z, dacă x.equals(y) returnează true și y.equals(z) returnează true, atunci x.equals(z) trebuie să returneze true.
4. **Consistență**: Pentru orice referințe non-null x și y, apeluri multiple ale x.equals(y) trebuie să returneze consistent true sau false, atât timp cât nu s-a modificat nicio informație folosită în comparația equals.
5. **Comportament cu null**: Pentru orice referință non-null x, x.equals(null) trebuie să returneze false.

#### Pași pentru implementarea corectă a equals()

1. Verifică dacă referințele obiectelor sunt identice folosind operatorul == (optimizare)
2. Verifică dacă parametrul este null
3. Verifică dacă obiectele sunt de același tip (folosind getClass() sau instanceof)
4. Convertește parametrul la tipul clasei tale
5. Compară fiecare câmp relevant pentru egalitate:
    - Pentru primitive, folosește operatorul ==
    - Pentru obiecte, folosește Objects.equals() sau apelează equals() pe obiectul non-null
    - Pentru arrays, folosește Arrays.equals() sau Arrays.deepEquals() pentru array-uri multidimensionale

#### Exemple de erori comune în implementarea equals()

```java
// GREȘIT: Nu verifică tipul obiectului
public boolean equals(Object obj) {
    Student other = (Student) obj; // Poate genera ClassCastException
    return this.id == other.id;
}

// GREȘIT: Semnătură incorectă (suprascrie metoda)
public boolean equals(Student obj) { // Aceasta este o metodă nouă, nu o suprascriere!
    return this.id == obj.id;
}
```

### 3. hashCode()
Generează un cod hash pentru obiect, esențial pentru utilizarea în colecții.

```java
@Override
public int hashCode() {
    return Objects.hash(atribut1, atribut2);
}
```

**Utilizare**: Necesar pentru funcționarea corectă în HashMap, HashSet etc.
**Regulă importantă**: Trebuie suprascrisa împreună cu equals().

#### Contractul metodei hashCode()

Implementarea metodei hashCode() trebuie să respecte următoarele reguli:

1. **Consistență internă**: Dacă nu s-a modificat nicio informație folosită în equals(), mai multe apeluri ale hashCode() pe același obiect trebuie să returneze consecvent aceeași valoare.
2. **Concordanță cu equals()**: Dacă două obiecte sunt egale conform metodei equals(), atunci apelând hashCode() pe fiecare dintre ele trebuie să se obțină aceeași valoare hash.
3. **Coliziuni**: Deși nu este obligatoriu, este de dorit ca obiecte diferite (conform equals()) să returneze valori hash diferite, pentru a îmbunătăți performanța structurilor de date bazate pe hash.

#### Implementări ale hashCode()

1. **Folosind Objects.hash()** (Java 7+)
   ```java
   @Override
   public int hashCode() {
       return Objects.hash(atribut1, atribut2, atribut3);
   }
   ```

2. **Implementare manuală**
   ```java
   @Override
   public int hashCode() {
       int result = 17; // număr prim inițial
       result = 31 * result + atribut1; // înmulțire cu un alt număr prim
       result = 31 * result + (atribut2 != null ? atribut2.hashCode() : 0);
       // se continuă pentru toate atributele relevante
       return result;
   }
   ```

3. **Pentru array-uri**
   ```java
   @Override
   public int hashCode() {
       int result = 17;
       result = 31 * result + Arrays.hashCode(arrayAtribut);
       return result;
   }
   ```

#### Probleme comune cu hashCode()

1. **Utilizarea atributelor diferite**: Folosirea unor atribute în hashCode() diferite de cele folosite în equals().
2. **Ignorarea relației cu equals()**: Dacă suprascrii equals(), trebuie să suprascrii și hashCode().
3. **Hash ineficient**: Generarea aceluiași hash pentru prea multe obiecte diferite, ceea ce reduce performanța colecțiilor.

#### Impactul în colecții bazate pe hash

Implementarea incorectă a hashCode() poate duce la probleme grave când obiectele sunt stocate în colecții precum:
- HashMap
- HashSet
- LinkedHashMap
- LinkedHashSet
- Hashtable

Exemplu de problemă:
```java
Student s1 = new Student(1, "Ana");
Student s2 = new Student(1, "Ana");

// Dacă equals() returnează true dar hashCode() nu este suprascris corect:
HashSet<Student> set = new HashSet<>();
set.add(s1);
set.add(s2);
System.out.println(set.size()); // Ar putea afișa 2 în loc de 1 (duplicat)!
```

### 4. getClass()
Returnează un obiect de tip Class care reprezintă clasa obiectului la runtime.

```java
public void afisareTipObiect() {
    System.out.println("Tipul obiectului: " + this.getClass().getName());
}
```

**Utilizare**: Identificarea tipului real al unui obiect, reflecție.
**Notă**: Nu poate fi suprascrisă (metodă finală).

### 5. clone()
Creează o copie a obiectului.

```java
@Override
protected Object clone() throws CloneNotSupportedException {
    return super.clone();
}
```

**Utilizare**: Crearea unei copii a obiectului.
**Cerințe**: Clasa trebuie să implementeze interfața Cloneable.

### 6. finalize()
Invocată de garbage collector înainte de a elibera memoria obiectului.

```java
@Override
protected void finalize() throws Throwable {
    // Eliberare resurse
    System.out.println("Obiect finalizat");
    super.finalize();
}
```

**Utilizare**: Eliberarea resurselor externe.
**Notă**: Depreciat în versiunile recente de Java în favoarea try-with-resources.

## Relația dintre equals() și hashCode()

Este esențial să respecți contractul dintre aceste două metode:
- Dacă două obiecte sunt egale prin equals(), trebuie să aibă același hashCode()
- Dacă două obiecte au același hashCode(), nu înseamnă neapărat că sunt egale prin equals()

### Implicații practice ale relației equals-hashCode

#### 1. Comportamentul în colecții

```java
Map<Student, String> noteStudenti = new HashMap<>();

Student s1 = new Student(1, "Ana");
Student s2 = new Student(1, "Ana"); // Același ID, ar trebui să fie "egal" cu s1

noteStudenti.put(s1, "10");
String nota = noteStudenti.get(s2);

System.out.println(nota); // Should print "10" if equals and hashCode are implemented correctly
```

#### 2. Procesul de căutare în HashMap/HashSet

1. Se calculează hashCode() pentru cheia căutată
2. Se identifică "bucket-ul" corespunzător în structura internă
3. Pentru fiecare element din bucket:
    - Se verifică dacă hashCode-urile sunt egale
    - Dacă da, se apelează equals() pentru a confirma egalitatea

#### 3. Consecințe ale implementării incorecte

| Situație | Consecință |
|----------|------------|
| equals() suprascris, hashCode() nu | Obiectele egale pot ajunge în bucket-uri diferite, ducând la duplicate aparente în HashSet |
| Ambele metode suprascrise incorect | Comportament imprevizibil în colecții, căutări eșuate, duplicare |
| hashCode() returnează constant | Toate obiectele ajung în același bucket, transformând HashMap într-o listă liniară (ineficient) |

### Exemplu complet cu testare

```java
public class Student {
    private int id;
    private String nume;
    
    public Student(int id, String nume) {
        this.id = id;
        this.nume = nume;
    }
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Student student = (Student) obj;
        return id == student.id; // Considerăm că ID-ul este unicul identificator
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(id); // Folosim același câmp ca în equals()
    }
    
    // Test funcționalitate
    public static void main(String[] args) {
        Student s1 = new Student(1, "Ana");
        Student s2 = new Student(1, "Ana");
        Student s3 = new Student(2, "Ion");
        
        System.out.println("s1 equals s2: " + s1.equals(s2)); // true
        System.out.println("s1 hashCode == s2 hashCode: " + (s1.hashCode() == s2.hashCode())); // true
        
        HashSet<Student> students = new HashSet<>();
        students.add(s1);
        students.add(s2);
        students.add(s3);
        
        System.out.println("Set size: " + students.size()); // 2, nu 3 (s1 și s2 considerate duplicate)
    }
}
```

## Exemplu Practic

```java
public class Student {
    private int id;
    private String nume;
    
    public Student(int id, String nume) {
        this.id = id;
        this.nume = nume;
    }
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Student student = (Student) obj;
        return id == student.id;
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
    
    @Override
    public String toString() {
        return "Student{id=" + id + ", nume='" + nume + "'}";
    }
}
```

## Importanța Clasei Object în Java

1. **Polimorfism**: Orice obiect poate fi tratat ca un Object
2. **Funcționalitate comună**: Toate obiectele au aceleași metode de bază
3. **Interoperabilitate**: Facilitează lucrul cu diverse tipuri de obiecte în colecții și APIs
