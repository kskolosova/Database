-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
select
	u.id as user_id, u.name as user_name,
	op.order_id as order_id,
	op.product_id as product_id,
	(select name from products where id = op.product_id) as product_name,
	op.total
from 
	users as u
right join
	orders as o
on 
	u.id = o.user_id
right join 
	orders_products as op 
on
	o.id = op.order_id;

-- Выведите список товаров products и разделов catalogs, который соответствует товару.

select 
	p.id, p.name, p.price,
	c.id as cat_id,
	c.name as category
from 
	products as p
join
	catalogs as c
on 
	p.catalog_id = c.id;

