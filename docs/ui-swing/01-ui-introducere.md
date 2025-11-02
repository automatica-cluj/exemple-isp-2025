# Documentație: Interfețe Grafice în Java

## Introducere în Interfețele Grafice

Interfețele grafice (GUI - Graphical User Interface) reprezintă modalitatea prin care utilizatorii interacționează vizual cu o aplicație, folosind elemente precum ferestre, butoane, meniuri și alte componente grafice, în loc să folosească o interfață bazată pe linie de comandă. O interfață grafică bine proiectată este esențială pentru experiența utilizatorului, făcând aplicația mai accesibilă și mai ușor de utilizat.

## Alegerea Tehnologiei pentru Interfețe Grafice

Alegerea tehnologiei pentru dezvoltarea interfețelor grafice depinde în primul rând de tipul aplicației pe care doriți să o creați. Principalele categorii sunt:

### Aplicații Web
Pentru interfețe grafice accesibile prin browser web, tehnologiile tipice includ:
- HTML, CSS și JavaScript pentru interfața front-end
- Framework-uri JavaScript precum React, Angular sau Vue.js
- Biblioteci precum Bootstrap pentru design responsive

### Aplicații Mobile Native
Pentru aplicații mobile specifice unei platforme:
- Java/Kotlin cu Android SDK pentru aplicații Android
- Swift/Objective-C cu UIKit sau SwiftUI pentru aplicații iOS

### Aplicații Mobile Cross-Platform
Pentru aplicații mobile care rulează pe multiple platforme:
- React Native
- Flutter
- Xamarin

### Aplicații Desktop
Pentru aplicații care rulează pe sistemele de operare desktop:
- Java cu Swing, AWT sau JavaFX
- C# cu Windows Forms sau WPF pentru Windows
- Python cu biblioteci precum PyQt sau Tkinter
- Electron pentru aplicații desktop bazate pe tehnologii web

În acest curs ne vom concentra pe dezvoltarea aplicațiilor desktop folosind Java, în special tehnologia Swing, pentru a înțelege principiile fundamentale ale dezvoltării interfețelor grafice.

## Tehnologii pentru Interfețe Grafice în Java

Java oferă mai multe opțiuni pentru dezvoltarea interfețelor grafice pentru aplicații desktop:

### AWT (Abstract Window Toolkit)

AWT este cea mai veche bibliotecă pentru interfețe grafice în Java, fiind parte din JDK încă de la versiunea 1.0. Caracteristici principale:

- Folosește componentele native ale sistemului de operare
- Este dependent de platforma pe care rulează
- Oferă un set de bază de componente GUI
- Este considerat mai greu și mai puțin flexibil decât alternativele mai noi
- Are o performanță mai slabă în comparație cu bibliotecile mai moderne

### Swing

Swing a fost introdus în Java 1.2 ca o extensie a AWT și oferă o serie de îmbunătățiri:

- Este scris în întregime în Java (independent de platforma nativă)
- Oferă un aspect consistent pe toate platformele ("Look and Feel")
- Are un set mai bogat de componente GUI
- Permite personalizarea avansată a componentelor
- Folosește arhitectura Model-View-Controller (MVC)
- Este ușor de învățat și utilizat

### JavaFX

JavaFX este cea mai nouă tehnologie pentru interfețe grafice în Java, lansată în 2008 și a fost integrată în JDK între Java 8 și Java 10. Începând cu Java 11, JavaFX a fost eliminat din JDK standard și a devenit un modul separat:

- Necesită instalarea separată a bibliotecilor JavaFX sau adăugarea acestora ca dependențe în proiect (prin Maven, Gradle, etc.)
- Oferă capabilități moderne pentru aplicații desktop
- Suportă efecte vizuale avansate, animații și multimedia
- Folosește FXML pentru separarea designului de logica aplicației
- Integrează CSS pentru stilizare
- Oferă instrumente de proiectare vizuală
- Are suport mai bun pentru arhitecturile moderne și aplicațiile touch
- Este dezvoltat ca proiect open-source sub umbrela OpenJFX

## De ce Swing?

În acest curs ne vom concentra pe Swing din următoarele motive:

