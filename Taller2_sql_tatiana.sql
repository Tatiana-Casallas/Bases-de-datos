-- Crear base de datos
CREATE DATABASE alquiler_peliculas;
USE alquiler_peliculas;

-- Tabla MEMBRESIA
CREATE TABLE MEMBRESIA (
    MEM_NUM INT PRIMARY KEY,
    MEM_FNAME VARCHAR(50),
    MEM_LNAME VARCHAR(50),
    MEM_STREET VARCHAR(100),
    MEM_CITY VARCHAR(50),
    MEM_STATE VARCHAR(2),
    MEM_ZIP VARCHAR(5),
    MEM_BALANCE DECIMAL(10,2)
);

INSERT INTO MEMBRESIA VALUES
(102, 'Tami', 'Dawson', '2632 Takli Circle', 'Norene', 'TN', '37136', 11),
(103, 'Curt', 'Knight', '4025 Cornell Court', 'Flaygap', 'KY', '41219', 6),
(104, 'Jamal', 'Melendez', '788 East 145th Avenue', 'Quebeck', 'TN', '38579', 0),
(105, 'Iva', 'Mcclain', '6045 Musket Ball Circle', 'Summit', 'KY', '42783', 15),
(106, 'Miranda', 'Parks', '4469 Maxwell Place', 'Germantown', 'TN', '38183', 0),
(107, 'Rosario', 'Elliott', '7578 Danner Avenue', 'Columbia', 'TN', '38402', 5),
(108, 'Mattie', 'Guy', '4390 Evergreen Street', 'Lily', 'KY', '40740', 0),
(109, 'Clint', 'Ochoa', '1711 ELM Street', 'Greeneville', 'TN', '37745', 10),
(110, 'Lewis', 'Rosalez', '4524 Southwind Circle', 'Counce', 'TN', '38326', 0),
(111, 'Stacy', 'Mann', '2789 East Cook Avenue', 'Murfreesboro', 'TN', '37132', 8),
(112, 'Luis', 'Trujillo', '7267 Melvin Avenue', 'Heiskell', 'TN', '37754', 3),
(113, 'Minnie', 'Gonzales', '6430 Vasili Drive', 'Williston', 'TN', '38076', 0);

-- Tabla PRECIO
CREATE TABLE PRECIO (
    PRICE_CODE INT PRIMARY KEY,
    PRICE_DESCRIPTION VARCHAR(50),
    PRICE_RENTFEE DECIMAL(10,2),
    PRICE_DAILYLATEFEE DECIMAL(10,2)
);

INSERT INTO PRECIO VALUES
(1, 'Standart', 2, 1),
(2, 'New Realease', 3.5, 3),
(3, 'Discount', 1.5, 1),
(4, 'Weekly Special', 1, 0.5);

-- Tabla PELICULA
CREATE TABLE PELICULA (
    MOVIE_NUM INT PRIMARY KEY,
    MOVIE_NAME VARCHAR(100),
    MOVIE_YEAR INT,
    MOVIE_COST DECIMAL(10,2),
    MOVIE_GENRE VARCHAR(50),
    PRICE_CODE INT,
    FOREIGN KEY (PRICE_CODE) REFERENCES PRECIO(PRICE_CODE)
);

INSERT INTO PELICULA VALUES
(1234, 'The Cesar Family Chrisstmas', 2007, 39.95, 'FAMILY', 2),
(1235, 'Smokey Mountain Wildlife', 2004, 59.95, 'ACTION', 1),
(1236, 'Richard Goodhope', 2008, 59.95, 'DRAMA', 2),
(1237, 'Beatnik Fever', 2007, 29.95, 'COMEDY', 2),
(1238, 'Constant Companion', 2008, 89.95, 'DRAMA', 2),
(1239, 'Where Hope Dies', 1998, 25.49, 'DRAMA', 3),
(1245, 'Time to Born', 2005, 45.49, 'ACTION', 1),
(1246, 'What He Doesn''t Know', 2006, 58.29, 'COMEDY', 1);

-- Tabla VIDEO (CORREGIDA)
CREATE TABLE VIDEO (
    VID_NUM INT PRIMARY KEY,
    VID_INDATE DATE,
    MOVIE_NUM INT,
    FOREIGN KEY (MOVIE_NUM) REFERENCES PELICULA(MOVIE_NUM)
);

INSERT INTO VIDEO VALUES
(54324, '2008-06-18', 1234),
(54325, '2008-06-18', 1234),
(34341, '2007-01-22', 1235),
(34342, '2007-01-22', 1235),
(34366, '2009-03-02', 1236),
(34367, '2009-03-02', 1236),
(34368, '2009-03-02', 1236),
(34369, '2009-03-02', 1236),
(44392, '2008-10-21', 1237),
(44397, '2008-10-21', 1237),
(59237, '2008-02-14', 1237),
(61388, '2007-01-25', 1239),
(61353, '2006-01-28', 1245),
(61354, '2006-01-28', 1245),
(61367, '2008-07-30', 1246),
(61369, '2008-07-30', 1246);

