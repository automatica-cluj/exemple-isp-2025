# Introducere în Algoritmii de Planificare pentru Sisteme de Timp Real

## Ce sunt sistemele de timp real?

Sistemele de timp real sunt sisteme computaționale în care **corectitudinea** unui rezultat depinde nu doar de **valorile calculate**, ci și de **momentul în care** acestea sunt produse. În astfel de sisteme, întârzierea în livrarea unui rezultat poate avea consecințe grave, de la degradarea performanței până la erori catastrofale.

### Exemple de sisteme de timp real

- **Sisteme de control industrial** - controlul proceselor chimice, fabrici automatizate
- **Sisteme automotive** - frânare ABS, airbag-uri, control motor
- **Sisteme medicale** - monitorizare pacienți, echipament de suport vital
- **Sisteme aerospațiale** - controlul zborului, navigație
- **Sisteme multimedia** - streaming video/audio, jocuri video

## Concepte fundamentale

### Taskuri (Tasks)

Un **task** (sau proces) reprezintă o unitate de lucru care trebuie executată de sistem. Fiecare task are mai multe caracteristici importante:

- **Timp de execuție (C)** - timpul necesar pentru a finaliza taskul
- **Perioadă (T)** - pentru taskuri periodice, intervalul de timp între activări succesive
- **Deadline (D)** - momentul maxim până la care taskul trebuie finalizat
- **Prioritate** - importanța relativă a taskului față de alte taskuri

### Tipuri de taskuri

**Taskuri periodice:**
- Se activează la intervale regulate de timp
- Exemplu: citirea senzorilor la fiecare 10ms

**Taskuri aperiodice:**
- Se activează la momente nepredictibile
- Exemplu: procesarea unui eveniment de urgență

**Taskuri sporadice:**
- Similare cu cele aperiodice, dar cu un interval minim garantat între activări

### Planificabilitate (Schedulability)

Un sistem este **planificabil** dacă toate taskurile sale pot fi executate respectând deadline-urile stabilite. Testele de planificabilitate verifică matematic dacă un set de taskuri poate fi planificat cu succes.

### Utilizarea CPU

**Utilizarea CPU** (U) măsoară fracțiunea de timp în care procesorul este ocupat:

$$U = \sum_{i=1}^{n} \frac{C_i}{T_i}$$

Unde **Cᵢ** este timpul de execuție și **Tᵢ** este perioada taskului i.

- **U < 1** (100%) înseamnă că există timp liber
- **U = 1** înseamnă că CPU-ul este utilizat complet
- **U > 1** înseamnă că sistemul este supraîncărcat (imposibil de planificat)

## Clasificarea algoritmilor de planificare

### 1. Algoritmi cu prioritate statică

Prioritatea fiecărui task este **atribuită o singură dată** și rămâne constantă pe toată durata execuției.

**Avantaje:**
- Implementare simplă
- Overhead redus
- Predictibilitate ridicată

**Dezavantaje:**
- Inflexibilitate
- Utilizare suboptimală a CPU (max ~69%)
- Nu gestionează bine taskurile aperiodice

**Exemple:**
- Rate Monotonic Scheduling (RMS)
- Deadline Monotonic Scheduling (DMS)

### 2. Algoritmi cu prioritate dinamică

Prioritatea taskurilor se **recalculează în timpul execuției** în funcție de starea curentă a sistemului.

**Avantaje:**
- Utilizare optimă a CPU (până la 100%)
- Flexibilitate mare
- Gestionează eficient taskuri aperiodice

**Dezavantaje:**
- Implementare mai complexă
- Overhead mai mare
- Mai greu de analizat teoretic

**Exemple:**
- Earliest Deadline First (EDF)
- Least Laxity First (LLF)

### 3. Algoritmi híbrizi

Combină **principiile algoritmilor statici și dinamici** pentru a obține un echilibru între performanță și overhead.

**Avantaje:**
- Balans între optimalitate și complexitate
- Adaptabilitate la diverse scenarii
- Potrivit pentru sisteme reale complexe

**Dezavantaje:**
- Complexitate de configurare
- Necesită ajustare fină a parametrilor

**Exemple:**
- Maximum Urgency First (MUF)
- Hierarchical scheduling

## Preempțiune (Preemption)

**Preempțiunea** este capacitatea unui task cu prioritate mai mare de a **întrerupe** execuția unui task cu prioritate mai joasă.

- **Sisteme preemptive** - permit întreruperea taskurilor (mai flexibile)
- **Sisteme non-preemptive** - taskurile rulează până la finalizare (mai simple)

Majoritatea algoritmilor moderni de timp real folosesc **preempțiune** pentru a asigura respectarea deadline-urilor.

## Alegerea algoritmului potrivit

### Când să folosim algoritmi statici (RMS/DMS)?

- Sistem cu taskuri **exclusiv periodice**
- **Simplitate** și **predictibilitate** sunt prioritare
- Resurse hardware **limitate** (overhead mic)
- Certificare necesară (mai ușor de verificat formal)

### Când să folosim algoritmi dinamici (EDF/LLF)?

- Sistem cu taskuri **periodice și aperiodice**
- **Utilizare maximă** a CPU este critică
- Deadline-urile sunt **variate** și nu corespund perioadelor
- Sistem cu resurse de calcul suficiente

### Când să folosim algoritmi híbrizi (MUF)?

- Sisteme **complexe** cu cerințe mixte
- Combinație de taskuri **critice periodice** și **evenimente neprevăzute**
- Balanță între **performanță** și **overhead**
- Aplicații industriale reale

## Evoluția algoritmilor de planificare

```
Sisteme simple          Sisteme moderne          Sisteme complexe
    (1970s)                 (1980s-90s)              (2000s+)
       │                        │                        │
       ├─> RMS                  ├─> EDF                 ├─> MUF
       │   (prioritate          │   (deadline            │   (hibrid)
       │    pe perioadă)        │    dinamic)            │
       │                        │                        │
       └─> DMS ────────────────>└─> LLF                 └─> Hierarchical
           (prioritate              (laxitate                 scheduling
            pe deadline)             dinamică)
```

## Concluzie

Algoritmii de planificare pentru sisteme de timp real reprezintă un domeniu fundamental în informatica industrială și embedded. **Nu există un algoritm universal optim** - alegerea depinde de:

- Natura taskurilor (periodice, aperiodice, mixte)
- Cerințele de utilizare CPU
- Complexitatea acceptabilă a implementării
- Constrângerile hardware
- Cerințele de certificare

Înțelegerea profundă a diferențelor dintre algoritmi permite designul de sisteme de timp real **eficiente**, **predictibile** și **sigure**.
