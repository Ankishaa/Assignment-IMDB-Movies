USE imdb;

/* Now that you have imported the data sets, let’s explore some of the tables. 
 To begin with, it is beneficial to know the shape of the tables and whether any column has null values.
 Further in this segment, you will take a look at 'movies' and 'genre' tables.*/



-- Segment 1:




-- Q1. Find the total number of rows in each table of the schema?
-- Type your code below:

SELECT 
    COUNT(*) AS no_of_movie
FROM
    movie;
SELECT 
    COUNT(*) AS no_of_names
FROM
    names;
SELECT 
    COUNT(*) AS no_of_ratings
FROM
    ratings;
SELECT 
    COUNT(*) AS no_of_genre
FROM
    genre;
SELECT 
    COUNT(*) AS no_of_director
FROM
    director_mapping;
SELECT 
    COUNT(*) AS no_of_role
FROM
    role_mapping;










-- Q2. Which columns in the movie table have null values?
-- Type your code below:
SELECT 
    COUNT(*) - COUNT(id),
    COUNT(*) - COUNT(title),
    COUNT(*) - COUNT(year),
    COUNT(*) - COUNT(date_published),
    COUNT(*) - COUNT(duration),
    COUNT(*) - COUNT(country),
    COUNT(*) - COUNT(worlwide_gross_income),
    COUNT(*) - COUNT(languages),
    COUNT(*) - COUNT(production_company)
FROM
    movie;








-- Now as you can see four columns of the movie table has null values. Let's look at the at the movies released each year. 
-- Q3. Find the total number of movies released each year? How does the trend look month wise? (Output expected)

/* Output format for the first part:

+---------------+-------------------+
| Year			|	number_of_movies|
+-------------------+----------------
|	2017		|	2134			|
|	2018		|		.			|
|	2019		|		.			|
+---------------+-------------------+


Output format for the second part of the question:
+---------------+-------------------+
|	month_num	|	number_of_movies|
+---------------+----------------
|	1			|	 134			|
|	2			|	 231			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
SELECT 
    year, COUNT(title) AS no_of_movies
FROM
    movie
GROUP BY year
ORDER BY COUNT(title) DESC;

SELECT 
    MONTH(date_published) AS month_num,
    YEAR(date_published),
    COUNT(title) AS num_of_movies
FROM
    movie
GROUP BY MONTH(date_published)
ORDER BY COUNT(title) DESC;







/*The highest number of movies is produced in the month of March.
So, now that you have understood the month-wise trend of movies, let’s take a look at the other details in the movies table. 
We know USA and India produces huge number of movies each year. Lets find the number of movies produced by USA or India for the last year.*/
  
-- Q4. How many movies were produced in the USA or India in the year 2019??
-- Type your code below:

SELECT 
    count(id) as movie_count, year, country
    
FROM
    movie
WHERE
    year = 2019
        AND (country like '%INDIA%' OR country like '%USA%' );








/* USA and India produced more than a thousand movies(you know the exact number!) in the year 2019.
Exploring table Genre would be fun!! 
Let’s find out the different genres in the dataset.*/

-- Q5. Find the unique list of the genres present in the data set?
-- Type your code below:

SELECT 
    genre 
FROM
    genre
GROUP BY genre;








/* So, RSVP Movies plans to make a movie of one of these genres.
Now, wouldn’t you want to know which genre had the highest number of movies produced in the last year?
Combining both the movie and genres table can give more interesting insights. */

-- Q6.Which genre had the highest number of movies produced overall?
-- Type your code below:

SELECT 
    genre, COUNT(genre) AS genre_count
FROM
    movie m
        INNER JOIN
    genre g ON m.id = g.movie_id
GROUP BY genre
ORDER BY count(genre) desc;








/* So, based on the insight that you just drew, RSVP Movies should focus on the ‘Drama’ genre. 
But wait, it is too early to decide. A movie can belong to two or more genres. 
So, let’s find out the count of movies that belong to only one genre.*/

-- Q7. How many movies belong to only one genre?
-- Type your code below:

