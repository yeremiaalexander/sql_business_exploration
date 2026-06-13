use magist;
-- 1. How many orders are there in the dataset? 
select  
count(distinct order_id)
from orders;

-- 2. Are orders actually delivered?
select order_status, count(*) as orders
from orders 
group by order_status;


-- 3. Is Magist having user growth?
select year(order_purchase_timestamp) as year_,
month(order_purchase_timestamp) as month_, count(customer_id)
from orders
group by year_, month_
order by year_, month_;

-- 4. How many products are there on the products table?
select count(distinct product_id)
from products;

-- 5. Which are the categories with the most products? 
select product_category_name, count(distinct product_id) as n_products
from products p
group by product_category_name
order by count(product_id) desc
;

-- 6. How many of those products were present in actual transactions? 
select count(distinct product_id)
from order_items;

-- 7. What’s the price for the most expensive and cheapest products?
SELECT 
    p.product_category_name, 
    oi.price, p.product_id
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
WHERE oi.price > (SELECT MIN(price) FROM order_items)
  AND oi.price < (SELECT MAX(price) FROM order_items)
  order by price asc;
  
-- 8. What are the highest and lowest payment values?
select *
from order_payments;


select order_id
from order_payments
where payment_value > (select min(payment_value) from order_payments)
group by order_id;


-- in relation to products


-- 1) how many What categories of tech products does Magist have?
select count(distinct product_category_name_english)
from product_category_name_translation
where product_category_name_english like '%tech%';

select product_category_name,
case when product_category_name_english = 'audio' then 'tech'
when product_category_name_english = 'cine_photo' then 'tech'
when product_category_name_english = 'consoles_games' then 'tech'
when product_category_name_english = 'dvds_blu_ray' then 'tech'
when product_category_name_english = 'computers_accessories' then 'tech'
when product_category_name_english = 'pc_gamer' then 'tech'
when product_category_name_english = 'computers'  then 'tech'
when product_category_name_english = 'tablets_printing_image' then 'tech'
when product_category_name_english = 'telephony' then 'tech'
when product_category_name_english = 'fixed_telephony' then 'tech'
when product_category_name_english = 'electronics' then 'tech'
when product_category_name_english = 'signaling_and_security' then 'tech'
else 'unknown'
end as techProducts
from product_category_name_translation;

SELECT 
    COUNT(*) AS total_items,
    CASE 
        WHEN product_category_name_english IN ('audio', 
        'cine_photo', 
        'consoles_games', 
        'dvds_blu_ray', 
        'computers_accessories', 
        'pc_gamer', 
        'computers', 
        'tablets_printing_image',
        'telephony',
        'fixed_telephony','electronics','signaling_and_security') 
        THEN 'tech'
        ELSE 'not_tech'
    END AS category_type
FROM product_category_name_translation
GROUP BY category_type;


-- 2) How many products of these tech categories have been sold (within the time window of the database snapshot)?
SELECT COUNT(oi.product_id) AS total_tech_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
JOIN product_category_name_translation p2 USING (product_category_name)
WHERE p2.product_category_name_english IN (
    'audio', 'cine_photo', 'computers', 'computers_accessories', 
    'console_games', 'electronics', 'fixed_telephony', 
    'pc_gamer', 'signaling_and_security', 'tablets_printing_image', 'telephony'
)
AND o.order_status = 'delivered';
    
    
    
    
--   What percentage does that represent from the overall number of products sold?
select 
(sum(case when product_category_name_english 
IN ('audio', 
        'cine_photo', 
        'computers', 
        'computers_accessories', 
        'consoles_games', 
        'electronics', 
        'fixed_telephony',
        'pc_gamer',
        'telephony','signaling_and_security','tablets_printing_image') 
        then 1 else 0 end) * 100 / count(*)) as tech_percentage
from order_items oi
jOIN products p ON oi.product_id = p.product_id
JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name;


-- 3) What’s the average price of the products being sold?
select avg(price)
from order_items;

-- 4) Are expensive tech products popular? 

select 
case when price > 500 then 'cheap'
when price between 500 and 1000 then 'medium'
else 'expensive'
end as price_clasification,
avg(ore.review_score) as avg_review, count(oi.order_id) as sum_id
from order_items oi
join order_reviews ore on oi.order_id = ore.order_id
join products p on oi.product_id = p.product_id
join product_category_name_translation pcnt on p.product_category_name = pcnt.product_category_name
where pcnt.product_category_name_english in ('audio', 
        'cine_photo', 
        'computers', 
        'computers_accessories', 
        'console_games'
        'electronics', 
        'fixed_telephony', 
        'pc_gamer',
        'signaling_and_security',
        'tablets_printing_image','telephony')
