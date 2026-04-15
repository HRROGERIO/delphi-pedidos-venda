-- =========================================================
-- SISTEMA DE PEDIDOS DE VENDA
-- BANCO DE DADOS: MYSQL
--
-- Autor: Hamilton Rodrigo Rogério
-- Data: 13/03/2026
--
-- Este script cria toda a estrutura do banco de dados
-- necessária para o funcionamento do sistema de pedidos.
--
-- Estrutura criada:
--   - Banco de dados
--   - Tabela de clientes
--   - Tabela de produtos
--   - Tabela de pedidos
--   - Tabela de itens do pedido
--   - Chaves primárias
--   - Chaves estrangeiras
--   - Índices
--   - Dados de teste
-- =========================================================



-- =========================================================
-- CRIAÇÃO DO BANCO DE DADOS
-- =========================================================

CREATE DATABASE IF NOT EXISTS sistema_pedidos;

USE sistema_pedidos;



-- =========================================================
-- TABELA: CLIENTES
-- Armazena os dados cadastrais dos clientes
-- =========================================================

CREATE TABLE clientes (

    codigo INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(100),
    uf CHAR(2),

    CONSTRAINT pk_clientes
    PRIMARY KEY (codigo)

);


-- =========================================================
-- TABELA: PRODUTOS
-- Armazena os produtos disponíveis para venda
-- =========================================================

CREATE TABLE produtos (

    codigo INT NOT NULL,
    descricao VARCHAR(150) NOT NULL,
    preco_venda DECIMAL(10,2) NOT NULL,

    CONSTRAINT pk_produtos
    PRIMARY KEY (codigo)

);



-- =========================================================
-- TABELA: PEDIDOS
-- Armazena os dados gerais do pedido
-- =========================================================

CREATE TABLE pedidos (

    numero_pedido INT NOT NULL auto_increment,
    data_emissao DATE NOT NULL,
    codigo_cliente INT NOT NULL,
    valor_total DECIMAL(12,2) DEFAULT 0,

    CONSTRAINT pk_pedidos
    PRIMARY KEY (numero_pedido),

    CONSTRAINT fk_pedidos_clientes
    FOREIGN KEY (codigo_cliente)
    REFERENCES clientes(codigo)

);



-- =========================================================
-- TABELA: PEDIDOS_PRODUTOS
-- Armazena os itens de cada pedido
-- =========================================================

CREATE TABLE pedidos_produtos (

    id INT NOT NULL AUTO_INCREMENT,
    numero_pedido INT NOT NULL,
    codigo_produto INT NOT NULL,
    quantidade INT NOT NULL,
    vr_unitario DECIMAL(10,2) NOT NULL,
    vr_total DECIMAL(12,2) NOT NULL,

    CONSTRAINT pk_pedidos_produtos
    PRIMARY KEY (id),

    CONSTRAINT fk_pedido_produto_pedido
    FOREIGN KEY (numero_pedido)
    REFERENCES pedidos(numero_pedido),

    CONSTRAINT fk_pedido_produto_produto
    FOREIGN KEY (codigo_produto)
    REFERENCES produtos(codigo)

);



-- =========================================================
-- CRIAÇÃO DE ÍNDICES PARA MELHOR PERFORMANCE
-- =========================================================

CREATE INDEX idx_pedidos_cliente
ON pedidos (codigo_cliente);

CREATE index idx_pedidos_produtos_pedido
ON pedidos_produtos (numero_pedido);

CREATE INDEX idx_pedidos_produtos_produto
ON pedidos_produtos (codigo_produto);



-- =========================================================
-- DADOS DE TESTE - CLIENTES
-- =========================================================

INSERT INTO clientes VALUES (1,'João Silva','Franca','SP');
INSERT INTO clientes VALUES (2,'Maria Oliveira','Ribeirão Preto','SP');
INSERT INTO clientes VALUES (3,'Carlos Souza','Uberaba','MG');
INSERT INTO clientes VALUES (4,'Ana Paula','Franca','SP');
INSERT INTO clientes VALUES (5,'Pedro Santos','Batatais','SP');
INSERT INTO clientes VALUES (6,'Juliana Costa','Franca','SP');
INSERT INTO clientes VALUES (7,'Lucas Lima','Ribeirão Preto','SP');
INSERT INTO clientes VALUES (8,'Fernanda Rocha','Franca','SP');
INSERT INTO clientes VALUES (9,'Rafael Martins','Uberlândia','MG');
INSERT INTO clientes VALUES (10,'Patricia Alves','Franca','SP');
INSERT INTO clientes VALUES (11,'Ricardo Mendes','Franca','SP');
INSERT INTO clientes VALUES (12,'Camila Ferreira','Ribeirão Preto','SP');
INSERT INTO clientes VALUES (13,'André Barros','Franca','SP');
INSERT INTO clientes VALUES (14,'Bruno Ribeiro','Batatais','SP');
INSERT INTO clientes VALUES (15,'Paula Nunes','Franca','SP');
INSERT INTO clientes VALUES (16,'Roberto Dias','Franca','SP');
INSERT INTO clientes VALUES (17,'Sandra Lopes','Ribeirão Preto','SP');
INSERT INTO clientes VALUES (18,'Marcelo Gomes','Franca','SP');
INSERT INTO clientes VALUES (19,'Tatiane Duarte','Uberaba','MG');
INSERT INTO clientes VALUES (20,'Felipe Castro','Franca','SP');



-- =========================================================
-- DADOS DE TESTE - PRODUTOS
-- =========================================================

INSERT INTO produtos VALUES (1,'Notebook Dell',4500.00);
INSERT INTO produtos VALUES (2,'Mouse Logitech',120.00);
INSERT INTO produtos VALUES (3,'Teclado Mecânico',350.00);
INSERT INTO produtos VALUES (4,'Monitor 24 Polegadas',900.00);
INSERT INTO produtos VALUES (5,'HD SSD 1TB',600.00);
INSERT INTO produtos VALUES (6,'Memória RAM 16GB',420.00);
INSERT INTO produtos VALUES (7,'Impressora HP',850.00);
INSERT INTO produtos VALUES (8,'Cadeira Gamer',1300.00);
INSERT INTO produtos VALUES (9,'Webcam Full HD',250.00);
INSERT INTO produtos VALUES (10,'Headset Gamer',300.00);
INSERT INTO produtos VALUES (11,'Placa de Vídeo RTX',3500.00);
INSERT INTO produtos VALUES (12,'Processador Intel i7',2800.00);
INSERT INTO produtos VALUES (13,'Notebook Lenovo',3900.00);
INSERT INTO produtos VALUES (14,'Tablet Samsung',1600.00);
INSERT INTO produtos VALUES (15,'Smartphone Motorola',1800.00);
INSERT INTO produtos VALUES (16,'Roteador WiFi',200.00);
INSERT INTO produtos VALUES (17,'Switch 8 Portas',150.00);
INSERT INTO produtos VALUES (18,'Cabo HDMI',40.00);
INSERT INTO produtos VALUES (19,'Fonte 600W',350.00);
INSERT INTO produtos VALUES (20,'Gabinete Gamer',500.00);



-- =========================================================
-- FIM DO SCRIPT
-- =========================================================