with m_count as
(
select  count(title), genre
from movie m
inner join genre g 
on g.movie_id = m.id
group by title
having count(genre)=1
)
select count(*) from m_count;






/* There are more than three thousand movies which has only one genre associated with them.
So, this figure appears significant. 
Now, let's find out the possible duration of RSVP Movies’ next project.*/

-- Q8.What is the average duration of movies in each genre? 
-- (Note: The same movie can belong to multiple genres.)


/* Output format:

+---------------+-------------------+
| genre			|	avg_duration	|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

SELECT 
    genre, ROUND(AVG(duration), 2)
FROM
    movie m
        INNER JOIN
    genre g ON m.id = g.movie_id
GROUP BY genre
ORDER BY AVG(duration) DESC;  





/* Now you know, movies of genre 'Drama' (produced highest in number in 2019) has the average duration of 106.77 mins.
Lets find where the movies of genre 'thriller' on the basis of number of movies.*/

-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 
-- (Hint: Use the Rank function)


/* Output format:
+---------------+-------------------+---------------------+
| genre			|		movie_count	|		genre_rank    |	
+---------------+-------------------+---------------------+
|drama			|	2312			|			2		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:


SELECT genre,
       Count(title)                     AS movie_count,
       Rank()
         OVER(
           ORDER BY Count(title) DESC ) AS genre_rank
FROM   genre g
       INNER JOIN movie m
               ON m.id = g.movie_id
WHERE genre ="thriller"
GROUP  BY genre; 






/*Thriller movies is in top 3 among all genres in terms of number of movies
 In the previous segment, you analysed the movies and genres tables. 
 In this segment, you will analyse the ratings table as well.
To start with lets get the min and max values of different columns in the table*/




-- Segment 2:




-- Q10.  Find the minimum and maximum values in  each column of the ratings table except the movie_id column?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
| min_avg_rating|	max_avg_rating	|	min_total_votes   |	max_total_votes 	 |min_median_rating|min_median_rating|
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
|		0		|			5		|	       177		  |	   2000	    		 |		0	       |	8			 |
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+*/
-- Type your code below:

SELECT 
    MIN(avg_rating) AS min_avg_rating,
    MAX(avg_rating) AS max_avg_rating,
    MIN(total_votes) AS min_total_votes,
    MAX(total_votes) AS max_total_votes,
    MIN(median_rating) AS min_median_rating,
    MAX(median_rating) AS max_median_rating
FROM
    ratings; 





    

/* So, the minimum and maximum values in each column of the ratings table are in the expected range. 
This implies there are no outliers in the table. 
Now, let’s find out the top 10 movies based on average rating.*/

-- Q11. Which are the top 10 movies based on average rating?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		movie_rank    |
+---------------+-------------------+---------------------+
| Fan			|		9.6			|			5	  	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:
-- It's ok if RANK() or DENSE_RANK() is used too

WITH top_movie
     AS (SELECT title,
                avg_rating,
                Dense_rank()
                  OVER(
                    ORDER BY avg_rating DESC) AS movie_rank
         FROM   ratings r
                INNER JOIN movie m
                        ON m.id = r.movie_id)
SELECT *
FROM   top_movie
WHERE  movie_rank <= 10; 





/* Do you find you favourite movie FAN in the top 10 movies with an average rating of 9.6? If not, please check your code again!!
So, now that you know the top 10 movies, do you think character actors and filler actors can be from these movies?
Summarising the ratings table based on the movie counts by median rating can give an excellent insight.*/

-- Q12. Summarise the ratings table based on the movie counts by median ratings.
/* Output format:

+---------------+-------------------+
| median_rating	|	movie_count		|
+-------------------+----------------
|	1			|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- Order by is good to have

SELECT 
    median_rating, COUNT(movie_id) AS movie_count
FROM
    ratings
GROUP BY median_rating
ORDER BY COUNT(movie_id) desc;

/* Movies with a median rating of 7 is highest in number. 
Now, let's find out the production house with which RSVP Movies can partner for its next project.*/

