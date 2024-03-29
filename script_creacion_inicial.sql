USE [GD1C2022]
GO

----------------------------------------------------------
------------------- CREACION DE SCHEMA -------------------
----------------------------------------------------------

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name='Data_Center_Group')
BEGIN
	PRINT 'CREANDO NUEVO ESQUEMA'
	EXEC('CREATE SCHEMA [Data_Center_Group]')
END
GO

----------------------------------------------------------
----------------- FIN CREACION DE SCHEMA -----------------
----------------------------------------------------------


----------------------------------------------------------
-------------------- DROPEO DE TABLAS --------------------
----------------------------------------------------------

-- BI
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
IF OBJECT_ID('Data_Center_Group.BI_VIEW_AUX_MejorTiempoCadaVuelta', 'V') IS NOT NULL
    DROP VIEW [Data_Center_Group].BI_VIEW_AUX_MejorTiempoCadaVuelta;
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
IF OBJECT_ID('Data_Center_Group.BI_VIEW_AUX_CantidadIncidentesEscuderiaPorAnioEnSectores', 'V') IS NOT NULL 
	DROP VIEW [Data_Center_Group].BI_VIEW_AUX_CantidadIncidentesEscuderiaPorAnioEnSectores;
IF OBJECT_ID('Data_Center_Group.BI_VIEW_PromedioIncidentesEscuderiaPorAnioEnSectores', 'V') IS NOT NULL 
	DROP VIEW [Data_Center_Group].BI_VIEW_PromedioIncidentesEscuderiaPorAnioEnSectores;

--OLTP

IF OBJECT_ID('Data_Center_Group.IncidenteAuto', 'U') IS NOT NULL
	DROP TABLE [Data_Center_Group].IncidenteAuto
IF OBJECT_ID('Data_Center_Group.Incidente', 'U') IS NOT NULL
	DROP TABLE [Data_Center_Group].Incidente
IF OBJECT_ID('Data_Center_Group.ParadaCambioNeumatico', 'U') IS NOT NULL
	DROP TABLE [Data_Center_Group].ParadaCambioNeumatico
IF OBJECT_ID('Data_Center_Group.Parada', 'U') IS NOT NULL
	DROP TABLE [Data_Center_Group].Parada
IF OBJECT_ID('Data_Center_Group.TelemetriaFreno', 'U') IS NOT NULL
	DROP TABLE [Data_Center_Group].TelemetriaFreno
IF OBJECT_ID('Data_Center_Group.TelemetriaNeumatico', 'U') IS NOT NULL
	DROP TABLE [Data_Center_Group].TelemetriaNeumatico
IF OBJECT_ID('Data_Center_Group.TelemetriaMotor', 'U') IS NOT NULL
	DROP TABLE [Data_Center_Group].TelemetriaMotor
IF OBJECT_ID('Data_Center_Group.TelemetriaAuto', 'U') IS NOT NULL
	DROP TABLE [Data_Center_Group].TelemetriaAuto
IF OBJECT_ID('Data_Center_Group.TelemetriaCaja', 'U') IS NOT NULL
	DROP TABLE [Data_Center_Group].TelemetriaCaja
IF OBJECT_ID('Data_Center_Group.Telemetria', 'U') IS NOT NULL
	DROP TABLE [Data_Center_Group].Telemetria
IF OBJECT_ID('Data_Center_Group.Carrera', 'U') IS NOT NULL
	DROP TABLE [Data_Center_Group].Carrera
IF OBJECT_ID('Data_Center_Group.Sector', 'U') IS NOT NULL
	DROP TABLE [Data_Center_Group].Sector
IF OBJECT_ID('Data_Center_Group.Circuito', 'U') IS NOT NULL
	DROP TABLE [Data_Center_Group].Circuito
IF OBJECT_ID('Data_Center_Group.Auto', 'U') IS NOT NULL
	DROP TABLE [Data_Center_Group].Auto
IF OBJECT_ID('Data_Center_Group.Escuderia', 'U') IS NOT NULL
	DROP TABLE [Data_Center_Group].Escuderia
IF OBJECT_ID('Data_Center_Group.Piloto', 'U') IS NOT NULL
	DROP TABLE [Data_Center_Group].Piloto
IF OBJECT_ID('Data_Center_Group.Neumatico', 'U') IS NOT NULL
	DROP TABLE [Data_Center_Group].Neumatico
