USE Pizza;

 
-- TRUNCATE TABLE orders;
-- TRUNCATE TABLE order_details;

-- TRUNCATE TABLE customer;

-- TRUNCATE TABLE pizzas;

CREATE TABLE `customer` (
  `id_customer` int NOT NULL,
  `customer_phone_number` varchar(45) NOT NULL,
  `customer_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_customer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `order_details` (
  `id_order_details` int NOT NULL,
  `pizza_type` varchar(45) NOT NULL,
  `quantity` int NOT NULL,
  `pizza_cost` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`id_order_details`,`pizza_type`),
  KEY `pizza_type_idx` (`pizza_type`),
  CONSTRAINT `id_order_details` FOREIGN KEY (`id_order_details`) REFERENCES `orders` (`id_orders`),
  CONSTRAINT `pizza_type` FOREIGN KEY (`pizza_type`) REFERENCES `pizzas` (`pizza_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `orders` (
  `id_orders` int NOT NULL,
  `id_customer` int NOT NULL,
  `order_datetime` datetime NOT NULL,
  `total_cost` decimal(8,2) NOT NULL,
  PRIMARY KEY (`id_orders`),
  KEY `id_customer_idx` (`id_customer`),
  CONSTRAINT `id_customer` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id_customer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `pizzas` (
  `pizza_type` varchar(45) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  PRIMARY KEY (`pizza_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO pizzas(pizza_type,price)
VALUES('Pepperoni & Cheese',7.99);

INSERT INTO pizzas(pizza_type,price)
VALUES('Vegetarian',9.99);

INSERT INTO pizzas(pizza_type,price)
VALUES('Meat Lovers',14.99);

INSERT INTO pizzas(pizza_type,price)
VALUES('Hawaiian',12.99);

SELECT * FROM pizzas;

 INSERT INTO customer(id_customer,customer_name,customer_phone_number)
 VALUES(1,'Trevor Page','226-555-4982');

 INSERT INTO customer(id_customer,customer_name,customer_phone_number)
 VALUES(2,'John Doe','555-555-9498');
 
 SELECT * FROM customer;

-- Order 1
INSERT INTO orders (id_orders,id_customer,order_datetime,total_cost)
 VALUES(1,1,'2014-09-10 13:20:00',22.98);
 
 INSERT INTO order_details(id_order_details,pizza_type,quantity,pizza_cost)
 VALUES(1,'Pepperoni & Cheese',1, 7.99);

 INSERT INTO order_details(id_order_details,pizza_type,quantity,pizza_cost)
 VALUES(1,'Meat Lovers',1, 14.99);
  
  -- Order 2
  
  INSERT INTO orders (id_orders,id_customer,order_datetime,total_cost)
 VALUES(2,2,'2014-09-10 13:20:00',39.97);
 
 INSERT INTO order_details(id_order_details,pizza_type,quantity,pizza_cost)
 VALUES(2,'Vegetarian',1, 9.99);

 INSERT INTO order_details(id_order_details,pizza_type,quantity,pizza_cost)
 VALUES(2,'Meat Lovers',2, 14.99);
 
-- Order 3

 INSERT INTO orders (id_orders,id_customer,order_datetime,total_cost)
 VALUES(3,1,'2014-09-10 09:47:00',27.98);
 
 INSERT INTO order_details(id_order_details,pizza_type,quantity,pizza_cost)
 VALUES(3,'Meat Lovers',1, 14.99);

 INSERT INTO order_details(id_order_details,pizza_type,quantity,pizza_cost)
 VALUES(3,'Hawaiian',1, 12.99);
 
 SELECT * FROM orders;
  SELECT * FROM order_details;

SELECT c.id_customer, c.customer_name, SUM(od.pizza_cost * od.quantity) AS total_spent
FROM customer c
JOIN orders o ON c.id_customer = o.id_customer
JOIN order_details od ON o.id_orders = od.id_order_details
GROUP BY c.id_customer;

SELECT c.id_customer, c.customer_name, DATE(o.order_datetime) AS order_date, SUM(od.pizza_cost * od.quantity) AS total_spent
FROM customer c
JOIN orders o ON c.id_customer = o.id_customer
JOIN order_details od ON o.id_orders = od.id_order_details
GROUP BY c.id_customer, DATE(o.order_datetime);