group by price_clasification
order by avg_review;


-- another query
SELECT
CASE
	WHEN product_category_name_english IN (
            'electronics','computers','computers_accessories','pc_gamer','cine_photo',
            'tablets_printing_image','telephony','fixed_telephony', 'dvds_blu_ray',
            'audio','consoles_games', 'signaling_and_security'
        ) THEN 'Tech'
        ELSE 'Non-Tech'
    END AS category_group,
CASE
	WHEN price > (SELECT AVG(PRICE) FROM order_items) THEN 'expensive'
    ELSE 'affordable'
    END AS price_category,
COUNT(DISTINCT product_id)
FROM product_category_name_translation
JOIN products
USING (product_category_name)
JOIN order_items
USING (product_id)
GROUP BY category_group, price_category;


-- in relation to the sellers


-- 1) how many months of data are included in the magist database?
select *
from sellers;

select Max(order_purchase_timestamp) , min(order_purchase_timestamp)
from orders;

select Max(order_purchase_timestamp), min(order_purchase_timestamp),
timestampdiff(month, min(order_purchase_timestamp), max(order_purchase_timestamp) )
from orders;

-- 2) How many sellers are there? How many Tech sellers are there? What percentage of overall sellers are Tech sellers?


select count(distinct s.seller_id) as amount_seller,
case when product_category_name_english = 'audio' then 'tech'
when product_category_name_english = 'cine_photo' then 'tech'
when product_category_name_english = 'computers' then 'tech'
when product_category_name_english = 'computers_accessories' then 'tech'
when product_category_name_english = 'consoles_games' then 'tech'
when product_category_name_english = 'electronics'  then 'tech'
when product_category_name_english = 'fixed_telephony' then 'tech'
when product_category_name_english = 'pc_gamer' then 'tech'
when product_category_name_english = 'signaling_and_security' then 'tech'
when product_category_name_english = 'tablets_printing_image' then 'tech'
when product_category_name_english = 'signaling_and_security' then 'tech'
else 'non-tech'
end as tech_products
from sellers s
join order_items oi on s.seller_id = oi.seller_id
join products p on oi.product_id = p.product_id
join product_category_name_translation pcnt on p.product_category_name = pcnt.product_category_name
group by tech_products;



select 
(
(select count(distinct s.seller_id)
from sellers s
join order_items oi on s.seller_id = oi.seller_id
join products p using (product_id)
join product_category_name_translation pcnt on p.product_category_name = pcnt.product_category_name
where product_category_name_english in ('audio', 
        'cine_photo', 
        'computers', 
        'computers_accessories', 
        'consoles_games', 
        'electronics', 
        'fixed_telephony',
        'pc_gamer',
        'signaling_and_security','tablets_printing_image','telephony') ) * 100 /
        
        (select count(distinct s.seller_id)
        from sellers s
        join order_items oi on s.seller_id = oi.seller_id)) as tech_seller_percentage;

-- 3) What is the total amount earned by all sellers? What is the total amount earned by all Tech sellers?
-- asnwer with case function         
select 
sum(case 
when product_category_name_english in ('audio', 
        'cine_photo', 
        'consoles_games', 
        'dvds_blu_ray', 
        'computers_accessories', 
        'pc_gamer', 
        'computers', 
        'tablets_printing_image',
        'telephony',
        'fixed_telephony','electronics','signaling_and_security')  
        then price else 0 end) as total_tech_revenue,
 sum(case 
 when 
 product_category_name_english not in ('audio', 
        'cine_photo', 
        'consoles_games', 
        'dvds_blu_ray', 
        'computers_accessories', 
        'pc_gamer', 
        'computers', 
        'tablets_printing_image',
        'telephony',
        'fixed_telephony','electronics','signaling_and_security')  
        then price else 0 end) as total_non_tech_revenue
from order_items oi
join products p using(product_id)
join product_category_name_translation pcnt using (product_category_name);
 
 
 -- answer without CASE function
 select sum(price) as total_revenue
 from order_items;
 
 
 select sum(price) as total_tech_revenue
 from order_items oi
 join products p using(product_id)
 join product_category_name_translation pcnt using(product_category_name)
 where product_category_name_english in ('audio', 
        'cine_photo', 
        'computers', 
        'computers_accessories', 
        'consoles_games', 
        'electronics', 
        'fixed_telephony',
        'pc_gamer',
        'signaling_and_security','tablets_printing_image','telephony'); 
        

