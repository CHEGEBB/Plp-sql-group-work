-- Bookstore Database Sample Queries
-- 1. Basic SELECT query to get all books with their titles, ISBNs, and prices
SELECT book_id, title, isbn, price FROM book;


-- 2. Get list of books with their authors 
SELECT b.title, CONCAT(a.first_name, ' ', a.last_name) AS author_name
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id
ORDER BY b.title;

-- 3. Get total number of books by each author
SELECT a.first_name, a.last_name, COUNT(ba.book_id) AS book_count
FROM author a
LEFT JOIN book_author ba ON a.author_id = ba.author_id
GROUP BY a.author_id
ORDER BY book_count DESC;

-- 4. Find the most expensive books 
SELECT title, price 
FROM book 
ORDER BY price DESC 
LIMIT 5;




-- 5. Get customer order history with status
SELECT c.first_name, c.last_name, co.order_id, co.order_date, 
       os.status_name, co.order_total
FROM customer c
JOIN cust_order co ON c.customer_id = co.customer_id
JOIN order_status os ON co.status_id = os.status_id
ORDER BY co.order_date DESC;



-- 6. Calculate total sales by book 
SELECT b.title, SUM(ol.quantity) AS copies_sold, 
       SUM(ol.quantity * ol.price) AS total_revenue
FROM book b
JOIN order_line ol ON b.book_id = ol.book_id
GROUP BY b.book_id
ORDER BY total_revenue DESC;

-- 7. Find books published in a specific language
SELECT b.title, bl.language_name
FROM book b
JOIN book_language bl ON b.language_id = bl.language_id
WHERE bl.language_name = 'English';

-- 8. Get customer addresses with country information
SELECT c.first_name, c.last_name, 
       CONCAT(a.street_number, ' ', a.street_name) AS street,
       a.city, a.postal_code, co.country_name, ast.status_name
FROM customer c
JOIN customer_address ca ON c.customer_id = ca.customer_id
JOIN address a ON ca.address_id = a.address_id
JOIN country co ON a.country_id = co.country_id
JOIN address_status ast ON ca.status_id = ast.status_id;

-- 9. Find orders that used express shipping
SELECT co.order_id, c.first_name, c.last_name, sm.method_name, co.order_date
FROM cust_order co
JOIN customer c ON co.customer_id = c.customer_id
JOIN shipping_method sm ON co.shipping_method_id = sm.method_id
WHERE sm.method_name = 'Express';

-- 10. View order history timeline for a specific order
SELECT oh.status_date, os.status_name, oh.notes
FROM order_history oh
JOIN order_status os ON oh.status_id = os.status_id
WHERE oh.order_id = 1
ORDER BY oh.status_date;

-- 11. Count books by publisher
SELECT p.publisher_name, COUNT(b.book_id) AS book_count
FROM publisher p
LEFT JOIN book b ON p.publisher_id = b.publisher_id
GROUP BY p.publisher_id
ORDER BY book_count DESC;



-- 12. Find customers who haven't placed any orders
SELECT c.customer_id, c.first_name, c.last_name, c.email
FROM customer c
LEFT JOIN cust_order co ON c.customer_id = co.customer_id
WHERE co.order_id IS NULL;
-- 13. Calculate average order value
SELECT AVG(order_total) AS average_order_value
FROM cust_order;

-- 14. Find the most popular shipping method
SELECT sm.method_name, COUNT(co.order_id) AS usage_count
FROM shipping_method sm
LEFT JOIN cust_order co ON sm.method_id = co.shipping_method_id
GROUP BY sm.method_id
ORDER BY usage_count DESC
LIMIT 1;

-- 15. Get complete order details including all books in an order
SELECT co.order_id, c.first_name, c.last_name, 
       co.order_date, os.status_name,
       b.title, ol.quantity, ol.price, 
       (ol.quantity * ol.price) AS item_total
FROM cust_order co
JOIN customer c ON co.customer_id = c.customer_id
JOIN order_status os ON co.status_id = os.status_id
JOIN order_line ol ON co.order_id = ol.order_id
JOIN book b ON ol.book_id = b.book_id
ORDER BY co.order_id, b.title;