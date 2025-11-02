# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **documentation repository** for "Ingineria Sistemelor de Programe" (Software Systems Engineering) and "Structuri Software pentru Aplicații de Timp Real" (Software Structures for Real-Time Applications) courses at the Technical University of Cluj-Napoca, Romania. The documentation is published as a **Jekyll-based GitHub Pages site** using the Hacker theme.

**Primary language**: Romanian
**Format**: Markdown documentation organized by topic
**Site generator**: Jekyll with `jekyll-theme-hacker`

## Documentation Structure

The documentation is organized into the following main sections:

### Core Java Programming
- **oop-basic/** - Fundamental OOP concepts: lexical structures, control flow, primitives, Strings, classes/objects, packages, JARs, inheritance, aggregation, composition
- **oop-advanced/** - Advanced topics: interfaces, abstract classes, generics, Optional, collections, comparators, Streams API, I/O streams, lambdas, try-with-resources, exception handling, annotations

### Software Design & Architecture
- **oop-design/** - Design patterns and principles: OOP fundamentals, SOLID principles, KISS/DRY/YAGNI, creational/structural/behavioral patterns, SDLC introduction
- **uml/** - UML modeling: use-case diagrams, class diagrams, sequence diagrams, communication diagrams, state diagrams

### User Interfaces & Concurrency
- **ui-swing/** - Java Swing GUI development: layouts, components, tables, lists, MVC pattern, event handling
- **concurrent/** - Multi-threading: thread basics, thread-safe collections, blocking queues, atomic types, virtual threads

### Real-Time Systems
- **rt-concepts/** - Real-time theory: task model, scheduling algorithms (RM, DM, EDF, LLF), hybrid algorithms
- **rt-preempt-rt/** - Linux PREEMPT_RT: kernel patches, scheduling policies, practical exercises
- **rt-modeling/** - RT modeling: UML-RT capsules, Giotto, UPPAAL

### Tools & Exercises
- **tools-basic/** - Development tools: Git, Maven, Docker, IntelliJ, Azure (VMs, Container Apps), GitHub Actions, Lombok, Keycloak
- **exercitii-si-intrebari/** - Practice exercises for OOP basics, advanced OOP, interfaces/abstract classes, collections

## Key Files

- **SUMMARY.md** - Table of contents for all documentation pages (GitBook-style structure)
- **index.md** - Main landing page with organized navigation by topic
- **README.md** - Short introduction to the documentation
- **_config.yml** - Jekyll configuration with site metadata and theme settings

## Documentation Conventions

### Markdown Style
- All documentation files use `.md` extension
- Each major topic has a `README.md` in its directory
- Files are numbered for sequential reading (e.g., `01-structuri-lexicale.md`, `02-structuri-repetitive-conditionale.md`)
- Use Romanian language for all content
- Include emoji markers in index.md for visual categorization (🧰, 📦, ⚠️, 🔧, 🔀, 📚, etc.)

### Content Structure
Each documentation file typically includes:
- Main title as H1 (`#`)
- Table of contents (Cuprins) for longer documents
- Section headings using H2 (`##`) and H3 (`###`)
- Code examples in fenced blocks with `java` syntax highlighting
- Practical exercises at the end (when applicable)

### Cross-References
- Use relative paths for internal links (e.g., `[text](../oop-basic/05-clasa-si-obiect.md)`)
- Link to related topics within the documentation
- Reference external resources with full URLs

## Common Tasks

### Adding New Documentation
1. Create the `.md` file in the appropriate topic directory
2. Follow the numbering convention if it's part of a sequence
3. Add an entry to `SUMMARY.md` maintaining the hierarchy
4. Optionally add to the structured navigation in `index.md`
5. Include a `README.md` section header if creating a new topic directory

### Updating Existing Content
- Maintain consistency with existing formatting and style
- Keep code examples complete and runnable when possible
- Update cross-references if file paths change
- Ensure Romanian technical terminology is accurate

### Jekyll Site Management
- The site uses `remote_theme: pages-themes/hacker@v0.2.0`
- No local Jekyll build commands needed (GitHub Pages handles deployment)
- Front matter in markdown files should include `title:` for proper rendering
- Images are stored in `media/` directory

## Important Notes

### Language & Audience
- All documentation is in **Romanian** - maintain this consistently
- Target audience: undergraduate students in Automation/Computer Science
- Balance theoretical concepts with practical Java examples

### Code Examples
- Provide complete, compilable Java code snippets
- Use modern Java features (Java 8+) including streams, lambdas, Optional
- Show both correct implementations and common mistakes/anti-patterns
- Include output examples where relevant

### Real-Time Systems Content
- RT sections combine theory (scheduling algorithms) with practical Linux PREEMPT_RT
- UML-RT modeling uses capsule-based architecture (derived from ROOM language)
- Reference academic papers when introducing complex RT concepts

### Continuous Development
The documentation states it is "în dezvoltare continuă" (under continuous development) - sections may be incomplete or revised over time.
