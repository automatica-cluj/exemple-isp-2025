# Crearea mașinii virtuale Azure: Ghid pas cu pas

## Introducere

Acest ghid oferă instrucțiuni pas cu pas pentru a crea o mașină virtuală (VM) în Microsoft Azure folosind Azure CLI. Veți învăța cum să creați un grup de resurse, să configurați mașina virtuală și să vă conectați la aceasta prin SSH.

Acest ghid a fost creat pentru a oferi studenților posibilitatea de a experimenta lucrul cu mașini virtuale Azure. Experimentarea este posibilă în mod gratuit deoarece, ca student al Universității Tehnice din Cluj-Napoca, utilizand contul **campus**, aveți acces la portalul Azure și puteți beneficia de un credit de 100 USD anual pe care îl puteți utiliza pentru diferite tipuri de resurse.
Este important de menționat faptul că anumite resurse sunt disponibile permanent în mod gratuit, iar detalii suplimentare cu privire la acestea pot fi disponibile pe portalul Azure (https://portal.azure.com/).

## Condiții prealabile

Acest ghid presupune că:
- Aveți deja un cont Azure
- Interfața Azure CLI (Command Line Interface) este instalată și configurată pe sistemul dumneavoastră

Dacă nu ați instalat încă Azure CLI, urmați documentația oficială Microsoft: [Cum se instalează Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

Toate operatiile din acest ghid se vor executa din linia de comandă (terminal) a sistemului  de operare. 

## 1. Autentificarea în Azure

Mai întâi, autentificați-vă în contul Azure:

```bash
az login
```

Aceasta va deschide o fereastră de browser pentru autentificare sau va afișa un cod pentru a fi introdus pe un dispozitiv separat. După autentificare, veți vedea abonamentele disponibile.

## 2. Crearea unui grup de resurse

Creați un grup de resurse pentru a găzdui mașina virtuală și resursele asociate:

```bash
az group create --name isp2025 --location eastus
```

Această comandă creează un grup de resurse numit "isp2025" în regiunea Est SUA.

## 3. Crearea mașinii virtuale

Creați mașina virtuală cu setările corespunzătoare:

```bash
az vm create --resource-group isp2025 --name isp2025m1VM --image Ubuntu2204 --admin-username azureuser --generate-ssh-keys
```

Această comandă:
- Plasează VM-ul în grupul de resurse "isp2025"
- Denumește VM-ul "isp2025m1VM"
- Folosește Ubuntu 22.04 LTS ca sistem de operare
- Creează un utilizator numit "azureuser" cu privilegii de administrator
- Generează automat chei SSH pentru acces securizat

După crearea cu succes, veți primi informații detaliate, inclusiv adresele IP publice și private ale mașinii virtuale. Aceste informații au urmatoarea structura:

```json
{
"fqdns": "",
"id": "/subscriptions/cceb7ea6-59b4-4b01-ac4a-16fb72b2f83c/resourceGroups/isp2025/providers/Microsoft.Compute/virtualMachines/isp2025m1VM",
"location": "eastus",
"macAddress": "7C-1E-52-18-82-7E",
"powerState": "VM running",
"privateIpAddress": "10.0.0.4",
"publicIpAddress": "<adresa-ip-publica>",
"resourceGroup": "isp2025",
"zones": ""
}
```

## 4. Conectarea la mașina virtuală

Folosiți SSH pentru a vă conecta la mașina virtuală:

```bash
ssh azureuser@<adresa-ip-publica>
```

Înlocuiți `<adresa-ip-publica>` cu adresa IP publică obținută din rezultatul pasului anterior.

## 5. Gestionarea mașinii virtuale 

Dacă doriți să vizualizați informații detaliate despre mașina virtuală, utilizați:

```bash
az vm show --resource-group isp2025 --name isp2025m1VM
```
Aceasta va afișa detalii despre VM, inclusiv dimensiunea, starea și resursele asociate.

Daca doriti sa deschideti un port pe VM pentru a permite accesul la un serviciu (de exemplu, portul 80 pentru HTTP), utilizați:

```bash
az vm open-port --resource-group isp2025 --name isp2025m1VM --port 80
```

ATENTIE! In mod implicit doar portul 22 (SSH) este deschis pentru acces. Deschiderea altor porturi poate expune VM-ul la atacuri externe, deci asigurați-vă că aveți măsuri de securitate adecvate.

Când ați terminat de utilizat mașina virtuală, o puteți opri pentru a economisi costuri:

```bash
az vm stop --resource-group isp2025 --name isp2025m1VM
```

Pentru a opri complet facturarea (cu excepția costurilor de stocare), dealocați mașina virtuală:

```bash
az vm deallocate --resource-group isp2025 --name isp2025m1VM
```

Pentru a reporni o mașină virtuală dealocată anterior:

```bash
az vm start --resource-group isp2025 --name isp2025m1VM
```

Aceasta va porni mașina virtuală și o va face disponibilă din nou cu aceeași adresă IP publică (în majoritatea cazurilor) și toate datele intacte.

Pentru a șterge definitiv o mașină virtuală când nu mai aveți nevoie de ea:

```bash
az vm delete --resource-group isp2025 --name isp2025m1VM --yes
```

Parametrul `--yes` omite solicitarea de confirmare. Această comandă șterge mașina virtuală, dar nu neapărat toate resursele asociate, cum ar fi interfețele de rețea, adresele IP publice și discurile.

Pentru a șterge toate resursele asociate, puteți utiliza:

```bash
az group delete --name isp2025 --yes
```

Aceasta va șterge întregul grup de resurse, inclusiv toate resursele din cadrul acestuia (VM, discuri, rețele etc.). Fiți extrem de precauți cu această comandă, deoarece elimină permanent toate resursele din grup.

## Tipul implicit de mașină virtuală și costurile

Când nu specificați un parametru de dimensiune, Azure CLI creează în mod implicit o mașină virtuală de tip **Standard_DS1_v2**. Acest tip de VM include:

- 1 vCPU
- 3,5 GB RAM
- 7 GB stocare temporară
- Stocare SSD standard

**Costuri lunare estimate:**
- Costuri de calcul VM: Aproximativ 36-45 USD pe lună dacă rulează non-stop
- Costuri de stocare: Aproximativ 5-10 USD pe lună pentru discul OS (Premium SSD P10, 128 GB)
- Rețea: Costuri suplimentare pentru transferul de date în afara limitelor nivelului gratuit

Cost total estimat: **Aproximativ 45-60 USD pe lună** dacă rulează continuu.

Puteți reduce semnificativ costurile prin:
- Dealocarea VM-ului când nu este folosit (ceea ce poate reduce costurile cu 80% sau mai mult)
- Utilizarea instanțelor rezervate pentru angajamente pe termen lung
- Selectarea unei dimensiuni diferite de VM cu parametrul `--size` dacă aveți nevoie de mai puține sau mai multe resurse

## Note importante

- Cheile SSH sunt stocate automat în directorul `~/.ssh/`
- Dacă utilizați o mașină fără stocare permanentă, faceți o copie de rezervă a cheilor SSH
- Puteți alege imagini de mașini virtuale, dimensiuni și regiuni diferite în funcție de nevoile dumneavoastră
- Nu uitați să dealocați mașinile virtuale când nu le folosiți pentru a evita costuri inutile
- Pentru conturile de studenți, Azure oferă credite care pot acoperi aceste costuri în limita creditului dumneavoastră

Urmând acești pași, puteți crea și accesa rapid o mașină virtuală în Microsoft Azure.