IF OBJECT_ID('Data_Center_Group.Freno', 'U') IS NOT NULL
	DROP TABLE [Data_Center_Group].Freno
IF OBJECT_ID('Data_Center_Group.Caja', 'U') IS NOT NULL
	DROP TABLE [Data_Center_Group].Caja
IF OBJECT_ID('Data_Center_Group.Motor', 'U') IS NOT NULL
	DROP TABLE [Data_Center_Group].Motor

----------------------------------------------------------
------------------ FIN DROPEO DE TABLAS ------------------
----------------------------------------------------------


----------------------------------------------------------
------------------- CREACION DE TABLAS -------------------
----------------------------------------------------------

--- GENERAL: INICIO ---

CREATE TABLE [Data_Center_Group].Escuderia (
	nombre NVARCHAR(255) NOT NULL PRIMARY KEY,
	nacionalidad NVARCHAR(255) NOT NULL
);

CREATE TABLE [Data_Center_Group].Piloto (
	codigo INT NOT NULL IDENTITY PRIMARY KEY,
	nombre NVARCHAR(50) NOT NULL,
	apellido NVARCHAR(50) NOT NULL,
	nacionalidad NVARCHAR(50) NOT NULL,
	fecha_nacimiento DATE NOT NULL,
);

CREATE TABLE [Data_Center_Group].Neumatico (
	numero_serie NVARCHAR(255) NOT NULL PRIMARY KEY,
	tipo NVARCHAR(255) NOT NULL
);

CREATE TABLE [Data_Center_Group].Freno (
	numero_serie NVARCHAR(255) NOT NULL PRIMARY KEY,
	tamanio_disco DECIMAL(18,2) NOT NULL
); 

CREATE TABLE [Data_Center_Group].Motor (
	numero_serie NVARCHAR(255) NOT NULL PRIMARY KEY,
	modelo NVARCHAR(255) NOT NULL
);

CREATE TABLE [Data_Center_Group].Caja (
	numero_serie NVARCHAR(255) NOT NULL PRIMARY KEY,
	modelo NVARCHAR(50) NOT NULL
);

CREATE TABLE [Data_Center_Group].Auto (
	numero INT NOT NULL,
	escuderia_nombre NVARCHAR(255) NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Escuderia(nombre),
	modelo NVARCHAR(255) NOT NULL,
	piloto_codigo INT NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Piloto(codigo),
	CONSTRAINT auto_pk PRIMARY KEY (numero, escuderia_nombre)
);

CREATE TABLE [Data_Center_Group].Circuito (
	codigo INT NOT NULL PRIMARY KEY,
	nombre NVARCHAR(50),
	pais NVARCHAR(50)
);

CREATE TABLE [Data_Center_Group].Carrera (
	codigo INT NOT NULL PRIMARY KEY,
	fecha DATE NOT NULL,
	clima NVARCHAR(100) NOT NULL,
	total_carrera DECIMAL(18,2) NOT NULL,
	cantidad_vueltas INT NOT NULL,
	circuito_codigo INT NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Circuito(codigo)
)

CREATE TABLE [Data_Center_Group].Sector (
	codigo INT NOT NULL PRIMARY KEY,
	circuito_codigo INT NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Circuito(codigo),
	distancia DECIMAL(18,2) NOT NULL,
	tipo NVARCHAR(255) NOT NULL
) 

--- GENERAL: FIN ---

--- TELEMETRIA: INICIO ---

CREATE TABLE [Data_Center_Group].Telemetria (
	codigo DECIMAL(18,0) NOT NULL PRIMARY KEY,
	sector_codigo INT NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Sector(codigo),
	carrera_codigo INT NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Carrera(codigo),
	carrera_distancia DECIMAL(18,6) NOT NULL,
	vuelta_numero DECIMAL(18,0) NOT NULL, 
	vuelta_distancia DECIMAL(18,2) NOT NULL, 
	vuelta_tiempo DECIMAL(18,10) NOT NULL, 
);

CREATE TABLE [Data_Center_Group].TelemetriaCaja (
	telemetria_codigo DECIMAL(18,0) NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES [Data_Center_Group].Telemetria(codigo),
	caja_numero_serie NVARCHAR(255) NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Caja(numero_serie),
	temperatura_aceite DECIMAL(18,2) NOT NULL,
	rpm DECIMAL(18,2) NOT NULL,
	desgaste DECIMAL(18,2) NOT NULL
)

