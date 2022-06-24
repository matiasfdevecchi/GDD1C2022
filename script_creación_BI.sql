USE GD1C2022

GO

--Sentencia para que sea reejecutable el script

IF OBJECT_ID('Data_Center_Group.BI_DIM_Tiempo', 'U') IS NOT NULL
    DROP TABLE [Data_Center_Group].BI_DIM_Tiempo;
IF OBJECT_ID('Data_Center_Group.BI_DIM_Auto', 'U') IS NOT NULL
    DROP TABLE [Data_Center_Group].BI_DIM_Auto;
IF OBJECT_ID('Data_Center_Group.BI_DIM_Escuderia', 'U') IS NOT NULL
    DROP TABLE [Data_Center_Group].BI_DIM_Escuderia;
IF OBJECT_ID('Data_Center_Group.BI_DIM_Circuito', 'U') IS NOT NULL
    DROP TABLE [Data_Center_Group].BI_DIM_Circuito;
IF OBJECT_ID('Data_Center_Group.BI_DIM_Piloto', 'U') IS NOT NULL
    DROP TABLE [Data_Center_Group].BI_DIM_Piloto;
IF OBJECT_ID('Data_Center_Group.BI_DIM_Sector', 'U') IS NOT NULL
    DROP TABLE [Data_Center_Group].BI_DIM_Sector;
IF OBJECT_ID('Data_Center_Group.BI_DIM_Neumatico', 'U') IS NOT NULL
    DROP TABLE [Data_Center_Group].BI_DIM_Neumatico;
IF OBJECT_ID('Data_Center_Group.BI_DIM_Incidente', 'U') IS NOT NULL
    DROP TABLE [Data_Center_Group].BI_DIM_Incidente;

/*IF OBJECT_ID('Data_Center_Group.BI_view_desgaste_promedio_cada_auto_x_vuelta_x_circuito', 'V') IS NOT NULL
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
    DROP VIEW Data_Center_Group.BI_view_promedio_incidentes_cada_escuderia_x_anio*/
	


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

CREATE TABLE [Data_Center_Group].BI_DIM_Circuito (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	codigo INT NOT NULL,
	nombre NVARCHAR(50),
	pais NVARCHAR(50)
);

CREATE TABLE [Data_Center_Group].BI_DIM_Piloto (
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

--Carga de datos de tiempo (falta)
GO
CREATE PROCEDURE [Data_Center_Group].cargarDIMTiempos
AS
BEGIN
    INSERT INTO [Data_Center_Group].BI_DIM_Tiempo(anio, cuatrimestre)
	SELECT DISTINCT YEAR(fecha), MONTH(fecha) / 4 + 1
	FROM [Data_Center_Group].Carrera
END;

--Carga de datos de auto
GO
CREATE PROCEDURE [Data_Center_Group].cargarDIMAutos
AS
BEGIN
	INSERT INTO [Data_Center_Group].BI_DIM_Auto
	SELECT DISTINCT numero, modelo 
	FROM [Data_Center_Group].Auto
END;

--Carga de datos de escuderia
GO
CREATE PROCEDURE [Data_Center_Group].cargarDIMEscuderias
AS
BEGIN
	INSERT INTO [Data_Center_Group].BI_DIM_Escuderia
	SELECT DISTINCT nombre
	FROM  [Data_Center_Group].Escuderia
END;
    
--Carga de datos de circuito
GO
CREATE PROCEDURE [Data_Center_Group].cargarDIMCircuitos
AS
BEGIN
	INSERT INTO [Data_Center_Group].BI_DIM_Circuito
	SELECT DISTINCT codigo, nombre, pais
	FROM  [Data_Center_Group].Circuito
END;
    
--Carga de datos de piloto
GO
CREATE PROCEDURE [Data_Center_Group].cargarDIMPilotos
AS
BEGIN
	INSERT INTO [Data_Center_Group].BI_DIM_Piloto
	SELECT DISTINCT nombre, apellido, nacionalidad, fecha_nacimiento
	FROM  [Data_Center_Group].Piloto
END;

--Carga de datos de sector

GO
CREATE PROCEDURE [Data_Center_Group].cargarDIMSectores
AS
BEGIN
	INSERT INTO [Data_Center_Group].BI_DIM_Sector
	SELECT DISTINCT tipo
	FROM [Data_Center_Group].Sector
END;

--Carga de datos de neumatico
GO
CREATE PROCEDURE [Data_Center_Group].cargarDIMNeumaticos
AS
BEGIN
	INSERT INTO [Data_Center_Group].BI_DIM_Neumatico
	SELECT DISTINCT tipo
	FROM [Data_Center_Group].Neumatico
END;

--Carga de datos de incidente
GO
CREATE PROCEDURE [Data_Center_Group].cargarDIMIncidentes
AS
BEGIN
	INSERT INTO [Data_Center_Group].BI_DIM_Incidente
	SELECT DISTINCT bandera
	FROM [Data_Center_Group].Incidente
END;

GO
EXEC [Data_Center_Group].cargarDIMTiempos;
EXEC [Data_Center_Group].cargarDIMAutos;
EXEC [Data_Center_Group].cargarDIMEscuderias;
EXEC [Data_Center_Group].cargarDIMCircuitos;
EXEC [Data_Center_Group].cargarDIMPilotos;
EXEC [Data_Center_Group].cargarDIMSectores;
EXEC [Data_Center_Group].cargarDIMNeumaticos;
EXEC [Data_Center_Group].cargarDIMIncidentes;

DROP PROCEDURE [Data_Center_Group].cargarDIMTiempos;
DROP PROCEDURE [Data_Center_Group].cargarDIMAutos;
DROP PROCEDURE [Data_Center_Group].cargarDIMEscuderias;
DROP PROCEDURE [Data_Center_Group].cargarDIMCircuitos;
DROP PROCEDURE [Data_Center_Group].cargarDIMPilotos;
DROP PROCEDURE [Data_Center_Group].cargarDIMSectores;
DROP PROCEDURE [Data_Center_Group].cargarDIMNeumaticos;
DROP PROCEDURE [Data_Center_Group].cargarDIMIncidentes;


/*--Vistas -- (falta)

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

CREATE VIEW  Data_Center_Group.BI_view_promedio_incidentes_cada_escuderia_x_anio AS*/