-- Q13. Which production house has produced the most number of hit movies (average rating > 8)??
/* Output format:
+------------------+-------------------+---------------------+
|production_company|movie_count	       |	prod_company_rank|
+------------------+-------------------+---------------------+
| The Archers	   |		1		   |			1	  	 |
+------------------+-------------------+---------------------+*/
-- Type your code below:


SELECT production_company,
       count(movie_id) AS movie_count,
       rank() OVER(
                    ORDER BY count(movie_id)DESC) AS prod_company_rank
FROM movie AS m
INNER JOIN 
ratings AS r
ON m.id = r.movie_id
WHERE production_company IS NOT NULL
AND avg_rating> 8
GROUP BY production_company
LIMIT 1;
 




-- It's ok if RANK() or DENSE_RANK() is used too
-- Answer can be Dream Warrior Pictures or National Theatre Live or both

-- Q14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?
/* Output format:

+---------------+-------------------+
| genre			|	movie_count		|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

SELECT 
    genre, COUNT(movie_id) AS movie_count
FROM
    genre g
        INNER JOIN
    movie m ON g.movie_id = m.id
        INNER JOIN
    ratings r USING (movie_id)
WHERE
    year = 2017
        AND MONTH(date_published) = 3
        AND country = 'USA'
        AND total_votes > 1000
GROUP BY genre
ORDER BY COUNT(movie_id) DESC;

-- Lets try to analyse with a unique problem statement.
-- Q15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		genre	      |
+---------------+-------------------+---------------------+
| Theeran		|		8.3			|		Thriller	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:

SELECT 
    title, avg_rating, genre
FROM
    movie m
        INNER JOIN
    genre g ON g.movie_id = m.id
        INNER JOIN
    ratings USING (movie_id)
WHERE
    title REGEXP '^The' AND avg_rating > 8
GROUP BY title
ORDER BY avg_rating DESC;

-- USING median_rating

SELECT 
    title, median_rating, genre
FROM
    movie m
        INNER JOIN
    genre g ON g.movie_id = m.id
        INNER JOIN
    ratings USING (movie_id)
WHERE
    title REGEXP '^The' AND median_rating > 8
GROUP BY title
ORDER BY median_rating DESC;


-- You should also try your hand at median rating and check whether the ‘median rating’ column gives any significant insights.
-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?
-- Type your code below:

SELECT 
    COUNT(id) AS Total_Movies
FROM
    movie m
        INNER JOIN
    ratings r ON r.movie_id = m.id
WHERE
    median_rating = 8
        AND date_published BETWEEN 4 / 1 / 2018 AND 4 / 1 / 2019;

-- Once again, try to solve the problem given below.
-- Q17. Do German movies get more votes than Italian movies? 
-- Hint: Here you have to find the total number of votes for both German and Italian movies.
-- Type your code below:

SELECT 
    country, total_votes, COUNT(id) AS Num_of_Movies
FROM
    movie m
        INNER JOIN
    ratings r ON r.movie_id = m.id
WHERE
    country IN ('Germany' , 'italy')
GROUP BY country;



-- Answer is Yes

/* Now that you have analysed the movies, genres and ratings tables, let us now analyse another table, the names table. 
Let’s begin by searching for null values in the tables.*/




-- Segment 3:



-- Q18. Which columns in the names table have null values??
/*Hint: You can find null values for individual columns or follow below output format
+---------------+-------------------+---------------------+----------------------+
| name_nulls	|	height_nulls	|date_of_birth_nulls  |known_for_movies_nulls|
+---------------+-------------------+---------------------+----------------------+
|		0		|			123		|	       1234		  |	   12345	    	 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:

SELECT 
    COUNT(*) - COUNT(id) AS id_nulls,
    COUNT(*) - COUNT(name) AS name_nulls,
    COUNT(*) - COUNT(height) AS height_nulls,
    COUNT(*) - COUNT(date_of_birth) AS dob_nulls,
    COUNT(*) - COUNT(known_for_movies) AS known_for_movies_nulls
FROM
    names;


/* There are no Null value in the column 'name'.
The director is the most important person in a movie crew. 
Let’s find out the top three directors in the top three genres who can be hired by RSVP Movies.*/

