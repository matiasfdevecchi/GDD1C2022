USE GD1C2022

GO

--Sentencia para que sea reejecutable el script

IF OBJECT_ID('Data_Center_Group.BI_DIM_Tiempo', 'U') IS NOT NULL
    DROP TABLE Data_Center_Group.BI_DIM_Tiempo;
IF OBJECT_ID('Data_Center_Group.BI_DIM_Auto', 'U') IS NOT NULL
    DROP TABLE Data_Center_Group.BI_DIM_Auto;
IF OBJECT_ID('Data_Center_Group.BI_DIM_Escuderia', 'U') IS NOT NULL
    DROP TABLE Data_Center_Group.BI_DIM_Escuderia;
IF OBJECT_ID('Data_Center_Group.BI_DIM_CIRCUITO', 'U') IS NOT NULL
    DROP TABLE Data_Center_Group.BI_DIM_CIRCUITO;
IF OBJECT_ID('Data_Center_Group.BI_DIM_PILOTO', 'U') IS NOT NULL
    DROP TABLE Data_Center_Group.BI_DIM_PILOTO;
IF OBJECT_ID('Data_Center_Group.BI_DIM_Sector', 'U') IS NOT NULL
    DROP TABLE Data_Center_Group.BI_DIM_Sector;
IF OBJECT_ID('Data_Center_Group.BI_DIM_Neumatico', 'U') IS NOT NULL
    DROP TABLE Data_Center_Group.BI_DIM_Neumatico;
IF OBJECT_ID('Data_Center_Group.BI_DIM_Incidente', 'U') IS NOT NULL
    DROP TABLE Data_Center_Group.BI_DIM_Incidente;

IF EXISTS(SELECT name FROM sys.objects WHERE type_desc LIKE '%fun%' AND name LIKE 'BI_f_recoleccion_datos_x_cuatrimestre')
    DROP FUNCTION  Data_Center_Group.BI_f_recoleccion_datos_x_cuatrimestre

IF OBJECT_ID('Data_Center_Group.BI_view_desgaste_promedio_cada_auto_x_vuelta_x_circuito', 'V') IS NOT NULL
    DROP VIEW Data_Center_Group.BI_view_desgaste_promedio_cada_auto_x_vuelta_x_circuito;
IF OBJECT_ID('Data_Center_Group.BI_view_mejor_tiempo_vuelta_cada_escuderia_x_circuito_x_anio', 'V') IS NOT NULL
    DROP VIEW Data_Center_Group.BI_view_mejor_tiempo_vuelta_cada_escuderia_x_circuito_x_anio;
IF OBJECT_ID('Data_Center_Group.BI_view_circuito_mayor_consumo_combustible_promedio', 'V') IS NOT NULL
    DROP VIEW Data_Center_Group.BI_view_circuito_mayor_consumo_combustible_promedio;
IF OBJECT_ID('Data_Center_Group.BI_view_maxima_velocidad_x_auto', 'V') IS NOT NULL
    DROP VIEW Data_Center_Group.BI_view_maxima_velocidad_x_auto;
IF OBJECT_ID('Data_Center_Group.BI_view_tiempo_promedio_cada_escuderia_en_paradas_x_cuatrimestre', 'V') IS NOT NULL
    DROP VIEW Data_Center_Group.BI_view_tiempo_promedio_cada_escuderia_en_paradas_x_cuatrimestre;
IF OBJECT_ID('Data_Center_Group.BI_view_cantidad_paradas_x_circuito_x_escuderia_x_anio', 'V') IS NOT NULL
    DROP VIEW Data_Center_Group.BI_view_cantidad_paradas_x_circuito_x_escuderia_x_anio;
IF OBJECT_ID('Data_Center_Group.BI_view_3_circutos_mayor_cantidad_tiempo_paradas_de_incidentes', 'V') IS NOT NULL
    DROP VIEW Data_Center_Group.BI_view_3_circutos_mayor_cantidad_tiempo_paradas_de_incidentes;
IF OBJECT_ID('Data_Center_Group.BI_view_3_circutos_mayor_peligro_x_anio', 'V') IS NOT NULL
    DROP VIEW Data_Center_Group.BI_view_3_circuitos_mayor_peligro_x_anio
IF OBJECT_ID('Data_Center_Group.BI_view_promedio_incidentes_cada_escuderia_x_anio', 'V') IS NOT NULL
    DROP VIEW Data_Center_Group.BI_view_promedio_incidentes_cada_escuderia_x_anio
	


--Creacion de tablas --
    
CREATE TABLE [Data_Center_Group].BI_DIM_Tiempo(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	anio INT,
	cuatrimestre INT,
);

CREATE TABLE [Data_Center_Group].BI_DIM_Auto (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	numero INT NOT NULL,
	modelo NVARCHAR(255) NOT NULL,
);

