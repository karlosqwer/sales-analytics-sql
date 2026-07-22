USE sales_analytics;
-- 1 Faturamento total
SELECT ROUND(SUM(quantidade*preco_unitario),2) AS faturamento_total FROM itens_pedido;
-- 2 Total de pedidos
SELECT COUNT(*) AS total_pedidos FROM pedidos;
-- 3 Ticket médio
SELECT ROUND(SUM(quantidade*preco_unitario)/COUNT(DISTINCT id_pedido),2) AS ticket_medio FROM itens_pedido;
-- 4 Faturamento mensal
SELECT DATE_FORMAT(p.data_pedido,'%Y-%m') AS mes,ROUND(SUM(ip.quantidade*ip.preco_unitario),2) AS faturamento FROM pedidos p JOIN itens_pedido ip ON p.id_pedido=ip.id_pedido GROUP BY mes ORDER BY mes;
-- 5 Top produtos por receita
SELECT pr.nome_produto,ROUND(SUM(ip.quantidade*ip.preco_unitario),2) AS receita FROM produtos pr JOIN itens_pedido ip ON pr.id_produto=ip.id_produto GROUP BY pr.id_produto,pr.nome_produto ORDER BY receita DESC LIMIT 10;
-- 6 Faturamento por categoria
SELECT c.nome_categoria,ROUND(SUM(ip.quantidade*ip.preco_unitario),2) AS faturamento FROM categorias c JOIN produtos pr ON c.id_categoria=pr.id_categoria JOIN itens_pedido ip ON pr.id_produto=ip.id_produto GROUP BY c.id_categoria,c.nome_categoria ORDER BY faturamento DESC;
-- 7 Top clientes
SELECT c.nome,c.cidade,c.estado,ROUND(SUM(ip.quantidade*ip.preco_unitario),2) AS total_gasto FROM clientes c JOIN pedidos p ON c.id_cliente=p.id_cliente JOIN itens_pedido ip ON p.id_pedido=ip.id_pedido GROUP BY c.id_cliente,c.nome,c.cidade,c.estado ORDER BY total_gasto DESC LIMIT 10;
-- 8 Faturamento por estado
SELECT c.estado,ROUND(SUM(ip.quantidade*ip.preco_unitario),2) AS faturamento FROM clientes c JOIN pedidos p ON c.id_cliente=p.id_cliente JOIN itens_pedido ip ON p.id_pedido=ip.id_pedido GROUP BY c.estado ORDER BY faturamento DESC;
-- 9 Clientes acima da média
WITH gastos AS (SELECT c.id_cliente,c.nome,SUM(ip.quantidade*ip.preco_unitario) total FROM clientes c JOIN pedidos p ON c.id_cliente=p.id_cliente JOIN itens_pedido ip ON p.id_pedido=ip.id_pedido GROUP BY c.id_cliente,c.nome) SELECT nome,ROUND(total,2) total_gasto FROM gastos WHERE total>(SELECT AVG(total) FROM gastos) ORDER BY total DESC;
-- 10 Ranking de categorias
SELECT c.nome_categoria,ROUND(SUM(ip.quantidade*ip.preco_unitario),2) faturamento,DENSE_RANK() OVER(ORDER BY SUM(ip.quantidade*ip.preco_unitario) DESC) ranking FROM categorias c JOIN produtos pr ON c.id_categoria=pr.id_categoria JOIN itens_pedido ip ON pr.id_produto=ip.id_produto GROUP BY c.id_categoria,c.nome_categoria;
-- 11 Estoque baixo
SELECT nome_produto,estoque FROM produtos WHERE estoque<20 ORDER BY estoque;
-- 12 View para Power BI
CREATE OR REPLACE VIEW vw_vendas_detalhadas AS SELECT p.id_pedido,p.data_pedido,c.id_cliente,c.nome cliente,c.cidade,c.estado,pr.id_produto,pr.nome_produto,cat.nome_categoria,ip.quantidade,ip.preco_unitario,ROUND(ip.quantidade*ip.preco_unitario,2) valor_total FROM pedidos p JOIN clientes c ON p.id_cliente=c.id_cliente JOIN itens_pedido ip ON p.id_pedido=ip.id_pedido JOIN produtos pr ON ip.id_produto=pr.id_produto JOIN categorias cat ON pr.id_categoria=cat.id_categoria;
-- 13 Ranking de clientes por valor gasto
SELECT
    c.nome,
    ROUND(SUM(ip.quantidade * ip.preco_unitario), 2) AS total_gasto,
    RANK() OVER (
        ORDER BY SUM(ip.quantidade * ip.preco_unitario) DESC
    ) AS ranking_cliente
