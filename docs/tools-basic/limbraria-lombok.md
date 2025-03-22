## Librăria Lombok

Lombok este o librărie Java care reduce codul boilerplate (repetitiv) prin generarea automată a metodelor comune precum getteri, setteri, constructori, etc.

### Instalare și Configurare

1. Adăugați dependința Lombok în fișierul pom.xml (pentru Maven):
   ```xml
   <dependency>
       <groupId>org.projectlombok</groupId>
       <artifactId>lombok</artifactId>
       <version>1.18.26</version>
       <scope>provided</scope>
   </dependency>
   ```

2. Instalați pluginul Lombok în IDE-ul dvs. (pentru generarea codului în timpul dezvoltării).

### Adnotări Lombok frecvent utilizate

1. **@Getter / @Setter**
    - Generează automat metodele getter și setter pentru toate câmpurile clasei
    - Poate fi aplicat la nivel de câmp individual sau la nivel de clasă

2. **@NoArgsConstructor**
    - Generează un constructor fără parametri

3. **@AllArgsConstructor**
    - Generează un constructor cu parametri pentru toate câmpurile clasei

4. **@RequiredArgsConstructor**
    - Generează un constructor cu parametri doar pentru câmp