SELECT ano, mes, revenue  FROM ( 

(SELECT
CAST (  EXTRACT(YEAR FROM purchase.purchase_date) as varchar)  as  ano ,
CAST (  EXTRACT(MONTH FROM purchase.purchase_date) as varchar)  as  mes,
  SUM(product.price) AS revenue
FROM purchase
JOIN product
ON product.purchase_id = purchase.id
GROUP BY ano, mes
ORDER BY ano  , mes )

UNION ALL

( SELECT
CAST (  EXTRACT(YEAR FROM purchase.purchase_date) as varchar)   as ano ,
'Subtotal'   as mes,
SUM(product.price) AS revenue
FROM purchase
JOIN product
ON product.purchase_id = purchase.id
GROUP BY ano, mes
ORDER BY ano  , mes )

UNION ALL

( SELECT
'Total'   as ano ,
'Total'   as mes,
SUM(product.price) AS revenue
FROM purchase
JOIN product
ON product.purchase_id = purchase.id
GROUP BY ano, mes
ORDER BY ano  , mes ) ) AS TEMP 

GROUP BY ano, mes,revenue

ORDER BY CAST (  CASE WHEN ano = 'Total' Then '1000000'                                 
                else ano end  as integer) ASC,
		CAST (  CASE WHEN mes = 'Total' Then '1000000' 
                WHEN mes = 'Subtotal' Then '500'
                else mes end  as integer) ASC 