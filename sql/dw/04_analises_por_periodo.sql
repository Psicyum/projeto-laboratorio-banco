-- ============================================================
-- TECHPOP - ANÁLISES POR ANO, TRIMESTRE E MÊS
-- Consultas que demonstram explicitamente o requisito temporal.
-- ============================================================

-- 1) PRODUTOS MAIS VENDIDOS POR ANO
SELECT t.ano, p.nome_produto AS produto,
       SUM(f.quantidade) AS quantidade_vendida
FROM fato_vendas f
JOIN dim_tempo t ON t.sk_tempo = f.sk_tempo
JOIN dim_produto p ON p.sk_produto = f.sk_produto
GROUP BY t.ano, p.nome_produto
ORDER BY t.ano, quantidade_vendida DESC;

-- 2) PRODUTOS MAIS VENDIDOS POR TRIMESTRE
SELECT t.ano, t.trimestre, p.nome_produto AS produto,
       SUM(f.quantidade) AS quantidade_vendida
FROM fato_vendas f
JOIN dim_tempo t ON t.sk_tempo = f.sk_tempo
JOIN dim_produto p ON p.sk_produto = f.sk_produto
GROUP BY t.ano, t.trimestre, p.nome_produto
ORDER BY t.ano, t.trimestre, quantidade_vendida DESC;

-- 3) PRODUTOS MAIS VENDIDOS POR MÊS
SELECT t.ano, t.mes, t.nome_mes, p.nome_produto AS produto,
       SUM(f.quantidade) AS quantidade_vendida
FROM fato_vendas f
JOIN dim_tempo t ON t.sk_tempo = f.sk_tempo
JOIN dim_produto p ON p.sk_produto = f.sk_produto
GROUP BY t.ano, t.mes, t.nome_mes, p.nome_produto
ORDER BY t.ano, t.mes, quantidade_vendida DESC;

-- 4) FATURAMENTO POR CATEGORIA, ANO, TRIMESTRE E MÊS
SELECT t.ano, t.trimestre, t.mes, t.nome_mes,
       p.categoria,
       SUM(f.subtotal) AS faturamento
FROM fato_vendas f
JOIN dim_tempo t ON t.sk_tempo = f.sk_tempo
JOIN dim_produto p ON p.sk_produto = f.sk_produto
GROUP BY t.ano, t.trimestre, t.mes, t.nome_mes, p.categoria
ORDER BY t.ano, t.trimestre, t.mes, faturamento DESC;

-- 5) FATURAMENTO POR PRODUTO E PERÍODO
SELECT t.ano, t.trimestre, t.mes, t.nome_mes,
       p.nome_produto AS produto,
       SUM(f.subtotal) AS faturamento
FROM fato_vendas f
JOIN dim_tempo t ON t.sk_tempo = f.sk_tempo
JOIN dim_produto p ON p.sk_produto = f.sk_produto
GROUP BY t.ano, t.trimestre, t.mes, t.nome_mes, p.nome_produto
ORDER BY t.ano, t.trimestre, t.mes, faturamento DESC;

-- 6) COMISSÕES POR VENDEDOR E PERÍODO
SELECT t.ano, t.trimestre, t.mes, t.nome_mes,
       v.nome AS vendedor,
       v.comissao_percentual,
       SUM(f.valor_comissao) AS total_comissao
FROM fato_vendas f
JOIN dim_tempo t ON t.sk_tempo = f.sk_tempo
JOIN dim_vendedor v ON v.sk_vendedor = f.sk_vendedor
GROUP BY t.ano, t.trimestre, t.mes, t.nome_mes,
         v.nome, v.comissao_percentual
ORDER BY t.ano, t.trimestre, t.mes, total_comissao DESC;

-- 7) FORNECEDORES POR ESTADO E PERÍODO
SELECT t.ano, t.trimestre, t.mes, t.nome_mes,
       fo.estado, fo.region,
       COUNT(DISTINCT fo.supplier_id) AS qtd_fornecedores
FROM fato_vendas f
JOIN dim_tempo t ON t.sk_tempo = f.sk_tempo
JOIN dim_fornecedor fo ON fo.sk_fornecedor = f.sk_fornecedor
GROUP BY t.ano, t.trimestre, t.mes, t.nome_mes,
         fo.estado, fo.region
ORDER BY t.ano, t.trimestre, t.mes, qtd_fornecedores DESC;

-- 8) CLIENTES POR ESTADO E PERÍODO
SELECT t.ano, t.trimestre, t.mes, t.nome_mes,
       c.estado, c.region,
       COUNT(DISTINCT c.customer_id) AS qtd_clientes
FROM fato_vendas f
JOIN dim_tempo t ON t.sk_tempo = f.sk_tempo
JOIN dim_cliente c ON c.sk_cliente = f.sk_cliente
GROUP BY t.ano, t.trimestre, t.mes, t.nome_mes,
         c.estado, c.region
ORDER BY t.ano, t.trimestre, t.mes, qtd_clientes DESC;

-- 9) FATURAMENTO TOTAL POR ANO/TRIMESTRE/MÊS
SELECT t.ano, t.trimestre, t.mes, t.nome_mes,
       SUM(f.subtotal) AS faturamento_total
FROM fato_vendas f
JOIN dim_tempo t ON t.sk_tempo = f.sk_tempo
GROUP BY t.ano, t.trimestre, t.mes, t.nome_mes
ORDER BY t.ano, t.trimestre, t.mes;
