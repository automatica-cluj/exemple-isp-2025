# Introducere în Șabloanele de Proiectare

## Ce sunt Șabloanele de Proiectare?

Șabloanele de proiectare (Design Patterns) reprezintă soluții general acceptate pentru probleme frecvent întâlnite în proiectarea software. Acestea sunt descrieri sau modele pentru rezolvarea problemelor care pot apărea în mod repetat în diferite contexte.

Conceptul de șabloane de proiectare a fost popularizat de cartea "*Design Patterns: Elements of Reusable Object-Oriented Software*" publicată în 1994 de cei patru autori: Erich Gamma, Richard Helm, Ralph Johnson și John Vlissides, cunoscuți în comunitatea de dezvoltare software ca "Gang of Four" (GoF).

## De ce sunt importante Șabloanele de Proiectare?

Șabloanele de proiectare oferă următoarele avantaje:

1. **Reutilizare**: Oferă soluții testate și dovedite pentru probleme comune
2. **Vocabular comun**: Permit dezvoltatorilor să comunice eficient despre arhitectura software
3. **Abstractizare**: Oferă un nivel superior de gândire despre problema de proiectare
4. **Flexibilitate**: Promovează un cod ușor de întreținut și extins
5. **Evitarea problemelor**: Ajută la evitarea problemelor care ar putea să nu fie evidente până târziu în procesul de dezvoltare

## Categorii de Șabloane conform Gang of Four

Gang of Four a clasificat 23 de șabloane de proiectare în trei categorii principale:

### 1. Șabloane Creaționale (Creational Patterns)

Acestea se ocupă cu mecanismele de creare a obiectelor, încercând să creeze obiecte într-un mod adecvat situației.

* **Singleton**: Asigură că o clasă are o singură instanță și oferă un punct global de acces la aceasta
* **Factory Method**: Definește o interfață pentru crearea unui obiect, dar lasă subclasele să decidă ce clasă să instanțieze
* **Abstract Factory**: Oferă o interfață pentru crearea familiilor de obiecte înrudite sau dependente fără a specifica clasele lor concrete
* **Builder**: Separă construcția unui obiect complex de reprezentarea sa
* **Prototype**: Specifică tipurile de obiecte care urmează să fie create folosind o instanță prototip și creează obiecte noi prin clonarea acestui prototip

### 2. Șabloane Structurale (Structural Patterns)

Acestea se ocupă cu compoziția claselor și a obiectelor pentru a forma structuri mai mari.

* **Adapter**: Permite ca interfețele incompatibile să lucreze împreună
* **Bridge**: Separă o abstracție de implementarea sa pentru a putea varia independent
* **Composite**: Compune obiecte în structuri de tip arbore pentru a reprezenta ierarhii parte-întreg
* **Decorator**: Adaugă responsabilități suplimentare unui obiect în mod dinamic
* **Facade**: Oferă o interfață unificată pentru un set de interfețe dintr-un subsistem
* **Flyweight**: Utilizează partajarea pentru a suporta un număr mare de obiecte de granuație fină în mod eficient
* **Proxy**: Furnizează un substitut sau un locțiitor pentru un alt obiect pentru a controla accesul la acesta

### 3. Șabloane Comportamentale (Behavioral Patterns)

Acestea sunt preocupate de algoritmii și atribuirea responsabilităților între obiecte.

* **Chain of Responsibility**: Trece o cerere de-a lungul unui lanț de manipulanți
* **Command**: Încapsulează o cerere ca un obiect
* **Interpreter**: Definește o reprezentare gramaticală și un interpret pentru limbaj
* **Iterator**: Oferă o modalitate de a accesa secvențial elementele unui obiect agregat
* **Mediator**: Definește un obiect care încapsulează modul în care un set de obiecte interacționează
* **Memento**: Capturează și externalizează starea internă a unui obiect fără a încălca încapsularea
* **Observer**: Definește o dependență un-la-mulți între obiecte
* **State**: Permite unui obiect să-și schimbe comportamentul când starea sa internă se schimbă
* **Strategy**: Definește o familie de algoritmi și îi face interschimbabili
* **Template Method**: Definește scheletul unui algoritm, lăsând unele etape să fie implementate de subclase
* **Visitor**: Reprezintă o operație care urmează să fie efectuată pe elementele unei structuri de obiecte

## Cum să utilizezi Șabloanele de Proiectare

Pentru a utiliza eficient șabloanele de proiectare:

1. **Înțelege problema**: Înainte de a aplica un șablon, asigură-te că ai înțeles problema pe care încerci să o rezolvi
2. **Selectează șablonul potrivit**: Evaluează diferite șabloane și alege-l pe cel care se potrivește cel mai bine contextului
3. **Adaptează la nevoi**: Șabloanele sunt ghiduri, nu soluții rigide; adaptează-le la cerințele specifice
4. **Nu forța utilizarea**: Nu încerca să potrivești o problemă într-un șablon doar pentru a folosi acel șablon
5. **Combină șabloane**: Șabloanele pot fi combinate pentru a rezolva probleme complexe

## Exempele de utilizare a șabloanelor

Pentru a ilustra utilizarea șabloanelor de proiectare, iată câteva exemple:
[proiect sabloande de proiectare.](../../sample-1)


## Critici și considerații

Deși extrem de valoroase, șabloanele de proiectare au primit și critici:

1. **Complexitate**: Pot adăuga complexitate inutilă în probleme simple
2. **Suprautilizare**: Utilizarea de șabloane acolo unde soluții mai simple ar fi suficiente
3. **Dependență de limbaj**: Unele șabloane sunt mai relevante în anumite limbaje de programare

## Concluzie

Șabloanele de proiectare, așa cum au fost descrise de Gang of Four, reprezintă un instrument valoros în arsenalul oricărui dezvoltator software. Ele oferă un vocabular și o abordare structurată pentru rezolvarea problemelor comune de proiectare. Cu toate acestea, ele ar trebui utilizate judicios, ținând cont de contextul specific al problemei și de compromisurile implicate.

Așa cum au subliniat autorii Gang of Four: "Șabloanele de proiectare nu sunt despre soluții elegante sau sofisticate, ci despre soluții practice și testate în timp."