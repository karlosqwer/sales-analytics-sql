# 📊 Sales Analytics SQL

### End-to-End Sales Analytics Project with MySQL, SQL, Python, Pandas and Power BI

![Python](https://img.shields.io/badge/Python-3.x-3776AB?logo=python&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?logo=mysql&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-Data%20Analysis-150458?logo=pandas&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?logo=powerbi&logoColor=black)

Projeto completo de análise de vendas que simula o fluxo de trabalho de um Analista de Dados, desde a modelagem de um banco relacional até análises em SQL, processamento com Python e visualização no Power BI.

---

## 📊 Dashboard Power BI

O dashboard apresenta os principais indicadores comerciais e permite analisar tendências, categorias, produtos e estados com maior faturamento.

![Sales Analytics Dashboard](dashboard/dashboard-print.png)

Principais indicadores:

- Faturamento total
- Total de pedidos
- Produtos vendidos
- Ticket médio
- Faturamento mensal
- Faturamento por categoria
- Top 10 produtos por faturamento
- Faturamento por estado

Arquivo editável:

```text
dashboard/POWER-BI-BD.pbix
```

---

## 🔄 Fluxo do Projeto

```text
Arquivos CSV
     │
     ▼
Banco de Dados MySQL
     │
     ▼
Consultas de Negócio em SQL
     │
     ▼
Processamento com Python e Pandas
     │
     ▼
Arquivos Analíticos
     │
     ▼
Dashboard no Power BI
```

---

## 🎯 Objetivos

- Construir um banco de dados relacional estruturado
- Analisar o desempenho comercial
- Calcular indicadores relevantes para o negócio
- Identificar produtos e categorias com maior faturamento
- Classificar clientes por valor de compra
- Analisar receita por período e localização
- Monitorar produtos com estoque baixo
- Automatizar relatórios analíticos
- Criar um dashboard executivo no Power BI

---

## 🗄️ Estrutura do Banco

```text
Clientes
   │
   └── Pedidos
          │
          └── Itens do Pedido
                    │
                    └── Produtos
                           │
                           └── Categorias
```

---

## 📁 Estrutura do Projeto

```text
sales-analytics-sql/
├── dashboard/
│   ├── dashboard-print.png
│   ├── POWER-BI-BD.pbix
│   └── README.md
├── data/
│   ├── clientes.csv
│   ├── categorias.csv
│   ├── produtos.csv
│   ├── pedidos.csv
│   ├── itens_pedido.csv
│   ├── vendas_detalhadas.csv
│   └── resultados/
├── database/
│   ├── 01_create_database.sql
│   ├── 02_insert_data.sql
│   └── 03_business_queries.sql
├── docs/
│   └── GUIA_RAPIDO.md
├── images/
│   ├── customer-ranking.png
│   └── project-structure.png
├── python/
│   └── analysis.py
├── .gitignore
├── README.md
└── requirements.txt
```

---

## 📦 Dataset

| Tabela | Registros |
|---|---:|
| Clientes | 500 |
| Produtos | 100 |
| Categorias | 10 |
| Pedidos | 5.000 |
| Itens de pedidos | 14.000+ |

> Todos os dados são simulados para fins educacionais e de portfólio.

---

## 💼 Perguntas de Negócio

- Qual é o faturamento total?
- Quantos pedidos foram realizados?
- Qual é o ticket médio?
- Como o faturamento evolui ao longo dos meses?
- Quais produtos geram mais receita?
- Quais categorias possuem maior faturamento?
- Quais clientes gastam mais?
- Quais estados geram mais receita?
- Quais clientes gastam acima da média?
- Quais produtos possuem estoque baixo?
- Qual é a taxa de crescimento mensal?
- Qual é a participação de cada categoria?
- Qual é a média móvel dos últimos três meses?
- Como segmentar clientes por valor gasto?

---

## 🧠 Conceitos SQL Aplicados

- `SELECT`, `WHERE`, `ORDER BY` e `GROUP BY`
- `INNER JOIN` e `LEFT JOIN`
- `SUM()`, `COUNT()` e `AVG()`
- `CASE`
- Subconsultas
- Views
- CTEs com `WITH`
- Funções de janela
- `RANK()`, `DENSE_RANK()` e `LAG()`
- Média móvel
- Segmentação de dados

Arquivo principal:

```text
database/03_business_queries.sql
```

---

## 🐍 Análise com Python

O script em Python utiliza Pandas para:

- Ler os arquivos CSV
- Unir os conjuntos relacionais
- Criar a tabela detalhada de vendas
- Calcular KPIs
- Agregar receita por mês, categoria e estado
- Identificar os principais produtos e clientes
- Exportar relatórios automaticamente

Script:

```text
python/analysis.py
```

---

## 📈 Principais Resultados

- Faturamento total superior a R$ 50 milhões
- Ticket médio superior a R$ 10 mil
- Notebooks como categoria de maior faturamento
- Concentração de receita em produtos específicos
- Clientes com gastos acima da média
- Diferenças de faturamento entre estados
- Períodos de crescimento e queda nas vendas
- Produtos com estoque reduzido

---

## 🚀 Como Executar

```bash
git clone https://github.com/karlosqwer/sales-analytics-sql.git
cd sales-analytics-sql
pip install -r requirements.txt
python python/analysis.py
```

Depois, execute os scripts SQL na ordem:

```text
database/01_create_database.sql
database/02_insert_data.sql
database/03_business_queries.sql
```

Para visualizar o dashboard, abra:

```text
dashboard/POWER-BI-BD.pbix
```

---

## 🛠️ Tecnologias

- MySQL
- SQL
- Python
- Pandas
- Power BI
- Git
- GitHub

---

## ✅ Habilidades Demonstradas

- Modelagem de banco relacional
- Desenvolvimento de consultas SQL
- Joins, CTEs e funções de janela
- Limpeza e transformação de dados
- Análise exploratória
- Cálculo de KPIs
- Automação de relatórios
- Criação de dashboards
- Business Intelligence
- Visualização de dados
- Versionamento com Git
- Documentação técnica

---

## 🔮 Melhorias Futuras

- Pipeline ETL automatizado
- Modelagem dimensional em esquema estrela
- Stored procedures e triggers
- Otimização com índices
- Validação automática de qualidade
- Docker
- Testes automatizados
- Publicação no Power BI Service

---

## 👨‍💻 Autor

**Karlos Eduardo**

[GitHub](https://github.com/karlosqwer)

---

⭐ Caso este projeto tenha sido útil, considere deixar uma estrela no repositório.
