-- Question: Find the product ids that are both low fat and recyclable
-- Video: 

Create table Products 
(product_id int, low_fats char(1), recyclable char(1));
Truncate table Products;
insert into Products (product_id, low_fats, recyclable) values 
 (0, 'Y', 'N')
,(1, 'Y', 'Y') -- ***
,(2, 'N', 'Y')
,(3, 'Y', 'Y') -- ***
,(4, 'N', 'N');

/* Expected output 
+-------------+
| product_id  |
+-------------+
| 1           |
| 3           |
+-------------+
*/ 

-- General SQL 
select product_id 
       from Products 
      where low_fats = 'Y'   
        and recyclable = 'Y'; 

-- Case insensitive code 
select product_id 
       from Products 
      where upper(low_fats) = 'Y' 
        and upper(recyclable) = 'Y';
