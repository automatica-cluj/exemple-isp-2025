## Relația dintre algoritmii de planificare în timp real și mecanismele de planificare din Linux PREEMPT_RT

Planificarea în timp real (real-time scheduling) reprezintă un domeniu esențial în proiectarea sistemelor de calcul care trebuie să asigure respectarea unor constrângeri temporale stricte. Din perspectivă teoretică, algoritmii de planificare se clasifică în trei mari categorii: **statici**, **dinamici** și **hibrizi**, fiecare cu particularități privind modul de determinare a ordinii de execuție a sarcinilor.

### 1. Algoritmi de planificare în timp real

- **Algoritmii statici (off-line)** stabilesc ordinea de execuție înainte de rularea sistemului, pornind de la un set complet cunoscut de sarcini și caracteristicile lor temporale (perioadă, deadline, timp de execuție). Exemple clasice sunt *Rate Monotonic Scheduling (RMS)* și *Time-Triggered Scheduling (TTS)*. Aceste metode oferă predictibilitate maximă, dar flexibilitate redusă.
- **Algoritmii dinamici (on-line)** decid ordinea execuției în timpul rulării, în funcție de starea curentă a sistemului și de deadline-urile sarcinilor. Cel mai reprezentativ exemplu este *Earliest Deadline First (EDF)*, care ordonează sarcinile în funcție de apropierea deadline-ului. Aceste metode sunt mai flexibile, dar necesită mecanisme eficiente de preemțiune și prioritizare.
- **Algoritmii hibrizi** combină elemente din ambele categorii, rezervând resurse și priorități fixe pentru sarcini critice, în timp ce sarcinile mai puțin critice sunt planificate dinamic. Acest model este des întâlnit în aplicațiile mixte (de exemplu, sisteme embedded industriale).

------

### 2. Planificarea în Linux cu PREEMPT_RT

Patch-ul **PREEMPT_RT** transformă kernelul Linux într-un sistem aproape complet preemptibil, permițând o execuție predictibilă și timpi de răspuns reduși. Linux oferă mai multe politici de planificare care pot fi utilizate pentru sarcini în timp real:

- **SCHED_FIFO** – politică cu priorități fixe, fără time-slicing. Sarcinile rulează până cedează procesorul sau sunt întrerupte de o sarcină cu prioritate mai mare. Aceasta reflectă comportamentul algoritmilor statici precum RMS, dacă prioritățile sunt configurate corespunzător.
- **SCHED_RR** – similar cu SCHED_FIFO, dar adaugă un interval de timp (time quantum) pentru sarcinile de aceeași prioritate, implementând un mecanism Round-Robin.
- **SCHED_DEADLINE** – implementare practică a algoritmului *Earliest Deadline First (EDF)*. Fiecare sarcină este definită printr-un triplet de parametri *(runtime, deadline, period)*, iar kernelul asigură execuția conform acestor constrângeri, atâta timp cât condiția de schedulability este satisfăcută.

Astfel, **PREEMPT_RT** oferă o punte între teoria planificării în timp real și aplicabilitatea sa practică într-un sistem de operare general-purpose.

------

### 3. Corelarea modelelor teoretice cu politicile Linux

| Model teoretic    | Echivalent în Linux PREEMPT_RT             | Caracteristici principale                                    |
| ----------------- | ------------------------------------------ | ------------------------------------------------------------ |
| Static (RMS, TTS) | **SCHED_FIFO**                             | Priorități fixe, deterministe; planificare configurată off-line. |
| Dinamic (EDF)     | **SCHED_DEADLINE**                         | Decizii on-line, ordonate după deadline; parametri expliciți runtime/deadline. |
| Hibrid            | **Combinații SCHED_FIFO + SCHED_DEADLINE** | Sarcini critice sub FIFO, sarcini flexibile sub DEADLINE.    |

------

### 4. Verificarea algoritmilor de planificare disponibili în Linux

În Linux, politicile de planificare disponibile sunt determinate de kernelul curent și pot fi interogate din linia de comandă.
 Cele mai uzuale metode sunt:

#### a) Afișarea politicilor suportate de kernel

```bash
chrt --help
```

sau

```bash
chrt --list
```

Aceste comenzi vor afișa politicile disponibile, de exemplu:

```
SCHED_OTHER (0)
SCHED_BATCH (3)
SCHED_IDLE (5)
SCHED_FIFO (1)
SCHED_RR (2)
SCHED_DEADLINE (6)
```

Prezența lui **SCHED_DEADLINE** confirmă suportul pentru algoritmi dinamici de tip EDF.

#### b) Verificarea politicii de planificare pentru un proces

```bash
ps -eo pid,comm,policy
```

Rezultatul va afișa codurile numerice corespunzătoare politicilor:

- 0 – SCHED_OTHER
- 1 – SCHED_FIFO
- 2 – SCHED_RR
- 5 – SCHED_IDLE
- 6 – SCHED_DEADLINE

Pentru o vizualizare mai clară:

```bash
chrt -p <PID>
```

Aceasta arată politica curentă și prioritatea unui proces, de exemplu:

```
pid 1234's current scheduling policy: SCHED_FIFO
pid 1234's current scheduling priority: 70
```

#### c) Setarea sau testarea unei politici de planificare

Pentru testare, se poate crea un proces care rulează sub o anumită politică:

```bash
sudo chrt -f 70 ./aplicatie_rt
```

(specifică politica **SCHED_FIFO** cu prioritate 70).

------

### 5. Concluzie

Modelul PREEMPT_RT demonstrează aplicabilitatea practică a conceptelor teoretice din planificarea în timp real în cadrul unui kernel Linux.
 Instrumentele de linie de comandă precum `chrt` și `ps` permit identificarea și configurarea politicilor de planificare, facilitând analiza comportamentului temporal al sarcinilor și verificarea respectării constrângerilor de deadline.

Astfel, PREEMPT_RT nu este doar o extensie tehnică, ci o punte funcțională între teoria planificării în timp real și ingineria practică a sistemelor cu constrângeri temporale stricte.