1. **Accesibilitate pentru începători**: Swing are o curbă de învățare mai blândă, fiind ideal pentru cei care învață pentru prima dată despre interfețe grafice.

2. **Concepte fundamentale**: Swing ilustrează foarte bine conceptele de bază ale dezvoltării interfețelor grafice, care sunt aplicabile și în alte tehnologii.

3. **Documentație vastă**: Fiind o tehnologie matură, există numeroase resurse, tutoriale și exemple disponibile.

4. **Stabilitate**: Swing este o tehnologie stabilă și bine testată, cu comportament predictibil.

5. **Transferabilitate a cunoștințelor**: Principiile învățate cu Swing (layout management, gestionarea evenimentelor, componentele GUI) sunt aplicabile și în alte tehnologii precum JavaFX sau chiar în alte limbaje de programare.

6. **Prevalență în aplicații existente**: Multe aplicații enterprise încă folosesc Swing, astfel încât învățarea acestuia rămâne relevantă pentru piața muncii.

7. **Disponibilitate directă în JDK**: Spre deosebire de JavaFX care necesită instalare separată începând cu Java 11, Swing este integrat direct în Java SE, astfel încât nu există dependențe externe de gestionat.

Deși JavaFX oferă caracteristici mai moderne, Swing rămâne o alegere excelentă pentru a înțelege fundamentele dezvoltării interfețelor grafice în Java.

## Concepte Fundamentale în Swing

### Containere și Componente

În Swing, interfața grafică este construită pe baza unui model ierarhic de componente:

**Containere** sunt componente speciale care pot conține alte componente:
- `JFrame`: Fereastră principală a aplicației
- `JPanel`: Container pentru gruparea componentelor
- `JDialog`: Fereastră pentru dialoguri
- `JApplet`: Pentru aplicații de tip applet (învechit)

**Componente** sunt elementele UI cu care interacționează utilizatorul:
- `JButton`: Buton
- `JLabel`: Text sau imagine statică
- `JTextField`: Câmp pentru introducerea textului
- `JCheckBox`: Casetă de selectare
- `JRadioButton`: Buton radio
- `JComboBox`: Listă derulantă
- `JList`: Listă de elemente

### Layout Managers

Layout Managers sunt clase care controlează poziționarea și dimensionarea componentelor într-un container:

- `FlowLayout`: Aranjează componentele în linie, de la stânga la dreapta
- `BorderLayout`: Împarte containerul în 5 regiuni (North, South, East, West, Center)
- `GridLayout`: Aranjează componentele într-un grid cu rânduri și coloane de dimensiuni egale
- `BoxLayout`: Aranjează componentele pe o singură axă (orizontală sau verticală)
- `GridBagLayout`: Cel mai flexibil layout, permite poziționare și dimensionare detaliată
- `CardLayout`: Permite afișarea unei singure componente la un moment dat, ca un stack de carduri

### Gestionarea Evenimentelor

Swing folosește un model de programare bazat pe evenimente. Când utilizatorul interacționează cu interfața (click, tastare, etc.), se generează evenimente care pot fi procesate de codul aplicației:

1. **Sursa evenimentului**: Componenta care generează evenimentul (ex. un buton)
2. **Obiectul eveniment**: Conține informații despre eveniment
3. **Listener**: Obiect care "ascultă" evenimente și definește acțiunile de efectuat

Tipuri comune de listeners:
- `ActionListener`: Pentru acțiuni simple (ex. click pe buton)
- `MouseListener`: Pentru evenimente de mouse (click, enter, exit)
- `KeyListener`: Pentru evenimente de tastatură
- `FocusListener`: Pentru evenimente de focus
- `WindowListener`: Pentru evenimente legate de fereastră

## Mecanismul de Bază al Creării unei Interfețe Grafice în Java

Crearea unei interfețe grafice în Java urmează o secvență logică de pași. Înțelegerea acestui proces vă va permite să dezvoltați interfețe grafice într-un mod structurat și eficient. Mai jos sunt prezentați pașii principali necesari pentru crearea unei interfețe grafice în Java Swing:

### 1. Importul Bibliotecilor Necesare

Primul pas este importul claselor necesare din pachetele Swing și AWT:

