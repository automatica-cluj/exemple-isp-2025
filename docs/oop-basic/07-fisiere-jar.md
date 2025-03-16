# Fișierele JAR (Java Archive)

Fișierele JAR reprezintă un format de arhivare specific pentru Java, bazat pe formatul ZIP, care permite organizarea și distribuirea codului Java. Aceste arhive pot conține clase Java compilate, resurse precum imagini, fișiere de configurare, și metadate în fișierul MANIFEST.MF.

## Structura unui fișier JAR

Un fișier JAR standard conține:

1. **Directorul META-INF/** - un director special cu metadate, incluzând:
    - **MANIFEST.MF** - un fișier text cu informații despre arhivă și conținutul ei
    - Potențial alte fișiere de configurare (services, signatures, etc.)

2. **Clase compilate** - organizate în directoare conform structurii pachetelor
    - Ex: clasa `com.example.MyClass` va fi stocată ca `com/example/MyClass.class`

3. **Resurse** - orice fișiere adiționale (imagini, fișiere de configurare, etc.)

## Tipuri de fișiere JAR

Există mai multe tipuri de fișiere JAR:

1. **JAR executabile** - conțin o clasă principală specificată în MANIFEST.MF și pot fi executate direct
2. **JAR de bibliotecă** - conțin funcționalitate reutilizabilă pentru alte aplicații
3. **WAR (Web Application Archive)** - un tip special de JAR pentru aplicații web
4. **EAR (Enterprise Application Archive)** - un container pentru mai multe module (JAR, WAR)

## Fișierul MANIFEST.MF

Fișierul MANIFEST.MF conține metadate esențiale despre arhivă în format cheie-valoare. Unele dintre cele mai importante atribute sunt:

- **Manifest-Version**: versiunea formatului manifest (de obicei 1.0)
- **Main-Class**: clasa ce conține metoda `main()` pentru JAR-urile executabile
- **Class-Path**: locația altor JAR-uri necesare
- **Sealed**: indică dacă pachetele sunt sigilate (toate clasele unui pachet trebuie să provină din același JAR)
- **Implementation-Title**, **Implementation-Version**, **Implementation-Vendor**: metadate despre biblioteca sau aplicația conținută

Exemplu de MANIFEST.MF:
```
Manifest-Version: 1.0
Main-Class: com.example.Main
Class-Path: lib/helper.jar lib/utils.jar
Implementation-Title: ExampleApp
Implementation-Version: 1.0
Implementation-Vendor: Example Corp
```

## Crearea și manipularea fișierelor JAR

Fișierele JAR pot fi create și manipulate folosind instrumentul `jar` inclus în JDK:

- **Crearea unui JAR**:
  ```
  jar cf myapp.jar -C classes .
  ```

- **Crearea unui JAR executabil**:
  ```
  jar cfe myapp.jar com.example.Main -C classes .
  ```

- **Vizualizarea conținutului**:
  ```
  jar tf myapp.jar
  ```

- **Extragerea conținutului**:
  ```
  jar xf myapp.jar
  ```

## Împachetarea proiectelor Java cu Maven

Maven simplifică procesul de împachetare a proiectelor în fișiere JAR. Maven utilizează un fișier de configurare XML numit `pom.xml` (Project Object Model) pentru a defini structura proiectului, dependențele și procesul de build.

### Configurarea Maven pentru crearea JAR-urilor

1. **Configurare de bază în pom.xml**:
   ```xml
   <project>
       <modelVersion>4.0.0</modelVersion>
       <groupId>com.example</groupId>
       <artifactId>my-app</artifactId>
       <version>1.0-SNAPSHOT</version>
       <packaging>jar</packaging>
       
       <name>My Application</name>
       <description>A simple Java application</description>
   </project>
   ```

2. **Crearea unui JAR executabil**:
   ```xml
   <build>
       <plugins>
           <plugin>
               <groupId>org.apache.maven.plugins</groupId>
               <artifactId>maven-jar-plugin</artifactId>
               <version>3.2.0</version>
               <configuration>
                   <archive>
                       <manifest>
                           <addClasspath>true</addClasspath>
                           <classpathPrefix>lib/</classpathPrefix>
                           <mainClass>com.example.Main</mainClass>
                       </manifest>
                   </archive>
               </configuration>
           </plugin>
       </plugins>
   </build>
   ```

3. **Crearea unui JAR cu dependențe incluse (fat JAR / uber JAR)**:
   ```xml
   <build>
       <plugins>
           <plugin>
               <groupId>org.apache.maven.plugins</groupId>
               <artifactId>maven-shade-plugin</artifactId>
               <version>3.2.4</version>
               <executions>
                   <execution>
                       <phase>package</phase>
                       <goals>
                           <goal>shade</goal>
                       </goals>
                       <configuration>
                           <transformers>
                               <transformer implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
                                   <mainClass>com.example.Main</mainClass>
                               </transformer>
                           </transformers>
                       </configuration>
                   </execution>
               </executions>
           </plugin>
       </plugins>
   </build>
   ```

### Ciclul de viață Maven pentru crearea JAR-urilor

Maven folosește un ciclu de viață standardizat pentru build-ul proiectelor:

1. **compile** - compilează codul sursă
2. **test** - rulează testele
3. **package** - împachetează codul compilat într-un format distribuit (JAR)
4. **install** - instalează pachetul în repository-ul local
5. **deploy** - copiază pachetul final în repository-ul remote

Pentru a crea un JAR cu Maven, se execută comanda:
```
mvn package
```
