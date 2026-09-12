# 🐕 Cão Q-Late - Sistema de Gerenciamento para Petshop

Sistema web desenvolvido em Java para gestão completa de petshops, incluindo cadastro de clientes, pets, agendamentos e controle financeiro.

**Cão Q-Late** é um sistema completo de gerenciamento para petshops que permite:

- 👥 Cadastro e gestão de clientes
- 🐶 Registro de cães com informações detalhadas (raça, porte, proprietário)
- ✂️ Catálogo de serviços e precificação dinâmica
- 📅 Sistema de agendamentos com validação de disponibilidade
- 💰 Controle de prestação de serviços com descontos automáticos
- 📊 Relatórios financeiros e histórico de atendimentos

> **Disciplina**: Desenvolvimento de Aplicações Web  
> **Curso**: Sistemas para Internet  
> **Tipo**: Trabalho Individual 

<br>

## 🔍 Prévia

<img src="/readme-img/home.jpg" width="800" alt="Página exemplo1">

<img src="/readme-img/dashboard.jpg" width="800" alt="Página exemplo2">

<img src="/readme-img/report.jpg" width="800" alt="Página exemplo3">

<br>

## 🌐 Tecnologias

- **Java 21** - Linguagem principal
- **Jakarta Servlet/JSP** - Framework web
- **JSTL** - Template engine
- **Maven** - Gerenciamento de dependências
- **PostgreSQL 42.7.7** - Banco de dados relacional
- **JDBC** - Conectividade com banco
- **Apache Tomcat 10.1** - Container de servlets
- **HTML5 + CSS3** - Interface moderna e responsiva
- **JavaScript (ES6+)** - Validações e interatividade
- **SHA-256** - Hash de senhas no frontend
- **Docker e Docker Compose** - Imagens personalizadas e orquestração via Docker Compose.

<br>

## 📦 Pré-requisitos

- JDK 24+
- Apache Tomcat 10.1+
- PostgreSQL 12+
- Maven 3.x

<br>

## ✨ Funcionalidades

- 🔒 **Sistema de Login**: Hash de senhas no frontend com Web Crypto API
- 🎯 **Dashboard intuitivo** Acesso rápido às principais funcionalidades
- 📝 **Validação de formulários** Verificação de dados em tempo real no frontend
- 🛡️ **Transações ACID** Segurança e integridade em operações críticas
- 📱 **Design Responsivo** Funciona perfeitamente em todos os dispositivos

<br>

## 💻 Arquitetura do Sistema

### Padrão MVC

```
┌─────────────┐      ┌──────────────┐      ┌──────────┐
│   View      │ ───> │  Controller  │ ───> │   Model  │
│  (JSP)      │ <─── │  (Servlet)   │ <─── │  (DAO)   │
└─────────────┘      └──────────────┘      └──────────┘
                             │
                             ↓
                     ┌──────────────┐
                     │   Database   │
                     │ (PostgreSQL) │
                     └──────────────┘
```

<br>

## 🔐 Credenciais de Acesso

**Login:** `admin`  
**Senha:** `admin`

> ⚠️ A senha é hasheada com SHA-256 no frontend antes do envio. Hash armazenado: `8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918`

<br>

## 📊 Regras de Negócio

1. **Único Administrador**: Sistema permite apenas um usuário admin
2. **Validação de Propriedade**: Apenas o dono pode agendar serviços para seu cão
3. **Desconto Automático**: 10% de desconto em 3+ serviços na mesma prestação
4. **Status de Agendamento**: `Agendado` → `Finalizado` ou `Cancelado`
5. **Histórico Completo**: Todos os serviços prestados são mantidos no histórico

<br>

## 🛠️ Destaques Técnicos

### 🔒 Hash de Senhas com Web Crypto API

As senhas são protegidas no frontend utilizando SHA-256 antes do envio ao servidor.

```javascript
async function hashPassword(password) {
    const encoder = new TextEncoder();
    const data = encoder.encode(password);
    const hashBuffer = await crypto.subtle.digest('SHA-256', data);
    const hashArray = Array.from(new Uint8Array(hashBuffer));
    return hashArray.map(b => b.toString(16).padStart(2, '0')).join('');
}
```

### 📅 Validação de Agendamentos

Verificação de disponibilidade e validação de propriedade do animal antes da criação do agendamento.

```java
// Verifica se o cão pertence ao cliente
public boolean dog_belongs_client(int dog_id, int client_id)

// Verifica disponibilidade da data
public boolean is_date_available(int dog_id, Date date)

// Registra agendamento com múltiplos serviços
public boolean register_scheduling(Scheduling scheduling)
```

### 💰 Desconto Automático

Aplicação automática de 10% de desconto quando três ou mais serviços são realizados na mesma prestação.

```java
boolean hasDiscount = services.size() >= 3;
float amountCharged = hasDiscount ? total * 0.9f : total;
```

### 📊 Relatórios Financeiros

```java
// Relatório de prestações em período
public List<ServiceProvision> provision_report(Date startDate, Date endDate)

// Cálculo de receita total
public float calculate_total_revenue(Date startDate, Date endDate)
```