```java
import javax.swing.*;          // Pachetul principal pentru Swing
import java.awt.*;             // Abstract Window Toolkit pentru layout și grafică
import java.awt.event.*;       // Pentru gestionarea evenimentelor
```

### 2. Crearea și Configurarea Ferestrei Principale (JFrame)

JFrame este containerul principal al aplicației, reprezentând fereastra vizibilă pentru utilizator:

```java
// Metoda 1: Crearea unui JFrame separat
JFrame frame = new JFrame("Titlul Aplicației");
frame.setSize(600, 400);                             // Setarea dimensiunii (lățime, înălțime)
frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); // Închiderea aplicației la închiderea ferestrei
frame.setLocationRelativeTo(null);                    // Centrarea ferestrei pe ecran
frame.setResizable(true);                            // Permiterea redimensionării (opțional)
frame.setIconImage(new ImageIcon("icon.png").getImage()); // Setarea iconiței ferestrei (opțional)

// SAU Metoda 2: Extinderea clasei JFrame
public class AplicatiaMea extends JFrame {
    public AplicatiaMea() {
        setTitle("Titlul Aplicației");
        setSize(600, 400);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        // ...restul configurărilor
    }
}
```

### 3. Alegerea și Configurarea Layout Manager-ului

Layout Manager-ul determină cum sunt aranjate componentele în container:

```java
// Opțiunea 1: Setarea Layout Manager direct pe JFrame
frame.setLayout(new FlowLayout()); // Componentele vor fi aranjate în flux

// Opțiunea 2: Crearea unui JPanel cu Layout Manager și adăugarea în JFrame
JPanel panel = new JPanel();
panel.setLayout(new BorderLayout()); // Sau alt layout manager
frame.add(panel);

// Opțiunea 3: Utilizarea mai multor paneluri cu layout managers diferite
JPanel mainPanel = new JPanel(new BorderLayout());
JPanel topPanel = new JPanel(new FlowLayout());
JPanel centerPanel = new JPanel(new GridLayout(3, 2, 10, 10)); // 3 rânduri, 2 coloane, gap 10px

mainPanel.add(topPanel, BorderLayout.NORTH);
mainPanel.add(centerPanel, BorderLayout.CENTER);
frame.add(mainPanel);
```

### 4. Crearea și Configurarea Componentelor

Adăugați componentele necesare pentru interfața utilizator:

```java
// Crearea componentelor
JLabel titleLabel = new JLabel("Aplicație de Exemplu");
titleLabel.setFont(new Font("Arial", Font.BOLD, 20)); // Setarea fontului

JTextField inputField = new JTextField(20); // 20 de caractere vizibile
JButton submitButton = new JButton("Trimite");
JCheckBox optionCheckbox = new JCheckBox("Activează opțiunea");

// Personalizarea componentelor (opțional)
submitButton.setBackground(new Color(100, 180, 100)); // Setarea culorii de fundal
submitButton.setForeground(Color.WHITE);              // Setarea culorii textului
submitButton.setFocusPainted(false);                  // Elimină border-ul de focus
```

### 5. Adăugarea Componentelor în Containere

Adăugați componentele create în containerele configurate anterior:

```java
// Adăugarea în layout-uri standard (exemplu pentru BorderLayout)
topPanel.add(titleLabel);
centerPanel.add(new JLabel("Introduceți datele:"));
centerPanel.add(inputField);
centerPanel.add(new JLabel("Opțiuni:"));
centerPanel.add(optionCheckbox);
centerPanel.add(new JLabel()); // Celulă goală pentru aranjament
centerPanel.add(submitButton);

// Adăugarea în layout-uri specifice (exemplu pentru BorderLayout)
panel.add(titleLabel, BorderLayout.NORTH);
panel.add(inputField, BorderLayout.CENTER);
panel.add(submitButton, BorderLayout.SOUTH);
```

### 6. Atașarea Event Handler-elor

Adăugați logica pentru a răspunde la interacțiunile utilizatorului:

