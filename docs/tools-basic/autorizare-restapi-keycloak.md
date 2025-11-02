# Keycloak pentru Autentificare și Autorizare REST API

## Introducere

**Keycloak** este o soluție open-source de Identity and Access Management (IAM) dezvoltată de Red Hat. Oferă servicii complete de autentificare și autorizare pentru aplicații moderne, implementând standardele OAuth2, OpenID Connect și SAML.

## Concepte Fundamentale

### Identity Provider (IdP)
Keycloak funcționează ca un **Identity Provider centralizat** care:
- Gestionează identitățile utilizatorilor
- Autentifică utilizatorii prin diverse metode
- Emite token-uri de acces pentru aplicații
- Centralizează politicile de securitate

### OAuth2 și OpenID Connect
- **OAuth2** - Protocol de autorizare pentru accesul la resurse
- **OpenID Connect** - Extensie a OAuth2 pentru autentificare
- **JWT (JSON Web Tokens)** - Format standard pentru token-urile de acces

## Arhitectura de Securitate

### Fluxul de Autentificare

1. **Autentificare Utilizator**
    - Clientul trimite credențialele către Keycloak
    - Keycloak validează identitatea utilizatorului

2. **Emiterea Token-urilor**
    - Access Token (JWT) - pentru accesul la resurse
    - Refresh Token - pentru reînnoirea access token-urilor
    - ID Token - informații despre identitatea utilizatorului

3. **Accesul la API**
    - Clientul include Access Token în header-ul Authorization
    - API-ul validează token-ul cu Keycloak
    - API-ul returnează datele solicitate

## Avantajele Keycloak

### Centralizarea Securității
- **Single Point of Authentication** - o singură sursă de adevăr pentru identități
- **Consistent Security Policies** - politici uniforme între aplicații
- **Centralized User Management** - gestionarea utilizatorilor într-un singur loc

### Standardizare
- **OAuth2/OpenID Connect Compliance** - compatibilitate cu standardele industriei
- **Vendor Independence** - nu există dependență de furnizori proprietari
- **Ecosystem Integration** - integrare ușoară cu framework-uri moderne

### Funcționalități Avansate
- **Single Sign-On (SSO)** - autentificare unică pentru multiple aplicații
- **Social Login** - integrare cu provideri precum Google, Facebook, GitHub
- **Multi-factor Authentication** - securitate suplimentară prin 2FA/MFA
- **Role-Based Access Control** - autorizare granulară bazată pe roluri

## Securizarea REST API-urilor

### Resource Server Pattern
REST API-ul funcționează ca **Resource Server** care:
- Acceptă request-uri cu token-uri JWT
- Validează token-urile cu Keycloak
- Autorizează accesul bazat pe roluri și scope-uri

### Token Validation
```
1. Client Request → Include JWT Token in Authorization Header
2. API Gateway → Extract and Validate Token Structure
3. Token Verification → Verify Signature with Keycloak Public Key
4. Claims Extraction → Extract User Info and Roles
5. Authorization → Check Permissions Based on Roles
6. API Response → Return Data or Deny Access
```

## Implementarea cu Spring Boot

### Dependințe Necesare
```xml
<!-- OAuth2 Resource Server -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-oauth2-resource-server</artifactId>
</dependency>

<!-- JWT Support -->
<dependency>
    <groupId>org.springframework.security</groupId>
    <artifactId>spring-security-oauth2-jose</artifactId>
</dependency>
```

### Configurare Minimală
```yaml
spring:
  security:
    oauth2:
      resourceserver:
        jwt:
          issuer-uri: http://keycloak-server/realms/my-realm
```

### Securizarea Endpoint-urilor
```java
@RestController
@PreAuthorize("hasRole('USER')")
public class SecureController {
    
    @GetMapping("/protected")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<String> adminOnly() {
        return ResponseEntity.ok("Admin access granted");
    }
}
```

## Proiect Demonstrativ

Pentru a testa efectiv utilizarea Keycloak cu REST API-uri, consultați repository-ul demonstrativ care conține:

- Configurare completă Keycloak cu Docker Compose
- Implementare REST API cu Spring Boot
- Exemple de testare cu curl și Swagger UI
- Documentație detaliată pentru setup și configurare

[Link Repository](https://github.com/automatica-cluj/demo-springboot-keycloak)