DROP TABLE IF EXISTS `shops`;
CREATE TABLE `shops` (
	`id` INT,
    `shopname` VARCHAR (100),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS `cats`;
CREATE TABLE `cats` (
	`name` VARCHAR (100),
    `id` INT,
    PRIMARY KEY (id),
    shops_id INT,
    CONSTRAINT fk_cats_shops_id FOREIGN KEY (shops_id)
        REFERENCES `shops` (id)
);

INSERT INTO `shops`
VALUES 
		(1, "Четыре лапы"),
        (2, "Мистер Зоо"),
        (3, "МурзиЛЛа"),
        (4, "Кошки и собаки");

INSERT INTO `cats`
VALUES 
		("Murzik",1,1),
        ("Nemo",2,2),
        ("Vicont",3,1),
        ("Zuza",4,3);

/*
Условие:
Используя JOIN-ы, выполните следующие операции:
1.Вывести всех котиков по магазинам по id (условие соединения shops.id = cats.shops_id)
2.Вывести магазин, в котором продается кот “Мурзик” (попробуйте выполнить 2 способами)
3.Вывести магазины, в которых НЕ продаются коты “Мурзик” и “Zuza”

Табличка (после слов “Последнее задание, таблица:”)
4.Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю.
*/

-- 1.Вывести всех котиков по магазинам по id (условие соединения shops.id = cats.shops_id)
SELECT * 
FROM cats
JOIN shops ON shops.id = cats.shops_id;

-- 2.Вывести магазин, в котором продается кот “Мурзик” (попробуйте выполнить 2 способами)
-- Первый способ:

SELECT shops.*
FROM shops
JOIN cats ON shops.id = cats.shops_id
WHERE cats.name = 'Murzik';

-- Второй способ:

SELECT shops.*
FROM shops
WHERE shops.id IN (SELECT shops_id FROM cats WHERE name = 'Murzik');

-- 3.Вывести магазины, в которых НЕ продаются коты “Мурзик” и “Zuza”
SELECT s.shopname
FROM shops AS s
LEFT JOIN cats AS c
  ON s.id = c.shops_id AND c.name IN ('Murzik', 'Zuza')
WHERE c.id IS NULL;