CREATE TABLE [Data_Center_Group].TelemetriaAuto (
	telemetria_codigo DECIMAL(18,0) NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES [Data_Center_Group].Telemetria(codigo),
	auto_numero INT NOT NULL,
	auto_escuderia_nombre NVARCHAR(255) NOT NULL,
	posicion DECIMAL(18,0) NOT NULL,
	velocidad DECIMAL(18,2) NOT NULL,
	combustible DECIMAL(18,2) NOT NULL,
	FOREIGN KEY (auto_numero, auto_escuderia_nombre) REFERENCES [Data_Center_Group].Auto(numero, escuderia_nombre)
);

CREATE TABLE [Data_Center_Group].TelemetriaMotor (
	telemetria_codigo DECIMAL(18,0) NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES [Data_Center_Group].Telemetria(codigo),
	motor_numero_serie NVARCHAR(255) NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Motor(numero_serie),
	potencia DECIMAL(18,6) NOT NULL,
	rpm DECIMAL(18,6) NOT NULL,
	temperatura_aceite DECIMAL(18,6) NOT NULL,
	temperatura_agua DECIMAL(18,6) NOT NULL
);

CREATE TABLE [Data_Center_Group].TelemetriaNeumatico (
	telemetria_codigo DECIMAL(18,0) NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Telemetria(codigo),
	neumatico_numero_serie NVARCHAR(255) NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Neumatico(numero_serie),
	posicion NVARCHAR(255) NOT NULL,
	presion DECIMAL(18,2) NOT NULL,
	profundidad DECIMAL(18,6) NOT NULL,
	temperatura DECIMAL(18,6) NOT NULL,
	CONSTRAINT telemetria_neumatico_pk PRIMARY KEY (telemetria_codigo, posicion)

);

CREATE TABLE [Data_Center_Group].TelemetriaFreno (
	telemetria_codigo DECIMAL(18,0) NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Telemetria(codigo),
	posicion NVARCHAR(255) NOT NULL,
	freno_numero_serie NVARCHAR(255) NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Freno(numero_serie),
	grosor_pastilla DECIMAL(18,2) NOT NULL,
	temperatura DECIMAL(18,2) NOT NULL,
	CONSTRAINT telemetria_freno_pk PRIMARY KEY (telemetria_codigo, posicion)
);

--- TELEMETRIA: FIN ---

--- PARADA: INICIO ---

CREATE TABLE [Data_Center_Group].Parada (
	codigo INT NOT NULL IDENTITY PRIMARY KEY,
	numero_vuelta DECIMAL(18,0) NOT NULL,
	tiempo DECIMAL(18,2) NOT NULL,
	auto_numero INT NOT NULL,
	auto_escuderia_nombre NVARCHAR(255) NOT NULL,
	FOREIGN KEY (auto_numero, auto_escuderia_nombre) REFERENCES [Data_Center_Group].Auto(numero, escuderia_nombre),
	carrera_codigo INT NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Carrera(codigo)
);

CREATE TABLE [Data_Center_Group].ParadaCambioNeumatico (
	parada_codigo INT NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Parada(codigo),
	posicion NVARCHAR(255) NOT NULL,
	neumatico_viejo_numero_serie NVARCHAR(255) NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Neumatico(numero_serie),
	neumatico_nuevo_numero_serie NVARCHAR(255) NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Neumatico(numero_serie),
	CONSTRAINT parada_cambio_neumatico_pk PRIMARY KEY (parada_codigo, posicion) 
);

--- PARADA: FIN ---

--- INCIDENTE: INICIO ---

CREATE TABLE [Data_Center_Group].Incidente (
	codigo INT NOT NULL IDENTITY PRIMARY KEY,
	tiempo DECIMAL(18,2) NOT NULL,
	bandera NVARCHAR(255) NOT NULL,
	sector_codigo INT NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Sector(codigo),
	carrera_codigo INT NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Carrera(codigo)
);

CREATE TABLE [Data_Center_Group].IncidenteAuto (
	incidente_codigo INT NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Incidente(codigo),
	auto_numero INT NOT NULL,
	auto_escuderia_nombre NVARCHAR(255) NOT NULL,
	numero_vuelta DECIMAL(18,0) NOT NULL,
	tipo NVARCHAR(255) NOT NULL,
	FOREIGN KEY (auto_numero, auto_escuderia_nombre) REFERENCES [Data_Center_Group].Auto(numero, escuderia_nombre),
	CONSTRAINT incidente_auto_pk PRIMARY KEY (incidente_codigo, auto_numero, auto_escuderia_nombre)
);

