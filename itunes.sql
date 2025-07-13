create database itunes2;
use itunes2;
select * from artist;
select * from customer;
select * from employee;
select * from genre;
select * from invoice;
select * from invoice_line;
select * from media_type;
select * from playlist;
select * from playlist_track;
select * from track;
select t.Name, SUM(il.Quantity)
from invoice_line il
join track t on il.Track_id = t.Track_id
group by t.Track_id, t.Name;
#Top selling Genres
SELECT g.name AS genre, SUM(il.unit_price * il.quantity) AS revenue
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.genre_id, g.name
ORDER BY revenue DESC
LIMIT 5;
#Most active customers by purchase
SELECT c.first_name, c.last_name, COUNT(i.invoice_id) AS total_purchases, SUM(i.total) AS total_spent
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 10;
#Monthly sales trend
SELECT DATE_FORMAT(STR_TO_DATE(invoice_date, '%d-%m-%Y'), '%Y-%m') AS month,
       SUM(total) AS monthly_revenue
FROM invoice
GROUP BY DATE_FORMAT(STR_TO_DATE(invoice_date, '%d-%m-%Y'), '%Y-%m')
ORDER BY month;
#Employees handling more customer
SELECT e.employee_id, e.first_name, e.last_name, COUNT(c.customer_id) AS customers_handled
FROM employee e
JOIN customer c ON e.employee_id = c.support_rep_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY customers_handled DESC;
#Top tracks by revenue
SELECT t.track_id, t.name, SUM(il.unit_price * il.quantity) AS revenue
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id
GROUP BY t.track_id, t.name
ORDER BY revenue DESC
LIMIT 10;
#Track count in each playlist
SELECT p.playlist_id, p.name AS playlist_name, COUNT(pt.track_id) AS track_count
FROM playlist p
JOIN playlist_track pt ON p.playlist_id = pt.playlist_id
GROUP BY p.playlist_id, p.name
ORDER BY track_count DESC;
#Media type usage distribution 
SELECT m.media_type_id, m.name AS media_type, COUNT(t.track_id) AS track_count
FROM media_type m
JOIN track t ON m.media_type_id = t.media_type_id
GROUP BY m.media_type_id, m.name
ORDER BY track_count DESC;
#country wise revenue summary
SELECT i.billing_country, 
       COUNT(i.invoice_id) AS total_orders, 
       ROUND(SUM(i.total), 2) AS total_revenue
FROM invoice i
GROUP BY i.billing_country
ORDER BY total_revenue DESC;









