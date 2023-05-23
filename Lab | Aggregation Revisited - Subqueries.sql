#Lab | Aggregation Revisited - Subqueries

USE Sakila;

# 1.Select the first name, last name, and email address of all the customers who have rented a movie.

SELECT DISTINCT r.customer_id, c.first_name, c.last_name, c.email FROM sakila.customer c 
RIGHT JOIN sakila.rental r USING (customer_id);


#2. What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).

SELECT DISTINCT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, AVG(p.amount) AS Average_payment_amount FROM sakila.customer c 
JOIN sakila.payment p USING (customer_id)
GROUP BY customer_id;

#3. Select the name and email address of all the customers who have rented the "Action" movies.
# Write the query using multiple join statements
SELECT DISTINCT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, c.email, ca.name 
FROM sakila.customer c JOIN sakila.rental r USING (customer_id)
JOIN sakila.inventory i USING (inventory_id)
JOIN sakila.film_category fc USING (film_id)
JOIN sakila.category ca USING (category_id)
WHERE ca.name= "Action";


# Write the query using sub queries with multiple WHERE clause and IN condition

SELECT DISTINCT customer_id, CONCAT(first_name, ' ', last_name) AS customer_name, email 
FROM customer 
WHERE customer_id in
(SELECT  customer_id FROM sakila.rental  WHERE inventory_id in
(SELECT inventory_id FROM inventory WHERE film_id in
(SELECT film_id FROM film_category WHERE category_id in
(SELECT category_id FROM category WHERE name="Action"))));

# Verify if the above two queries produce the same results or not
#I get same results: 498 rows

# 4. Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. 
#If the amount is between 0 and 2, label should be low and 
#if the amount is between 2 and 4, the label should be medium, 
#and if it is more than 4, then it should be high.

SELECT customer_id, amount,
	   CASE 
        WHEN 0 <amount< 2  Then "low" 
	    WHEN 2 <amount< 4  Then "medium" 
	    WHEN amount>4  Then "high" 
	   END AS label
FROM payment;
  

