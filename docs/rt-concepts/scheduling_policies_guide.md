# Ghid Linux Scheduling Policies

## Cuprins
- [Prezentare generală](#prezentare-generală)
- [Politici de planificare](#politici-de-planificare)
    - [SCHED_OTHER (CFS)](#sched_other-cfs)
    - [SCHED_FIFO](#sched_fifo)
    - [SCHED_RR](#sched_rr)
    - [SCHED_BATCH](#sched_batch)
    - [SCHED_IDLE](#sched_idle)
- [Intervale de prioritate](#intervale-de-prioritate)
- [Tabel comparativ](#tabel-comparativ)
- [Utilizare API](#utilizare-api)
- [Cerințe și permisiuni (CAP_SYS_NICE)](#cerințe-și-permisiuni-cap_sys_nice)

---

## Prezentare generală

Linux oferă mai multe politici de planificare pentru a gestiona diferite tipuri de sarcini de lucru. Înțelegerea acestor politici este crucială pentru construirea sistemelor real-time unde execuția previzibilă a sarcinilor este necesară.

**Două categorii principale:**

1. **Planificarea normală** - Time-sharing pentru procese obișnuite (SCHED_OTHER, SCHED_BATCH, SCHED_IDLE)
2. **Planificarea Real-time** - Planificare bazată pe prioritate cu preempție (SCHED_FIFO, SCHED_RR)

```
┌─────────────────────────────────────────────────────────┐
│      Arhitectura Linux Scheduler                        │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Politici Real-time (Prioritate 1-99)                 │
│  ┌─────────────────────────────────────────────────┐  │
│  │ SCHED_FIFO: Se execută până la yielding/blocare │  │
│  │ SCHED_RR:   Se execută până la expirarea kuantei│  │
│  └─────────────────────────────────────────────────┘  │
│                     ▲                                  │
│                     │ Prioritate mai mare preemptează│
│                     │                                  │
│  Politici normale (Prioritate 0)                      │
│  ┌─────────────────────────────────────────────────┐  │
│  │ SCHED_OTHER: Planificare CFS echitabilă         │  │
│  │ SCHED_BATCH: Joburi batch non-interactive       │  │
│  │ SCHED_IDLE:  Doar taskuri de background         │  │
│  └─────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

---

## Politici de planificare

### SCHED_OTHER (CFS)

**Tip:** Normal, time-sharing  
**Prioritate:** Întotdeauna 0 (niceness controlează pondere: -20 la +19)  
**Algoritm:** Completely Fair Scheduler (CFS)

#### Cum funcționează

- Politica implicită pentru 99% din procese
- Utilizează urmărirea runtime-ului virtual pentru a asigura echitate
- Fără priorități statice - niceness afectează pondere de timp
- Preemptibilă de orice task real-time
- Optimizată pentru sarcini interactive și de throughput

#### Caracteristici

```
Alocare timp:     Partajare echitabilă pe bază de valoare nice
Preempție:        De către taskuri RT, sau după expirarea time slice
Latență:          Variabilă (20-200 µs tipic, poate crește sub sarcină)
Caz de utilizare: Aplicații desktop, servere, procesare batch
```

#### Când să o utilizezi

- Aplicații general-purpose
- Servere web, baze de date
- Programe interactive cu utilizatorul
- Orice sarcină non-real-time

#### Exemplu cod

```c
// SCHED_OTHER este politica implicită - nu e nevoie de setup special
// Pentru a o seta explicit:
struct sched_param param;
param.sched_priority = 0;  // Trebuie să fie 0 pentru SCHED_OTHER
sched_setscheduler(0, SCHED_OTHER, &param);
```

---

### SCHED_FIFO

**Tip:** Real-time, FIFO (First-In-First-Out)  
**Prioritate:** 1-99 (număr mai mare = prioritate mai mare)  
**Algoritm:** Planificare preemptivă bazată pe prioritate strictă

#### Cum funcționează

- Task se execută până când:
    - Se yielduiește voluntar (sched_yield())
    - Se blochează la I/O sau sincronizare
    - Este preemtat de task RT cu prioritate mai mare
- **Fără time slicing** - poate monopoliza CPU la nesfârșit!
- Taskurile cu prioritate mai mare preemptează întotdeauna pe cele cu prioritate mai mică
- Taskurile cu aceeași prioritate se execută în ordine FIFO

#### Caracteristici

```
Alocare timp:     Nelimitată până la yielding/blocare
Preempție:        Doar de taskuri RT cu prioritate mai mare
Latență:          Foarte scăzută (< 100 µs), deterministă
Caz de utilizare: Taskuri hard real-time, control loops
```

#### Diagramă comportament task

```
Prioritate 90: [████████████████] (se execută continuu)
Prioritate 50: [așteptare...]
Prioritate 10: [așteptare...]
             └─> Priorități mai mici blocate până ce P90 yield
```

#### Când să o utilizezi

- Bucle de control hard real-time
- Achiziție date senzor
- Taskuri safety-critical cu deadline-uri
- Taskuri care necesită timp de răspuns garantat

#### Exemplu cod

```c
struct sched_param param;
param.sched_priority = 80;  // 1-99, de obicei folosiți 50-90

if (sched_setscheduler(0, SCHED_FIFO, &param) != 0) {
    perror("sched_setscheduler");
    // Necesită CAP_SYS_NICE sau root
}
```

#### Avertisment de siguranță

```
⚠️  PERICOL: SCHED_FIFO fără yield poate bloca sistemul!
    Includeți întotdeauna sleep/yield în taskuri FIFO
    Mențineti prioritate < 99 (kernel folosește 99)
    Testați cu priorități mai mici la început
```

---

### SCHED_RR

**Tip:** Real-time, Round-Robin  
**Prioritate:** 1-99 (număr mai mare = prioritate mai mare)  
**Algoritm:** Prioritate preemptivă cu time slicing

#### Cum funcționează

- Ca SCHED_FIFO, dar adaugă **time quantum** (de obicei 100ms)
- După expirarea time quantum, task se mută la sfârșitul cozii la prioritatea sa
- Taskuri multiple la aceeași prioritate partajează CPU echitabil
- Taskurile cu prioritate mai mare preemptează încă priorități mai mici

#### Caracteristici

```
Alocare timp:     Time quantum (de obicei 100ms) per tur
Preempție:        De taskuri RT cu prioritate mai mare, sau expirare kuantă
Latență:          Foarte scăzută (< 100 µs), deterministă
Caz de utilizare: Multiple taskuri RT la aceeași prioritate
```

#### Comportament Round-Robin

```
Taskuri prioritate 80 cu kuantă 100ms:

Task A: [███████] yielduiește la Task B
Task B: [███████] yielduiește la Task C  } Aceeași prioritate, time-shared
Task C: [███████] yielduiește la Task A

Task prioritate 90 sosește → preemptează imediat indiferent de kuantă
```

#### Când să o utilizezi

- Multiple taskuri real-time cu importanță egală
- Doriți garantii RT dar partajare echitabilă între pari
- Prevenire ca un singur task să monopolizeze CPU
- Bucle control cu senzori multipli

#### Exemplu cod

```c
struct sched_param param;
param.sched_priority = 80;  // 1-99

if (sched_setscheduler(0, SCHED_RR, &param) != 0) {
    perror("sched_setscheduler");
}

// Verificați time quantum
struct timespec quantum;
sched_rr_get_interval(0, &quantum);
printf("Kuantă RR: %ld.%ld sec\n", quantum.tv_sec, quantum.tv_nsec);
```

#### SCHED_FIFO vs SCHED_RR

```
Scenariu: Două taskuri la prioritate 80

SCHED_FIFO:
Task 1: [██████████████████████████] (se execută până la yield)
Task 2:                             [████████████]

SCHED_RR:
Task 1: [██████] [██████] [██████]
Task 2:       [██████] [██████] [██████]
        └─> Alternează la fiecare 100ms
```

---

### SCHED_BATCH

**Tip:** Normal, procesare batch  
**Prioritate:** Întotdeauna 0 (niceness controlează pondere)  
**Algoritm:** CFS cu penalitate ușoară pentru interactivitate

#### Cum funcționează

- Ca SCHED_OTHER dar optimizat pentru taskuri non-interactive
- Scheduler-ul presupune că task este legat de CPU
- Prioritate ușor mai mică decât taskuri SCHED_OTHER interactive
- Throughput mai bun pentru joburi batch

#### Când să o utilizezi

- Compilare background
- Pipelines procesare date
- Calcule științifice
- Codare video

#### Exemplu cod

```c
struct sched_param param;
param.sched_priority = 0;
sched_setscheduler(0, SCHED_BATCH, &param);
```

---

### SCHED_IDLE

**Tip:** Normal, prioritate extrem de scăzută  
**Prioritate:** Întotdeauna 0  
**Algoritm:** Se execută doar când niciun alt task nu este runnable

#### Cum funcționează

- Prioritate cea mai scăzută din sistem
- Se execută doar când CPU ar fi altfel inactiv
- Chiar și taskuri SCHED_OTHER cu nice +19 au prioritate mai mare

#### Când să o utilizezi

- Servicii indexare (ex. updatedb)
- Taskuri background cu prioritate scăzută
- Taskuri care nu ar trebui să interfereze cu altele

#### Exemplu cod

```c
struct sched_param param;
param.sched_priority = 0;
sched_setscheduler(0, SCHED_IDLE, &param);
```

---

## Intervale de prioritate

| Politică     | Interval prioritate | Note                                      |
|--------------|-------------------|------------------------------------------|
| SCHED_OTHER  | 0                 | Valoare nice (-20 la +19) controlează pondere |
| SCHED_BATCH  | 0                 | Valoare nice (-20 la +19) controlează pondere |
| SCHED_IDLE   | 0                 | Valoare nice ignorată                     |
| SCHED_FIFO   | 1-99              | 99 = maxim, rezervat pentru kernel        |
| SCHED_RR     | 1-99              | 99 = maxim, rezervat pentru kernel        |

#### Ierarhie prioritate

```
  99 ← Fire kernel (migration, watchdog)
  90 ← Taskuri RT utilizator cu prioritate mare
  80 ← Prioritate task RT tipică (folosit în exerciții)
  50 ← Taskuri RT cu prioritate medie
  10 ← Taskuri RT cu prioritate scăzută
   1 ← Prioritate RT minimă
─────────────────────────────────────────────
   0 ← SCHED_OTHER (toate taskurile normale)
   0 ← SCHED_BATCH
   0 ← SCHED_IDLE (se execută ultim)
```

#### Verificare limite sistem

```c
int min_fifo = sched_get_priority_min(SCHED_FIFO);  // Returnează 1
int max_fifo = sched_get_priority_max(SCHED_FIFO);  // Returnează 99
```

---

## Tabel comparativ

| Caracteristică         | SCHED_OTHER | SCHED_FIFO | SCHED_RR | SCHED_BATCH | SCHED_IDLE |
|------------------------|-------------|------------|----------|-------------|------------|
| **Tip**                | Normal      | Real-time  | Real-time| Normal      | Normal     |
| **Interval prioritate**| 0           | 1-99       | 1-99     | 0           | 0          |
| **Time Slicing**       | Da (CFS)    | Nu         | Da       | Da (CFS)    | Da         |
| **Preemptibil de RT**  | Da          | De prioritate mai mare | De prioritate mai mare | Da | Da |
| **Determinism**        | Scăzut      | Înalt      | Înalt    | Scăzut      | Scăzut     |
| **Latență**            | 20-200 µs   | < 100 µs   | < 100 µs | Variabilă   | Variabilă  |
| **Caz de utilizare**   | Desktop     | Hard RT    | Soft RT  | Batch       | Background |
| **Necesită privilegi** | Nu          | Da         | Da       | Nu          | Nu         |
| **Poate bloca sistem** | Nu          | **DA**     | **DA**   | Nu          | Nu         |

---

## Utilizare API

### Setarea politicii de planificare

```c
#include <sched.h>

int sched_setscheduler(pid_t pid, int policy, const struct sched_param *param);
```

**Parametri:**
- `pid`: 0 pentru fire-ul apelator, sau PID specific
- `policy`: SCHED_OTHER, SCHED_FIFO, SCHED_RR, etc.
- `param`: struct conținând `sched_priority`

**Întoarcere:** 0 la succes, -1 la eroare (verificați errno)

### Interogare setări curente

```c
// Obțineți politica curentă
int policy = sched_getscheduler(0);  // 0 = proces curent

// Obțineți prioritate curentă
struct sched_param param;
sched_getparam(0, &param);
printf("Prioritate: %d\n", param.sched_priority);

// Convertiți politica în nume
const char* policy_name(int policy) {
    switch(policy) {
        case SCHED_OTHER: return "SCHED_OTHER";
        case SCHED_FIFO:  return "SCHED_FIFO";
        case SCHED_RR:    return "SCHED_RR";
        case SCHED_BATCH: return "SCHED_BATCH";
        case SCHED_IDLE:  return "SCHED_IDLE";
        default:          return "NECUNOSCUT";
    }
}
```

### Exemplu complet

```c
#include <stdio.h>
#include <sched.h>
#include <errno.h>
#include <string.h>

int main(void) {
    struct sched_param param;

    // Setare la SCHED_FIFO cu prioritate 80
    param.sched_priority = 80;

    if (sched_setscheduler(0, SCHED_FIFO, &param) != 0) {
        if (errno == EPERM) {
            fprintf(stderr, "Eroare: Privilegi insuficiente\n");
            fprintf(stderr, "Rulați cu: sudo ./program\n");
            fprintf(stderr, "Sau în Docker: docker run --privileged ...\n");
        } else {
            perror("sched_setscheduler");
        }
        return 1;
    }

    printf("Setare reușită la SCHED_FIFO prioritate 80\n");

    // Lucru real-time...

    // Restaurare la planificare normală înainte de ieșire
    param.sched_priority = 0;
    sched_setscheduler(0, SCHED_OTHER, &param);

    return 0;
}
```

### Utilizare cu pthreads

```c
#include <pthread.h>
#include <sched.h>

void* thread_function(void *arg) {
    // Setare planificare pentru fire curent
    struct sched_param param;
    param.sched_priority = 70;

    if (pthread_setschedparam(pthread_self(), SCHED_FIFO, &param) != 0) {
        perror("pthread_setschedparam");
    }

    // Lucru fire...
    return NULL;
}

int main(void) {
    pthread_t thread;
    pthread_attr_t attr;

    // Alternativă: Setare politică înainte de creare fire
    pthread_attr_init(&attr);
    pthread_attr_setschedpolicy(&attr, SCHED_FIFO);

    struct sched_param param;
    param.sched_priority = 70;
    pthread_attr_setschedparam(&attr, &param);

    pthread_create(&thread, &attr, thread_function, NULL);
    pthread_join(thread, NULL);

    pthread_attr_destroy(&attr);
    return 0;
}
```

---

## Cerințe și permisiuni (CAP_SYS_NICE)

### Ce este CAP_SYS_NICE?

**CAP_SYS_NICE** este o capacitate Linux care permite unui proces să efectueze operații privilegiate legate de planificarea proceselor și valorile de prioritate.

#### Permisiuni acordate

Cu CAP_SYS_NICE, un proces poate:

1. **Schimba politici de planificare** - Seta SCHED_FIFO, SCHED_RR și alte politici real-time folosind `sched_setscheduler()`

2. **Modifica priorități de proces** - Schimba valorile nice dincolo de restricții normale folosind `nice()` sau `setpriority()`

3. **Ocoli limitele de nice** - Crește prioritatea (valori nice mai mici) pentru orice proces, nu doar pentru cel propriu

4. **Crește priorități CPU** - Oferi proceselor prioritate mai mare decât alocarea implicită

#### De ce este necesar?

Operațiile real-time ca `SCHED_FIFO` și `SCHED_RR` sunt operații privilegiate pentru a preveni procesele normale să monopolizeze CPU-ul. Prin urmare, aveți nevoie de:
- **Acces root** (UID 0), SAU
- **Capacitatea CAP_SYS_NICE**

### Cum să obțineți CAP_SYS_NICE

#### Metoda 1: Rulare cu sudo (cea mai simplă)

```bash
sudo ./your_program
```

#### Metoda 2: Acordare permanentă a capacității

```bash
# Acordă capacitatea binarului permanent
sudo setcap cap_sys_nice=ep ./your_program

# Rulare fără sudo
./your_program
```

#### Metoda 3: Verificare capacități acordate

```bash
# Verificare ce capacități are un binar
getcap ./your_program

# Rezultat tipic după setcap
# ./your_program = cap_sys_nice+ep
```

### Exemple de erori și soluții

#### Eroare: "Operation not permitted"

```
$ ./program
sched_setscheduler: Operation not permitted
```

**Soluție:** Rulați cu sudo sau acordați capacitatea:
```bash
sudo ./program
# sau
sudo setcap cap_sys_nice=ep ./program
./program
```

#### Verificare permisiuni în cod

```c
#include <stdio.h>
#include <sched.h>
#include <errno.h>

int main(void) {
    struct sched_param param;
    param.sched_priority = 80;

    if (sched_setscheduler(0, SCHED_FIFO, &param) != 0) {
        if (errno == EPERM) {
            fprintf(stderr, "Eroare: Privilegi insuficiente\n");
            fprintf(stderr, "Rulați cu: sudo ./program\n");
            fprintf(stderr, "Sau acordați capacitate: sudo setcap cap_sys_nice=ep ./program\n");
        } else {
            perror("sched_setscheduler");
        }
        return 1;
    }

    printf("Setare reușită la SCHED_FIFO prioritate 80\n");
    return 0;
}
```

