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
	
	
IF OBJECT_ID('Data_Center_Group.BI_VIEW_DesgasteComponentes', 'V') IS NOT NULL
    DROP VIEW [Data_Center_Group].BI_VIEW_DesgasteComponentes;
IF OBJECT_ID('Data_Center_Group.BI_VIEW_MejorTiempoVuelta', 'V') IS NOT NULL
    DROP VIEW [Data_Center_Group].BI_VIEW_MejorTiempoVuelta;
IF OBJECT_ID('Data_Center_Group.BI_VIEW_AUX_ConsumoDeCombustible', 'V') IS NOT NULL
    DROP VIEW [Data_Center_Group].BI_VIEW_AUX_ConsumoDeCombustible;
IF OBJECT_ID('Data_Center_Group.BI_VIEW_Top3CircuitosConMasConsumo', 'V') IS NOT NULL
    DROP VIEW [Data_Center_Group].BI_VIEW_Top3CircuitosConMasConsumo;
IF OBJECT_ID('Data_Center_Group.BI_VIEW_MaximaVelocidadPorAutoEnCadaSectorEnCadaCircuito', 'V') IS NOT NULL
    DROP VIEW [Data_Center_Group].BI_VIEW_MaximaVelocidadPorAutoEnCadaSectorEnCadaCircuito;
IF OBJECT_ID('Data_Center_Group.BI_VIEW_TiempoPromedioCadaEscuderiaEnParadasPorCuatrimestre', 'V') IS NOT NULL 
	DROP VIEW [Data_Center_Group].BI_VIEW_TiempoPromedioCadaEscuderiaEnParadasPorCuatrimestre;
IF OBJECT_ID('Data_Center_Group.BI_VIEW_CantidadParadasPorCircuitoPorEscuderiaPorAnio', 'V') IS NOT NULL 
	DROP VIEW [Data_Center_Group].BI_VIEW_CantidadParadasPorCircuitoPorEscuderiaPorAnio;
IF OBJECT_ID('Data_Center_Group.BI_VIEW_Top3CircutosConMayorCantidadDeTiempoEnParadasEnBoxes', 'V') IS NOT NULL 
	DROP VIEW [Data_Center_Group].BI_VIEW_Top3CircutosConMayorCantidadDeTiempoEnParadasEnBoxes;
IF OBJECT_ID('Data_Center_Group.BI_VIEW_AUX_IncidentesPorCircuitoPorAnio', 'V') IS NOT NULL 
	DROP VIEW [Data_Center_Group].BI_VIEW_AUX_IncidentesPorCircuitoPorAnio;
IF OBJECT_ID('Data_Center_Group.BI_VIEW_Top3CircuitosMasPeligrososPorAnio', 'V') IS NOT NULL 
	DROP VIEW [Data_Center_Group].BI_VIEW_Top3CircuitosMasPeligrososPorAnio;
