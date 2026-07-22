/*
==========================================================
PROJETO: SALES ANALYTICS SQL
Autor: Karlos Eduardo
Descrição:
Banco de dados para análise de vendas de uma empresa fictícia
de tecnologia (TechStore Brasil).
==========================================================
*/

DROP DATABASE IF EXISTS sales_analytics;

CREATE DATABASE sales_analytics;

USE sales_analytics;

-- ===========================
-- TABELA CLIENTES
-- ===========================

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    cidade VARCHAR(100),
    estado CHAR(2),
    idade INT,
    sexo CHAR(1)
);

-- ===========================
-- TABELA CATEGORIAS
-- ===========================

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(100)
);

-- ===========================
-- TABELA PRODUTOS
-- ===========================

CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(150),
    preco DECIMAL(10,2),
    estoque INT,
    id_categoria INT,

    FOREIGN KEY (id_categoria)
        REFERENCES categorias(id_categoria)
);

-- ===========================
-- TABELA PEDIDOS
-- ===========================

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE,

    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
);

-- ===========================
-- TABELA ITENS_PEDIDO
-- ===========================

CREATE TABLE itens_pedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_produto INT,
    quantidade INT,
    preco_unitario DECIMAL(10,2),

    FOREIGN KEY (id_pedido)
        REFERENCES pedidos(id_pedido),

    FOREIGN KEY (id_produto)
        REFERENCES produtos(id_produto)
);