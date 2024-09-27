SELECT 
    p.surname AS surname,
    p.name AS name,
    COALESCE(SUM(od.price_with_discount * od.product_amount), 0) AS total_expenses
FROM person p
INNER JOIN customer c ON p.id = c.person_id
INNER JOIN customer_order co ON c.person_id = co.customer_id
INNER JOIN order_details od ON od.customer_order_id = co.id
WHERE p.birth_date BETWEEN '2000-01-01' AND '2010-12-31'
GROUP BY p.surname, p.name
HAVING COALESCE(SUM(od.price_with_discount * od.product_amount), 0) > (
    SELECT AVG(total_purchase)
    FROM (
        SELECT COALESCE(SUM(od2.price_with_discount * od2.product_amount), 0) AS total_purchase
        FROM person p2
        INNER JOIN customer c2 ON p2.id = c2.person_id
        INNER JOIN customer_order co2 ON c2.person_id = co2.customer_id
        INNER JOIN order_details od2 ON od2.customer_order_id = co2.id
        GROUP BY p2.id
    ) AS avg_total_purchases
)
ORDER BY total_expenses ASC, surname ASC;