--- INCIDENTE: FIN ---

----------------------------------------------------------
----------------- FIN CREACION DE TABLAS -----------------
----------------------------------------------------------


----------------------------------------------------------
----------------------- MIGRACION ------------------------
----------------------------------------------------------

GO
CREATE PROCEDURE [Data_Center_Group].cargarEscuderias
AS
BEGIN
    INSERT INTO [Data_Center_Group].Escuderia (nombre, nacionalidad)
	SELECT DISTINCT ESCUDERIA_NOMBRE, ESCUDERIA_NACIONALIDAD
	FROM gd_esquema.Maestra
END;

GO
CREATE PROCEDURE [Data_Center_Group].cargarPilotos
AS
BEGIN
    INSERT INTO [Data_Center_Group].Piloto (nombre, apellido, nacionalidad, fecha_nacimiento)
	SELECT DISTINCT PILOTO_NOMBRE, PILOTO_APELLIDO, PILOTO_NACIONALIDAD, PILOTO_FECHA_NACIMIENTO
	FROM gd_esquema.Maestra
END;

GO
CREATE PROCEDURE [Data_Center_Group].cargarAutos
AS
BEGIN
    INSERT INTO [Data_Center_Group].Auto(numero, escuderia_nombre, modelo, piloto_codigo)
	SELECT DISTINCT AUTO_NUMERO, ESCUDERIA_NOMBRE, AUTO_MODELO, (SELECT codigo FROM Piloto WHERE nombre = PILOTO_NOMBRE AND apellido = PILOTO_APELLIDO AND nacionalidad = PILOTO_NACIONALIDAD AND fecha_nacimiento = PILOTO_FECHA_NACIMIENTO)
	FROM gd_esquema.Maestra
END;

GO
CREATE PROCEDURE [Data_Center_Group].cargarCajas
AS
BEGIN
	INSERT INTO [Data_Center_Group].Caja(numero_serie, modelo)
	SELECT DISTINCT TELE_CAJA_NRO_SERIE, TELE_CAJA_MODELO
	FROM gd_esquema.Maestra
	WHERE TELE_AUTO_CODIGO IS NOT NULL
END;

GO
CREATE PROCEDURE [Data_Center_Group].cargarMotores
AS
BEGIN
	INSERT INTO [Data_Center_Group].Motor(numero_serie, modelo)
	SELECT DISTINCT TELE_MOTOR_NRO_SERIE, TELE_MOTOR_MODELO
	FROM gd_esquema.Maestra
	WHERE TELE_AUTO_CODIGO IS NOT NULL
END;

GO
CREATE PROCEDURE [Data_Center_Group].cargarFrenos
AS
BEGIN
	INSERT INTO [Data_Center_Group].Freno(numero_serie, tamanio_disco)
	SELECT TELE_FRENO1_NRO_SERIE, TELE_FRENO1_TAMANIO_DISCO
	FROM gd_esquema.Maestra
	WHERE TELE_AUTO_CODIGO IS NOT NULL
	UNION
	SELECT TELE_FRENO2_NRO_SERIE, TELE_FRENO2_TAMANIO_DISCO
	FROM gd_esquema.Maestra
	WHERE TELE_AUTO_CODIGO IS NOT NULL
	UNION
	SELECT TELE_FRENO3_NRO_SERIE, TELE_FRENO3_TAMANIO_DISCO
	FROM gd_esquema.Maestra
	WHERE TELE_AUTO_CODIGO IS NOT NULL
	UNION
	SELECT TELE_FRENO4_NRO_SERIE, TELE_FRENO4_TAMANIO_DISCO
	FROM gd_esquema.Maestra
	WHERE TELE_AUTO_CODIGO IS NOT NULL
END;

GO
CREATE PROCEDURE [Data_Center_Group].cargarCircuitos
AS
BEGIN
    INSERT INTO [Data_Center_Group].Circuito(codigo, nombre, pais)
	SELECT DISTINCT CIRCUITO_CODIGO, CIRCUITO_NOMBRE, CIRCUITO_PAIS
	FROM gd_esquema.Maestra
END;

