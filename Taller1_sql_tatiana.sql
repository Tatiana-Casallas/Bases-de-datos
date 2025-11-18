CREATE DATABASE TALLER_BD1;
USE TALLER_BD1;

CREATE TABLE TALLER_BD1.estudiantes (
    ID_EST VARCHAR(9) PRIMARY KEY,
    nombre_est VARCHAR(50),
    apellidos_est VARCHAR(100),
    edad INT,
    telefono VARCHAR(15),
    ciudad VARCHAR(50)
);


INSERT INTO TALLER_BD1.estudiantes (ID_EST, nombre_est, apellidos_est, edad, telefono, ciudad) VALUES
('11111111A', 'Carlos', 'Martínez Martínez', 30, '950111111', 'Cali'),
('22222222B', 'Laura', 'López López', 26, '950222222', 'Barranquilla'),
('33333333C', 'Manuel', 'Gallegos Gallegos', 23, '950333333', 'Bogotá'),
('44444444D', 'Leonor', 'Capel Capel', 30, '950444444', 'Medellín'),
('55555555E', 'Felipe', 'Jimenez Jimenez', 30, '950555555', 'Bucaramanga');


CREATE TABLE TALLER_BD1.asignaturas (
    cod_as INT PRIMARY KEY,
    nombre_as VARCHAR(45),
    num_creditos_as INT,
    profesor_as VARCHAR(50),
    area_as VARCHAR(30)
);


INSERT INTO TALLER_BD1.asignaturas (cod_as, nombre_as, num_creditos_as, profesor_as, area_as) VALUES
(1, 'bases de datos', 6, 'Fran', 'Bases de datos'),
(2, 'Redes', 5, 'Amalia', 'Arquitectura ordenadores'),
(3, 'matemáticas Discretas', 9, 'Fran', 'Matemáticas'),
(4, 'Programacion 1', 6, 'Emilio', 'Bases de datos'),
(5, 'Programacion 2', 8, 'Fran', 'Bases de datos');


CREATE TABLE TALLER_BD1.asig_est (
    ID_EST VARCHAR(9),
    cod_as INT,
    nota_est_as INT,
    num_convoc INT,
    PRIMARY KEY (ID_EST, cod_as, num_convoc),
    FOREIGN KEY (ID_EST) REFERENCES TALLER_BD1.estudiantes(ID_EST),
    FOREIGN KEY (cod_as) REFERENCES TALLER_BD1.asignaturas(cod_as)
);


INSERT INTO TALLER_BD1.asig_est (ID_EST, cod_as, nota_est_as, num_convoc) VALUES
('11111111A', 1, 10, 1),
('11111111A', 3,  6, 3),
('22222222B', 1,  8, 2),
('22222222B', 2,  6, 3),
('33333333C', 5,  7, 1),
('44444444D', 1,  7, 2),
('44444444D', 4,  9, 2),
('44444444D', 5,  6, 5),
('55555555E', 3,  6, 2),
('55555555E', 4,  9, 1);

SELECT nombre_as, num_creditos_as 
FROM asignaturas
WHERE num_creditos_as = (select max(num_creditos_as)
FROM asignaturas); 

SELECT ID_EST, 
AVG (nota_est_as) as nota_media
FROM asig_est
group by ID_EST; 


SELECT edad, 
group_concat(nombre_est SEPARATOR ".") AS estudiantes_por_edad
FROM estudiantes
group by edad; 


SELECT e.nombre_est, e.apellidos_est
FROM estudiantes e
LEFT JOIN asig_est a ON e.ID_EST = a.ID_EST
WHERE a.ID_EST IS NULL;

SELECT e.ID_EST, e.nombre_est, e.apellidos_est, COUNT(a.cod_as) AS num_asignaturas
FROM estudiantes e
JOIN asig_est a ON e.ID_EST = a.ID_EST
GROUP BY e.ID_EST, e.nombre_est, e.apellidos_est
HAVING COUNT(a.cod_as) > 2;