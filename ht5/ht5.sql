CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT *
FROM cars;


-- 1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов:
CREATE VIEW cars_under_25000 AS
SELECT *
FROM cars
WHERE cost < 25000;

SELECT * FROM cars_under_25000;

-- 2. Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW):
ALTER VIEW cars_under_25000 AS
SELECT *
FROM cars
WHERE cost < 30000;

SELECT * FROM cars_under_25000;

-- 3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди” (аналогично):
CREATE VIEW skoda_and_audi_cars AS
SELECT *
FROM cars
WHERE name IN ('Skoda', 'Audi');

SELECT * FROM skoda_and_audi_cars;

-- Дополнительные задания:

-- 1. Получить ранжированный список автомобилей по цене в порядке возрастания:
SELECT *, RANK() OVER (ORDER BY cost) AS rankAsc
FROM cars;


-- 2. Получить топ-3 самых дорогих автомобилей, а также их общую стоимость:
SELECT *, SUM(cost) OVER (ORDER BY cost DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS total_cost
FROM cars
ORDER BY cost DESC
LIMIT 3;


-- 3. Получить список автомобилей, у которых цена больше предыдущей цены:
SELECT *
FROM (
    SELECT *, LAG(cost) OVER (ORDER BY id) AS prev_cost
    FROM cars
) AS subquery
WHERE cost > prev_cost;


-- 4. Получить список автомобилей, у которых цена меньше следующей цены:
SELECT *
FROM (
    SELECT *, LEAD(cost) OVER (ORDER BY id) AS next_cost
    FROM cars
) AS subquery
WHERE cost < next_cost;


-- 5. Получить список автомобилей, отсортированный по возрастанию цены, и добавить столбец со значением разницы между текущей ценой и ценой следующего автомобиля:
SELECT *, LEAD(cost) OVER (ORDER BY cost) - cost AS price_difference
FROM cars
ORDER BY cost;