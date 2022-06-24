USE GD1C2022

GO

--Sentencia para que sea reejecutable el script

IF OBJECT_ID('Data_Center_Group.BI_FACT_Telemetria', 'U') IS NOT NULL
    DROP TABLE [Data_Center_Group].BI_FACT_Telemetria;
IF OBJECT_ID('Data_Center_Group.BI_FACT_Parada', 'U') IS NOT NULL
    DROP TABLE [Data_Center_Group].BI_FACT_Parada;
IF OBJECT_ID('Data_Center_Group.BI_FACT_IncidenteAuto', 'U') IS NOT NULL
    DROP TABLE [Data_Center_Group].BI_FACT_IncidenteAuto;
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
IF OBJECT_ID('Data_Center_Group.BI_DIM_IncidenteAuto', 'U') IS NOT NULL
    DROP TABLE [Data_Center_Group].BI_DIM_IncidenteAuto;
	
IF OBJECT_ID('Data_Center_Group.BI_VIEW_AUX_MejorTiempoCadaVuelta', 'V') IS NOT NULL
    DROP VIEW [Data_Center_Group].BI_VIEW_AUX_MejorTiempoCadaVuelta;
IF OBJECT_ID('Data_Center_Group.BI_VIEW_MejorTiempoVuelta', 'V') IS NOT NULL
    DROP VIEW [Data_Center_Group].BI_VIEW_MejorTiempoVuelta;
IF OBJECT_ID('Data_Center_Group.BI_VIEW_AUX_ConsumoDeCombustible', 'V') IS NOT NULL
    DROP VIEW [Data_Center_Group].BI_VIEW_AUX_ConsumoDeCombustible;
IF OBJECT_ID('Data_Center_Group.BI_VIEW_Top3CircuitosConMasConsumo', 'V') IS NOT NULL
    DROP VIEW [Data_Center_Group].BI_VIEW_Top3CircuitosConMasConsumo;
