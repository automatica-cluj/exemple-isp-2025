# Șabloane Comportamentale de Proiectare

Aceasta secțiune cuprinde câteva șabloane comportamentale de proiectare care sunt utilizate frecvent în dezvoltarea software-ului. Aceste șabloane se concentrează pe comunicarea eficientă între obiecte și pe alocarea responsabilităților între acestea.

# Șablon de proiectare Observer

**Nume**: Observer

**Problemă**:
Necesitatea de a notifica automat multiple obiecte despre schimbările de stare ale unui obiect observat. Este util când o schimbare într-un obiect necesită modificări în alte obiecte, fără a cunoaște câte obiecte trebuie modificate sau care sunt acestea.

**Soluție**:
Definirea unei dependențe de tip one-to-many între obiecte, astfel încât când un obiect își schimbă starea, toate obiectele dependente sunt notificate și actualizate automat.

**Structură**:
- O interfață Subject care definește operațiile de înregistrare și notificare a observatorilor
- Clasa ConcreteSubject care implementează interfața Subject și menține starea de interes
- O interfață Observer care definește metoda de actualizare
- Clase ConcreteObserver care implementează interfața Observer și reacționează la notificări

**Implementare**:

```java
// Interfața Subject
interface Subject {
    void registerObserver(Observer o);
    void removeObserver(Observer o);
    void notifyObservers();
}

// ConcreteSubject
class WeatherData implements Subject {
    private List<Observer> observers;
    private float temperature;
    private float humidity;
    private float pressure;
    
    public WeatherData() {
        observers = new ArrayList<>();
    }
    
    @Override
    public void registerObserver(Observer o) {
        observers.add(o);
    }
    
    @Override
    public void removeObserver(Observer o) {
        int i = observers.indexOf(o);
        if (i >= 0) {
            observers.remove(i);
        }
    }
    
    @Override
    public void notifyObservers() {
        for (Observer observer : observers) {
            observer.update(temperature, humidity, pressure);
        }
    }
    
    public void measurementsChanged() {
        notifyObservers();
    }
    
    public void setMeasurements(float temperature, float humidity, float pressure) {
        this.temperature = temperature;
        this.humidity = humidity;
        this.pressure = pressure;
        measurementsChanged();
    }
}

// Interfața Observer
interface Observer {
    void update(float temp, float humidity, float pressure);
}

// Interfața pentru display-uri
interface DisplayElement {
    void display();
}

// ConcreteObserver
class CurrentConditionsDisplay implements Observer, DisplayElement {
    private float temperature;
    private float humidity;
    private Subject weatherData;
    
    public CurrentConditionsDisplay(Subject weatherData) {
        this.weatherData = weatherData;
        weatherData.registerObserver(this);
    }
    
    @Override
    public void update(float temperature, float humidity, float pressure) {
        this.temperature = temperature;
        this.humidity = humidity;
        display();
    }
    
    @Override
    public void display() {
        System.out.println("Condiții curente: " + temperature + 
                "°C și " + humidity + "% umiditate");
    }
}

// Client
class WeatherStation {
    public static void main(String[] args) {
        WeatherData weatherData = new WeatherData();
        
        CurrentConditionsDisplay currentDisplay = 
            new CurrentConditionsDisplay(weatherData);
            
        // Simulăm noi măsurători meteo
        weatherData.setMeasurements(29, 65, 1013.2f);
        weatherData.setMeasurements(28, 70, 1012.8f);
        weatherData.setMeasurements(26, 90, 1010.5f);
    }
}
```

**Consecințe**:
- **Avantaje**:
    - Permite modificarea subiecților și observatorilor în mod independent
    - Relația dintre observatori și subiect este stabilită dinamic la rulare
    - Realizează o cuplare slabă între subiect și observatori
    - Suportă comunicarea de tip broadcast
- **Dezavantaje**:
    - Notificările necondiționate pot duce la actualizări în cascadă ineficiente
    - Memoria poate fi afectată dacă observatorii nu sunt eliminați când nu mai sunt necesari
    - Poate introduce dependențe subtile și greu de depanat între observatori și subiect

# Șablon de proiectare Strategy

**Nume**: Strategy

**Problemă**:
Necesitatea de a defini o familie de algoritmi, de a încapsula fiecare algoritm și de a-i face interschimbabili. Este util când există multiple implementări posibile pentru o funcționalitate, iar alegerea implementării concrete trebuie făcută la rulare.

**Soluție**:
Definirea unei familii de algoritmi, încapsularea fiecăruia și făcându-le interschimbabile. Strategy permite algoritmului să varieze independent de clienții care îl utilizează.

**Structură**:
- O interfață Strategy care definește comportamentul comun pentru toți algoritmii
- Clase ConcreteStrategy care implementează algoritmii specifici
- Clasa Context care utilizează un obiect Strategy și poate schimba algoritmul în timpul execuției

