# Introducere în clasa String în Java

## Ce este clasa String?

- Clasa fundamentală în Java pentru manipularea textului
- Aparține pachetului `java.lang` (importat automat)
- **Imutabilă**: odată creată, conținutul nu poate fi modificat
- O clasă specială cu suport direct în limbaj prin literali de tip șir

## Crearea obiectelor String

```java
// Prin literal de șir (recomandat)
String nume = "Maria";

// Prin constructor
String titlu = new String("Java Programming");

// Diverse constructori
String dinCharArray = new String(new char[]{'J', 'a', 'v', 'a'});
String dinBytes = new String(new byte[]{74, 97, 118, 97}, "UTF-8");
```

## Imutabilitatea String-urilor

```java
String text = "Hello";
text.concat(" World");  // Aceasta nu modifică string-ul original!
System.out.println(text);  // Afișează doar "Hello"

// Atribuirea este necesară pentru a păstra rezultatul
text = text.concat(" World");
System.out.println(text);  // Acum afișează "Hello World"
```

## Pool-ul de String-uri

- Java menține un "String Pool" (bazin de string-uri) pentru optimizare
- Literalii identici folosesc aceeași referință în memorie

```java
String s1 = "abc";
String s2 = "abc";
String s3 = new String("abc");

System.out.println(s1 == s2);  // true (aceeași referință)
System.out.println(s1 == s3);  // false (referințe diferite)
System.out.println(s1.equals(s3));  // true (conținut identic)
```

## Metode importante

### Obținerea informațiilor despre șir

```java
String text = "Java Programming";

int lungime = text.length();  // 16
char primaLitera = text.charAt(0);  // 'J'
int pozitieLitera = text.indexOf('P');  // 5
boolean contineJava = text.contains("Java");  // true
```

### Compararea șirurilor

```java
String s1 = "abc";
String s2 = "ABC";

boolean egale = s1.equals(s2);  // false (case-sensitive)
boolean egaleIgnorandCaz = s1.equalsIgnoreCase(s2);  // true
int comparatie = s1.compareTo(s2);  // pozitiv (a > A în Unicode)
```

### Extragerea sub-șirurilor

```java
String text = "Java Programming";

String subText = text.substring(5);  // "Programming"
String partialText = text.substring(0, 4);  // "Java"
```

### Transformarea șirurilor

```java
String text = "  Java Programming  ";

String lower = text.toLowerCase();  // "  java programming  "
String upper = text.toUpperCase();  // "  JAVA PROGRAMMING  "
String trimmed = text.trim();  // "Java Programming"
String replaced = text.replace('a', 'o');  // "Jovo Progromming"
String[] parts = text.trim().split(" ");  // ["Java", "Programming"]
```

## Concatenarea șirurilor

```java
// Utilizând operatorul +
String nume = "Ana";
String mesaj = "Salut, " + nume + "!";  // "Salut, Ana!"

// Utilizând metoda concat()
String rezultat = "Salut, ".concat(nume).concat("!");

// Utilizând StringBuilder (recomandat pentru multe concatenări)
StringBuilder sb = new StringBuilder();
sb.append("Salut, ");
sb.append(nume);
sb.append("!");
String final = sb.toString();
```

## Performanță și optimizare

- String: imutabil, bun pentru valori fixe
- StringBuilder: mutabil, rapid, nu este thread-safe
- StringBuffer: mutabil, thread-safe, mai lent decât StringBuilder

```java
// Ineficient pentru multe concatenări
String result = "";
for (int i = 0; i < 10000; i++) {
    result += i;  // Creează un nou obiect String la fiecare iterație!
}

// Eficient pentru multe concatenări
StringBuilder sb = new StringBuilder();
for (int i = 0; i < 10000; i++) {
    sb.append(i);  // Modifică același obiect
}
String result = sb.toString();  // O singură conversie la final
```

## Metode utile introduse în versiuni mai noi de Java

```java
// Java 11+
String text = "  Hello  ";
String trimmedStart = text.stripLeading();  // "Hello  "
String trimmedEnd = text.stripTrailing();  // "  Hello"
String trimmedBoth = text.strip();  // "Hello"

// Verifică dacă un șir este gol sau conține doar spații
boolean isEmpty = text.isBlank();  // false

// Java 12+
String indented = "Hello".indent(4);  // "    Hello"

// Java 15+
String formatted = "%s are %d mere".formatted("Ana", 5);  // "Ana are 5 mere"
```

## Bune practici

1. Folosiți literali de șir în loc de constructori pentru eficiență
2. Utilizați `equals()` pentru compararea conținutului, nu `==`
3. Folosiți StringBuilder pentru concatenări multiple
4. Fiți atenți la imutabilitate - atribuiți rezultatul operațiilor
5. Pentru căutări și manipulări complexe, considerați regex (Pattern și Matcher)

## Exercițiu practic

Scrieți un program Java care:
1. Primește un text de la utilizator
2. Numără câte vocale conține
3. Inversează textul
4. Convertește prima literă din fiecare cuvânt la majusculă

```java
import java.util.Scanner;

public class StringExercise {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Introduceți un text: ");
        String text = scanner.nextLine();
        scanner.close();
        
        // Numără vocalele
        int vocale = 0;
        for (char c : text.toLowerCase().toCharArray()) {
            if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                vocale++;
            }
        }
        
        // Inversează textul
        String inversat = new StringBuilder(text).reverse().toString();
        
        // Convertește prima literă din fiecare cuvânt la majusculă
        StringBuilder result = new StringBuilder();
        boolean nouCuvant = true;
        
        for (char c : text.toCharArray()) {
            if (Character.isWhitespace(c)) {
                nouCuvant = true;
                result.append(c);
            } else {
                if (nouCuvant) {
                    result.append(Character.toUpperCase(c));
                    nouCuvant = false;
                } else {
                    result.append(c);
                }
            }
        }
        
        System.out.println("Text original: " + text);
        System.out.println("Număr de vocale: " + vocale);
        System.out.println("Text inversat: " + inversat);
        System.out.println("Text cu prima literă majusculă: " + result.toString());
    }
}
```

## Concluzie

- String este o clasă fundamentală în Java pentru manipularea textului
- Imutabilitatea oferă avantaje de securitate și optimizare 
- Alegerea corectă între String, StringBuilder și StringBuffer este importantă pentru performanță
- Java oferă un set bogat de metode pentru manipularea și transformarea șirurilor
- Înțelegerea profundă a clasei String este esențială pentru dezvoltarea eficientă în Java
