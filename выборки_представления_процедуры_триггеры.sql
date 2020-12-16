 -- комментарии, где полезность больше 50
select * from comments where comment_likes > 50 order by comment_likes;
-- рейензии, где неполезность больше 50
select film_id, review from film_reviews fr where review_not_useful > 50 order by film_id;

-- фильмы и жанры
select * from films_genres fg 
join genres g 
on fg.genre_id = g.id
join films f 
on fg.film_id = f.id;

--  фильмы с жанром фантастика
select * from genres g 
left join films_genres fg 
on  fg.genre_id = g.id
where genre = 'фантастика';

-- режиссеры фильмов обе таблицы
select 
	title, produced_date, description, director_id
from films f
left join directors_films df 
on f.id = df.film_id;

-- режиссеры фильмов
select title, director
from 
directors_films df 
join films f
on df.film_id  = f.id
join directors d 
on df.director_id = d.id;

-- фильмы с жанром боевик
select title, genre
from 
films_genres fg 
join films f
on fg.film_id  = f.id
join genres g 
on fg.genre_id= g.id
where g.genre = 'Боевик';

-- фильмы, рецензии к фильмам и комменты к рецензиям
select title, review, comment
from film_reviews fr 
join films f 
on fr.film_id = f.id
join comments c 
on c.film_review_id = f.id;

-- кто написал комментарий к фильму.
select title, firstname, lastname, review
from film_reviews fr 
join films f 
on fr.film_id = f.id
join users u 
on fr.user_id = u.id;

-- количество рецензий у пользователя
select 
	firstname,
	lastname,
	count(*) as total_reviews
from film_reviews fr 
	join users u 
	on fr.user_id = u.id 
	group by u.id;

-- представление по названию фильма
create view cat as select * from films order by title;
select * from cat

create or replace view fi as
	select id, title, produced_date, description
	from films
	order by title;
select * from fi;



-- процедуры
drop procedure if exists films_offers

delimiter //

create procedure films_offers(in for_film_id INT)
begin 
	-- объединяем по стране
	select f2.id from films f1
	join films f2
	on (f1.country = f2.country)
	where f1.id = for_film_id
	and f2.id <> for_film_id
	union
	-- объединяем по жанрам
	select fg2.film_id from films_genres fg1 
	join films_genres fg2 
	on fg1.genre_id = fg2.genre_id
	where fg1.film_id = for_film_id
	and fg2.film_id <> fg1.film_id
	order by rand()
	limit 10;
	
end //

delimiter ;


call films_offers(1);


-- триггер

delimiter //

create trigger check_user_age_before_update before update on users 
for each row
begin 
	if new.birthday >= current_date() then 
		signal sqlstate '45000' set message_text = 'Birthday must be in the past';
	end if;
end //

delimiter ;
