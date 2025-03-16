# Exerciții și întrebări pentru validarea cunoștințelor avansate Java

## 1. Enum
**Întrebare:**
Care sunt principalele avantaje ale utilizării enum-urilor în comparație cu utilizarea constantelor statice (static final) în Java?

**Exercițiu:**
Creează un enum `Anotimp` care conține cele patru anotimpuri. Adaugă pentru fiecare anotimp un atribut pentru temperatura medie și o metodă pentru a determina dacă este un anotimp cald sau rece. Apoi, scrie un program care parcurge toate valorile enum-ului și afișează detaliile despre fiecare anotimp.

## 2. Clase Abstracte
**Întrebare:**
Care este diferența fundamentală între o clasă abstractă și o interfață în Java? În ce situații ai prefera utilizarea unei clase abstracte?

**Exercițiu:**
Creează o clasă abstractă `InstrumentMuzical` care conține un atribut protejat pentru nume, un constructor, o metodă abstractă `canta()` și o metodă concretă `descriere()`. Apoi, creează cel puțin două clase concrete care extind această clasă abstractă: `Chitara` și `Pian`. Implementează metodele necesare și adaugă atribute și metode specifice fiecărui instrument.

## 3. Interfețe
**Întrebare:**
De ce este utilă declararea și implementarea mai multor interfețe pentru aceeași clasă? Dă un exemplu de situație reală în care această abordare este benefică.

**Exercițiu:**
Creează două interfețe: `Innotator` și `Alergator`. Interfața `Innotator` ar trebui să aibă o metodă `inoata()`, iar interfața `Alergator` ar trebui să aibă o metodă `alearga()`. Apoi, creează cel puțin două clase care implementează ambele interfețe (de exemplu, `Sportiv` și `Animal`) și o clasă care implementează doar una dintre ele. Demonstrează utilizarea polimorfismului cu aceste interfețe.

## 4. Interfețe Funcționale
**Întrebare:**
Ce este o interfață funcțională și care este legătura dintre interfețele funcționale și expresiile lambda în Java?

**Exercițiu:**
Definește o interfață funcțională proprie numită `Procesor` care conține o metodă `proceseaza` ce primește un String și returnează un alt String. Apoi, utilizează această interfață funcțională cu expresii lambda pentru a implementa cel puțin trei procesări diferite (de exemplu, conversie la majuscule, inversare de text, eliminare spații). Demonstrează utilizarea acestor procesări pe câteva exemple de texte.

## 5. Metode Default
**Întrebare:**
Care a fost necesitatea introducerii metodelor default în interfețe începând cu Java 8? Ce problemă rezolvă acestea?

**Exercițiu:**
Creează o interfață `Media` cu o metodă abstractă `calculeazaMedia(int[] numere)` și o metodă default `afiseazaRezultat(int[] numere)` care calculează media folosind metoda abstractă și apoi afișează rezultatul formatat. Implementează această interfață în cel puțin două clase diferite, una care calculează media aritmetică și una care calculează media geometrică. Apoi, suprascrie metoda default într-una din implementări pentru a personaliza formatul de afișare.

## 6. Metode Statice în Interfețe
**Întrebare:**
Care este diferența dintre metodele statice din interfețe și metodele statice din clase? Cum sunt accesate metodele statice din interfețe?

**Exercițiu:**
Creează o interfață `Conversie` care conține metode statice utilitare pentru convertirea între diferite unități de măsură (de exemplu, `celsiusToFahrenheit`, `kilometersToMiles`, `kilogramsToPounds`). Adaugă apoi o metodă abstractă `converteste(double valoare)` și implementează această interfață în mai multe clase pentru conversii specifice. Demonstrează utilizarea atât a metodelor statice, cât și a celor de instanță.

## 7. Clase Interne Statice
**Întrebare:**
Care sunt avantajele utilizării unei clase interne statice în comparație cu o clasă de nivel superior (top-level class)?

**Exercițiu:**
Creează o clasă `ListaGenerica` care implementează o listă simplă. În interiorul acestei clase, definește o clasă internă statică `Element` care reprezintă un element din listă. Apoi, adaugă metode în clasa `ListaGenerica` pentru adăugarea, eliminarea și afișarea elementelor, utilizând clasa internă statică. Demonstrează utilizarea acestei implementări.

## 8. Clase Interne de Instanță
**Întrebare:**
Care este diferența principală între o clasă internă statică și o clasă internă de instanță? Ce tip de acces au clasele interne de instanță la membrii clasei exterioare?

**Exercițiu:**
Creează o clasă `MasinaHibrid` care are atribute pentru nivelul bateriei și nivelul combustibilului. În interiorul acestei clase, definește o clasă internă de instanță `SistemHibrid` care gestionează funcționarea mașinii și are acces la atributele mașinii. Adaugă metode pentru pornirea și oprirea mașinii, accelerare, frânare, etc., demonstrând cum clasa internă interacționează cu membrii clasei exterioare.

## 9. Clase Interne Locale
**Întrebare:**
Ce restricții au clasele interne locale în comparație cu alte tipuri de clase interne? Ce tip de variabile locale pot fi accesate din cadrul unei clase interne locale?

**Exercițiu:**
Creează o clasă `Generator` care are o metodă `genereazaRaport(String tipRaport, int zile)`. În interiorul acestei metode, definește o clasă internă locală `Raport` care implementează logica pentru generarea raportului în funcție de parametrii primiți. Demonstrează cum această clasă locală accesează parametrii metodei și membrii clasei exterioare.

## 10. Clase Interne Anonime
**Întrebare:**
Care este diferența dintre o clasă internă anonimă și o expresie lambda? În ce situații este preferabilă utilizarea uneia față de cealaltă?

**Exercițiu:**
Creează o interfață `Predicat` cu o metodă `testeaza(Object obj)` care returnează un boolean. Apoi, utilizează o clasă internă anonimă pentru a implementa această interfață și a testa dacă un număr este prim. Implementează aceeași funcționalitate folosind o expresie lambda și compară cele două abordări. Demonstrează utilizarea acestor implementări pentru a filtra o listă de numere.

## 11. Exercițiu Complex
Creează o mică aplicație de gestionare a unei biblioteci care să demonstreze utilizarea conceptelor avansate discutate:

1. Utilizează un enum `CategorieCarti` pentru a defini categoriile de cărți disponibile
2. Creează o clasă abstractă `Publicatie` de la care să derive clasele `Carte` și `Revista`
3. Definește interfața `Imprumutabil` cu metodele necesare pentru împrumut și returnare
4. Adaugă o interfață funcțională `Cautare` pentru căutarea publicațiilor după diferite criterii
5. Implementează clase interne statice și de instanță pentru gestionarea detaliilor specifice
6. Utilizează clase interne locale și anonime pentru implementarea logicii de sortare și filtrare
7. Adaugă metode default și statice în interfețe pentru funcționalități comune

Demonstrează funcționarea aplicației printr-o clasă `BibliotecaDemo` cu o metodă `main`.