**Implementare**:

```java
// Interfața Strategy
interface PaymentStrategy {
    void pay(int amount);
}

// ConcreteStrategy 1
class CreditCardPayment implements PaymentStrategy {
    private String name;
    private String cardNumber;
    private String cvv;
    private String dateOfExpiry;
    
    public CreditCardPayment(String name, String cardNumber, 
                          String cvv, String dateOfExpiry) {
        this.name = name;
        this.cardNumber = cardNumber;
        this.cvv = cvv;
        this.dateOfExpiry = dateOfExpiry;
    }
    
    @Override
    public void pay(int amount) {
        System.out.println(amount + " lei plătiți cu cardul de credit");
    }
}

// ConcreteStrategy 2
class PayPalPayment implements PaymentStrategy {
    private String emailId;
    private String password;
    
    public PayPalPayment(String email, String password) {
        this.emailId = email;
        this.password = password;
    }
    
    @Override
    public void pay(int amount) {
        System.out.println(amount + " lei plătiți prin PayPal");
    }
}

// ConcreteStrategy 3
class BitcoinPayment implements PaymentStrategy {
    private String walletAddress;
    
    public BitcoinPayment(String walletAddress) {
        this.walletAddress = walletAddress;
    }
    
    @Override
    public void pay(int amount) {
        System.out.println(amount + " lei plătiți în Bitcoin");
    }
}

// Context
class ShoppingCart {
    private List<Item> items;
    
    public ShoppingCart() {
        this.items = new ArrayList<Item>();
    }
    
    public void addItem(Item item) {
        this.items.add(item);
    }
    
    public int calculateTotal() {
        int sum = 0;
        for (Item item : items) {
            sum += item.getPrice();
        }
        return sum;
    }
    
    public void pay(PaymentStrategy paymentMethod) {
        int amount = calculateTotal();
        paymentMethod.pay(amount);
    }
}

// Item class
class Item {
    private String name;
    private int price;
    
    public Item(String name, int price) {
        this.name = name;
        this.price = price;
    }

    public String getName() {
        return name;
    }
    
    public int getPrice() {
        return price;
    }
}

// Client
class ShoppingDemo {
    public static void main(String[] args) {
        ShoppingCart cart = new ShoppingCart();
        
        cart.addItem(new Item("Carte", 50));
        cart.addItem(new Item("Telefon", 999));
        
        // Plată cu card de credit
        cart.pay(new CreditCardPayment("Ion Popescu", "1234567890123456", 
                                      "786", "12/25"));
        
        // Plată cu PayPal
        cart.pay(new PayPalPayment("ion.popescu@example.com", "parola123"));
        
        // Plată cu Bitcoin
        cart.pay(new BitcoinPayment("1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa"));
    }
}
```

**Consecințe**:
- **Avantaje**:
    - Elimină condițiile multiple în cod prin încapsularea algoritmilor
    - Permite schimbarea algoritmului independent de clientul care îl folosește
    - Promovează principiile SOLID, în special Open/Closed Principle
    - Izolează implementarea unui algoritm de codul care îl utilizează
- **Dezavantaje**:
    - Clienții trebuie să cunoască diferențele între strategii pentru a alege corect
    - Poate crește numărul de obiecte în sistem
    - Comunicarea între strategie și context poate introduce overhead

# Șablon de proiectare Command

**Nume**: Command

**Problemă**:
Necesitatea de a încapsula o cerere ca un obiect, permițând parametrizarea clienților cu diferite cereri, punerea cererilor într-o coadă, jurnalizarea cererilor și suportul pentru operații reversibile.

**Soluție**:
Încapsularea unei cereri într-un obiect, permițând astfel parametrizarea clienților cu diferite cereri, punerea cererilor în coadă sau jurnalizarea acestora și suportul pentru operațiuni reversibile.

**Structură**:
- O interfață Command care declară metoda de execuție
- Clase ConcreteCommand care implementează interfața Command
- Clasa Invoker care solicită comanda să-și execute cererea
- Clasa Receiver care știe cum să efectueze operațiunile asociate cu o cerere
- Clientul care creează un obiect ConcreteCommand și îl asociază cu un Receiver

**Implementare**:

```java
// Interfața Command
interface Command {
    void execute();
    void undo();
}

// Receiver
class Light {
    private String location;
    
    public Light(String location) {
        this.location = location;
    }
    
    public void on() {
        System.out.println(location + " lumină aprinsă");
    }
    
    public void off() {
        System.out.println(location + " lumină stinsă");
    }
}

// ConcreteCommand pentru aprinderea luminii
class LightOnCommand implements Command {
    private Light light;
    
    public LightOnCommand(Light light) {
        this.light = light;
    }
    
    @Override
    public void execute() {
        light.on();
    }
    
    @Override
    public void undo() {
        light.off();
    }
}

// ConcreteCommand pentru stingerea luminii
class LightOffCommand implements Command {
    private Light light;
    
    public LightOffCommand(Light light) {
        this.light = light;
    }
    
    @Override
    public void execute() {
        light.off();
    }
    
    @Override
    public void undo() {
        light.on();
    }
}

// Receiver
class Stereo {
    private String location;
    
    public Stereo(String location) {
        this.location = location;
    }
    
    public void on() {
        System.out.println(location + " stereo pornit");
    }
    
    public void off() {
        System.out.println(location + " stereo oprit");
    }
    
    public void setCD() {
        System.out.println(location + " stereo setat pentru CD");
    }
    
    public void setVolume(int volume) {
        System.out.println(location + " stereo volum setat la " + volume);
    }
}

// ConcreteCommand pentru pornirea stereo-ului
class StereoOnWithCDCommand implements Command {
    private Stereo stereo;
    
    public StereoOnWithCDCommand(Stereo stereo) {
        this.stereo = stereo;
    }
    
    @Override
    public void execute() {
        stereo.on();
        stereo.setCD();
        stereo.setVolume(11);
    }
    
    @Override
    public void undo() {
        stereo.off();
    }
}

// Invoker
class RemoteControl {
    private Command[] onCommands;
    private Command[] offCommands;
    private Command undoCommand;
    
    public RemoteControl() {
        onCommands = new Command[7];
        offCommands = new Command[7];
        
        Command noCommand = new NoCommand();
        for (int i = 0; i < 7; i++) {
            onCommands[i] = noCommand;
            offCommands[i] = noCommand;
        }
        undoCommand = noCommand;
    }
    
    public void setCommand(int slot, Command onCommand, Command offCommand) {
        onCommands[slot] = onCommand;
        offCommands[slot] = offCommand;
    }
    
    public void onButtonWasPushed(int slot) {
        onCommands[slot].execute();
        undoCommand = onCommands[slot];
    }
    
    public void offButtonWasPushed(int slot) {
        offCommands[slot].execute();
        undoCommand = offCommands[slot];
    }
    
    public void undoButtonWasPushed() {
        undoCommand.undo();
    }
    
    public String toString() {
        StringBuffer stringBuff = new StringBuffer();
        stringBuff.append("\n------ Telecomandă -------\n");
        for (int i = 0; i < onCommands.length; i++) {
            stringBuff.append("[slot " + i + "] " + onCommands[i].getClass().getName()
                + "    " + offCommands[i].getClass().getName() + "\n");
        }
        stringBuff.append("[undo] " + undoCommand.getClass().getName() + "\n");
        return stringBuff.toString();
    }
}

// Implementare NullObject pentru Command
class NoCommand implements Command {
    @Override
    public void execute() {}
    
    @Override
    public void undo() {}
}

// Client
class RemoteLoader {
    public static void main(String[] args) {
        RemoteControl remote = new RemoteControl();
        
        // Crearea dispozitivelor
        Light livingRoomLight = new Light("Camera de zi");
        Light kitchenLight = new Light("Bucătărie");
        Stereo stereo = new Stereo("Camera de zi");
        
        // Crearea comenzilor pentru lumini
        LightOnCommand livingRoomLightOn = new LightOnCommand(livingRoomLight);
        LightOffCommand livingRoomLightOff = new LightOffCommand(livingRoomLight);
        LightOnCommand kitchenLightOn = new LightOnCommand(kitchenLight);
        LightOffCommand kitchenLightOff = new LightOffCommand(kitchenLight);
        
        // Crearea comenzilor pentru stereo
        StereoOnWithCDCommand stereoOnWithCD = new StereoOnWithCDCommand(stereo);
        
        // Configurarea telecomenzii
        remote.setCommand(0, livingRoomLightOn, livingRoomLightOff);
        remote.setCommand(1, kitchenLightOn, kitchenLightOff);
        remote.setCommand(2, stereoOnWithCD, new NoCommand());
        
        System.out.println(remote);
        
        // Testarea butoanelor
        remote.onButtonWasPushed(0);
        remote.offButtonWasPushed(0);
        remote.onButtonWasPushed(1);
        remote.offButtonWasPushed(1);
        remote.onButtonWasPushed(2);
        remote.undoButtonWasPushed();
    }
}
```

**Consecințe**:
- **Avantaje**:
    - Decuplează obiectul care invocă operațiunea de cel care știe cum să o execute
    - Permite crearea de comandă compuse (macro-comenzi)
    - Permite implementarea ușoară a funcționalităților de undo/redo
    - Permite jurnalizarea modificărilor și recuperarea în caz de crash
    - Suportă extensibilitatea prin adăugarea de noi comenzi fără a modifica codul existent
- **Dezavantaje**:
    - Poate duce la un număr mare de clase mici de comandă
    - Implementarea unor operațiuni complexe de undo poate fi dificilă