IF OBJECT_ID('Data_Center_Group.BI_VIEW_PromedioIncidentesEscuderiaPorAnioEnSectores', 'V') IS NOT NULL 
	DROP VIEW [Data_Center_Group].BI_VIEW_PromedioIncidentesEscuderiaPorAnioEnSectores;
	


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
	tiempo_id INTEGER FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Tiempo(id),
	auto_id INTEGER FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Auto(id),
	escuderia_nombre NVARCHAR(255) FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Escuderia(nombre),
	piloto_codigo INT FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Piloto(codigo),
	sector_codigo INT FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Sector(codigo),
	circuito_codigo INT FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Circuito(codigo),
	numero_vuelta DECIMAL(18,0) NOT NULL,
	tiempo_vuelta DECIMAL(18,10) NOT NULL,
	caja_desgaste_promedio DECIMAL(18,2) NOT NULL,
	caja_desgaste_cantidad INT NOT NULL,
	motor_potencia_min DECIMAL(18,6) NOT NULL,
	motor_potencia_max DECIMAL(18,6) NOT NULL,
	neumatico_del_izq_profundidad_min DECIMAL(18,6),
	neumatico_del_izq_profundidad_max DECIMAL(18,6),
	neumatico_del_der_profundidad_min DECIMAL(18,6),
	neumatico_del_der_profundidad_max DECIMAL(18,6),
	neumatico_tra_izq_profundidad_min DECIMAL(18,6),
	neumatico_tra_izq_profundidad_max DECIMAL(18,6),
	neumatico_tra_der_profundidad_min DECIMAL(18,6),
	neumatico_tra_der_profundidad_max DECIMAL(18,6),
	freno_del_izq_grosor_pastilla_min DECIMAL(18,2),
	freno_del_izq_grosor_pastilla_max DECIMAL(18,2),
	freno_del_der_grosor_pastilla_min DECIMAL(18,2),
	freno_del_der_grosor_pastilla_max DECIMAL(18,2),
	freno_tra_izq_grosor_pastilla_min DECIMAL(18,2),
	freno_tra_izq_grosor_pastilla_max DECIMAL(18,2),
	freno_tra_der_grosor_pastilla_min DECIMAL(18,2),
	freno_tra_der_grosor_pastilla_max DECIMAL(18,2),
	velocidad_max DECIMAL(18,2) NOT NULL,
	combustible_min DECIMAL(18,2) NOT NULL,
	combustible_max DECIMAL(18,2) NOT NULL,
	CONSTRAINT BI_FACT_Telemetria_pk PRIMARY KEY (tiempo_id, auto_id, escuderia_nombre, piloto_codigo, sector_codigo, circuito_codigo, numero_vuelta) 
);

CREATE TABLE [Data_Center_Group].BI_FACT_Parada( 
	tiempo_id INTEGER FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Tiempo(id),
	auto_id INTEGER FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Auto(id),
	escuderia_nombre NVARCHAR(255) FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Escuderia(nombre),
	piloto_codigo INT FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Piloto(codigo),
	circuito_codigo INT FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Circuito(codigo),
	numero_vuelta DECIMAL(18,0) NOT NULL,
	tiempo DECIMAL(18,2) NOT NULL,
	CONSTRAINT BI_FACT_Parada_pk PRIMARY KEY (tiempo_id, auto_id, escuderia_nombre, piloto_codigo, circuito_codigo, numero_vuelta) 
);

