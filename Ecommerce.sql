# Display the number of the customer group by their genders who have placed any order of amount greater than or equal to Rs.3000.

SELECT 
    COUNT(c.cus_id) AS No_of_customer, c.cus_gender
FROM
    customer c
        INNER JOIN
    orders o ON c.cus_id = o.cus_id
WHERE
    o.ord_amount > 3000
GROUP BY c.cus_gender;



#4)	Display all the orders along with the product name ordered by a customer having Customer_Id=2.

SELECT 
    o.*, p.pro_name
FROM
    orders o
        INNER JOIN
    product_details pd ON o.prod_id = pd.prod_id
        INNER JOIN
    product p ON p.pro_id = pd.pro_id
WHERE
    o.cus_id = 2;



#5)	Display the Supplier details who can supply more than one product.

SELECT 
    s.*
FROM
    Supplier s
        INNER JOIN
    Product_details pd ON pd.supp_id = s.supp_id
GROUP BY pd.supp_id
HAVING COUNT(pd.prod_id) > 1;



#6)	Find the category of the product whose order amount is minimum.

SELECT 
    c.cat_id, c.cat_name, MIN(o.ord_amount)
FROM
    Category c
        INNER JOIN
    product p ON c.cat_id = p.cat_id
        INNER JOIN
    product_details pd ON pd.pro_id = p.pro_id
        INNER JOIN
    orders o ON o.prod_id = pd.prod_id;



#7)	Display the Id and Name of the Product ordered after “2021-10-05”.
SELECT 
    p.pro_id,p.pro_name, o.ord_date
FROM
     product p
        INNER JOIN
    product_details pd ON pd.pro_id = p.pro_id
        INNER JOIN
    orders o ON o.prod_id = pd.prod_id
    where o.ord_date> "2021-10-05";



#8)	Display customer name and gender whose names start or end with character 'A'.
SELECT 
    c.cus_name, c.cus_gender
FROM
    customer c
WHERE
    c.cus_name LIKE '%A'
        OR c.cus_name LIKE 'A%';



# 9) Create a stored procedure to display the Rating for a Supplier if any along with the Verdict on that rating if #any like if rating >4 then “Genuine Supplier” if rating >2 “Average Supplier” else “Supplier should not be #considered”.

DROP procedure IF EXISTS `GetVerdict`;

DELIMITER $$
USE `ecommerce`$$
CREATE PROCEDURE `GetVerdict` ()
BEGIN
SELECT s.*, case
    when r.Rat_ratstars > 4 then 'Genuine Supplier' 
    when r.Rat_ratstars > 2 then 'Average Supplier'
    else 'Supplier should not be considered'
    end as verdict
    FROM Supplier s inner join rating r on s.supp_id = r.supp_id
    order by verdict;
END$$

DELIMITER ;