/*IF OBJECT_ID('Data_Center_Group.BI_view_circuito_mayor_consumo_combustible_promedio', 'V') IS NOT NULL
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
	nombre NVARCHAR(255) NOT NULL PRIMARY KEY,
);

CREATE TABLE [Data_Center_Group].BI_DIM_Circuito (
	codigo INT NOT NULL PRIMARY KEY,
	nombre NVARCHAR(50),
	pais NVARCHAR(50)
);

CREATE TABLE [Data_Center_Group].BI_DIM_Piloto (
	codigo INT NOT NULL PRIMARY KEY,
	nombre NVARCHAR(50) NOT NULL,
	apellido NVARCHAR(50) NOT NULL,
	nacionalidad NVARCHAR(50) NOT NULL,
	fecha_nacimiento DATE NOT NULL,
);

CREATE TABLE [Data_Center_Group].BI_DIM_Sector (
	codigo INT NOT NULL PRIMARY KEY,
	tipo NVARCHAR(255) NOT NULL,
);

CREATE TABLE [Data_Center_Group].BI_DIM_Neumatico (
	numero_serie NVARCHAR(255) NOT NULL PRIMARY KEY,
	tipo NVARCHAR(255) NOT NULL,
);

CREATE TABLE [Data_Center_Group].BI_DIM_IncidenteAuto (
	tipo NVARCHAR(255) NOT NULL PRIMARY KEY,
);

-- Tabla de hechos
CREATE TABLE [Data_Center_Group].BI_FACT_Telemetria(
    id INT NOT NULL IDENTITY PRIMARY KEY, 
	tiempo_id INTEGER FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Tiempo(id),
	auto_id INTEGER FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Auto(id),
	escuderia_nombre NVARCHAR(255) FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Escuderia(nombre),
	piloto_codigo INT FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Piloto(codigo),
	sector_codigo INT FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Sector(codigo),
	circuito_codigo INT FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Circuito(codigo),
	neumatico_del_izq_numero_serie NVARCHAR(255) FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Neumatico(numero_serie),
	neumatico_del_der_numero_serie NVARCHAR(255) FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Neumatico(numero_serie),
	neumatico_tra_izq_numero_serie NVARCHAR(255) FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Neumatico(numero_serie),
	neumatico_tra_der_numero_serie NVARCHAR(255) FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Neumatico(numero_serie),
	numero_vuelta DECIMAL(18,0) NOT NULL,
	tiempo_vuelta DECIMAL(18,10) NOT NULL,
	caja_desgaste DECIMAL(18,2) NOT NULL,
	motor_potencia DECIMAL(18,6) NOT NULL,
	neumatico_del_izq_profundidad DECIMAL(18,6) NOT NULL,
	neumatico_del_der_profundidad DECIMAL(18,6) NOT NULL,
	neumatico_tra_izq_profundidad DECIMAL(18,6) NOT NULL,
	neumatico_tra_der_profundidad DECIMAL(18,6) NOT NULL,
	freno_del_izq_grosor_pastilla DECIMAL(18,2) NOT NULL,
	freno_del_der_grosor_pastilla DECIMAL(18,2) NOT NULL,
	freno_tra_izq_grosor_pastilla DECIMAL(18,2) NOT NULL,
	freno_tra_der_grosor_pastilla DECIMAL(18,2) NOT NULL,
	velocidad DECIMAL(18,2) NOT NULL,
	combustible DECIMAL(18,2) NOT NULL
);

CREATE TABLE [Data_Center_Group].BI_FACT_Parada(
    id INT NOT NULL IDENTITY PRIMARY KEY, 
	tiempo_id INTEGER FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Tiempo(id),
	auto_id INTEGER FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Auto(id),
	escuderia_nombre NVARCHAR(255) FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Escuderia(nombre),
	piloto_codigo INT FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Piloto(codigo),
	circuito_codigo INT FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Circuito(codigo),
	neumatico_del_izq_viejo_numero_serie NVARCHAR(255) FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Neumatico(numero_serie),
	neumatico_del_izq_nuevo_numero_serie NVARCHAR(255) FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Neumatico(numero_serie),
	neumatico_del_der_viejo_numero_serie NVARCHAR(255) FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Neumatico(numero_serie),
	neumatico_del_der_nuevo_numero_serie NVARCHAR(255) FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Neumatico(numero_serie),
	neumatico_tra_izq_viejo_numero_serie NVARCHAR(255) FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Neumatico(numero_serie),
	neumatico_tra_izq_nuevo_numero_serie NVARCHAR(255) FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Neumatico(numero_serie),
	neumatico_tra_der_viejo_numero_serie NVARCHAR(255) FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Neumatico(numero_serie),
	neumatico_tra_der_nuevo_numero_serie NVARCHAR(255) FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Neumatico(numero_serie),
	numero_vuelta DECIMAL(18,0) NOT NULL,
	tiempo DECIMAL(18,2) NOT NULL
);

CREATE TABLE [Data_Center_Group].BI_FACT_IncidenteAuto(
    id INT NOT NULL IDENTITY PRIMARY KEY, 
	tiempo_id INTEGER FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Tiempo(id),
	auto_id INTEGER FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Auto(id),
	escuderia_nombre NVARCHAR(255) FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Escuderia(nombre),
	piloto_codigo INT FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Piloto(codigo),
	circuito_codigo INT FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Circuito(codigo),
	sector_codigo INT FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Sector(codigo),
	incidente_auto_tipo NVARCHAR(255) FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_IncidenteAuto(tipo),
	numero_vuelta DECIMAL(18,0) NOT NULL
);

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
	SELECT DISTINCT codigo, nombre, apellido, nacionalidad, fecha_nacimiento
	FROM  [Data_Center_Group].Piloto
END;

--Carga de datos de sector

GO
CREATE PROCEDURE [Data_Center_Group].cargarDIMSectores
AS
BEGIN
	INSERT INTO [Data_Center_Group].BI_DIM_Sector
	SELECT codigo, tipo
	FROM [Data_Center_Group].Sector
END;

--Carga de datos de neumatico
GO
CREATE PROCEDURE [Data_Center_Group].cargarDIMNeumaticos
AS
BEGIN
	INSERT INTO [Data_Center_Group].BI_DIM_Neumatico
	SELECT numero_serie, tipo
	FROM [Data_Center_Group].Neumatico
END;

--Carga de datos de incidente
GO
CREATE PROCEDURE [Data_Center_Group].cargarDIMIncidenteAutos
AS
BEGIN
	INSERT INTO [Data_Center_Group].BI_DIM_IncidenteAuto
	SELECT DISTINCT tipo
	FROM [Data_Center_Group].IncidenteAuto
END;

--Carga de datos de telemetria
GO
CREATE FUNCTION [Data_Center_Group].retornarTiempo(@fecha DATE)
RETURNS INT
BEGIN
	RETURN (
    SELECT id FROM [Data_Center_Group].BI_DIM_Tiempo t
    WHERE t.anio = YEAR(@fecha) AND t.cuatrimestre = MONTH(@fecha)
    )
END;

GO
CREATE FUNCTION [Data_Center_Group].retornarAuto(@numero INT, @modelo NVARCHAR(255))
RETURNS INT
BEGIN
	RETURN (
    SELECT id FROM [Data_Center_Group].BI_DIM_Auto a
    WHERE a.modelo = @modelo AND a.numero = @numero
    )
END;

GO
CREATE FUNCTION [Data_Center_Group].retornarNeumaticoDeTelemetria(@telemetria_codigo DECIMAL(18,0), @posicion NVARCHAR(255))
RETURNS NVARCHAR(255)
BEGIN
	RETURN (
    SELECT tn.neumatico_numero_serie FROM [Data_Center_Group].TelemetriaNeumatico tn
    WHERE tn.telemetria_codigo = @telemetria_codigo AND tn.posicion = @posicion
    )
END;

GO
CREATE FUNCTION [Data_Center_Group].retornarProfundidadDeTelemetriaNeumatico(@telemetria_codigo DECIMAL(18,0), @posicion NVARCHAR(255))
RETURNS DECIMAL(18,6)
BEGIN
	RETURN (
    SELECT tn.profundidad FROM [Data_Center_Group].TelemetriaNeumatico tn
    WHERE tn.telemetria_codigo = @telemetria_codigo AND tn.posicion = @posicion
    )
END;

GO
CREATE FUNCTION [Data_Center_Group].retornarGrosorPastillaDeTelemetriaFreno(@telemetria_codigo DECIMAL(18,0), @posicion NVARCHAR(255))
RETURNS DECIMAL(18,6)
BEGIN
	RETURN (
    SELECT tf.grosor_pastilla FROM [Data_Center_Group].TelemetriaFreno tf
    WHERE tf.telemetria_codigo = @telemetria_codigo AND tf.posicion = @posicion
    )
END;

GO
CREATE PROCEDURE [Data_Center_Group].cargarFACTTelemetrias
AS
BEGIN
	INSERT INTO [Data_Center_Group].BI_FACT_Telemetria
	SELECT 
		[Data_Center_Group].retornarTiempo(c.fecha), 
		[Data_Center_Group].retornarAuto(a.numero, a.modelo), 
		a.escuderia_nombre, 
		a.piloto_codigo, 
		t.sector_codigo, 
		c.circuito_codigo, 
		[Data_Center_Group].retornarNeumaticoDeTelemetria(t.codigo, 'Delantero Izquierdo'), 
		[Data_Center_Group].retornarNeumaticoDeTelemetria(t.codigo, 'Delantero Derecho'), 
		[Data_Center_Group].retornarNeumaticoDeTelemetria(t.codigo, 'Trasero Izquierdo'), 
		[Data_Center_Group].retornarNeumaticoDeTelemetria(t.codigo, 'Trasero Derecho'),
		t.vuelta_numero,
		t.vuelta_tiempo,
		tc.desgaste,
		tm.potencia,
		[Data_Center_Group].retornarProfundidadDeTelemetriaNeumatico(t.codigo, 'Delantero Izquierdo'),
		[Data_Center_Group].retornarProfundidadDeTelemetriaNeumatico(t.codigo, 'Delantero Derecho'), 
		[Data_Center_Group].retornarProfundidadDeTelemetriaNeumatico(t.codigo, 'Trasero Izquierdo'), 
		[Data_Center_Group].retornarProfundidadDeTelemetriaNeumatico(t.codigo, 'Trasero Derecho'),
		[Data_Center_Group].retornarGrosorPastillaDeTelemetriaFreno(t.codigo, 'Delantero Izquierdo'),
		[Data_Center_Group].retornarGrosorPastillaDeTelemetriaFreno(t.codigo, 'Delantero Derecho'), 
		[Data_Center_Group].retornarGrosorPastillaDeTelemetriaFreno(t.codigo, 'Trasero Izquierdo'), 
		[Data_Center_Group].retornarGrosorPastillaDeTelemetriaFreno(t.codigo, 'Trasero Derecho'),
		ta.velocidad,
		ta.combustible
	FROM [Data_Center_Group].Telemetria t
	JOIN [Data_Center_Group].TelemetriaAuto ta ON ta.telemetria_codigo = t.codigo
	JOIN [Data_Center_Group].TelemetriaCaja tc ON tc.telemetria_codigo = t.codigo
	JOIN [Data_Center_Group].TelemetriaMotor tm ON tm.telemetria_codigo = t.codigo
	JOIN [Data_Center_Group].Carrera c ON c.codigo = t.carrera_codigo
	JOIN [Data_Center_Group].Auto a ON a.numero = ta.auto_numero AND a.escuderia_nombre = ta.auto_escuderia_nombre
END;



GO
CREATE FUNCTION [Data_Center_Group].retornarNeumaticoViejoDeParada(@parada_codigo DECIMAL(18,0), @posicion NVARCHAR(255))
RETURNS NVARCHAR(255)
BEGIN
	RETURN (
    SELECT p.neumatico_viejo_numero_serie FROM [Data_Center_Group].ParadaCambioNeumatico p
    WHERE p.parada_codigo = @parada_codigo AND p.posicion = @posicion
    )
END;

GO
CREATE FUNCTION [Data_Center_Group].retornarNeumaticoNuevoDeParada(@parada_codigo DECIMAL(18,0), @posicion NVARCHAR(255))
RETURNS NVARCHAR(255)
BEGIN
	RETURN (
    SELECT p.neumatico_viejo_numero_serie FROM [Data_Center_Group].ParadaCambioNeumatico p
    WHERE p.parada_codigo = @parada_codigo AND p.posicion = @posicion
    )
END;

GO
CREATE PROCEDURE [Data_Center_Group].cargarFACTParadas
AS
BEGIN
	INSERT INTO [Data_Center_Group].BI_FACT_Parada
	SELECT 
		[Data_Center_Group].retornarTiempo(c.fecha), 
		[Data_Center_Group].retornarAuto(a.numero, a.modelo), 
		a.escuderia_nombre, 
		a.piloto_codigo, 
		c.circuito_codigo, 
		[Data_Center_Group].retornarNeumaticoViejoDeParada(p.codigo, 'Delantero Izquierdo'), 
		[Data_Center_Group].retornarNeumaticoNuevoDeParada(p.codigo, 'Delantero Izquierdo'), 
		[Data_Center_Group].retornarNeumaticoViejoDeParada(p.codigo, 'Delantero Derecho'), 
		[Data_Center_Group].retornarNeumaticoNuevoDeParada(p.codigo, 'Delantero Derecho'), 
		[Data_Center_Group].retornarNeumaticoViejoDeParada(p.codigo, 'Trasero Izquierdo'), 
		[Data_Center_Group].retornarNeumaticoNuevoDeParada(p.codigo, 'Trasero Izquierdo'), 
		[Data_Center_Group].retornarNeumaticoViejoDeParada(p.codigo, 'Trasero Derecho'),
		[Data_Center_Group].retornarNeumaticoNuevoDeParada(p.codigo, 'Trasero Derecho'),
		p.numero_vuelta,
		p.tiempo
	FROM [Data_Center_Group].Parada p
	JOIN [Data_Center_Group].Carrera c ON p.carrera_codigo = c.codigo
	JOIN [Data_Center_Group].Auto a ON a.numero = p.auto_numero AND a.escuderia_nombre = p.auto_escuderia_nombre
END;

GO
CREATE PROCEDURE [Data_Center_Group].cargarFACTIncidenteAutos
AS
BEGIN
	INSERT INTO [Data_Center_Group].BI_FACT_IncidenteAuto
	SELECT 
		[Data_Center_Group].retornarTiempo(c.fecha), 
		[Data_Center_Group].retornarAuto(a.numero, a.modelo), 
		a.escuderia_nombre, 
		a.piloto_codigo, 
		c.circuito_codigo, 
		i.sector_codigo,
		ia.tipo,
		ia.numero_vuelta
	FROM [Data_Center_Group].Incidente i
	JOIN [Data_Center_Group].IncidenteAuto ia ON i.codigo = ia.incidente_codigo
	JOIN [Data_Center_Group].Carrera c ON i.carrera_codigo = c.codigo
	JOIN [Data_Center_Group].Auto a ON a.numero = ia.auto_numero AND a.escuderia_nombre = ia.auto_escuderia_nombre
END;

GO
EXEC [Data_Center_Group].cargarDIMTiempos;
EXEC [Data_Center_Group].cargarDIMAutos;
EXEC [Data_Center_Group].cargarDIMEscuderias;
EXEC [Data_Center_Group].cargarDIMCircuitos;
EXEC [Data_Center_Group].cargarDIMPilotos;
EXEC [Data_Center_Group].cargarDIMSectores;
EXEC [Data_Center_Group].cargarDIMNeumaticos;
EXEC [Data_Center_Group].cargarDIMIncidenteAutos;
EXEC  [Data_Center_Group].cargarFACTTelemetrias;
EXEC  [Data_Center_Group].cargarFACTParadas;
EXEC  [Data_Center_Group].cargarFACTIncidenteAutos;

DROP PROCEDURE [Data_Center_Group].cargarDIMTiempos;
DROP PROCEDURE [Data_Center_Group].cargarDIMAutos;
DROP PROCEDURE [Data_Center_Group].cargarDIMEscuderias;
DROP PROCEDURE [Data_Center_Group].cargarDIMCircuitos;
DROP PROCEDURE [Data_Center_Group].cargarDIMPilotos;
DROP PROCEDURE [Data_Center_Group].cargarDIMSectores;
DROP PROCEDURE [Data_Center_Group].cargarDIMNeumaticos;
DROP PROCEDURE [Data_Center_Group].cargarDIMIncidenteAutos;
DROP PROCEDURE [Data_Center_Group].cargarFACTTelemetrias;
DROP PROCEDURE [Data_Center_Group].cargarFACTParadas;
DROP PROCEDURE [Data_Center_Group].cargarFACTIncidenteAutos;

DROP FUNCTION [Data_Center_Group].retornarTiempo;
DROP FUNCTION [Data_Center_Group].retornarAuto;
DROP FUNCTION [Data_Center_Group].retornarNeumaticoDeTelemetria;
DROP FUNCTION [Data_Center_Group].retornarProfundidadDeTelemetriaNeumatico;
DROP FUNCTION [Data_Center_Group].retornarGrosorPastillaDeTelemetriaFreno;
DROP FUNCTION [Data_Center_Group].retornarNeumaticoViejoDeParada;
DROP FUNCTION [Data_Center_Group].retornarNeumaticoNuevoDeParada;

/*--Vistas -- (falta)

--Desgaste promedio de cada componente de cada auto por vuelta por circuito

CREATE VIEW  Data_Center_Group.BI_view_desgaste_promedio_cada_auto_x_vuelta_x_circuito AS*/

