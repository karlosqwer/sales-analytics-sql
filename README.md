<div align="center">

# 📊 Sales Analytics SQL

### End-to-End Sales Analytics Project using MySQL, SQL and Python

![Python](https://img.shields.io/badge/Python-3.13-blue?style=for-the-badge&logo=python)
![MySQL](https://img.shields.io/badge/MySQL-8.0-orange?style=for-the-badge&logo=mysql)
![Pandas](https://img.shields.io/badge/Pandas-Data%20Analysis-150458?style=for-the-badge&logo=pandas)
![Git](https://img.shields.io/badge/Git-Version%20Control-red?style=for-the-badge&logo=git)
![GitHub](https://img.shields.io/badge/GitHub-Repository-black?style=for-the-badge&logo=github)

A complete Sales Analytics project simulating the daily activities of a Data Analyst using relational databases, SQL business queries and Python data analysis.

</div>

---

# 📌 Project Overview

This project was developed to simulate a real business environment where sales data is collected, organized, analyzed and transformed into business insights.

The project covers the complete analytical workflow:

- Database Modeling
- Relational Database (MySQL)
- SQL Business Queries
- Data Processing with Python
- KPI Calculation
- CSV Export
- Git Version Control

---

# 🏗 Database Structure

```
Categories
      │
      │
Products
      │
      │
Order Items
      │
      │
Orders
      │
      │
Customers
```

---

# 📂 Project Structure

```
sales-analytics-sql/

├── data/
│   ├── clientes.csv
│   ├── categorias.csv
│   ├── produtos.csv
│   ├── pedidos.csv
│   ├── itens_pedido.csv
│   ├── vendas_detalhadas.csv
│   └── resultados/
│
├── database/
│   ├── 01_create_database.sql
│   ├── 02_insert_data.sql
│   └── 03_business_queries.sql
│
├── python/
│   └── analysis.py
│
├── docs/
│
└── README.md
```

---

# 📊 Dataset

The project simulates a real retail company.

Current database:

| Table | Records |
|--------|---------|
| Customers | 500 |
| Products | 100 |
| Categories | 10 |
| Orders | 5,000 |
| Order Items | 14,000+ |

---

# 📈 Business Questions Answered

The SQL queries answer questions commonly requested by managers and business teams.

Examples:

- Total Revenue
- Average Ticket
- Revenue by Category
- Revenue by Product
- Revenue by State
- Revenue by City
- Top Customers
- Top Selling Products
- Monthly Revenue
- Product Ranking
- Stock Analysis

---

# 💻 Technologies

- MySQL
- SQL
- Python
- Pandas
- Git
- GitHub

---

# 🧠 SQL Concepts Applied

- SELECT
- WHERE
- ORDER BY
- GROUP BY
- JOIN
- INNER JOIN
- LEFT JOIN
- Aggregate Functions
- SUM()
- COUNT()
- AVG()
- ROUND()
- Views
- CTE (WITH)
- Window Functions
- Aliases

---

# 🐍 Python Analysis

Python was used to:

- Read CSV files
- Merge datasets
- Calculate KPIs
- Generate detailed sales dataset
- Export business reports

Libraries:

- Pandas

---

# 📁 Outputs

The project automatically generates:

```
data/resultados/

├── faturamento_mensal.csv
├── faturamento_por_categoria.csv
├── faturamento_por_estado.csv
├── top_10_clientes.csv
└── top_10_produtos.csv
```

---

# 🚀 How to Run

## Clone

```bash
git clone https://github.com/karlosqwer/sales-analytics-sql.git
```

---

## Create Database

Run:

```
database/01_create_database.sql
```

---

## Insert Data

Run:

```
database/02_insert_data.sql
```

---

## Execute Business Queries

Run:

```
database/03_business_queries.sql
```

---

## Execute Python Analysis

```bash
python python/analysis.py
```

---

# 📸 Future Improvements

- Power BI Dashboard
- Interactive Visualizations
- ETL Pipeline
- Data Warehouse
- Stored Procedures
- Triggers
- Index Optimization
- Docker Support

---

# 📚 Skills Demonstrated

- Relational Database Design
- SQL Development
- Data Cleaning
- Data Analysis
- Business Intelligence
- Python for Data Analytics
- KPI Calculation
- Git Workflow

---

# 👨‍💻 Author

**Karlos Eduardo**

GitHub:

https://github.com/karlosqwer

---

⭐ If you enjoyed this project, consider giving it a Star.