-- Q19. Who are the top three directors in the top three genres whose movies have an average rating > 8?
-- (Hint: The top three genres would have the most number of movies with an average rating > 8.)
/* Output format:

+---------------+-------------------+
| director_name	|	movie_count		|
+---------------+-------------------|
|James Mangold	|		4			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
SELECT 
    n.name AS director_name, COUNT(m.id) AS movie_count, genre
FROM
    movie m
        INNER JOIN
    director_mapping dm ON dm.movie_id = m.id
        INNER JOIN
    names n ON dm.name_id = n.id
        INNER JOIN
    genre g ON g.movie_id = m.id
        INNER JOIN
    ratings r ON r.movie_id = m.id
WHERE
    avg_rating > 8
GROUP BY genre , n.name
ORDER BY COUNT(m.id) DESC;


/* James Mangold can be hired as the director for RSVP's next project. Do you remeber his movies, 'Logan' and 'The Wolverine'. 
Now, let’s find out the top two actors.*/

-- Q20. Who are the top two actors whose movies have a median rating >= 8?
/* Output format:

+---------------+-------------------+
| actor_name	|	movie_count		|
+-------------------+----------------
|Christain Bale	|		10			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:


SELECT COUNT(m.id) AS movie_count, nm.name AS actor_name
FROM
    movie m
        INNER JOIN
    role_mapping rm ON m.id = rm.movie_id
        INNER JOIN
    names nm ON nm.id = rm.name_id
        INNER JOIN
    ratings r ON r.movie_id = m.id
WHERE
    r.median_rating >= 8
GROUP BY nm.name
ORDER BY COUNT(m.title) DESC;


/* Have you find your favourite actor 'Mohanlal' in the list. If no, please check your code again. 
RSVP Movies plans to partner with other global production houses. 
Let’s find out the top three production houses in the world.*/

-- Q21. Which are the top three production houses based on the number of votes received by their movies?
/* Output format:
+------------------+--------------------+---------------------+
|production_company|vote_count			|		prod_comp_rank|
+------------------+--------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:
SELECT production_company,
       sum(total_votes),
       Rank()
         OVER(
           ORDER BY sum(total_votes) DESC)
FROM   movie m
       INNER JOIN ratings r
               ON r.movie_id = m.id
GROUP  BY production_company 
LIMIT 3; 




/*Yes Marvel Studios rules the movie world.
So, these are the top three production houses based on the number of votes received by the movies they have produced.

Since RSVP Movies is based out of Mumbai, India also wants to woo its local audience. 
RSVP Movies also wants to hire a few Indian actors for its upcoming project to give a regional feel. 
Let’s find who these actors could be.*/

-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the list?
-- Note: The actor should have acted in at least five Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actor_name	|	total_votes		|	movie_count		  |	actor_avg_rating 	 |actor_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Yogi Babu	|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

SELECT n.NAME  AS actor_name,
       r.total_votes AS total_votes,
       Count(m.id)  AS movie_count,
       Round(Sum(avg_rating * total_votes) / Sum(total_votes), 2) AS actor_avg_rating,
       Dense_rank() OVER(ORDER BY Round(Sum(avg_rating * total_votes) / Sum(total_votes), 2)  DESC) AS actor_rank
FROM   movie m
       INNER JOIN ratings r
               ON r.movie_id = m.id
       INNER JOIN role_mapping rm
               ON rm.movie_id = m.id 
       INNER JOIN names n
               ON n.id = rm.name_id
WHERE category = 'Actor'   
and country = 'India'
       GROUP BY n.name
       HAVING movie_count >=5;

-- Top actor is Vijay Sethupathi

-- Q23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 
-- Note: The actresses should have acted in at least three Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |	actress_avg_rating 	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Tabu		|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