```java
// Metoda 1: Folosind clase anonime interne
submitButton.addActionListener(new ActionListener() {
    @Override
    public void actionPerformed(ActionEvent e) {
        String input = inputField.getText();
        JOptionPane.showMessageDialog(frame, "Ați introdus: " + input);
    }
});

// Metoda 2: Folosind expresii lambda (Java 8+)
submitButton.addActionListener(e -> {
    String input = inputField.getText();
    JOptionPane.showMessageDialog(frame, "Ați introdus: " + input);
});

// Metoda 3: Implementarea interfeței în clasa principală
public class AplicatiaMea extends JFrame implements ActionListener {
    // ...
    
    public AplicatiaMea() {
        // ...
        submitButton.addActionListener(this);
    }
    
    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == submitButton) {
            // Acțiunea pentru buton
        }
    }
}
```

### 7. Afișarea Interfației Grafice

La final, faceți interfața vizibilă pentru utilizator:

```java
// Este important să faceți toate operațiunile pe interfață în Event Dispatch Thread
SwingUtilities.invokeLater(() -> {
    // Pentru Metoda 1 (JFrame separat)
    frame.pack(); // Opțional - ajustează dimensiunea ferestrei la componente
    frame.setVisible(true); // Afișează fereastra
    
    // SAU pentru Metoda 2 (clasă extinsă din JFrame)
    AplicatiaMea app = new AplicatiaMea();
    app.pack(); // Opțional
    app.setVisible(true);
});
```

### 8. Gestionarea Aspectelor Avansate

Pentru interfețe mai complexe, puteți adăuga funcționalități suplimentare:

```java
// Setarea unui Look and Feel specific
try {
    UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
    // SAU pentru un L&F specific:
    // UIManager.setLookAndFeel("javax.swing.plaf.nimbus.NimbusLookAndFeel");
} catch (Exception e) {
    e.printStackTrace();
}

// Adăugarea de meniuri
JMenuBar menuBar = new JMenuBar();
JMenu fileMenu = new JMenu("Fișier");
JMenuItem exitItem = new JMenuItem("Ieșire");
exitItem.addActionListener(e -> System.exit(0));
fileMenu.add(exitItem);
menuBar.add(fileMenu);
frame.setJMenuBar(menuBar);

// Adăugarea de scurtături de tastatură
submitButton.setMnemonic(KeyEvent.VK_S); // Alt+S activează butonul
```


## Sfaturi și Bune Practici

1. **Utilizați Event Dispatch Thread**: Toate operațiile pe interfață trebuie efectuate astfel:
   ```java
   SwingUtilities.invokeLater(() -> {
       // Cod pentru interfața grafică
   });
   ```

2. **Separați logica de afaceri de interfața grafică**: Folosiți modele de design precum MVC pentru a separa codul.

3. **Folosiți layout managers în loc de poziționare absolută**: Aceasta asigură că interfața se adaptează la diferite dimensiuni de ecran.

4. **Gestionați erorile în mod grafic**: Folosiți dialoguri pentru afișarea erorilor în loc de consolă.

5. **Folosiți mnemonici și acceleratori pentru accesibilitate**: Aceștia permit utilizatorilor să folosească tastatura pentru navigare.

6. **Testați pe multiple platforme**: Verificați că interfața arată și funcționează corect pe diferite sisteme de operare.

7. **Folosiți Look and Feel consistent**: Setați un look and feel adecvat pentru aplicație:
   ```java
   try {
       UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
   } catch (Exception e) {
       e.printStackTrace();
   }
   ```

## Resurse Suplimentare

- [Documentația oficială Oracle pentru Swing](https://docs.oracle.com/javase/tutorial/uiswing/)
- [Java Swing (GUI) Programming: From Beginner to Expert](https://www.udemy.com/course/java-swing-complete/)
- [Swing Sightings](https://www.oracle.com/technical-resources/articles/java/swingsightings.html)
- [Java Swing Layout Management](https://docs.oracle.com/javase/tutorial/uiswing/layout/index.html)
- [OpenJFX - Site oficial](https://openjfx.io/) (pentru cei interesați în JavaFX)
- [Documentația și ghiduri de instalare JavaFX](https://openjfx.io/openjfx-docs/) (pentru adăugarea JavaFX în proiecte începând cu Java 11)