--Mejor tiempo de vuelta de cada escuderia por circuito por año

GO
CREATE VIEW [Data_Center_Group].BI_VIEW_AUX_MejorTiempoCadaVuelta AS
	SELECT tiempo.anio as anio, c.nombre as circuito, e.nombre as escuderia,  MAX(t.tiempo_vuelta) as mejor_tiempo_vuelta
	FROM [Data_Center_Group].BI_FACT_Telemetria t
	JOIN [Data_Center_Group].BI_DIM_Tiempo tiempo ON tiempo.id = t.tiempo_id
	JOIN [Data_Center_Group].BI_DIM_Circuito c ON c.codigo = t.circuito_codigo
	JOIN [Data_Center_Group].BI_DIM_Escuderia e ON e.nombre = t.escuderia_nombre
	GROUP BY tiempo.anio, e.nombre, c.nombre, t.numero_vuelta

GO
CREATE VIEW [Data_Center_Group].BI_VIEW_MejorTiempoVuelta AS
	SELECT t.anio as 'Año', t.circuito as Circuito, t.escuderia as Escuderia, MAX(t.mejor_tiempo_vuelta) as 'Mejor tiempo'
	FROM [Data_Center_Group].BI_VIEW_AUX_MejorTiempoCadaVuelta t
	GROUP BY t.anio, t.circuito, t.escuderia


-- los 3 circuitos con mayor consumo de combustible promedio
GO
CREATE VIEW [Data_Center_Group].BI_VIEW_AUX_ConsumoDeCombustible AS
	SELECT t.circuito_codigo, MAX(t.combustible) - MIN(t.combustible) as consumo_combustible
	FROM [Data_Center_Group].BI_FACT_Telemetria t
	GROUP BY t.circuito_codigo, t.auto_id, t.escuderia_nombre

GO
CREATE VIEW [Data_Center_Group].BI_VIEW_Top3CircuitosConMasConsumo AS
	SELECT TOP 3 c.nombre as 'Circuito', AVG(t.consumo_combustible) as 'Consumo promedio'
	FROM [Data_Center_Group].BI_VIEW_AUX_ConsumoDeCombustible t
	JOIN [Data_Center_Group].BI_DIM_Circuito c ON c.codigo = t.circuito_codigo
	GROUP BY c.nombre
	ORDER BY 'Consumo promedio' DESC
/*

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

/*
SELECT * FROM [Data_Center_Group].BI_VIEW_MejorTiempoVuelta;
SELECT * FROM [Data_Center_Group].BI_VIEW_Top3CircuitosConMasConsumo;
*/