-- 4) Can you work out the average monthly income of all sellers? Can you work out the average monthly income of Tech sellers?
select 
avg(case when product_category_name_english in ('audio', 
        'cine_photo', 
        'computers', 
        'computers_accessories', 
        'consoles_games', 
        'electronics', 
        'fixed_telephony',
        'pc_gamer',
        'signaling_and_security','tablets_printing_image','telephony')  
        then price else null end) as avg_tech_revenue,
 avg(case 
 when 
 product_category_name_english not in ('audio', 
        'cine_photo', 
        'consoles_games', 
        'dvds_blu_ray', 
        'computers_accessories', 
        'pc_gamer', 
        'computers', 
        'tablets_printing_image',
        'telephony',
        'fixed_telephony', 'electronics','signaling_and_security')  
        then price else null end) as total_non_tech_revenue,
sum(price) as total_revenue, oi.seller_id, 
date_format(o.order_purchase_timestamp, '%Y-%m') as order_month
from order_items oi
join products p using(product_id)
join product_category_name_translation pcnt using (product_category_name)
join orders o using(order_id)
group by oi.seller_id, order_month;






-- In relation to the delivery time 

-- 1) What’s the average time between the order being placed and the product being delivered?
select avg(datediff( order_delivered_customer_date,order_purchase_timestamp))
from orders
where order_delivered_customer_date is not null;

-- 2) How many orders are delivered on time vs orders delivered with a delay?
select 
case when order_delivered_customer_date <= order_delivered_customer_date then 'on-time' else 'delayed' end as delivery_tracking,
count(*) as total_orders
from orders 
group by delivery_tracking
;

-- 3) Is there any pattern for delayed orders, e.g. big products being delayed more often?
select avg(product_weight_g), max(product_weight_g), min(product_weight_g)
from products;

-- lets make the above average weight is big

select
case when product_weight_g < 1000 then 'low weight'
when product_weight_g between 1000 and 2000 then 'medium weight'
else 'high_weight' end as weight_category,
case when order_delivered_customer_date  <= order_estimated_delivery_date  then 'on-time' else 'delayed' end as delivery_tracking,
count(*) as total_orders
from orders
join order_items using (order_id)
join products using (product_id)
where order_delivered_customer_date is not null
group by delivery_tracking, weight_category
order by delivery_tracking, weight_category
;

-- 4) whats the percentage of tech sellers and non tech sellers compare to the total sellers
SELECT
        CASE
        WHEN product_category_name_english IN (
            'audio', 
        'cine_photo', 
        'computers', 
        'computers_accessories', 
        'consoles_games', 
        'electronics', 
        'fixed_telephony',
        'pc_gamer',
        'signaling_and_security','tablets_printing_image','telephony'
        ) THEN 'Tech'
        ELSE 'Non-Tech'
    END AS category_group,
    COUNT( DISTINCT seller_id) AS CATEGORYWISE_SELLERS,
    SUM(COUNT( DISTINCT seller_id)) OVER() AS TOTAL_SELLERS,
    (COUNT( DISTINCT seller_id) / SUM(COUNT( DISTINCT seller_id)) OVER()) * 100 AS PERCENTAGE
    FROM
		product_category_name_translation
    JOIN products
    USING (product_category_name)
    JOIN order_items
    USING (product_id)
    GROUP BY category_group;


-- 5. group seller based son seller_zip code and find which zip locations generate the most revenue
select g.zip_code_prefix, 
sum(oi.price) as total_revenue
from sellers s
join order_items oi using (seller_id)
join products p using (product_id) 
join geo g on s.seller_zip_code_prefix = g.zip_code_prefix
group by g.zip_code_prefix
order by total_revenue desc;

-- 6. average customer rating based on zp_code  
select round(avg(or1.review_score),2) as avg_review, g.zip_code_prefix
from order_reviews or1 
join orders o using (order_id)
join order_items oi using (order_id)
join products p using(product_id)
join sellers s using (seller_id)
join geo g on s.seller_zip_code_prefix = g.zip_code_prefix
group by g.zip_code_prefix
order by avg_review;

-- what is the most payment used alter
select *
from order_payments;

SELECT 
    payment_type,
    COUNT(*) AS count,
    (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER()) AS percentage
FROM order_payments
GROUP BY payment_type;


select count(zip_code_prefix)

from geo;