WITH actress_summary AS
(SELECT 
    n.NAME AS actress_name,
    total_votes,
    COUNT(r.movie_id) AS movie_count,
      ROUND(SUM(avg_rating * total_votes) / SUM(total_votes),
            2) AS actress_avg_rating
            
FROM                  movie AS m
                INNER JOIN ratings AS r
                        ON m.id = r.movie_id
                INNER JOIN role_mapping AS rm
                        ON m.id = rm.movie_id
                INNER JOIN names AS n
                        ON rm.name_id = n.id
 WHERE          category = 'ACTRESS'
                AND country = "INDIA"
                 AND languages LIKE '%HINDI%'
         GROUP  BY NAME
         HAVING  movie_count >=3
)
SELECT * ,
RANK () OVER ( ORDER BY actress_avg_rating DESC) AS actress_rank
from actress_summary
LIMIT 5;

/* Taapsee Pannu tops with average rating 7.74. 
Now let us divide all the thriller movies in the following categories and find out their numbers.*/


/* Q24. Select thriller movies as per avg rating and classify them in the following category: 

			Rating > 8: Superhit movies
			Rating between 7 and 8: Hit movies
			Rating between 5 and 7: One-time-watch movies
			Rating < 5: Flop movies
--------------------------------------------------------------------------------------------*/
-- Type your code below:


SELECT 
    title,
    CASE
        WHEN avg_rating > 8 THEN 'SuperHit Movie'
        WHEN avg_rating BETWEEN 7 AND 8 THEN 'Hit Movie'
        WHEN avg_rating BETWEEN 5 AND 7 THEN 'One-time-watch Movie'
        WHEN avg_rating < 5 THEN 'Flop Movie'
    END AS Review
FROM
    movie m
        INNER JOIN
    ratings r ON r.movie_id = m.id
		INNER JOIN 
	genre g ON g.movie_id = m.id
    WHERE genre LIKE 'THRILLER' 
;


/* Until now, you have analysed various tables of the data set. 
Now, you will perform some tasks that will give you a broader understanding of the data in this segment.*/

-- Segment 4:

