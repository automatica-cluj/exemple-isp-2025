# Adnotările 

## Ce sunt adnotările?

Adnotările (în engleză *annotations*) reprezintă o caracteristică a limbajului Java care permite atașarea de **metadate** la elemente ale codului sursă, cum ar fi clase, metode, câmpuri sau parametri. Aceste metadate pot fi utilizate de către compilator, instrumente externe (IDE-uri, generatoare de cod) sau de către aplicație la rulare prin mecanismele de reflecție.

Adnotările nu modifică direct comportamentul codului, dar oferă informații suplimentare despre acesta, facilitând automatizarea anumitor procese, validarea datelor sau configurarea componentelor într-un mod declarativ.

## Exemple de adnotări predefinite

Java oferă o serie de adnotări predefinite, cu roluri bine stabilite:

- `@Override` – indică faptul că metoda adnotată suprascrie o metodă din superclasă. Dacă nu există o astfel de metodă, compilatorul va genera eroare.
- `@Deprecated` – marchează un element ca fiind învechit, sugerând că utilizarea sa ar trebui evitată.
- `@SuppressWarnings` – instruiește compilatorul să ignore anumite tipuri de avertismente.
- `@FunctionalInterface` – indică faptul că interfața adnotată trebuie să aibă exact o metodă abstractă (utilă pentru expresii lambda).

### Exemplu de utilizare:

```java
@Override
public String toString() {
    return "Exemplu de obiect";
}
```

În acest caz, compilatorul va verifica dacă `toString()` este corect suprascris.

## Adnotări personalizate

Programatorii pot defini propriile adnotări folosind sintaxa:

```java
public @interface Eticheta {
    String valoare() default "";
}
```

Adnotarea poate fi apoi aplicată pe o clasă sau metodă:

```java
@Eticheta(valoare = "Test")
public class Exemplu {
}
```

Este posibilă și combinarea adnotărilor cu procesarea lor la runtime, folosind reflecția (`java.lang.reflect`), sau prin generatoare de cod.

## Clasificarea adnotărilor după scop

1. **Adnotări pentru compilator** – sunt utilizate de compilator pentru verificări statice (`@Override`, `@SuppressWarnings`).
2. **Adnotări pentru runtime** – sunt disponibile în timpul execuției aplicației și pot fi analizate prin reflecție (`@Retention(RetentionPolicy.RUNTIME)`).
3. **Adnotări pentru instrumente externe** – sunt folosite de IDE-uri, generatoare de cod sau framework-uri (ex: `@Entity` în JPA, `@Controller` în Spring MVC).

## Exemple din practică

### Validare cu Bean Validation

```java
public class Student {
    @NotNull
    private String nume;

    @Min(18)
    private int varsta;
}
```

Framework-ul de validare va verifica automat respectarea constrângerilor specificate prin adnotări.

### Configurare în Spring Framework

```java
@RestController
@RequestMapping("/api")
public class SalutController {

    @GetMapping("/salut")
    public String salut() {
        return "Salut!";
    }
}
```

În exemplul de mai sus, adnotările determină comportamentul automat al aplicației web, fără a scrie cod suplimentar pentru configurare.

## Concluzii

Adnotările oferă o metodă declarativă și concisă de exprimare a comportamentului dorit în cadrul aplicațiilor Java. Ele sunt folosite atât în aplicațiile simple pentru claritate și validare, cât și în aplicațiile enterprise, unde joacă un rol esențial în framework-uri moderne precum Spring, Hibernate sau Jakarta EE.

---