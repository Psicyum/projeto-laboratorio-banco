# ROTEIRO DE APRESENTAÇÃO — AVALIAÇÃO I TECHPOP

## 1. Problema de negócio
A TechPop enfrenta queda nas vendas e precisa de uma solução de BI para apoiar decisões da alta gestão.

## 2. OLTP / FatorV
Mostrar o modelo relacional fornecido pelo professor e explicar que ele é a fonte operacional do ETL.

Tabelas: `categories`, `products`, `suppliers`, `customers`, `sellers`, `sales`, `sales_items`.

## 3. Modelo dimensional
Apresentar `docs/modelo_dimensional.png`.

A tabela central é `FATO_VENDAS`, com granularidade de **um registro por item de venda**. As dimensões são Tempo, Cliente, Vendedor, Produto e Fornecedor.

## 4. Regras de negócio no ETL
- Datas: `YYYYMMDD`, ano, trimestre e mês.
- Textos: convertidos para MAIÚSCULO.
- `region`: criada a partir do estado.
- `subtotal = quantidade × preço do item`.
- `valor_comissao = subtotal × comissão / 100`.
- Duplicidades: chave lógica `(sales_id, item_id)`.
- `sales.total_price` é validado, mas não é usado no faturamento do DW porque os dados fornecidos apresentam inconsistências.

## 5. Resultado do DW
Com os dados fornecidos, o resultado esperado é:

| TABELA | REGISTROS |
|---|---:|
| DIM_TEMPO | 2 |
| DIM_CLIENTE | 9 |
| DIM_VENDEDOR | 9 |
| DIM_FORNECEDOR | 9 |
| DIM_PRODUTO | 9 |
| FATO_VENDAS | 28 |

## 6. Indicadores
O faturamento analítico é obtido pela soma de `subtotal`.

Resultado dos dados fornecidos:
- Faturamento: **R$ 2.267,00**
- Itens vendidos: **45 unidades**
- Comissões: **R$ 271,66**
- Produto com maior quantidade vendida: **PIZZA — 10 unidades**
- Produto com maior faturamento: **SMARTPHONE — R$ 959,00**

## 7. Gráficos exigidos
1. Produtos mais vendidos.
2. Faturamento total.
3. Faturamento por categoria.
4. Faturamento por produto.
5. Maiores comissões de vendedores.
6. Quantidade de fornecedores por estado.
7. Quantidade de clientes por estado.

Todos os gráficos do dashboard podem ser filtrados por **ANO, TRIMESTRE e MÊS**.

## 8. Demonstração
Executar:

```bash
python main.py
python reports/gerar_graficos.py
streamlit run dashboard/app.py
```

Para a apresentação, mostrar primeiro o modelo dimensional, depois o ETL, em seguida as tabelas do DW e finalmente o dashboard.