GO
CREATE PROCEDURE [Data_Center_Group].cargarCarreras
AS
BEGIN
    INSERT INTO [Data_Center_Group].Carrera(codigo, fecha, clima, total_carrera, cantidad_vueltas, circuito_codigo)
	SELECT DISTINCT CODIGO_CARRERA, CARRERA_FECHA, CARRERA_CLIMA, CARRERA_TOTAL_CARRERA, CARRERA_CANT_VUELTAS, CIRCUITO_CODIGO
	FROM gd_esquema.Maestra
END;

GO
CREATE PROCEDURE [Data_Center_Group].cargarSectores
AS
BEGIN
    INSERT INTO [Data_Center_Group].Sector(codigo, tipo, distancia, circuito_codigo)
	SELECT DISTINCT CODIGO_SECTOR, SECTO_TIPO, SECTOR_DISTANCIA, CIRCUITO_CODIGO
	FROM gd_esquema.Maestra
END;

GO
CREATE PROCEDURE [Data_Center_Group].cargarTelemetrias
AS
BEGIN
    INSERT INTO [Data_Center_Group].Telemetria(codigo, sector_codigo, carrera_codigo, carrera_distancia, vuelta_numero, vuelta_distancia, vuelta_tiempo)
	SELECT TELE_AUTO_CODIGO, CODIGO_SECTOR, CODIGO_CARRERA, TELE_AUTO_DISTANCIA_CARRERA, TELE_AUTO_NUMERO_VUELTA, TELE_AUTO_DISTANCIA_VUELTA, TELE_AUTO_TIEMPO_VUELTA
	FROM gd_esquema.Maestra
	WHERE TELE_AUTO_CODIGO IS NOT NULL
END;

GO
CREATE PROCEDURE [Data_Center_Group].cargarTelemetriaCajas
AS
BEGIN
    INSERT INTO [Data_Center_Group].TelemetriaCaja(telemetria_codigo, caja_numero_serie, temperatura_aceite, rpm, desgaste)
	SELECT TELE_AUTO_CODIGO, TELE_CAJA_NRO_SERIE, TELE_CAJA_TEMP_ACEITE, TELE_CAJA_RPM, TELE_CAJA_DESGASTE
	FROM gd_esquema.Maestra
	WHERE TELE_AUTO_CODIGO IS NOT NULL
END;

GO
CREATE PROCEDURE [Data_Center_Group].cargarTelemetriaAutos
AS
BEGIN
    INSERT INTO [Data_Center_Group].TelemetriaAuto(telemetria_codigo, auto_numero, auto_escuderia_nombre, posicion, velocidad, combustible)
	SELECT TELE_AUTO_CODIGO, AUTO_NUMERO, ESCUDERIA_NOMBRE, TELE_AUTO_POSICION, TELE_AUTO_VELOCIDAD, TELE_AUTO_COMBUSTIBLE
	FROM gd_esquema.Maestra
	WHERE TELE_AUTO_CODIGO IS NOT NULL
END;

GO
CREATE PROCEDURE [Data_Center_Group].cargarTelemetriaMotores
AS
BEGIN
    INSERT INTO [Data_Center_Group].TelemetriaMotor(telemetria_codigo, motor_numero_serie, potencia, rpm, temperatura_aceite, temperatura_agua)
	SELECT TELE_AUTO_CODIGO, TELE_MOTOR_NRO_SERIE, TELE_MOTOR_POTENCIA, TELE_MOTOR_RPM, TELE_MOTOR_TEMP_ACEITE, TELE_MOTOR_TEMP_AGUA
	FROM gd_esquema.Maestra
	WHERE TELE_AUTO_CODIGO IS NOT NULL
END;

GO
CREATE PROCEDURE [Data_Center_Group].cargarIncidentes
AS
BEGIN
    INSERT INTO [Data_Center_Group].Incidente(tiempo, bandera, sector_codigo, carrera_codigo)
	SELECT DISTINCT INCIDENTE_TIEMPO, INCIDENTE_BANDERA, CODIGO_SECTOR, CODIGO_CARRERA
	FROM gd_esquema.Maestra
	WHERE INCIDENTE_TIEMPO IS NOT NULL
END;

