-- ============================================================
-- VALIDAÇÃO FINAL PARA A APRESENTAÇÃO
-- ============================================================

SELECT 'DIM_TEMPO' AS tabela, COUNT(*) AS registros FROM dim_tempo
UNION ALL SELECT 'DIM_CLIENTE', COUNT(*) FROM dim_cliente
UNION ALL SELECT 'DIM_VENDEDOR', COUNT(*) FROM dim_vendedor
UNION ALL SELECT 'DIM_FORNECEDOR', COUNT(*) FROM dim_fornecedor
UNION ALL SELECT 'DIM_PRODUTO', COUNT(*) FROM dim_produto
UNION ALL SELECT 'FATO_VENDAS', COUNT(*) FROM fato_vendas;

SELECT ROUND(SUM(subtotal), 2) AS faturamento_total,
       SUM(quantidade) AS unidades_vendidas,
       ROUND(SUM(valor_comissao), 2) AS comissoes_totais
FROM fato_vendas;

SELECT p.nome_produto AS produto,
       SUM(f.quantidade) AS quantidade_vendida,
       ROUND(SUM(f.subtotal), 2) AS faturamento
FROM fato_vendas f
JOIN dim_produto p ON p.sk_produto = f.sk_produto
GROUP BY p.nome_produto
ORDER BY quantidade_vendida DESC, faturamento DESC;
