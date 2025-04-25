# Exerciții și întrebări - concepte avansate

## 1. Agregarea și Compoziția
**Întrebare:**
Care este diferența fundamentală între agregare și compoziție? Oferiți un exemplu din viața reală pentru fiecare.

**Exercițiu:**
Implementați două seturi de clase pentru a demonstra:
1. O relație de agregare între `Universitate` și `Profesor`
2. O relație de compoziție între `Calculator` și `Procesor`

Asigurați-vă că implementarea respectă caracteristicile specifice fiecărui tip de relație.

## 2. Moștenirea
**Întrebare:**
De ce este considerată moștenirea un mecanism important în programarea orientată pe obiecte? Care sunt limitările moștenirii în Java față de alte limbaje?

**Exercițiu:**
Creați o ierarhie de clase pentru a modela figuri geometrice. Implementați o clasă de bază `FiguraGeometrica` și cel puțin trei clase derivate (`Cerc`, `Dreptunghi`, `Triunghi`). Clasa de bază trebuie să conțină metode pentru calculul ariei și perimetrului, iar clasele derivate trebuie să suprascrie aceste metode corespunzător.

## 3. Clasa de Bază și Clasa Derivată
**Întrebare:**
Ce atribute și metode ale clasei de bază sunt accesibile în clasa derivată? Cum influențează specificatorii de acces această moștenire?

**Exercițiu:**
Creați o clasă de bază `Vehicul` cu atribute private, protected și publice. Apoi creați o clasă derivată `Avion` și demonstrați ce atribute și metode sunt accesibile în clasa derivată. Includeți comentarii pentru a explica de ce anumite elemente sunt sau nu sunt accesibile.

## 4. Polimorfismul
**Întrebare:**
Comparați polimorfismul static (la compilare) cu polimorfismul dinamic (la rulare). Când este preferabil să utilizați fiecare tip?

**Exercițiu:**
Implementați un sistem de procesare a plăților cu o interfață `Platibil` și mai multe clase care o implementează (`CardCredit`, `CardDebit`, `Transfer`, `CashOnDelivery`). Creați o clasă `ProcesatorPlati` care poate procesa orice tip de plată și arată cum funcționează polimorfismul dinamic.

## 5. Suprascrierea Metodelor
**Întrebare:**
Care sunt regulile pe care trebuie să le respectați când suprascrieți o metodă? Ce se întâmplă dacă modificați tipul de retur al metodei suprascrise?

**Exercițiu:**
Creați o clasă `Animal` cu o metodă `seCauta()` care returnează un String. Apoi creați o clasă derivată `Caine` care suprascrie această metodă, dar returnează un obiect de tip `Caine`. Demonstrați că covariant return type funcționează corect.

## 6. Cuvântul Cheie super
**Întrebare:**
Care sunt cele două utilizări principale ale cuvântului cheie `super` și de ce este important să fie utilizat corect?

**Exercițiu:**
Creați o clasă `Dispozitiv` cu un constructor care inițializează mai multe câmpuri și o metodă `porneste()`. Apoi, implementați o clasă derivată `Telefon` care:
1. Utilizează `super` pentru a apela constructorul clasei de bază
2. Suprascrie metoda `porneste()` astfel încât să apeleze implementarea din clasa de bază și apoi să adauge comportamente specifice telefonului

## 7. Cuvântul Cheie final
**Întrebare:**
Explicați care sunt implicațiile utilizării cuvântului cheie `final` în fiecare din următoarele contexte: clasa finală, metodă finală, atribut final.

**Exercițiu:**
Implementați o clasă `SistemSecurizat` care conține:
1. Un atribut final pentru stocarea unei chei de securitate
2. O metodă finală pentru verificarea autentificării
3. Apoi încercați să creați o clasă derivată care extinde `SistemSecurizat` și încearcă să suprascrie metoda finală. Comentați codul care nu compilează și explicați de ce.

## 8. Cuvântul Cheie extends
**Întrebare:**
În afară de relația de moștenire între clase, în ce alte contexte poate fi utilizat cuvântul cheie `extends` în Java?

**Exercițiu:**
Implementați un exemplu de clasă generică care utilizează cuvântul cheie `extends` pentru a restricționa tipul generic. De exemplu, creați o clasă `Colectie<T extends Comparable<T>>` care poate sorta elementele sale.

## 9. Clasa Object
**Întrebare:**
De ce este important să suprascriem metodele `equals()` și `hashCode()` din clasa `Object`? Ce se poate întâmpla dacă suprascriți doar una dintre ele?

**Exercițiu:**
Creați o clasă `Carte` cu atributele `titlu`, `autor` și `isbn`. Suprascrieți metodele `equals()`, `hashCode()` și `toString()` astfel încât două cărți să fie considerate egale dacă au același ISBN. Testați implementarea în cadrul unei colecții de tip `HashSet`.

## 10. Conversii de Tip
**Întrebare:**
Care este diferența între upcasting și downcasting? În ce situații este necesară verificarea tipului înainte de conversie?

**Exercițiu:**
Implementați o metodă `proceseazaObiecte(Object[] obiecte)` care primește un array de obiecte și le procesează diferit în funcție de tipul lor real. Includeți cel puțin trei tipuri diferite de obiecte și utilizați operatorul `instanceof` pentru a verifica tipul fiecărui obiect înainte de downcasting.

## 11. Exercițiu Complex
Creați un mic sistem de gestionare a angajaților care să demonstreze toate conceptele avansate de OOP discutate. Sistemul ar trebui să includă:

1. O ierarhie de clase pentru diferite tipuri de angajați (ex: `Angajat` -> `Manager`, `Programator`, `Contabil`)
2. Relații de agregare și compoziție între clase (ex: `Departament` agregă `Angajat`, `Angajat` are o compoziție cu `ContractMunca`)
3. Polimorfism la compilare și la rulare
4. Metode suprascrise cu implementare corespunzătoare
5. Utilizarea cuvintelor cheie `super`, `final` și `extends`
6. Suprascriere corectă a metodelor din clasa `Object`
7. Conversii de tip sigure folosind `instanceof`

Implementați o metodă `main()` pentru a demonstra funcționarea sistemului și a evidenția cum sunt utilizate conceptele avansate de OOP.