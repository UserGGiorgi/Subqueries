SELECT
p.id as id
,product_title.title as product,
p.price as price
FROM product p 
INNER JOIN product_title
on p.product_title_id=product_title.id
WHERE p.price > 2*(SELECT MIN(p2.price) From product p2)
ORDER BY price ASC,product ASC;