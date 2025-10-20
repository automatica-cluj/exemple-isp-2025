# Laboratoare PREEMT_RT

## Scopul Laboratoarelor

Pentru a facilita înțelegerea funcționalităților introduse de **PREEMPT_RT**, a fost creat un set de **laboratoare opționale** ce pot fi parcurse de studenți pentru a înțelege principiile de bază ale programării în timp real. Laboratoarele sunt configurate în repository-ul Git disponibil aici: **https://github.com/automatica-cluj/ssatr-iaisc-icaf-2025-labs-v2**.

Aceste laboratoare reprezintă un set complet de activități practice menite să sprijine familiarizarea studenților cu conceptele de **programare în timp real (real-time)** aplicate în sistemul de operare **Linux** modificat cu patch-ul de kernel **PREEMPT-RT**.

Structura laboratoarelor urmează o abordare **practică și incrementală**, pornind de la conceptele fundamentale din domeniul sistemelor real-time:

- măsurarea **latenței** și **jitter-ului**,
- explorarea **politicilor de planificare (scheduling)** specifice sarcinilor în timp real,
- implementarea **sarcinilor periodice**,
- și analiza comportamentului sistemului în condițiile **încălcării termenelor limită (deadlines)**.

Scopul acestor activități este de a oferi o înțelegere aplicată a modului în care Linux cu PREEMPT-RT poate fi utilizat pentru dezvoltarea și evaluarea sistemelor cu cerințe stricte de timp real.

## Structura Repository-ului

Repository-ul este organizat pe săptămâni, fiecare săptămână conținând:
- **Ghiduri detaliate** cu teorie și exemple practice
- **Exerciții progresive** pentru aplicarea conceptelor învățate
- **Documente de referință rapidă** pentru structura proiectului
- **Scripturi de automatizare** pentru compilare, rulare și vizualizare

### Conținut Actual

Repository-ul include toate instrucțiunile necesare pentru:
- Configurarea mediului de dezvoltare
- Compilarea și rularea exercițiilor
- Interpretarea rezultatelor
- Vizualizarea datelor de performanță

Fiecare săptămână urmează un pattern consistent, facilitând învățarea progresivă și înțelegerea conceptelor.

## Mediul de Dezvoltare Docker

Pentru a facilita rularea laboratoarelor într-un mediu uniform și portabil, repository-ul include un **mediu virtualizat Docker** complet configurat.

### Caracteristici Docker Environment

Mediul Docker oferă:
- Container pre-configurat cu toate dependențele necesare
- Suport pentru capabilități real-time (prin flag-ul `--privileged`)
- Izolare față de sistemul gazdă
- Portabilitate între diferite platforme (Windows, Linux, macOS)

### Limitări Importante ale Virtualizării

**Notă importantă:** Deși mediul Docker este extrem de util pentru învățare, trebuie să înțelegem că:

1. **Container-ul Docker partajează kernel-ul gazdă** - nu rulează propriul kernel PREEMPT-RT
2. **Nu permite demonstrarea efectivă a capacităților de timp real** ale unui kernel PREEMPT-RT dedicat
3. **Overhead-ul virtualizării** introduce latențe suplimentare care nu ar exista într-un sistem real-time nativ



## Abordare

Laboratoarele folosesc o metodologie practică bazată pe:

1. **Demonstrații comparative** - compararea comportamentului cu/fără scheduling real-time
2. **Măsurători cantitative** - colectarea și analiza datelor de latență și jitter
3. **Vizualizare** - grafica, text pentru înțelegerea impactului diferitelor configurații
4. **Teste de stres** - simularea încărcării sistemului pentru evidențierea diferențelor

## Obiective de Învățare

La finalul acestor laboratoare, studenții vor fi capabili să:

- Înțeleagă diferența dintre latență și jitter
- Configureze politici de schedulare real-time în Linux
- Implementeze sarcini periodice cu detectare de deadline miss
- Măsoare și analizeze performanța temporală
- Calculeze utilizarea procesorului pentru multiple sarcini
- Înțeleagă limitările și trade-off-urile sistemelor real-time

## Cum să Utilizați Repository

1. **Citiți ghidurile săptămânale** pentru context teoretic
2. **Configurați mediul Docker** conform instrucțiunilor
3. **Rulați exercițiile** în ordine pentru învățare progresivă
4. **Experimentați cu parametrii** pentru înțelegere aprofundată
5. **Analizați rezultatele** și comparați cu așteptările teoretice

## Concluzie

Aceste laboratoare reprezintă o introducere practică în lumea programării real-time pe Linux, oferind fundamentele necesare pentru dezvoltarea aplicațiilor critice din punct de vedere temporal. Deși mediul Docker nu oferă capabilități real-time autentice, el servește ca un instrument excelent de învățare pentru conceptele, API-urile și pattern-urile de design specifice acestui domeniu.