FROM clientes c
JOIN pedidos p
    ON c.id_cliente = p.id_cliente
JOIN itens_pedido ip
    ON p.id_pedido = ip.id_pedido
GROUP BY c.id_cliente, c.nome
ORDER BY ranking_cliente;
-- 14 Segmentação de clientes
SELECT
    c.nome,
    ROUND(SUM(ip.quantidade * ip.preco_unitario), 2) AS total_gasto,
    CASE
        WHEN SUM(ip.quantidade * ip.preco_unitario) >= 100000 THEN 'VIP'
        WHEN SUM(ip.quantidade * ip.preco_unitario) >= 50000 THEN 'Premium'
        WHEN SUM(ip.quantidade * ip.preco_unitario) >= 20000 THEN 'Recorrente'
        ELSE 'Regular'
    END AS segmento
FROM clientes c
JOIN pedidos p
    ON c.id_cliente = p.id_cliente
JOIN itens_pedido ip
    ON p.id_pedido = ip.id_pedido
GROUP BY c.id_cliente, c.nome
ORDER BY total_gasto DESC;-- 16 Participação percentual por categoria
-- 15 Crescimento mensal do faturamento
WITH faturamento_mensal AS (
    SELECT
        DATE_FORMAT(p.data_pedido, '%Y-%m') AS mes,
        SUM(ip.quantidade * ip.preco_unitario) AS faturamento
    FROM pedidos p
    JOIN itens_pedido ip
        ON p.id_pedido = ip.id_pedido
    GROUP BY DATE_FORMAT(p.data_pedido, '%Y-%m')
)
SELECT
    mes,
    ROUND(faturamento, 2) AS faturamento,
    ROUND(
        LAG(faturamento) OVER (ORDER BY mes),
        2
    ) AS faturamento_mes_anterior,
    ROUND(
        (
            faturamento -
            LAG(faturamento) OVER (ORDER BY mes)
        ) / NULLIF(
            LAG(faturamento) OVER (ORDER BY mes),
            0
        ) * 100,
        2
    ) AS crescimento_percentual
FROM faturamento_mensal
ORDER BY mes;


-- 16 Participação percentual por categoria
WITH receita_categoria AS (
    SELECT
        c.nome_categoria,
        SUM(ip.quantidade * ip.preco_unitario) AS faturamento
    FROM categorias c
    JOIN produtos pr
        ON c.id_categoria = pr.id_categoria
    JOIN itens_pedido ip
        ON pr.id_produto = ip.id_produto
    GROUP BY c.id_categoria, c.nome_categoria
)
SELECT
    nome_categoria,
    ROUND(faturamento, 2) AS faturamento,
    ROUND(
        faturamento / SUM(faturamento) OVER () * 100,
        2
    ) AS participacao_percentual
FROM receita_categoria
ORDER BY faturamento DESC;


-- 17 Média móvel de três meses
WITH faturamento_mensal AS (
    SELECT
        DATE_FORMAT(p.data_pedido, '%Y-%m') AS mes,
        SUM(ip.quantidade * ip.preco_unitario) AS faturamento
    FROM pedidos p
    JOIN itens_pedido ip
        ON p.id_pedido = ip.id_pedido
    GROUP BY DATE_FORMAT(p.data_pedido, '%Y-%m')
)
SELECT
    mes,
    ROUND(faturamento, 2) AS faturamento,
    ROUND(
        AVG(faturamento) OVER (
            ORDER BY mes
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS media_movel_3_meses
FROM faturamento_mensal
ORDER BY mes;