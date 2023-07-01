DROP DATABASE IF EXISTS ht2;
CREATE DATABASE IF NOT EXISTS ht2;

USE ht2;

-- Создания таблицы "sales" с полями "id", "order_date" и "counte_product" 
CREATE TABLE IF NOT EXISTS sales
(
id INT PRIMARY KEY AUTO_INCREMENT,
order_date DATE,
count_product INT);

-- Заполнения таблицы "sales" данными

INSERT INTO sales (id, order_date, count_product)
VALUES
    (1, '2022-01-01', 156),
    (2, '2022-01-02', 180),
    (3, '2022-01-03', 21),
    (4, '2022-01-04', 124),
    (5, '2022-01-05', 341);
    
    
-- Добавление столбца "order_type" в таблицу "sales"
ALTER TABLE sales ADD COLUMN order_type VARCHAR(20);

-- Обновление значений столбца "order_type" в зависимости от количества продуктов
UPDATE sales
SET order_type = CASE
    WHEN count_product < 100 THEN 'Маленький заказ'
    WHEN count_product >= 100 AND count_product <= 300 THEN 'Средний заказ'
    WHEN count_product > 300 THEN 'Большой заказ'
    ELSE 'Неизвестный тип заказа'
END;

-- Cоздания таблицы "orders" и заполнения ее значениями
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id VARCHAR(3),
    amount DECIMAL(10, 2),
    order_status VARCHAR(10)
);

INSERT INTO orders (id, employee_id, amount, order_status)
VALUES (1, 'e03', 15.00, 'OPEN'),
       (2, 'e01', 25.50, 'OPEN'),
       (3, 'e05', 100.70, 'CLOSED'),
       (4, 'e02', 22.18, 'OPEN'),
       (5, 'e04', 9.50, 'CANCELLED');
       
-- Выберите все заказы. В зависимости от поля order_status выведите столбец full_order_status:
-- OPEN – «Order is in open state» ; CLOSED - «Order is closed»; CANCELLED - «Order is cancelled»

SELECT id, employee_id, amount, order_status,
    IF(order_status = 'OPEN', 'Order is in open state',
        IF(order_status = 'CLOSED', 'Order is closed',
            IF(order_status = 'CANCELLED', 'Order is cancelled', NULL))) AS full_order_status
FROM orders;









