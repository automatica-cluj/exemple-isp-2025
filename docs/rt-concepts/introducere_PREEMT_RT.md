# Ghid introductiv Linux PREEMPT_RT

Acest ghid prezintă conceptele de bază ale kernelului Linux în timp real (PREEMPT_RT), principiile de funcționare, pașii pentru verificarea mediului și exemple de experimente simple pentru măsurarea latenței.

------

## 1. Ce este PREEMPT_RT

**PREEMPT_RT (Preemption Real-Time)** este un set de patch-uri aplicate kernelului Linux pentru a-l transforma într-un **sistem de operare determinist**, capabil să răspundă evenimentelor externe într-un timp limitat și previzibil.

### Obiective principale:

- reducerea latenței în execuția task-urilor;
- garantarea timpilor de răspuns (bounded latency);
- oferirea de predictibilitate și control total asupra priorităților de execuție.

Este folosit în domenii precum:

- automatizare industrială și robotică;
- automotive (control ABS, airbag, HMI);
- telecomunicații (RAN / 5G);
- aplicații medicale critice.

------

## 2. Noțiuni fundamentale

| Concept         | Descriere                                                    |
| --------------- | ------------------------------------------------------------ |
| **Determinism** | Sistemul răspunde într-un timp maxim cunoscut.               |
| **Latență**     | Timpul dintre apariția unui eveniment și reacția sistemului. |
| **Jitter**      | Variația latenței între cicluri succesive.                   |
| **Deadline**    | Timpul limită până la care o sarcină trebuie finalizată.     |
| **Prioritate**  | Ordinea de execuție a task-urilor; sarcinile cu prioritate mai mare pot prelua CPU-ul. |

------

## 3. Modele de preempție în kernelul Linux

| Model               | Descriere                                                    | Utilizare                |
| ------------------- | ------------------------------------------------------------ | ------------------------ |
| `PREEMPT_NONE`      | Fără preempție în kernel; performanță maximă, dar latență mare. | Servere generale         |
| `PREEMPT_VOLUNTARY` | Kernelul se poate preempta doar în anumite puncte definite.  | Desktop                  |
| `PREEMPT`           | Kernelul este preemptibil în afara secțiunilor critice.      | Sisteme embedded         |
| ``                  | Kernel complet preemptibil, inclusiv în multe secțiuni critice. | Aplicații hard real-time |

PREEMPT_RT permite întreruperea codului kernelului chiar și în timpul execuției unui handler, reducând semnificativ timpul de reacție.

------

## 4. Mecanisme interne cheie

| Mecanism                                   | Funcție                                                      |
| ------------------------------------------ | ------------------------------------------------------------ |
| **Threaded interrupts**                    | Întreruperile hardware rulează ca fire de execuție și pot fi planificate. |
| **RT Mutex & Priority Inheritance**        | Evită inversarea priorităților între fire.                   |
| **SCHED_FIFO / SCHED_RR / SCHED_DEADLINE** | Politici de planificare pentru task-uri în timp real.        |
| **Spinlock-uri preemptibile**              | Spinlock-urile clasice sunt înlocuite cu variante ce pot dormi (sleepable locks). |
| **Kernel complet preemptibil**             | Permite întreruperea execuției oricărui fir inferior pentru unul de prioritate superioară. |

------

## 5. Verificarea kernelului în timp real

Înainte de a efectua experimente, verifică dacă sistemul folosește un kernel PREEMPT_RT:

```bash
uname -a
```

Rezultatul ar trebui să conțină `PREEMPT_RT` sau `PREEMPT_DYNAMIC`.

Exemplu:

```bash
Linux rt-host 5.15.0-1051-realtime #56-Ubuntu SMP PREEMPT_RT x86_64 GNU/Linux
```

Verifică și nivelul de preempție efectiv:

```bash
grep PREEMPT /boot/config-$(uname -r)
```

Rezultat așteptat:

```
CONFIG_PREEMPT_RT_FULL=y
```

------

## 6. Măsurarea latenței

### 6.1. Instalare instrumente

Instalează pachetul `rt-tests`, care conține unelte standard pentru măsurarea latenței:

```bash
sudo apt install rt-tests
```

### 6.2. Măsurare cu Cyclictest

`cyclictest` măsoară deviația (jitter) și timpul maxim de reacție al unui task periodic.

Comandă de bază:

```bash
sudo cyclictest --mlockall --smp --priority=95 --interval=1000 --duration=30s
```

- `--mlockall` blochează memoria (fără swap);
- `--smp` folosește toate nucleele;
- `--priority` setează prioritatea RT;
- `--interval` definește perioada în microsecunde;
- `--duration` stabilește durata testului.

Rezultat tipic:

```
T: 0 (  1000) P:95 I:1000 C:  30000 Min: 3 Act: 5 Avg: 4 Max: 18
```

Interpretare:

- **Min/Avg/Max** = latențele măsurate (μs)
- Max trebuie să rămână cât mai mic și constant între rulari.

------

## 7. Experimente practice

### Experiment 1 – Verificarea diferenței între kernel generic și PREEMPT_RT

1. Rulează `cyclictest` pe un kernel standard Ubuntu.
2. Rulează același test pe kernelul PREEMPT_RT.
3. Compară valorile **Max latency**.

Exemplu:

| Kernel     | Max Latency (μs) |
| ---------- | ---------------- |
| Generic    | 150–250          |
| PREEMPT_RT | 20–40            |

### Experiment 2 – Încărcare artificială a CPU

Rulează în paralel un proces CPU intensiv:

```bash
stress-ng --cpu 4 --timeout 30s &
sudo cyclictest --mlockall --smp --priority=95 --interval=1000 --duration=30s
```

Observă creșterea latenței maxime (Max) – PREEMPT_RT va menține valori semnificativ mai mici decât kernelul standard.

### Experiment 3 – Izolarea unui nucleu pentru task-uri RT

Pentru a forța testul să ruleze pe un anumit nucleu  folosește comanda `taskset`, care restricționează execuția unui proces pe CPU-ul ales.

Exemplu:

```bash
sudo taskset -c 2 cyclictest --mlockall --priority=95 --interval=1000 --duration=30s
```

- `taskset -c 2` limitează execuția pe nucleul 2;
- `--priority=95` setează prioritatea de timp real;
- `--interval=1000` definește perioada în microsecunde;
- `--duration=30s` stabilește durata testului.

Compară rezultatele obținute cu cele ale testului rulat pe toate nucleele pentru a observa diferențele de latență și jitter.

------

## 8. Concluzii

- Kernelul PREEMPT_RT oferă **determinism și latență redusă**, esențiale pentru aplicații critice.
- Măsurarea și analiza latenței trebuie să fie parte a procesului de validare a oricărui sistem real-time.
- Optimizarea completă implică kernel, BIOS, rețea și aplicații.

------

### Resurse utile

- [Linux Foundation – Real-Time Project](https://wiki.linuxfoundation.org/realtime/start)
- [Ubuntu Real-Time Kernel Docs](https://ubuntu.com/real-time)
- [Cyclictest Manual](https://manpages.ubuntu.com/manpages/jammy/man8/cyclictest.8.html)