-- Tabla ALQUILER
CREATE TABLE ALQUILER (
    RENT_NUM INT PRIMARY KEY,
    RENT_DATE DATE,
    MEM_NUM INT,
    FOREIGN KEY (MEM_NUM) REFERENCES MEMBRESIA(MEM_NUM)
);

INSERT INTO ALQUILER VALUES
(1001, '2009-03-01', 103),
(1002, '2009-03-01', 105),
(1003, '2009-03-02', 102),
(1004, '2009-03-02', 110),
(1005, '2009-03-02', 111),
(1006, '2009-03-02', 107),
(1007, '2009-03-02', 104),
(1008, '2009-03-03', 105),
(1009, '2009-03-03', 111);

-- Tabla DETALLE_ALQUILER (CORREGIDA - solo con VID_NUM que existen en VIDEO)
CREATE TABLE DETALLE_ALQUILER (
    RENT_NUM INT,
    VID_NUM INT,
    DETAIL_FEE DECIMAL(10,2),
    DETAIL_DUEDATE DATE,
    RETAIL_RETURNDATE DATE,
    DATAIL_DAILYLATEFEE DECIMAL(10,2),
    PRIMARY KEY (RENT_NUM, VID_NUM),
    FOREIGN KEY (RENT_NUM) REFERENCES ALQUILER(RENT_NUM),
    FOREIGN KEY (VID_NUM) REFERENCES VIDEO(VID_NUM)
);

INSERT INTO DETALLE_ALQUILER VALUES
(1001, 34342, 2, '2009-03-04', '2009-03-02', 1),
(1001, 61353, 2, '2009-03-04', '2009-03-03', 1),
(1002, 59237, 3.5, '2009-03-04', '2009-03-04', 3),
(1003, 54325, 3.5, '2009-03-04', '2009-03-09', 3),
(1003, 61369, 2, '2009-03-06', '2009-03-09', 1),
(1003, 61388, 0, '2009-03-06', '2009-03-09', 1),
(1004, 44392, 3.5, '2009-03-05', '2009-03-07', 3),
(1004, 34367, 3.5, '2009-03-05', '2009-03-07', 3),
(1004, 34341, 2, '2009-03-07', '2009-03-07', 1),
(1005, 34342, 2, '2009-03-07', '2009-03-05', 1),
(1005, 44397, 3.5, '2009-03-05', '2009-03-05', 3),
(1006, 34366, 3.5, '2009-03-05', '2009-03-04', 3),
(1006, 61367, 2, '2009-03-07', NULL, 1),
(1007, 34368, 3.5, '2009-03-05', NULL, 3),
(1008, 34369, 3.5, '2009-03-05', '2009-03-05', 3),
(1009, 54324, 3.5, '2009-03-05', NULL, 3),
(1001, 34366, 3.5, '2009-03-04', '2009-03-02', 3);

-- 1. Escribir el comando de SQL para cambiar el año de película de código 1238 a 2009.
UPDATE PELICULA 
SET MOVIE_YEAR = 2009 
WHERE MOVIE_NUM = 1238;

-- Verificar el cambio
SELECT MOVIE_NUM, MOVIE_NAME, MOVIE_YEAR 
FROM PELICULA 
WHERE MOVIE_NUM = 1238;

-- Deshabilitar modo seguro temporalmente
SET SQL_SAFE_UPDATES = 0;

-- 2. Escribir un comando de SQL para aumentar todos los valores de precio de tarifa de alquiler en $0.50.
UPDATE PRECIO 
SET PRICE_RENTFEE = PRICE_RENTFEE + 0.50;

-- Reactivar modo seguro
SET SQL_SAFE_UPDATES = 1;

-- Verificar los cambios
SELECT * FROM PRECIO;

-- 3. Escribir una consulta para mostrar el nombre de la película, año y género para todas las películas.
SELECT MOVIE_NAME, MOVIE_YEAR, MOVIE_GENRE
FROM PELICULA;

-- 4. Escribir una consulta para mostrar el nombre de la película, año y costo, ordenados de forma descendente por año de película.
SELECT MOVIE_NAME, MOVIE_YEAR, MOVIE_COST
FROM PELICULA
ORDER BY MOVIE_YEAR DESC;

-- 5. Escribir una consulta para mostrar el nombre de la película, año y costo, para todas las películas que contengan la palabra "hope" en cualquier parte del título. Ordenar los resultados en orden ascendente por nombre.
SELECT MOVIE_NAME, MOVIE_YEAR, MOVIE_COST
FROM PELICULA
WHERE MOVIE_NAME LIKE '%hope%' OR MOVIE_NAME LIKE '%Hope%'
ORDER BY MOVIE_NAME ASC;

-- 6. Escribir una consulta para mostrar el género y el costo promedio de películas en cada género.
SELECT 
    MOVIE_GENRE,
    ROUND(AVG(MOVIE_COST), 2) AS COSTO_PROMEDIO
FROM PELICULA
GROUP BY MOVIE_GENRE;

-- 7. Escribir una consulta para mostrar el nombre de la película, año y costo, para todas las películas que tengan un costo entre $44.99 y $49.99.
SELECT MOVIE_NAME, MOVIE_YEAR, MOVIE_COST
FROM PELICULA
WHERE MOVIE_COST BETWEEN 44.99 AND 49.99;