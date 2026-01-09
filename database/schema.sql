-- 1. Tabela de Administrador
CREATE TABLE admin (
    login VARCHAR(50) PRIMARY KEY,
    password VARCHAR(64) NOT NULL 
);

-- Inserção do administrador padrão (Admin/Admin)
INSERT INTO admin (login, password) 
VALUES ('admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918');

-- 2. Tabela de Clientes
CREATE TABLE client (
    id SERIAL PRIMARY KEY,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telephone VARCHAR(20),
    birth_date DATE
);

-- 3. Tabela de Serviços
CREATE TABLE service (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- 4. Tabela de Cães
CREATE TABLE dog (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    breed VARCHAR(50),
    size VARCHAR(10) NOT NULL CHECK (size IN ('SMALL', 'MEDIUM', 'LARGE')),
    owner_id INTEGER REFERENCES client(id) ON DELETE CASCADE
);

-- 5. Tabela de Agendamentos
CREATE TABLE scheduling (
    id SERIAL PRIMARY KEY,
    status VARCHAR(20) DEFAULT 'Agendado', -- Agendado, Finalizado, Cancelado
    client INTEGER REFERENCES client(id) ON DELETE CASCADE,
    dog INTEGER REFERENCES dog(id) ON DELETE CASCADE,
    date DATE NOT NULL
);

-- 6. Tabela de Relacionamento Agendamento <-> Serviços (N:N)
CREATE TABLE scheduling_service (
    scheduling_id INTEGER REFERENCES scheduling(id) ON DELETE CASCADE,
    service_id INTEGER REFERENCES service(id),
    PRIMARY KEY (scheduling_id, service_id)
);

-- 7. Tabela de Prestação de Contas (Finalização)
CREATE TABLE service_provision (
    id SERIAL PRIMARY KEY,
    scheduling_id INTEGER REFERENCES scheduling(id),
    dog_id INTEGER REFERENCES dog(id),
    date DATE NOT NULL,
    discount BOOLEAN DEFAULT FALSE,
    amount_charged DECIMAL(10, 2) NOT NULL
);

-- 8. Tabela de Relacionamento Prestação <-> Serviços Realizados (N:N)
CREATE TABLE service_provision_service (
    service_provision_id INTEGER REFERENCES service_provision(id) ON DELETE CASCADE,
    service_id INTEGER REFERENCES service(id),
    PRIMARY KEY (service_provision_id, service_id)
);

-- Inserção de alguns serviços para demonstração
INSERT INTO service (name, price) VALUES ('Banho', 40.00);
INSERT INTO service (name, price) VALUES ('Tosa Higiênica', 35.00);
INSERT INTO service (name, price) VALUES ('Corte de Unha', 15.00);
INSERT INTO service (name, price) VALUES ('Vacina Antirrábica', 60.00);