CREATE TABLE [Data_Center_Group].BI_DIM_Escuderia (
	id_escuderia INT NOT NULL IDENTITY PRIMARY KEY,
	nombre NVARCHAR(255) NOT NULL,
);

CREATE TABLE [Data_Center_Group].BI_DIM_CIRCUITO (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	codigo INT NOT NULL,
	nombre NVARCHAR(50),
	pais NVARCHAR(50)
);

CREATE TABLE [Data_Center_Group].BI_DIM_PILOTO (
	codigo INT NOT NULL IDENTITY PRIMARY KEY,
	nombre NVARCHAR(50) NOT NULL,
	apellido NVARCHAR(50) NOT NULL,
	nacionalidad NVARCHAR(50) NOT NULL,
	fecha_nacimiento DATE NOT NULL,
);

CREATE TABLE [Data_Center_Group].BI_DIM_Sector (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	tipo NVARCHAR(255) NOT NULL,
);

CREATE TABLE [Data_Center_Group].BI_DIM_Neumatico (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	tipo NVARCHAR(255) NOT NULL,
);

CREATE TABLE [Data_Center_Group].BI_DIM_Incidente (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	tipo NVARCHAR(255) NOT NULL,
);
GO

--Funciones (falta)

CREATE FUNCTION Data_Center_Group.BI_f_recoleccion_datos_x_cuatrimestre(@anio INT, @cuatrimestre INT, @escuderia INT)
RETURNS INT
AS
BEGIN
	RETURN(
					 fecha_anio_numero * 3 + fecha_cuatrimestre_numero <= @anio * 3 + @cuatrimestre
		)
END
GO

--Carga de datos de tiempo (falta)

INSERT INTO [Data_Center_Group].BI_DIM_Tiempo


--Carga de datos de auto

INSERT INTO [Data_Center_Group].BI_DIM_Auto
SELECT numero, modelo FROM GD1C2022.Data_Center_Group.Auto

--Carga de datos de escuderia

INSERT INTO [Data_Center_Group].BI_DIM_Escuderia
SELECT nombre
FROM  GD1C2022.Data_Center_Group.Escuderia
    
--Carga de datos de circuito

INSERT INTO [Data_Center_Group].BI_DIM_CIRCUITO
SELECT codigo, nombre, pais
FROM  GD1C2022.Data_Center_Group.Circuito
    
--Carga de datos de piloto

INSERT INTO [Data_Center_Group].BI_DIM_PILOTO
SELECT nombre, apellido, nacionalidad, fecha_nacimiento
FROM  GD1C2022.Data_Center_Group.Piloto 

--Carga de datos de sector

INSERT INTO [Data_Center_Group].BI_DIM_Sector
SELECT tipo
FROM  GD1C2022.Data_Center_Group.Sector

--Carga de datos de neumatico

INSERT INTO [Data_Center_Group].BI_DIM_Neumatico
SELECT tipo
FROM  GD1C2022.Data_Center_Group.Neumatico

--Carga de datos de incidente

INSERT INTO [Data_Center_Group].BI_DIM_Incidente
SELECT bandera
FROM  GD1C2022.Data_Center_Group.Incidente


--Vistas -- (falta)

--Desgaste promedio de cada componente de cada auto por vuelta por circuito

CREATE VIEW  Data_Center_Group.BI_view_desgaste_promedio_cada_auto_x_vuelta_x_circuito AS

--Mejor tiempo de vuelta de cada escuderia por circuito por año

CREATE VIEW  Data_Center_Group.BI_view_mejor_tiempo_vuelta_cada_escuderia_x_circuito_x_anio AS

-- los 3 circuitos con mayor consumo de combustible promedio

CREATE VIEW  Data_Center_Group.BI_view_circuito_mayor_consumo_combustible_promedio AS

-- Maxima velocidad alcanzada por cada auto en cada tipo de sector de cada circuito

CREATE VIEW  Data_Center_Group.BI_view_maxima_velocidad_x_auto AS

--Tiempo promedio que tardo cada escuderia en las paradas por cuatrimestre 

CREATE VIEW  Data_Center_Group.BI_view_tiempo_promedio_cada_escuderia_en_paradas_x_cuatrimestre AS

-- Cantidad de paradas por circuito por escuderia por anio

CREATE VIEW  Data_Center_Group.BI_view_cantidad_paradas_x_circuito_x_escuderia_x_anio AS

-- los 3 circuitos donde se consume mayor cantidad en tiempo de paradas de incidentes

CREATE VIEW  Data_Center_Group.BI_view_3_circutos_mayor_cantidad_tiempo_paradas_de_incidentes AS

-- los 3 circuitos mas peligrosos del año en funcion mayor cantidad de incidentes 

CREATE VIEW  Data_Center_Group.BI_view_3_circuitos_mayor peligro_x_anio AS

--Promedio de incidentes que presenta cada escuderia por año en los distintos tipos de sectores 

CREATE VIEW  Data_Center_Group.BI_view_promedio_incidentes_cada_escuderia_x_anio AS