-- Q25. What is the genre-wise running total and moving average of the average movie duration? 
-- (Note: You need to show the output table in the question.) 
/* Output format:
+---------------+-------------------+---------------------+----------------------+
| genre			|	avg_duration	|running_total_duration|moving_avg_duration  |
+---------------+-------------------+---------------------+----------------------+
|	comdy		|			145		|	       106.2	  |	   128.42	    	 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:


SELECT 
    genre, 
    ROUND(AVG(duration), 0) AS total_duration,
    SUM(ROUND(AVG(duration), 0)) OVER(ORDER BY genre ROWS UNBOUNDED PRECEDING )  AS running_total_duration,
    AVG(ROUND(AVG(duration), 0)) OVER(ORDER BY genre ROWS 10 PRECEDING ) AS moving_avg_total_duration
FROM
    movie m
        INNER JOIN
    genre g ON g.movie_id = m.id
    GROUP BY genre
    ORDER BY genre;


-- Round is good to have and not a must have; Same thing applies to sorting


-- Let us find top 5 movies of each year with top 3 genres.

-- Q26. Which are the five highest-grossing movies of each year that belong to the top three genres? 
-- (Note: The top 3 genres would have the most number of movies.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| genre			|	year			|	movie_name		  |worldwide_gross_income|movie_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	comedy		|			2017	|	       indian	  |	   $103244842	     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

-- Top 3 Genres based on most number of movies
with gross_movie as
(
SELECT 
    genre,
    YEAR(date_published) AS year,
    title AS movie_name,
    cast(replace(replace(ifnull( worlwide_gross_income,0),'INR', ''), '$', '') AS decimal(10)) AS world_gross, 
    dense_rank() OVER( PARTITION BY year ORDER BY  cast(replace(replace(ifnull( worlwide_gross_income,0),'INR', ''), '$', '') AS decimal(10))  DESC ) as movie_rank
    
FROM
    movie m
        INNER JOIN
    genre g ON g.movie_id = m.id
WHERE
    genre like 
    '%drama%' or genre like '%comedy%'
    or genre like '%Thriller%'
)
select * 
from gross_movie 
where movie_rank <=5
;

-- Finally, let’s find out the names of the top two production houses that have produced the highest number of hits among multilingual movies.
-- Q27.  Which are the top two production houses that have produced the highest number of hits (median rating >= 8) among multilingual movies?
/* Output format:
+-------------------+-------------------+---------------------+
|production_company |movie_count		|		prod_comp_rank|
+-------------------+-------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:


WITH product_comp_summary
     AS (SELECT production_company,
                Count(*) AS movie_count
         FROM   movie AS m
                inner join ratings AS r
                        ON r.movie_id = m.id
         WHERE  median_rating >= 8
                AND production_company IS NOT NULL
                AND Position(',' IN languages) > 0
         GROUP  BY production_company
         ORDER  BY movie_count DESC)
SELECT *,
       dense_rank()
         OVER(ORDER BY movie_count DESC) AS prod_comp_rank
FROM   product_comp_summary;



-- Multilingual is the important piece in the above question. It was created using POSITION(',' IN languages)>0 logic
-- If there is a comma, that means the movie is of more than one language


-- Q28. Who are the top 3 actresses based on number of Super Hit movies (average rating >8) in drama genre?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |actress_avg_rating	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Laura Dern	|			1016	|	       1		  |	   9.60			     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

SELECT n.NAME AS actress_name,
       total_votes,
       Count(m.id)  AS movie_count,
       Round(Sum(total_votes * avg_rating) / Sum(total_votes), 1) AS actress_avg_rating,
       Dense_rank() OVER(ORDER BY count(m.id) DESC )
       AS actress_rank
FROM   movie m
       INNER JOIN ratings r
               ON m.id = r.movie_id
       INNER JOIN role_mapping rm
               ON rm.movie_id = m.id
       INNER JOIN names n
               ON n.id = rm.name_id
       INNER JOIN genre g
               ON g.movie_id = m.id
WHERE  r.avg_rating > 8
       AND rm.category = 'Actress'
       AND genre = 'Drama'
GROUP  BY n.NAME; 



/* Q29. Get the following details for top 9 directors (based on number of movies)
Director id
Name
Number of movies
Average inter movie duration in days
Average movie ratings
Total votes
Min rating
Max rating
total movie durations

Format:
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
| director_id	|	director_name	|	number_of_movies  |	avg_inter_movie_days |	avg_rating	| total_votes  | min_rating	| max_rating | total_duration |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
|nm1777967		|	A.L. Vijay		|			5		  |	       177			 |	   5.65	    |	1754	   |	3.7		|	6.9		 |		613		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+

--------------------------------------------------------------------------------------------*/
-- Type you code below:

WITH directors AS
(
           SELECT     dm.name_id,
                      n.NAME,
                      dm.movie_id,
                      duration,
                      r.avg_rating AS avg_rating ,
                      total_votes,
                      m.date_published,
                      Lead(date_published, 1) OVER(partition BY dm.name_id ORDER BY date_published, movie_id ) AS next_date
           FROM       movie m
           INNER JOIN director_mapping dm
           ON         m.id = dm.movie_id
           INNER JOIN ratings r
           ON         r.movie_id = dm.movie_id
           INNER JOIN names n
           ON         n.id = dm.name_id ), next_date_summary AS
(
       SELECT * ,
              Datediff( next_date, date_published) AS days_difference
       FROM   directors )
SELECT   name_id                       AS director_id,
         NAME                          AS director_name,
         Count(movie_id)               AS number_of_movies,
         Round(Avg(days_difference),2) AS avg_inter_movie_days,
         Round(Avg(avg_rating),2)      AS avg_rating,
         Sum(total_votes)              AS total_votes,
         Min(avg_rating)               AS min_rating,
         Max(avg_rating)               AS max_rating,
         Sum(duration)                 AS total_duration
FROM     next_date_summary
GROUP BY director_id
ORDER BY Count(movie_id) DESC limit 9;