GO
CREATE PROCEDURE [Data_Center_Group].cargarNeumaticos
AS
BEGIN
    INSERT INTO [Data_Center_Group].Neumatico(numero_serie, tipo)
	SELECT NEUMATICO1_NRO_SERIE_NUEVO, NEUMATICO1_TIPO_NUEVO
	FROM gd_esquema.Maestra
	WHERE PARADA_BOX_TIEMPO IS NOT NULL
	UNION
	SELECT NEUMATICO1_NRO_SERIE_VIEJO, NEUMATICO1_TIPO_VIEJO
	FROM gd_esquema.Maestra
	WHERE PARADA_BOX_TIEMPO IS NOT NULL
	UNION
	SELECT NEUMATICO2_NRO_SERIE_NUEVO, NEUMATICO2_TIPO_NUEVO
	FROM gd_esquema.Maestra
	WHERE PARADA_BOX_TIEMPO IS NOT NULL
	UNION
	SELECT NEUMATICO2_NRO_SERIE_VIEJO, NEUMATICO2_TIPO_VIEJO
	FROM gd_esquema.Maestra
	WHERE PARADA_BOX_TIEMPO IS NOT NULL
	UNION
	SELECT NEUMATICO3_NRO_SERIE_NUEVO, NEUMATICO3_TIPO_NUEVO
	FROM gd_esquema.Maestra
	WHERE PARADA_BOX_TIEMPO IS NOT NULL
	UNION
	SELECT NEUMATICO3_NRO_SERIE_VIEJO, NEUMATICO3_TIPO_VIEJO
	FROM gd_esquema.Maestra
	WHERE PARADA_BOX_TIEMPO IS NOT NULL
	UNION
	SELECT NEUMATICO4_NRO_SERIE_NUEVO, NEUMATICO4_TIPO_NUEVO
	FROM gd_esquema.Maestra
	WHERE PARADA_BOX_TIEMPO IS NOT NULL
	UNION
	SELECT NEUMATICO4_NRO_SERIE_VIEJO, NEUMATICO4_TIPO_VIEJO
	FROM gd_esquema.Maestra
	WHERE PARADA_BOX_TIEMPO IS NOT NULL
	UNION
	SELECT TELE_NEUMATICO1_NRO_SERIE, NEUMATICO1_TIPO_VIEJO
	FROM gd_esquema.Maestra
	WHERE TELE_AUTO_CODIGO IS NOT NULL
	UNION
	SELECT TELE_NEUMATICO2_NRO_SERIE, NEUMATICO2_TIPO_VIEJO
	FROM gd_esquema.Maestra
	WHERE TELE_AUTO_CODIGO IS NOT NULL
	UNION
	SELECT TELE_NEUMATICO3_NRO_SERIE, NEUMATICO3_TIPO_VIEJO
	FROM gd_esquema.Maestra
	WHERE TELE_AUTO_CODIGO IS NOT NULL
	UNION
	SELECT TELE_NEUMATICO4_NRO_SERIE, NEUMATICO4_TIPO_VIEJO
	FROM gd_esquema.Maestra
	WHERE TELE_AUTO_CODIGO IS NOT NULL
END;

GO
CREATE PROCEDURE [Data_Center_Group].cargarTelemetriaNeumaticos
AS
BEGIN
    INSERT INTO [Data_Center_Group].TelemetriaNeumatico(telemetria_codigo, posicion, neumatico_numero_serie, presion, profundidad, temperatura)
	SELECT TELE_AUTO_CODIGO, TELE_NEUMATICO1_POSICION, TELE_NEUMATICO1_NRO_SERIE, TELE_NEUMATICO1_PRESION, TELE_NEUMATICO1_PROFUNDIDAD, TELE_NEUMATICO1_TEMPERATURA
	FROM gd_esquema.Maestra
	WHERE TELE_AUTO_CODIGO IS NOT NULL
	UNION
	SELECT TELE_AUTO_CODIGO, TELE_NEUMATICO2_POSICION, TELE_NEUMATICO2_NRO_SERIE, TELE_NEUMATICO2_PRESION, TELE_NEUMATICO2_PROFUNDIDAD, TELE_NEUMATICO2_TEMPERATURA
	FROM gd_esquema.Maestra
	WHERE TELE_AUTO_CODIGO IS NOT NULL
	UNION
	SELECT TELE_AUTO_CODIGO, TELE_NEUMATICO3_POSICION, TELE_NEUMATICO3_NRO_SERIE, TELE_NEUMATICO3_PRESION, TELE_NEUMATICO3_PROFUNDIDAD, TELE_NEUMATICO3_TEMPERATURA
	FROM gd_esquema.Maestra
	WHERE TELE_AUTO_CODIGO IS NOT NULL
	UNION
	SELECT TELE_AUTO_CODIGO, TELE_NEUMATICO4_POSICION, TELE_NEUMATICO4_NRO_SERIE, TELE_NEUMATICO4_PRESION, TELE_NEUMATICO4_PROFUNDIDAD, TELE_NEUMATICO4_TEMPERATURA
	FROM gd_esquema.Maestra
	WHERE TELE_AUTO_CODIGO IS NOT NULL
