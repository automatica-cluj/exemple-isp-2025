# Exerciții și întrebări - concepte OOP de baza

## 1. Clasa și Obiect
**Exercițiu:**
Creează o clasă `Masina` care are următoarele atribute: `marca`, `model`, `anFabricatie`. Adaugă un constructor pentru inițializarea atributelor și o metodă `afiseazaDetalii()` care afișează informațiile despre mașină. Instanțiază două obiecte de tip `Masina` și apelează metoda `afiseazaDetalii()`.

## 2. Constructori
**Întrebare:**
Ce caracteristici trebuie să respecte un constructor?

**Exercițiu:**
Extinde clasa `Masina` adăugând un constructor implicit care setează valori implicite pentru atribute.

## 3. Atribute
**Întrebare:**
Care este diferența dintre un atribut de instanță și un atribut static?

**Exercițiu:**
Adaugă un atribut static `numarTotalMasini` în clasa `Masina`, care contorizează câte instanțe au fost create. Incrementarea trebuie să se facă în constructor.

## 4. Metode
**Întrebare:**
Care este diferența dintre o metodă statică și o metodă de instanță?

**Exercițiu:**
Adaugă o metodă statică `getNumarTotalMasini()` care returnează numărul total de mașini create.

## 5. Convenții Java
**Întrebare:**
Care sunt regulile de numire a claselor, metodelor și atributelor în Java?

## 6. Cuvinte cheie
### `new`
**Întrebare:**
Ce se întâmplă la nivel de memorie atunci când se creează un obiect folosind `new`?

### `null`
**Întrebare:**
Ce se întâmplă dacă apelăm o metodă pe un obiect care este `null`?

**Exercițiu:**
Scrie un exemplu de cod care generează `NullPointerException`.

### `this`
**Exercițiu:**
Modifică constructorul clasei `Masina` astfel încât să folosească `this` pentru a face diferența între atribute și parametri.

### `static`
**Întrebare:**
De ce metodele statice nu pot accesa direct atributele de instanță?

### `final`
**Întrebare:**
Ce se întâmplă dacă un atribut este declarat `final`? Poate fi modificat după inițializare?

## 7. Principiul Încapsulării
**Întrebare:**
Ce beneficii oferă principiul încapsulării?

**Exercițiu:**
Modifică clasa `Masina` astfel încât atributele să fie private și oferă metode getter și setter pentru accesarea lor.

## 8. Supraîncărcarea Metodelor
**Întrebare:**
Cum determină Java care versiune a unei metode supraîncărcate trebuie apelată?

**Exercițiu:**
Adaugă în clasa `Masina` metode supraîncărcate `setDetalii()` care permit setarea atributelor folosind diferite combinații de parametri.

## 9. Compararea Obiectelor
**Întrebare:**
Care este diferența dintre `==` și `equals()` la compararea obiectelor?

**Exercițiu:**
Suprascrie metoda `equals()` în clasa `Masina` astfel încât două mașini să fie considerate egale dacă au aceeași marcă și model.

## 10. Specificatori de Acces
**Întrebare:**
Care sunt diferențele dintre `public`, `private`, `protected` și *default* în Java?

**Exercițiu:**
Creează o clasă `Vehicul` cu atribute `protected` și extinde-o în clasa `Masina`. Verifică dacă aceste atribute pot fi accesate din subclasa `Masina`.

## 11. Garbage Collector
**Întrebare:**
Ce rol are Garbage Collector în Java și cum poate fi apelat manual?

**Exercițiu:**
Scrie un program în care creezi și elimini mai multe obiecte pentru a observa comportamentul Garbage Collector-ului folosind `System.gc()`.

