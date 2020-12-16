-- В данной курсовой работе рассмотрена часть поисковика  "Кинопоиск" - фильмы. Кинопоиск - интренет-сервис о кино. БД представлена в виде следующих таблиц: фильмы, жанры, жанры к фильмам, режиссеры, режиссеры по фильмам
-- актеры, актеры по фильмам, пользователи, рецензии к фильмам, комментарии к рецензиям. 
-- 
drop table if exists films; -- фильмы. Были набраны вручную (50 фильмов)
create table films(
	id serial primary key,
	title varchar(150)  DEFAULT null,
	produced_date year not null,
	country varchar (100) not null,
	slogan text default null,
	budget bigint (20) unsigned,
	box_office_USA bigint (20) unsigned,
	box_office_world  bigint (20) unsigned,
	realise_date_Russia date,
	realise_date_World date,
	duration SMALLINT unsigned not null,
	description text,
	rating_film decimal(2,1),
	poster bigint unsigned
);

alter table films add index (title); 

drop table if exists genres; -- жанры. Были набраны вручную.
create table genres(
	id serial primary key,
	genre varchar(50)	
);

drop table if exists films_genres; --  в каких жанрах представлен тот или иной фильм. вручную
create table films_genres(
	film_id bigint unsigned not null,
	genre_id bigint unsigned not null,
	primary key (film_id, genre_id),
	foreign key (film_id) references films(id),
	foreign key (genre_id) references genres(id)
);

drop table if exists directors; -- режисеры с краткой информацией о них. вручную 
create table directors(
	id serial primary key,
	director varchar(200),
	director_length decimal(3,2),
	birthdate date,
	hometown varchar (100),
	count_films smallint unsigned, 
	photo bigint unsigned
);

drop table if exists directors_films; -- кто срежисировал тот или иной фильм. 
create table directors_films(
	film_id bigint unsigned not null,
	director_id bigint unsigned not null,
	primary key (film_id, director_id),
	foreign key (film_id) references films(id),
	foreign key (director_id) references directors(id)
);

drop table if exists actors; -- актеры. набарны вручную
create table actors(
	id serial primary key,
	actor varchar(200),
	actor_length decimal(3,2),
	birthdate date,
	hometown varchar (100),
	count_films smallint unsigned, 
	photo bigint unsigned
);

drop table if exists actors_films; -- актеры в том или ином фильме (частично).
create table actors_films(
	film_id bigint unsigned not null,
	actor_id bigint unsigned not null,
	primary key (film_id, actor_id),
	foreign key (film_id) references films(id),
	foreign key (actor_id) references actors(id)
);

drop table if exists users; -- пользователи. Сгенерированно автоматически.
create table users(
	id serial primary key,
	firstname varchar(50),
	lastname varchar(50),
	email varchar(120) unique,
	birthday date,
	country varchar(100),
	hometown varchar(100),
	gender char(1),
	photo_id bigint unsigned,
	created_at datetime default now(),
	pass char(30)
);



drop table if exists film_reviews; -- рейцензии к фильмам. Сгенерированно автоматически
create table film_reviews(
	id serial primary key,
	user_id bigint unsigned not null,
	film_id bigint unsigned not null,
	review text,
	review_useful bigint,
	review_not_useful bigint,
	created_at datetime default current_timestamp,
	foreign key (user_id) references users(id),
	foreign key (film_id) references films(id)
);

drop table if exists comments; -- комментарии к рецензиям. Сгенерированно автоматически
create table comments (
	id serial primary key,
	user_id bigint unsigned not null,
	film_review_id bigint unsigned not null,
	comment text,
	comment_likes bigint,
	comment_dislikes bigint,
	created_at datetime default current_timestamp,
	foreign key (user_id) references users(id),
	foreign key (film_review_id) references film_reviews(id)
);
	



	
