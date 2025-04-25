# Model-View-Controller (MVC) în Java cu Swing

## Cuprins
1. [Introducere în MVC](#introducere-în-mvc)
2. [Componentele MVC](#componentele-mvc)
3. [Beneficiile utilizării MVC](#beneficiile-utilizării-mvc)
4. [Implementarea MVC în Java cu Swing](#implementarea-mvc-în-java-cu-swing)
5. [Exemplu practic](#exemplu-practic)
6. [Concluzii](#concluzii)

## Introducere în MVC

Model-View-Controller (MVC) este un pattern arhitectural folosit în dezvoltarea software pentru a separa componentele unei aplicații în trei părți distincte. Această separare ajută la organizarea codului, făcându-l mai ușor de întreținut, de testat și de extins.

MVC a fost inițial dezvoltat pentru aplicațiile desktop, dar a devenit popular și în dezvoltarea aplicațiilor web și mobile. În Java, MVC poate fi implementat eficient folosind biblioteca Swing pentru interfețe grafice.

## Componentele MVC

### Model
- **Definiție**: Reprezintă datele și logica de business a aplicației.
- **Responsabilități**:
    - Gestionează datele, logica și regulile aplicației
    - Răspunde la cereri de informații despre starea sa
    - Răspunde la instrucțiuni de schimbare a stării
    - Notifică observatorii (de obicei Views) când apar schimbări

### View
- **Definiție**: Reprezintă interfața grafică cu utilizatorul (GUI).
- **Responsabilități**:
    - Afișează datele din Model utilizatorului
    - Trimite acțiunile utilizatorului către Controller
    - Se actualizează când Model-ul se schimbă

### Controller
- **Definiție**: Intermediază interacțiunea dintre Model și View.
- **Responsabilități**:
    - Acceptă input de la utilizator prin intermediul View-ului
    - Convertește input-ul în comenzi pentru Model sau View
    - Coordonează fluxul de date între Model și View

## Beneficiile utilizării MVC

1. **Separarea responsabilităților**: Fiecare componentă are un rol bine definit, ceea ce face codul mai organizat.
2. **Reutilizarea codului**: Componentele pot fi reutilizate în alte părți ale aplicației sau în alte aplicații.
3. **Dezvoltare paralelă**: Echipele pot lucra simultan la diferite componente.
4. **Testabilitate îmbunătățită**: Componentele pot fi testate independent.
5. **Mentenanță ușoară**: Modificările într-o componentă au impact minim asupra celorlalte.

## Implementarea MVC în Java cu Swing

În Java, putem implementa MVC folosind biblioteca Swing pentru interfața grafică. Iată cum se potrivesc componentele Swing cu pattern-ul MVC:

### Model în Java
- Clasa Model conține datele și logica de business
- Implementează de obicei `Observable` sau un mecanism propriu de notificare
- Poate folosi colecții Java pentru a stoca date

### View în Java cu Swing
- Componente Swing: JFrame, JPanel, JButton, JTextField, etc.
- Ascultă modificările din Model și se actualizează
- Trimite evenimentele utilizatorului către Controller

### Controller în Java
- Gestionează evenimentele generate de componentele Swing (ActionListener, etc.)
- Actualizează Model-ul în funcție de acțiunile utilizatorului
- Poate inițializa și View-ul la pornirea aplicației

## Exemplu practic

Mai jos este prezentat un exemplu minimal de aplicație MVC în Java cu Swing, care implementează un calculator simplu de adunare.

### Structura proiectului:
```
src/
├── model/
│   └── CalculatorModel.java
├── view/
│   └── CalculatorView.java
├── controller/
│   └── CalculatorController.java
└── Main.java
```

### Model (CalculatorModel.java)
```java
package model;

import java.util.ArrayList;
import java.util.List;

public class CalculatorModel {
    private int result;
    private List<ModelObserver> observers = new ArrayList<>();

    public interface ModelObserver {
        void modelUpdated();
    }

    public void addObserver(ModelObserver observer) {
        observers.add(observer);
    }

    private void notifyObservers() {
        for (ModelObserver observer : observers) {
            observer.modelUpdated();
        }
    }

    public void add(int num1, int num2) {
        result = num1 + num2;
        notifyObservers();
    }

    public int getResult() {
        return result;
    }
}
```

### View (CalculatorView.java)
```java
package view;

import model.CalculatorModel;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionListener;

public class CalculatorView extends JFrame implements CalculatorModel.ModelObserver {
    private JTextField num1Field = new JTextField(10);
    private JTextField num2Field = new JTextField(10);
    private JButton addButton = new JButton("Adună");
    private JLabel resultLabel = new JLabel("Rezultat: 0");
    
    private CalculatorModel model;

    public CalculatorView(CalculatorModel model) {
        this.model = model;
        model.addObserver(this);
        
        setTitle("Calculator MVC");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(300, 200);
        setLayout(new FlowLayout());
        
        add(new JLabel("Primul număr:"));
        add(num1Field);
        add(new JLabel("Al doilea număr:"));
        add(num2Field);
        add(addButton);
        add(resultLabel);
        
        setVisible(true);
    }

    public void addCalculateListener(ActionListener listener) {
        addButton.addActionListener(listener);
    }

    public int getFirstNumber() {
        try {
            return Integer.parseInt(num1Field.getText());
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    public int getSecondNumber() {
        try {
            return Integer.parseInt(num2Field.getText());
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    @Override
    public void modelUpdated() {
        resultLabel.setText("Rezultat: " + model.getResult());
    }
}
```

### Controller (CalculatorController.java)
```java
package controller;

import model.CalculatorModel;
import view.CalculatorView;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class CalculatorController {
    private CalculatorModel model;
    private CalculatorView view;

    public CalculatorController(CalculatorModel model, CalculatorView view) {
        this.model = model;
        this.view = view;
        
        this.view.addCalculateListener(new CalculateListener());
    }

    class CalculateListener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            int num1 = view.getFirstNumber();
            int num2 = view.getSecondNumber();
            model.add(num1, num2);
        }
    }
}
```

### Main (Main.java)
```java
import model.CalculatorModel;
import view.CalculatorView;
import controller.CalculatorController;

public class Main {
    public static void main(String[] args) {
        // Creăm componentele MVC
        CalculatorModel model = new CalculatorModel();
        CalculatorView view = new CalculatorView(model);
        CalculatorController controller = new CalculatorController(model, view);
    }
}
```

## Fluxul de execuție

1. Utilizatorul introduce două numere în câmpurile de text din View.
2. Utilizatorul apasă butonul "Adună".
3. View-ul trimite acest eveniment către Controller prin ActionListener.
4. Controller-ul obține valorile introduse din View și apelează metoda `add` din Model.
5. Model-ul execută operația de adunare și notifică observatorii (inclusiv View-ul) despre schimbare.
6. View-ul se actualizează pentru a afișa noul rezultat.

## Concluzii

Model-View-Controller este un pattern arhitectural puternic care oferă o structură clară pentru dezvoltarea aplicațiilor Java cu interfață grafică Swing. Prin separarea responsabilităților în componentele Model, View și Controller, obținem un cod mai organizat, mai ușor de întreținut și de extins.

Exemplul simplu prezentat ilustrează principiile de bază ale MVC și poate servi ca punct de plecare pentru aplicații mai complexe. Pe măsură ce aplicația crește în complexitate, beneficiile utilizării MVC devin tot mai evidente, permițând o dezvoltare modulară și eficientă.

Recomandări pentru implementarea MVC în proiecte mai mari:
- Folosiți interfețe pentru a defini contractele între componente
- Implementați un sistem robust de evenimente pentru comunicare
- Considerați utilizarea unui pattern Observer mai avansat
- Separați componentele View în componente mai mici și reutilizabile