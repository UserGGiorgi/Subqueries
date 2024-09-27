SELECT 
    co.id AS order_id,
    COUNT(od.product_id) AS items_count
FROM customer_order co
INNER JOIN order_details od ON co.id = od.customer_order_id
WHERE co.operation_time between '2021-01-01' and '2021-12-31'
GROUP BY co.id
HAVING COUNT(od.product_id) > (
    SELECT AVG(items_per_order) 
    FROM (
        SELECT COUNT(od2.product_id) AS items_per_order
        FROM customer_order co2
        INNER JOIN order_details od2 ON co2.id = od2.customer_order_id
        GROUP BY co2.id
    ) AS avg_order_items
)
ORDER BY items_count ASC, order_id ASC;