END;

GO
CREATE PROCEDURE [Data_Center_Group].cargarTelemetriaFrenos
AS
BEGIN
    INSERT INTO [Data_Center_Group].TelemetriaFreno(telemetria_codigo, posicion, freno_numero_serie, grosor_pastilla, temperatura)
	SELECT TELE_AUTO_CODIGO, TELE_FRENO1_POSICION, TELE_FRENO1_NRO_SERIE, TELE_FRENO1_GROSOR_PASTILLA, TELE_FRENO1_TEMPERATURA
	FROM gd_esquema.Maestra
	WHERE TELE_AUTO_CODIGO IS NOT NULL
	UNION
	SELECT TELE_AUTO_CODIGO, TELE_FRENO2_POSICION, TELE_FRENO2_NRO_SERIE, TELE_FRENO2_GROSOR_PASTILLA, TELE_FRENO2_TEMPERATURA
	FROM gd_esquema.Maestra
	WHERE TELE_AUTO_CODIGO IS NOT NULL
	UNION
	SELECT TELE_AUTO_CODIGO, TELE_FRENO3_POSICION, TELE_FRENO3_NRO_SERIE, TELE_FRENO3_GROSOR_PASTILLA, TELE_FRENO3_TEMPERATURA
	FROM gd_esquema.Maestra
	WHERE TELE_AUTO_CODIGO IS NOT NULL
	UNION
	SELECT TELE_AUTO_CODIGO, TELE_FRENO4_POSICION, TELE_FRENO4_NRO_SERIE, TELE_FRENO4_GROSOR_PASTILLA, TELE_FRENO4_TEMPERATURA
	FROM gd_esquema.Maestra
	WHERE TELE_AUTO_CODIGO IS NOT NULL
END;

GO
CREATE PROCEDURE [Data_Center_Group].cargarParadas
AS
BEGIN
    INSERT INTO [Data_Center_Group].Parada(numero_vuelta, tiempo, auto_numero, auto_escuderia_nombre, carrera_codigo)
	SELECT DISTINCT PARADA_BOX_VUELTA, PARADA_BOX_TIEMPO, AUTO_NUMERO, ESCUDERIA_NOMBRE, CODIGO_CARRERA
	FROM gd_esquema.Maestra
	WHERE PARADA_BOX_TIEMPO IS NOT NULL
END;

GO
CREATE PROCEDURE [Data_Center_Group].cargarParadasCambioNeumatico
AS
BEGIN
    INSERT INTO [Data_Center_Group].ParadaCambioNeumatico(parada_codigo, posicion, neumatico_viejo_numero_serie, neumatico_nuevo_numero_serie) 
	SELECT (SELECT codigo FROM [Data_Center_Group].Parada WHERE (tiempo = PARADA_BOX_TIEMPO AND auto_escuderia_nombre = ESCUDERIA_NOMBRE)), NEUMATICO1_POSICION_NUEVO, NEUMATICO1_NRO_SERIE_VIEJO, NEUMATICO1_NRO_SERIE_NUEVO
	FROM gd_esquema.Maestra
	WHERE NEUMATICO1_POSICION_NUEVO IS NOT NULL
	UNION
	SELECT (SELECT codigo FROM [Data_Center_Group].Parada WHERE (tiempo = PARADA_BOX_TIEMPO AND auto_escuderia_nombre = ESCUDERIA_NOMBRE)), NEUMATICO2_POSICION_NUEVO, NEUMATICO2_NRO_SERIE_VIEJO, NEUMATICO2_NRO_SERIE_NUEVO
	FROM gd_esquema.Maestra
	WHERE NEUMATICO2_POSICION_NUEVO IS NOT NULL
	UNION
	SELECT (SELECT codigo FROM [Data_Center_Group].Parada WHERE (tiempo = PARADA_BOX_TIEMPO AND auto_escuderia_nombre = ESCUDERIA_NOMBRE)), NEUMATICO3_POSICION_NUEVO, NEUMATICO3_NRO_SERIE_VIEJO, NEUMATICO3_NRO_SERIE_NUEVO
	FROM gd_esquema.Maestra
	WHERE NEUMATICO3_POSICION_NUEVO IS NOT NULL
	UNION
	SELECT (SELECT codigo FROM [Data_Center_Group].Parada WHERE (tiempo = PARADA_BOX_TIEMPO AND auto_escuderia_nombre = ESCUDERIA_NOMBRE)), NEUMATICO4_POSICION_NUEVO, NEUMATICO4_NRO_SERIE_VIEJO, NEUMATICO4_NRO_SERIE_NUEVO
	FROM gd_esquema.Maestra
	WHERE NEUMATICO4_POSICION_NUEVO IS NOT NULL
