-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
update users set created_at = NOW();
update users set updated_at = NOW();


-- Таблица users была неудачно спроектирована. 
-- Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. 
-- Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.


ALTER TABLE users ADD new_created_at DATETIME;
ALTER TABLE users ADD new_updated_at DATETIME;
UPDATE users SET new_created_at = STR_TO_DATE(created_at, '%d.%m.%Y %h:%i');
UPDATE users SET new_updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %h:%i');
ALTER TABLE users DROP created_at, CHANGE new_created_at created_at DATETIME;
ALTER TABLE users DROP updated_at, CHANGE new_updated_at updated_at DATETIME;


-- В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. 
-- Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце, после всех записей.

select * from storehouses_products order by case when value = 0 then 1 else 0 end, value;


-- (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий (may, august)
select name, birthday_at, 
	case
		when date_format(birthday_at, '%m') = 05 then 'May' 
		when date_format(birthday_at, '%m') = 08 then 'August' 
	end as month
from 
	users where date_format(birthday_at, '%m') = 05 or date_format(birthday_at, '%m') = 08;
	

-- Подсчитайте средний возраст пользователей в таблице users.
select name, (to_days(now()) - to_days(birthday_at)) / 365.25 as age from users;
select name, FLOOR((to_days(now()) - to_days(birthday_at)) / 365.25) as age from users;
select name, timestampdiff(year, birthday_at, NOW()) as age from users;


-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.

select *, dayname(birthday_at) as dayname from users;

-- (по желанию) Подсчитайте произведение чисел в столбце таблицы.

select exp(sum(ln(value))) from tbl;


