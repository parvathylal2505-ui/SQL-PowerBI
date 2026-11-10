create database project;
use project;
select * from film limit 10;
alter table film_views_and_ratings_table rename to film;

select language, COUNT(*) as film,
       ROUND(AVG(vote_average),2) as avg_rating,
       SUM(vote_count) as total_votes
from film
group by language
order by film DESC;

select COUNT(*) from film;

-- Q1. How many films rated 7 or above are there in each language?

create view highratedfilmcount as
select
     language, 
     COUNT(*) as high_rated_films
from film
where vote_average >= 7
group by language
order by high_rated_films DESC;

select * from highratedfilmcount;

-- Q2. How many films are there in each language?

create view filminlanguage as
select
     language, COUNT(*) as films
	 from film
group by language
order by films DESC;

select * from filminlanguage;

-- Q3. Which languages have the highest average rating?

create view highestrating as
select 
	language,
    ROUND(AVG(vote_average),2) as avg_rating
from film
group by language
having COUNT(*) >= 50
order by avg_rating DESC;

select * from highestrating;

-- Q4. What share of total votes does each language get?

create view totalvotes as
select
       language,
       SUM(vote_count) as total_votes,
       ROUND(SUM(vote_count)*100.0 / (select SUM(vote_count) from film),1) as vote_share_pct
from film
group by language
order by total_votes DESC;

select * from totalvotes;

-- Q5. Which languages get the most votes per film?

create view mostvoteperfilm as
select
	   language,
       ROUND(SUM(vote_count)/COUNT(*),1) as votes_per_film
from film
group by language
order by  votes_per_film DESC;

select * from mostvoteperfilm;

-- Q6. How are films spread across rating categories?

create view  spreadacrossrating as
select case
         when vote_average < 4 then 'Poor (<4)'
         when vote_average < 6 then 'Average (4-6)'
         when vote_average < 8 then 'Good (6-8)'
         else 'Excellent (8+)'
       end as rating_category,
       COUNT(*) as films
from film
group by rating_category
order by MIN(vote_average);


select * from spreadacrossrating;

-- Q7. Which are the top 10 highest-rated films?

create view tenhighest as
select 
     title,
     language, vote_average, vote_count
from film
where vote_count >= 100
order by vote_average DESC
limit 10;

select  * from tenhighest;

-- Q9. How do film count and average rating change by release year?

create view candratingbyreyear as
select 
       year,
       COUNT(*) as film,
       ROUND(AVG(vote_average),2) as avg_rating
from film
group by year
order by year DESC;

select * from candratingbyreyear;

-- Q10. Which genres have the best average rating?

create view genreavgrating as
select genres,
       COUNT(*) as film,
       ROUND(AVG(vote_average),2) as avg_rating
from film
group by genres
having COUNT(*) >= 30
order by avg_rating DESC;


select * from genreavgrating;