END;

GO
CREATE PROCEDURE [Data_Center_Group].cargarIncidenteAutos
AS
BEGIN
    INSERT INTO [Data_Center_Group].IncidenteAuto(incidente_codigo, auto_numero, auto_escuderia_nombre, numero_vuelta, tipo)
	SELECT (SELECT codigo FROM [Data_Center_Group].Incidente WHERE tiempo = INCIDENTE_TIEMPO AND sector_codigo = CODIGO_SECTOR AND bandera = INCIDENTE_BANDERA), AUTO_NUMERO, ESCUDERIA_NOMBRE, INCIDENTE_NUMERO_VUELTA, INCIDENTE_TIPO
	FROM gd_esquema.Maestra
	WHERE INCIDENTE_TIEMPO IS NOT NULL
END;


GO
EXEC [Data_Center_Group].cargarEscuderias
EXEC [Data_Center_Group].cargarPilotos
EXEC [Data_Center_Group].cargarAutos
EXEC [Data_Center_Group].cargarCajas
EXEC [Data_Center_Group].cargarMotores
EXEC [Data_Center_Group].cargarFrenos
EXEC [Data_Center_Group].cargarCircuitos
EXEC [Data_Center_Group].cargarCarreras
EXEC [Data_Center_Group].cargarSectores
EXEC [Data_Center_Group].cargarTelemetrias
EXEC [Data_Center_Group].cargarTelemetriaCajas
EXEC [Data_Center_Group].cargarTelemetriaAutos
EXEC [Data_Center_Group].cargarTelemetriaMotores
EXEC [Data_Center_Group].cargarParadas
EXEC [Data_Center_Group].cargarIncidentes
EXEC [Data_Center_Group].cargarIncidenteAutos
EXEC [Data_Center_Group].cargarNeumaticos
EXEC [Data_Center_Group].cargarTelemetriaNeumaticos
EXEC [Data_Center_Group].cargarTelemetriaFrenos
EXEC [Data_Center_Group].cargarParadasCambioNeumatico

DROP PROCEDURE [Data_Center_Group].cargarEscuderias
DROP PROCEDURE [Data_Center_Group].cargarPilotos
DROP PROCEDURE [Data_Center_Group].cargarAutos
DROP PROCEDURE [Data_Center_Group].cargarCajas
DROP PROCEDURE [Data_Center_Group].cargarMotores
DROP PROCEDURE [Data_Center_Group].cargarFrenos
DROP PROCEDURE [Data_Center_Group].cargarCircuitos
DROP PROCEDURE [Data_Center_Group].cargarCarreras
DROP PROCEDURE [Data_Center_Group].cargarSectores
DROP PROCEDURE [Data_Center_Group].cargarTelemetrias
DROP PROCEDURE [Data_Center_Group].cargarTelemetriaCajas
DROP PROCEDURE [Data_Center_Group].cargarTelemetriaAutos
DROP PROCEDURE [Data_Center_Group].cargarTelemetriaMotores
DROP PROCEDURE [Data_Center_Group].cargarParadas
DROP PROCEDURE [Data_Center_Group].cargarIncidentes
DROP PROCEDURE [Data_Center_Group].cargarIncidenteAutos
DROP PROCEDURE [Data_Center_Group].cargarNeumaticos
DROP PROCEDURE [Data_Center_Group].cargarTelemetriaNeumaticos
DROP PROCEDURE [Data_Center_Group].cargarTelemetriaFrenos
DROP PROCEDURE [Data_Center_Group].cargarParadasCambioNeumatico
----------------------------------------------------------
--------------------- FIN MIGRACION ----------------------
----------------------------------------------------------
