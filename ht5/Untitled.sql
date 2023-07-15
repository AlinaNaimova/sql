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

/*
1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов

Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)

Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди” (аналогично)

Доп задания:
1* Получить ранжированный список автомобилей по цене в порядке возрастания
2* Получить топ-3 самых дорогих автомобилей, а также их общую стоимость
3* Получить список автомобилей, у которых цена больше предыдущей цены
4* Получить список автомобилей, у которых цена меньше следующей цены
5*Получить список автомобилей, отсортированный по возрастанию цены, и добавить столбец со значением разницы между текущей ценой и ценой следующего автомобиля
*/

1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов:

sql
CREATE VIEW cars_under_25000 AS
SELECT *
FROM cars
WHERE cost < 25000;


2. Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW):

sql
ALTER VIEW cars_under_25000 AS
SELECT *
FROM cars
WHERE cost < 30000;


3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди” (аналогично):

sql
CREATE VIEW skoda_and_audi_cars AS
SELECT *
FROM cars
WHERE name IN ('Skoda', 'Audi');


Дополнительные задания:

1. Получить ранжированный список автомобилей по цене в порядке возрастания:

sql
SELECT *, RANK() OVER (ORDER BY cost) AS rank
FROM cars;


2. Получить топ-3 самых дорогих автомобилей, а также их общую стоимость:

sql
SELECT *, SUM(cost) OVER (ORDER BY cost DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS total_cost
FROM cars
ORDER BY cost DESC
LIMIT 3;


3. Получить список автомобилей, у которых цена больше предыдущей цены:

sql
SELECT *
FROM (
    SELECT *, LAG(cost) OVER (ORDER BY id) AS prev_cost
    FROM cars
) AS subquery
WHERE cost > prev_cost;


4. Получить список автомобилей, у которых цена меньше следующей цены:

sql
SELECT *
FROM (
    SELECT *, LEAD(cost) OVER (ORDER BY id) AS next_cost
    FROM cars
) AS subquery
WHERE cost < next_cost;


5. Получить список автомобилей, отсортированный по возрастанию цены, и добавить столбец со значением разницы между текущей ценой и ценой следующего автомобиля:

sql
SELECT *, LEAD(cost) OVER (ORDER BY cost) - cost AS price_difference
FROM cars
ORDER BY cost;