CREATE TABLE [Data_Center_Group].BI_FACT_IncidenteAuto(
	tiempo_id INTEGER FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Tiempo(id),
	escuderia_nombre NVARCHAR(255) FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Escuderia(nombre),
	circuito_codigo INT FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Circuito(codigo),
	sector_codigo INT FOREIGN KEY REFERENCES [Data_Center_Group].BI_DIM_Sector(codigo),
	incidente_numero INT NOT NULL,
	cantidad INT NOT NULL
	CONSTRAINT BI_FACT_IncidenteAuto_pk PRIMARY KEY (tiempo_id, escuderia_nombre, circuito_codigo, sector_codigo) 
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
CREATE FUNCTION [Data_Center_Group].retornarCuatrimestre(@fecha DATE)
RETURNS INT
BEGIN
	RETURN MONTH(@fecha) / 4 + 1
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
CREATE VIEW [Data_Center_Group].BI_FACT_AUX_Telemetria_Neumatico AS
		SELECT 
			tiempo.id tiempo_id, 
			dim_auto.id auto_id, 
			a.escuderia_nombre, 
			a.piloto_codigo, 
			t.sector_codigo, 
			c.circuito_codigo, 
			t.vuelta_numero,
			MIN(
				CASE tn.posicion 
				WHEN 'Delantero Izquierdo' THEN tn.profundidad
				ELSE NULL
				END
			) del_izq_min,
			MAX(
				CASE tn.posicion 
				WHEN 'Delantero Izquierdo' THEN tn.profundidad
				ELSE NULL
				END
			) del_izq_max,
			MIN(
				CASE tn.posicion 
				WHEN 'Delantero Derecho' THEN tn.profundidad
				ELSE NULL
				END
			) del_der_min,
			MAX(
				CASE tn.posicion 
				WHEN 'Delantero Derecho' THEN tn.profundidad
				ELSE NULL
				END
			) del_der_max,
			MIN(
				CASE tn.posicion 
				WHEN 'Trasero Izquierdo' THEN tn.profundidad
				ELSE NULL
				END
			) tra_izq_min,
			MAX(
				CASE tn.posicion 
				WHEN 'Trasero Izquierdo' THEN tn.profundidad
				ELSE NULL
				END
			) tra_izq_max,
			MIN(
				CASE tn.posicion 
				WHEN 'Trasero Derecho' THEN tn.profundidad
				ELSE NULL
				END
			) tra_der_min,
			MAX(
				CASE tn.posicion 
				WHEN 'Trasero Derecho' THEN tn.profundidad
				ELSE NULL
				END
			) tra_der_max
		FROM [Data_Center_Group].Telemetria t
		JOIN [Data_Center_Group].TelemetriaAuto ta ON ta.telemetria_codigo = t.codigo
		JOIN [Data_Center_Group].TelemetriaNeumatico tn ON tn.telemetria_codigo = t.codigo
		JOIN [Data_Center_Group].Carrera c ON c.codigo = t.carrera_codigo
		JOIN [Data_Center_Group].Auto a ON a.numero = ta.auto_numero AND a.escuderia_nombre = ta.auto_escuderia_nombre
		JOIN [Data_Center_Group].BI_DIM_Tiempo tiempo ON tiempo.anio = YEAR(c.fecha) AND tiempo.cuatrimestre = [Data_Center_Group].retornarCuatrimestre(c.fecha)
		JOIN [Data_Center_Group].BI_DIM_Auto dim_auto ON dim_auto.numero = a.numero AND dim_auto.modelo = a.modelo
		GROUP BY 
			tiempo.id, 
			dim_auto.id, 
			a.escuderia_nombre, 
			a.piloto_codigo, 
			t.sector_codigo, 
			c.circuito_codigo, 
			t.vuelta_numero


GO
CREATE VIEW [Data_Center_Group].BI_FACT_AUX_Telemetria_Freno AS
		SELECT 
			tiempo.id tiempo_id, 
			dim_auto.id auto_id, 
			a.escuderia_nombre, 
			a.piloto_codigo, 
			t.sector_codigo, 
			c.circuito_codigo, 
			t.vuelta_numero,
			MIN(
				CASE tf.posicion 
				WHEN 'Delantero Izquierdo' THEN tf.grosor_pastilla
				ELSE NULL
				END
			) del_izq_min,
			MAX(
				CASE tf.posicion 
				WHEN 'Delantero Izquierdo' THEN tf.grosor_pastilla
				ELSE NULL
				END
			) del_izq_max,
			MIN(
				CASE tf.posicion 
				WHEN 'Delantero Derecho' THEN tf.grosor_pastilla
				ELSE NULL
				END
			) del_der_min,
			MAX(
				CASE tf.posicion 
				WHEN 'Delantero Derecho' THEN tf.grosor_pastilla
				ELSE NULL
				END
			) del_der_max,
			MIN(
				CASE tf.posicion 
				WHEN 'Trasero Izquierdo' THEN tf.grosor_pastilla
				ELSE NULL
				END
			) tra_izq_min,
			MAX(
				CASE tf.posicion 
				WHEN 'Trasero Izquierdo' THEN tf.grosor_pastilla
				ELSE NULL
				END
			) tra_izq_max,
			MIN(
				CASE tf.posicion 
				WHEN 'Trasero Derecho' THEN tf.grosor_pastilla
				ELSE NULL
				END
			) tra_der_min,
			MAX(
				CASE tf.posicion 
				WHEN 'Trasero Derecho' THEN tf.grosor_pastilla
				ELSE NULL
				END
			) tra_der_max
		FROM [Data_Center_Group].Telemetria t
		JOIN [Data_Center_Group].TelemetriaAuto ta ON ta.telemetria_codigo = t.codigo
		JOIN [Data_Center_Group].TelemetriaFreno tf ON tf.telemetria_codigo = t.codigo
		JOIN [Data_Center_Group].Carrera c ON c.codigo = t.carrera_codigo
		JOIN [Data_Center_Group].Auto a ON a.numero = ta.auto_numero AND a.escuderia_nombre = ta.auto_escuderia_nombre
		JOIN [Data_Center_Group].BI_DIM_Tiempo tiempo ON tiempo.anio = YEAR(c.fecha) AND tiempo.cuatrimestre = [Data_Center_Group].retornarCuatrimestre(c.fecha)
		JOIN [Data_Center_Group].BI_DIM_Auto dim_auto ON dim_auto.numero = a.numero AND dim_auto.modelo = a.modelo
		GROUP BY 
			tiempo.id, 
			dim_auto.id, 
			a.escuderia_nombre, 
			a.piloto_codigo, 
			t.sector_codigo, 
			c.circuito_codigo, 
			t.vuelta_numero

GO
CREATE PROCEDURE [Data_Center_Group].cargarFACTTelemetrias
AS
BEGIN
	INSERT INTO [Data_Center_Group].BI_FACT_Telemetria (
		tiempo_id, auto_id, escuderia_nombre, piloto_codigo, sector_codigo, circuito_codigo,
		numero_vuelta, tiempo_vuelta, caja_desgaste_promedio, caja_desgaste_cantidad, motor_potencia_min,
		motor_potencia_max, velocidad_max, combustible_min, combustible_max
	)
	SELECT 
		tiempo.id, 
		dim_auto.id, 
		a.escuderia_nombre, 
		a.piloto_codigo, 
		t.sector_codigo, 
		c.circuito_codigo, 
		t.vuelta_numero,
		MIN(t.vuelta_tiempo),
		AVG(tc.desgaste),
		COUNT(tc.desgaste),
		MIN(tm.potencia),
		MAX(tm.potencia),
		MAX(ta.velocidad),
		MIN(ta.combustible),
		MAX(ta.combustible)
	FROM [Data_Center_Group].Telemetria t
	JOIN [Data_Center_Group].TelemetriaAuto ta ON ta.telemetria_codigo = t.codigo
	JOIN [Data_Center_Group].TelemetriaCaja tc ON tc.telemetria_codigo = t.codigo
	JOIN [Data_Center_Group].TelemetriaMotor tm ON tm.telemetria_codigo = t.codigo
	JOIN [Data_Center_Group].Carrera c ON c.codigo = t.carrera_codigo
	JOIN [Data_Center_Group].Auto a ON a.numero = ta.auto_numero AND a.escuderia_nombre = ta.auto_escuderia_nombre
	JOIN [Data_Center_Group].BI_DIM_Tiempo tiempo ON tiempo.anio = YEAR(c.fecha) AND tiempo.cuatrimestre = [Data_Center_Group].retornarCuatrimestre(c.fecha)
	JOIN [Data_Center_Group].BI_DIM_Auto dim_auto ON dim_auto.numero = a.numero AND dim_auto.modelo = a.modelo
	GROUP BY 
		tiempo.id, 
		dim_auto.id, 
		a.escuderia_nombre, 
		a.piloto_codigo, 
		t.sector_codigo, 
		c.circuito_codigo, 
		t.vuelta_numero

	UPDATE [Data_Center_Group].BI_FACT_Telemetria
	SET 
		neumatico_del_izq_profundidad_min = tn.del_izq_min,
		neumatico_del_izq_profundidad_max = tn.del_izq_max,
		neumatico_del_der_profundidad_min = tn.del_der_min,
		neumatico_del_der_profundidad_max = tn.del_der_max,
		neumatico_tra_izq_profundidad_min = tn.tra_izq_min,
		neumatico_tra_izq_profundidad_max = tn.tra_izq_max,
		neumatico_tra_der_profundidad_min = tn.tra_der_min,
		neumatico_tra_der_profundidad_max = tn.tra_der_max
	FROM [Data_Center_Group].BI_FACT_AUX_Telemetria_Neumatico tn
	WHERE [Data_Center_Group].BI_FACT_Telemetria.tiempo_id = tn.tiempo_id
	AND [Data_Center_Group].BI_FACT_Telemetria.auto_id = tn.auto_id
	AND [Data_Center_Group].BI_FACT_Telemetria.escuderia_nombre = tn.escuderia_nombre
	AND [Data_Center_Group].BI_FACT_Telemetria.piloto_codigo = tn.piloto_codigo
	AND [Data_Center_Group].BI_FACT_Telemetria.sector_codigo = tn.sector_codigo
	AND [Data_Center_Group].BI_FACT_Telemetria.circuito_codigo = tn.circuito_codigo
	AND [Data_Center_Group].BI_FACT_Telemetria.numero_vuelta = tn.vuelta_numero

	UPDATE [Data_Center_Group].BI_FACT_Telemetria
	SET 
		freno_del_izq_grosor_pastilla_min = tf.del_izq_min,
		freno_del_izq_grosor_pastilla_max = tf.del_izq_max,
		freno_del_der_grosor_pastilla_min = tf.del_der_min,
		freno_del_der_grosor_pastilla_max = tf.del_der_max,
		freno_tra_izq_grosor_pastilla_min = tf.tra_izq_min,
		freno_tra_izq_grosor_pastilla_max = tf.tra_izq_max,
		freno_tra_der_grosor_pastilla_min = tf.tra_der_min,
		freno_tra_der_grosor_pastilla_max = tf.tra_der_max
	FROM [Data_Center_Group].BI_FACT_AUX_Telemetria_Freno tf
	WHERE [Data_Center_Group].BI_FACT_Telemetria.tiempo_id = tf.tiempo_id
	AND [Data_Center_Group].BI_FACT_Telemetria.auto_id = tf.auto_id
	AND [Data_Center_Group].BI_FACT_Telemetria.escuderia_nombre = tf.escuderia_nombre
	AND [Data_Center_Group].BI_FACT_Telemetria.piloto_codigo = tf.piloto_codigo
	AND [Data_Center_Group].BI_FACT_Telemetria.sector_codigo = tf.sector_codigo
	AND [Data_Center_Group].BI_FACT_Telemetria.circuito_codigo = tf.circuito_codigo
	AND [Data_Center_Group].BI_FACT_Telemetria.numero_vuelta = tf.vuelta_numero
END;

GO
CREATE PROCEDURE [Data_Center_Group].cargarFACTParadas
AS
BEGIN
	INSERT INTO [Data_Center_Group].BI_FACT_Parada
	SELECT 
		tiempo.id, 
		dim_auto.id,
		a.escuderia_nombre, 
		a.piloto_codigo, 
		c.circuito_codigo, 
		p.numero_vuelta,
		AVG(p.tiempo)
	FROM [Data_Center_Group].Parada p
	JOIN [Data_Center_Group].Carrera c ON p.carrera_codigo = c.codigo
	JOIN [Data_Center_Group].Auto a ON a.numero = p.auto_numero AND a.escuderia_nombre = p.auto_escuderia_nombre
	JOIN [Data_Center_Group].BI_DIM_Tiempo tiempo ON tiempo.anio = YEAR(c.fecha) AND tiempo.cuatrimestre = [Data_Center_Group].retornarCuatrimestre(c.fecha)
	JOIN [Data_Center_Group].BI_DIM_Auto dim_auto ON dim_auto.numero = a.numero AND dim_auto.modelo = a.modelo
	GROUP BY tiempo.id, dim_auto.id, a.escuderia_nombre, a.piloto_codigo, c.circuito_codigo, p.numero_vuelta
END;

GO
CREATE PROCEDURE [Data_Center_Group].cargarFACTIncidenteAutos
AS
BEGIN
	INSERT INTO [Data_Center_Group].BI_FACT_IncidenteAuto
	SELECT 
		tiempo.id, 
		a.escuderia_nombre, 
		c.circuito_codigo, 
		i.sector_codigo,
		i.codigo,
		COUNT(*)
	FROM [Data_Center_Group].Incidente i
	JOIN [Data_Center_Group].IncidenteAuto ia ON i.codigo = ia.incidente_codigo
	JOIN [Data_Center_Group].Carrera c ON i.carrera_codigo = c.codigo
	JOIN [Data_Center_Group].Auto a ON a.numero = ia.auto_numero AND a.escuderia_nombre = ia.auto_escuderia_nombre
	JOIN [Data_Center_Group].BI_DIM_Tiempo tiempo ON tiempo.anio = YEAR(c.fecha) AND tiempo.cuatrimestre = [Data_Center_Group].retornarCuatrimestre(c.fecha)
	GROUP BY tiempo.id, a.escuderia_nombre, c.circuito_codigo, i.sector_codigo, i.codigo
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

DROP VIEW [Data_Center_Group].BI_FACT_AUX_Telemetria_Neumatico;
DROP VIEW [Data_Center_Group].BI_FACT_AUX_Telemetria_Freno;

DROP FUNCTION [Data_Center_Group].retornarCuatrimestre;
DROP FUNCTION [Data_Center_Group].retornarNeumaticoDeTelemetria;
DROP FUNCTION [Data_Center_Group].retornarProfundidadDeTelemetriaNeumatico;
DROP FUNCTION [Data_Center_Group].retornarGrosorPastillaDeTelemetriaFreno;

--Vistas --

--Desgaste promedio de cada componente de cada auto por vuelta por circuito

GO
CREATE VIEW [Data_Center_Group].BI_VIEW_DesgasteComponentes AS
	SELECT 
		c.nombre as Circuito, 
		t.escuderia_nombre as Escuderia, 
		a.numero as 'Auto N°', t.numero_vuelta, 
		SUM(t.caja_desgaste_promedio * t.caja_desgaste_cantidad) / SUM(t.caja_desgaste_cantidad) as 'Caja - Desgaste',
		MAX(t.motor_potencia_max) - MIN(T.motor_potencia_min) 'Motor - Desgaste',
		MAX(t.neumatico_del_izq_profundidad_max) - MIN(T.neumatico_del_izq_profundidad_min) 'Neumatico Del. Izq. - Desgaste',
		MAX(t.neumatico_del_der_profundidad_max) - MIN(T.neumatico_del_der_profundidad_min) 'Neumatico Del. Der. - Desgaste', 
		MAX(t.neumatico_tra_izq_profundidad_max) - MIN(T.neumatico_tra_izq_profundidad_min) 'Neumatico Tras. Izq. - Desgaste',
		MAX(t.neumatico_tra_der_profundidad_max) - MIN(T.neumatico_tra_der_profundidad_min) 'Neumatico Tras. Der. - Desgaste', 
		MAX(t.freno_del_izq_grosor_pastilla_max) - MIN(T.freno_del_izq_grosor_pastilla_min) 'Freno Del. Izq. - Desgaste',
		MAX(t.freno_del_der_grosor_pastilla_max) - MIN(T.freno_del_der_grosor_pastilla_min) 'Freno Del. Der. - Desgaste', 
		MAX(t.freno_tra_izq_grosor_pastilla_max) - MIN(T.freno_tra_izq_grosor_pastilla_min) 'Freno Tras. Izq. - Desgaste',
		MAX(t.freno_tra_der_grosor_pastilla_max) - MIN(T.freno_tra_der_grosor_pastilla_min) 'Freno Tras. Der. - Desgaste'
	FROM [Data_Center_Group].BI_FACT_Telemetria t
	JOIN [Data_Center_Group].BI_DIM_Circuito c ON c.codigo = t.circuito_codigo
	JOIN [Data_Center_Group].BI_DIM_Auto a ON a.id = t.auto_id
	GROUP BY c.nombre, t.escuderia_nombre, a.numero, t.numero_vuelta

--Mejor tiempo de vuelta de cada escuderia por circuito por año

GO
CREATE VIEW [Data_Center_Group].BI_VIEW_MejorTiempoVuelta AS
	SELECT 
	tiempo.anio as 'Año', 
	c.nombre as Circuito, 
	e.nombre as Escuderia, 
	(
		SELECT TOP 1 MAX(t1.tiempo_vuelta) FROM [Data_Center_Group].BI_FACT_Telemetria t1
		JOIN [Data_Center_Group].BI_DIM_Tiempo tiempo1 ON tiempo1.id = t1.tiempo_id
		WHERE tiempo1.anio = tiempo.anio AND t1.circuito_codigo = c.codigo AND t1.escuderia_nombre = e.nombre
		GROUP BY t1.numero_vuelta
		ORDER BY MAX(t1.tiempo_vuelta) ASC
	) as 'Mejor tiempo' 
	FROM [Data_Center_Group].BI_FACT_Telemetria t
	JOIN [Data_Center_Group].BI_DIM_Tiempo tiempo ON tiempo.id = t.tiempo_id
	JOIN [Data_Center_Group].BI_DIM_Circuito c ON c.codigo = t.circuito_codigo
	JOIN [Data_Center_Group].BI_DIM_Escuderia e ON e.nombre = t.escuderia_nombre
	GROUP BY tiempo.anio, c.codigo, c.nombre, e.nombre


-- los 3 circuitos con mayor consumo de combustible promedio
GO
CREATE VIEW [Data_Center_Group].BI_VIEW_AUX_ConsumoDeCombustible AS
	SELECT t.circuito_codigo, MAX(t.combustible_max) - MIN(t.combustible_min) as consumo_combustible
	FROM [Data_Center_Group].BI_FACT_Telemetria t
	GROUP BY t.circuito_codigo, t.auto_id, t.escuderia_nombre

GO
CREATE VIEW [Data_Center_Group].BI_VIEW_Top3CircuitosConMasConsumo AS
	SELECT TOP 3 c.nombre as 'Circuito', AVG(t.consumo_combustible) as 'Consumo promedio'
	FROM [Data_Center_Group].BI_VIEW_AUX_ConsumoDeCombustible t
	JOIN [Data_Center_Group].BI_DIM_Circuito c ON c.codigo = t.circuito_codigo
	GROUP BY c.nombre
	ORDER BY 'Consumo promedio' DESC


-- Maxima velocidad alcanzada por cada auto en cada tipo de sector de cada circuito
GO
CREATE VIEW  Data_Center_Group.BI_VIEW_MaximaVelocidadPorAutoEnCadaSectorEnCadaCircuito AS
		SELECT 
			 e.nombre AS 'Escuderia',
			 a.numero AS 'Auto N°', 
			 c.nombre AS 'Circuito', 
			 s.tipo AS 'Sector', 
		 MAX(t.velocidad_max) AS 'Maxima velocidad' 
		 FROM [Data_Center_Group].BI_FACT_Telemetria t
		JOIN [Data_Center_Group].BI_DIM_Auto a ON t.auto_id = a.id
		JOIN [Data_Center_Group].BI_DIM_Sector s ON t.sector_codigo = s.codigo
		JOIN [Data_Center_Group].BI_DIM_Circuito c ON t.circuito_codigo = c.codigo
		JOIN [Data_Center_Group].BI_DIM_Escuderia e ON t.escuderia_nombre= e.nombre
		GROUP BY e.nombre, a.numero, c.nombre, s.tipo

--Tiempo promedio que tardo cada escuderia en las paradas por cuatrimestre 
GO
CREATE VIEW  Data_Center_Group.BI_VIEW_TiempoPromedioCadaEscuderiaEnParadasPorCuatrimestre AS
	SELECT p.escuderia_nombre as 'Nombre Escuderia', t.cuatrimestre as 'Cuatrimestre', AVG(p.tiempo) as 'Tiempo Promedio' 
	FROM [Data_Center_Group].BI_FACT_Parada p
	JOIN [Data_Center_Group].BI_DIM_Tiempo t ON t.id = p.tiempo_id
	JOIN [Data_Center_Group].BI_DIM_Escuderia e ON e.nombre = p.escuderia_nombre
	GROUP BY p.escuderia_nombre, t.cuatrimestre

-- Cantidad de paradas por circuito por escuderia por anio
GO
CREATE VIEW  Data_Center_Group.BI_VIEW_CantidadParadasPorCircuitoPorEscuderiaPorAnio AS
	SELECT c.nombre as 'Circuito', p.escuderia_nombre as 'Nombre Escuderia', t.anio as 'Año', COUNT(*) as 'Cantidad de Paradas'
	FROM [Data_Center_Group].BI_FACT_Parada p
	JOIN [Data_Center_Group].BI_DIM_Tiempo t ON t.id = p.tiempo_id
	JOIN [Data_Center_Group].BI_DIM_Circuito c ON c.codigo = p.circuito_codigo
	JOIN [Data_Center_Group].BI_DIM_Escuderia e ON e.nombre = p.escuderia_nombre
	GROUP BY p.escuderia_nombre, c.nombre, t.anio

-- los 3 circuitos donde se consume mayor cantidad en tiempo de paradas en boxes
GO
CREATE VIEW  Data_Center_Group.BI_VIEW_Top3CircutosConMayorCantidadDeTiempoEnParadasEnBoxes AS
	(SELECT TOP 3 c.nombre as 'Circuito', SUM(p.tiempo) as 'Tiempo en Boxes'
	FROM [Data_Center_Group].BI_FACT_Parada p
	JOIN [Data_Center_Group].BI_DIM_Circuito c ON c.codigo = p.circuito_codigo
	GROUP BY c.nombre
	ORDER BY 'Tiempo en Boxes' DESC)


-- los 3 circuitos mas peligrosos del año en funcion mayor cantidad de incidentes 
GO
CREATE VIEW  Data_Center_Group.BI_VIEW_AUX_IncidentesPorCircuitoPorAnio AS
	SELECT 
		t.anio as 'Año',
		c.nombre as 'Escudería', 
		COUNT(DISTINCT ia.incidente_numero) AS 'Cantidad incidentes', 
		ROW_NUMBER() OVER (PARTITION BY t.anio ORDER BY COUNT(DISTINCT ia.incidente_numero) DESC) ranking
	FROM [Data_Center_Group].BI_FACT_IncidenteAuto ia
	JOIN [Data_Center_Group].BI_DIM_Tiempo t ON t.id = ia.tiempo_id
	JOIN [Data_Center_Group].BI_DIM_Circuito c ON c.codigo = ia.circuito_codigo
	GROUP BY t.anio, c.nombre

GO
CREATE VIEW [Data_Center_Group].BI_VIEW_Top3CircuitosMasPeligrososPorAnio AS
	SELECT *
	FROM [Data_Center_Group].BI_VIEW_AUX_IncidentesPorCircuitoPorAnio ia
	WHERE ia.ranking <= 3

--Promedio de incidentes que presenta cada escuderia por año en los distintos tipos de sectores 
GO
CREATE VIEW  [Data_Center_Group].BI_VIEW_PromedioIncidentesEscuderiaPorAnioEnSectores AS
	SELECT
		t.anio AS 'Año', ia.escuderia_nombre AS 'Escudería', s.tipo AS 'Sector tipo', SUM(ia.cantidad) as 'Promedio incidentes'
	FROM [Data_Center_Group].BI_FACT_IncidenteAuto ia
	JOIN [Data_Center_Group].BI_DIM_Tiempo t ON t.id = ia.tiempo_id
	JOIN [Data_Center_Group].BI_DIM_Sector s ON s.codigo = ia.sector_codigo
	GROUP BY t.anio, ia.escuderia_nombre, s.tipo

/*
SELECT * FROM [Data_Center_Group].BI_VIEW_DesgasteComponentes;
SELECT * FROM [Data_Center_Group].BI_VIEW_MejorTiempoVuelta;
SELECT * FROM [Data_Center_Group].BI_VIEW_Top3CircuitosConMasConsumo;
SELECT * FROM [Data_Center_Group].BI_VIEW_MaximaVelocidadPorAutoEnCadaSectorEnCadaCircuito
SELECT * FROM [Data_Center_Group].BI_VIEW_TiempoPromedioCadaEscuderiaEnParadasPorCuatrimestre
SELECT * FROM [Data_Center_Group].BI_VIEW_CantidadParadasPorCircuitoPorEscuderiaPorAnio
SELECT * FROM [Data_Center_Group].BI_VIEW_Top3CircutosConMayorCantidadDeTiempoEnParadasEnBoxes
SELECT * FROM [Data_Center_Group].BI_VIEW_Top3CircuitosMasPeligrososPorAnio
SELECT * FROM [Data_Center_Group].BI_VIEW_PromedioIncidentesEscuderiaPorAnioEnSectores
*/