# MkDocs Setup cu Docker

Acest ghid vă arată cum să rulați documentația local folosind MkDocs și Docker.

## Cerințe

- Docker Desktop instalat și rulând
- Docker Compose (inclus în Docker Desktop)

## Comenzi Rapide

### Pornire server de dezvoltare

```bash
docker-compose up
```

Apoi deschideți în browser: http://localhost:8000

Documentația se va reîncărca automat când modificați fișierele.

### Oprire server

Apăsați `Ctrl+C` în terminal sau:

```bash
docker-compose down
```

### Rebuild după modificări la Dockerfile

```bash
docker-compose up --build
```

### Construire site static

Pentru a genera site-ul HTML static în directorul `site/`:

```bash
docker-compose run --rm mkdocs mkdocs build
```

## Comenzi MkDocs Directe (cu Docker)

### Servire documentație (mod dezvoltare)

```bash
docker-compose run --rm --service-ports mkdocs mkdocs serve --dev-addr=0.0.0.0:8000
```

### Construire documentație

```bash
docker-compose run --rm mkdocs mkdocs build
```

### Curățare fișiere generate

```bash
docker-compose run --rm mkdocs mkdocs build --clean
```

### Afișare versiune MkDocs

```bash
docker-compose run --rm mkdocs mkdocs --version
```

## Structura Fișierelor

```
exemple-isp-2025/
├── mkdocs.yml              # Configurație MkDocs
├── Dockerfile              # Imagine Docker pentru MkDocs
├── docker-compose.yml      # Configurație Docker Compose
├── .dockerignore          # Fișiere ignorate de Docker
├── MKDOCS-SETUP.md        # Acest ghid
├── site/                  # Output generat (ignorat de Git)
└── docs/                  # Documentația (fișiere Markdown)
    ├── index.md               # Pagina principală
    ├── oop-basic/             # Documentație OOP Fundamentală
    ├── oop-advanced/          # Documentație OOP Avansată
    ├── concurrent/            # Documentație Programare Concurentă
    ├── ui-swing/              # Documentație Interfețe Grafice
    ├── oop-design/            # Documentație Design Patterns
    ├── uml/                   # Documentație UML
    ├── tools-basic/           # Documentație Unelte
    ├── rt-concepts/           # Documentație Timp Real - Concepte
    ├── rt-preemt-rt/          # Documentație Timp Real - Linux
    ├── rt-modeling/           # Documentație Timp Real - Modelare
    └── exercitii-si-intrebari/ # Exerciții
```

## Configurație

### mkdocs.yml

Fișierul principal de configurație care conține:
- Informații despre site (titlu, descriere)
- Tema (Material for MkDocs)
- Structura navigației
- Extensii Markdown
- Plugin-uri

### Tema Material

Documentația folosește [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/), o temă modernă cu multe funcționalități:
- Navigare cu tabs și secțiuni
- Mod dark/light
- Căutare integrată
- Syntax highlighting pentru cod
- Emoji și iconițe
- Design responsive

## Personalizare

### Schimbarea temei de culori

Editați `mkdocs.yml`, secțiunea `theme.palette`:

```yaml
theme:
  palette:
    scheme: default      # sau 'slate' pentru dark mode implicit
    primary: indigo      # culoare primară
    accent: indigo       # culoare accent
```

Culori disponibile: red, pink, purple, deep purple, indigo, blue, light blue, cyan, teal, green, light green, lime, yellow, amber, orange, deep orange

### Adăugare pagini noi

1. Creați fișierul `.md` în directorul corespunzător
2. Adăugați referința în `mkdocs.yml` sub `nav:`

Exemplu:

```yaml
nav:
  - Acasă: index.md
  - Concepte Fundamentale:
    - Introducere: oop-basic/README.md
    - Noua Pagină: oop-basic/pagina-noua.md  # <- adăugați aici
```

### Extensii Markdown

Extensiile activate includ:
- **Code highlighting**: Syntax highlighting pentru Java și alte limbaje
- **Admonitions**: Blocuri de notă, avertisment, info
- **Emoji**: Suport pentru emoji :smile:
- **Tables**: Tabele Markdown extinse
- **Task lists**: Liste cu checkbox-uri

Exemple:

```markdown
!!! note "Notă importantă"
    Acesta este un bloc de notă.

!!! warning "Atenție"
    Acesta este un avertisment.

\`\`\`java
public class Example {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
\`\`\`
```

## Troubleshooting

### Portul 8000 este deja folosit

Modificați portul în `docker-compose.yml`:

```yaml
ports:
  - "8001:8000"  # schimbați 8000 cu alt port
```

### Modificările nu apar în browser

1. Asigurați-vă că fișierele sunt salvate
2. Verificați consola Docker pentru erori
3. Reîncărcați forțat pagina (Ctrl+Shift+R sau Cmd+Shift+R)
4. Rebuild containerul: `docker-compose up --build`

### Erori de build

Verificați sintaxa YAML în `mkdocs.yml`:
```bash
docker-compose run --rm mkdocs mkdocs build --strict
```

## Resurse Utile

- [MkDocs Documentation](https://www.mkdocs.org/)
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
- [Markdown Guide](https://www.markdownguide.org/)
- [Python Markdown Extensions](https://facelessuser.github.io/pymdown-extensions/)
