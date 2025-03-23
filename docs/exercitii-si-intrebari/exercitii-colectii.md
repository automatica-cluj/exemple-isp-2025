# Exerciții și Întrebări - Colecții în Java

## 1. Interfețe și Ierarhie

**Întrebare**: Care sunt principalele interfețe din framework-ul Java Collections și ce relație există între ele?

**Exercițiu**: Desenează manual o diagramă simplificată care să arate relația ierarhică între interfețele `Iterable`, `Collection`, `List`, `Set`, `Queue` și `Map`. Indică pentru fiecare interfață principala caracteristică care o diferențiază de celelalte.

## 2. ArrayList vs LinkedList

**Întrebare**: Care sunt diferențele principale între `ArrayList` și `LinkedList` din punct de vedere al performanței și al utilizării?

**Exercițiu**: Creează o clasă `PerformantaListe` care să conțină o metodă `main` unde să compari timpul de execuție pentru:
- Adăugarea a 100,000 de elemente la începutul listei
- Adăugarea a 100,000 de elemente la sfârșitul listei
- Accesarea aleatoare a 10,000 de elemente
  Efectuează aceste operații atât pentru `ArrayList` cât și pentru `LinkedList` și afișează rezultatele.

## 3. Seturi și Eliminarea Duplicatelor

**Întrebare**: De ce am folosi un `LinkedHashSet` în loc de un `HashSet` sau un `TreeSet`?

**Exercițiu**: Creează o metodă `eliminaDuplicate(List<String> lista)` care să primească o listă de cuvinte și să returneze o nouă colecție care conține cuvintele unice în ordinea primei lor apariții în lista originală. Implementează metoda în două moduri: folosind `LinkedHashSet` și folosind `ArrayList` cu verificări manuale.

## 4. Maps și Procesarea Datelor

**Întrebare**: Ce diferențe există între `HashMap`, `LinkedHashMap` și `TreeMap` din punct de vedere al performanței și garanțiilor de ordonare?

**Exercițiu**: Creează o clasă `AnalizatorText` care să proceseze un text (String) și să numere frecvența fiecărui cuvânt. Implementează o metodă `afiseazaTopCuvinte(int n)` care să afișeze cele mai frecvente n cuvinte din text, în ordine descrescătoare a frecvenței. Folosește o structură de tip Map pentru a stoca frecvențele.

## 5. Queue și Stack

**Întrebare**: Care este diferența între interfețele `Queue` și `Deque` în Java și ce implementări concrete ale acestora cunoști?

**Exercițiu**: Implementează o clasă `VerificatorParanteze` care să verifice dacă într-un șir de caractere parantezele sunt corect închise (fiecare paranteză deschisă are o paranteză închisă corespunzătoare în ordine corectă). De exemplu, șirul "((()))" este valid, dar "(()" nu este valid. Folosește o structură de tip Stack pentru implementare.

## 6. Comparare și Sortare

**Întrebare**: Explică diferența dintre interfețele `Comparable` și `Comparator` în Java. În ce situații ai folosi pe fiecare dintre ele?

**Exercițiu**: Creează o clasă `Produs` cu atributele `nume`, `pret` și `categorie`. Implementează interfața `Comparable` astfel încât produsele să fie sortate implicit după preț. Apoi, creează un `Comparator` separat care să sorteze produsele după categorie și apoi după nume. Demonstrează utilizarea ambelor metode de sortare într-o metodă `main`.

## 7. Operații pe Stream-uri

**Întrebare**: Care sunt avantajele utilizării Stream API în Java 8+ față de metodele tradiționale de procesare a colecțiilor?

**Exercițiu**: Având o listă de obiecte `Student` cu atributele `nume`, `varsta` și `nota`, folosește Stream API pentru a:
- Filtra studenții cu note peste 8
- Grupa studenții după vârstă
- Calcula media notelor pentru fiecare grupă de vârstă
- Afișa rezultatele sortate după vârstă

## 8. Colecții Imutabile și Thread-Safe

**Întrebare**: De ce și când ar trebui să folosim colecții imutabile sau colecții thread-safe?

**Exercițiu**: Creează un exemplu de clasă `RegistruUtilizatori` care menține o listă de utilizatori. Implementează metode pentru adăugarea și obținerea utilizatorilor, asigurându-te că lista internă nu poate fi modificată direct din exterior (folosind colecții imutabile). Apoi, modifică implementarea pentru a o face thread-safe.

## 9. Performanță și Alegerea Colecției Potrivite

**Întrebare**: Care sunt criteriile principale de care ții cont când alegi tipul de colecție pentru o anumită problemă?

**Exercițiu**: Pentru fiecare dintre următoarele scenarii, specifică ce implementare de colecție ai alege și explică motivul:
a) Un cache care memorează cele mai recente 100 de interogări către o bază de date
b) Stocarea elementelor unice dintr-un flux de date, cu necesitatea de a verifica frecvent dacă un element există deja
c) Menținerea unei liste de evenimente cronologice cu posibilitatea de a adăuga noi evenimente doar la final
d) Un dicționar de cuvinte care trebuie să afișeze cuvintele în ordine alfabetică

## 10. Colecții Generice

**Întrebare**: Care sunt avantajele utilizării colecțiilor generice (`List<String>`) față de colecțiile raw (`List`)?

**Exercițiu**: Creează o clasă generică `Pereche<K, V>` care stochează două valori de tipuri potențial diferite. Implementează metodele `getFirst()`, `getSecond()`, `setFirst()` și `setSecond()`. Apoi, implementează o metodă statică generică `swap` care primește o `Pereche<K, V>` și returnează o `Pereche<V, K>` cu valorile inversate.

## 11. Exercițiu Complet - Sistem de Gestionare a Bibliotecii

Creează un sistem simplu de gestionare a unei biblioteci cu următoarele funcționalități:

1. Clasa `Carte` cu atributele: `id`, `titlu`, `autor`, `anPublicare`, `genLiterar`
2. Clasa `Biblioteca` care gestionează o colecție de cărți și oferă următoarele operațiuni:
    - Adăugarea unei cărți
    - Căutarea cărților după titlu sau autor (returnând o listă de potriviri)
    - Împrumutarea unei cărți (marcarea ca împrumutată)
    - Returnarea unei cărți
    - Afișarea tuturor cărților disponibile
    - Afișarea cărților grupate după gen literar
    - Afișarea celor mai populare cărți (bazat pe numărul de împrumuturi)

Implementează acest sistem folosind colecțiile Java potrivite pentru fiecare funcționalitate, ținând cont de eficiența operațiilor.

## 12. Exercițiu Practic - Analizor de Log-uri

Creează un program care să analizeze un fișier de log-uri (pe care îl poți simula printr-un String mare). Fiecare linie de log are formatul:
```
[NIVEL] TIMESTAMP IP_ADRESA: MESAJ
```

Unde NIVEL poate fi: INFO, WARNING, ERROR sau CRITICAL.

Implementează următoarele funcționalități:
1. Parsarea log-ului și stocarea într-o structură de date adecvată
2. Filtrarea log-urilor după nivel
3. Căutarea log-urilor care conțin un anumit text în mesaj
4. Afișarea numărului de log-uri pentru fiecare nivel
5. Identificarea adreselor IP care au generat cele mai multe erori (ERROR sau CRITICAL)
6. Afișarea cronologică a log-urilor pentru o anumită adresă IP

Folosește colecțiile Java potrivite pentru fiecare din cerințele de mai sus.