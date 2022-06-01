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

DROP TABLE [Data_Center_Group].IncidenteAuto
DROP TABLE [Data_Center_Group].Incidente
DROP TABLE [Data_Center_Group].ParadaCambioNeumatico
DROP TABLE [Data_Center_Group].Parada
DROP TABLE [Data_Center_Group].TelemetriaNeumatico
DROP TABLE [Data_Center_Group].TelemetriaFreno
DROP TABLE [Data_Center_Group].TelemetriaMotor
DROP TABLE [Data_Center_Group].TelemetriaAuto
DROP TABLE [Data_Center_Group].TelemetriaCaja
DROP TABLE [Data_Center_Group].TelemetriaVuelta
DROP TABLE [Data_Center_Group].Telemetria
DROP TABLE [Data_Center_Group].Carrera
DROP TABLE [Data_Center_Group].Sector
DROP TABLE [Data_Center_Group].Circuito
DROP TABLE [Data_Center_Group].Auto
DROP TABLE [Data_Center_Group].Escuderia
DROP TABLE [Data_Center_Group].Piloto
DROP TABLE [Data_Center_Group].Neumatico
DROP TABLE [Data_Center_Group].Freno
DROP TABLE [Data_Center_Group].Caja
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
	codigo INT NOT NULL IDENTITY PRIMARY KEY,
	fecha DATE NOT NULL,
	clima NVARCHAR(100) NOT NULL,
	total_carrera DECIMAL(18,2) NOT NULL,
	cantidad_vueltas INT NOT NULL,
	circuito_codigo INT NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Circuito(codigo)
)

CREATE TABLE [Data_Center_Group].Sector (
	codigo INT NOT NULL PRIMARY KEY,
	circuito_codigo INT NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Circuito(codigo),
	tipo NVARCHAR(255)
) 

--- GENERAL: FIN ---

--- TELEMETRIA: INICIO ---

CREATE TABLE [Data_Center_Group].Telemetria (
	codigo DECIMAL(18,0) NOT NULL PRIMARY KEY,
	sector_codigo INT NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Sector(codigo),
	carrera_codigo INT NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Carrera(codigo),
	carrera_distancia DECIMAL(18,6) NOT NULL
) 

CREATE TABLE [Data_Center_Group].TelemetriaVuelta (
	telemetria_codigo DECIMAL(18,0) NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES [Data_Center_Group].Telemetria(codigo),
	numero DECIMAL(18,0) NOT NULL, 
	distancia DECIMAL(18,2) NOT NULL, 
	tiempo DECIMAL(18,10) NOT NULL, 
);

CREATE TABLE [Data_Center_Group].TelemetriaCaja (
	telemetria_codigo DECIMAL(18,0) NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Telemetria(codigo),
	caja_numero_serie NVARCHAR(255) NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Caja(numero_serie),
	temperatura_aceite DECIMAL(18,2) NOT NULL,
	rpm DECIMAL(18,2) NOT NULL,
	desgaste DECIMAL(18,2) NOT NULL,
	CONSTRAINT telemetria_caja_pk PRIMARY KEY (telemetria_codigo, caja_numero_serie)
)

CREATE TABLE [Data_Center_Group].TelemetriaAuto (
	telemetria_codigo DECIMAL(18,0) NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Telemetria(codigo),
	auto_numero INT NOT NULL,
	auto_escuderia_nombre NVARCHAR(255) NOT NULL,
	posicion DECIMAL(18,0) NOT NULL,
	velocidad DECIMAL(18,2) NOT NULL,
	combustible DECIMAL(18,2) NOT NULL,
	FOREIGN KEY (auto_numero, auto_escuderia_nombre) REFERENCES [Data_Center_Group].Auto(numero, escuderia_nombre),
	CONSTRAINT telemetria_auto_pk PRIMARY KEY (telemetria_codigo, auto_numero, auto_escuderia_nombre),
);

CREATE TABLE [Data_Center_Group].TelemetriaMotor (
	telemetria_codigo DECIMAL(18,0) NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Telemetria(codigo),
	motor_numero_serie NVARCHAR(255) NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Motor(numero_serie),
	potencia DECIMAL(18,6) NOT NULL,
	rpm DECIMAL(18,6) NOT NULL,
	temperatura_aceite DECIMAL(18,6) NOT NULL,
	temperatura_agua DECIMAL(18,6) NOT NULL,
	CONSTRAINT telemetria_motor_pk PRIMARY KEY (telemetria_codigo, motor_numero_serie)
);

CREATE TABLE [Data_Center_Group].TelemetriaFreno (
	codigo INT NOT NULL IDENTITY PRIMARY KEY,
	freno_numero_serie NVARCHAR(255) NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Freno(numero_serie),
	grosor_pastilla DECIMAL(18,2) NOT NULL,
	temperatura DECIMAL(18,2) NOT NULL,
);

CREATE TABLE [Data_Center_Group].TelemetriaNeumatico (
	codigo INT NOT NULL IDENTITY PRIMARY KEY,
	telemetria_codigo DECIMAL(18,0) NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Telemetria(codigo),
	telemetria_freno_codigo INT NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].TelemetriaFreno(codigo),
	neumatico_numero_serie NVARCHAR(255) NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Neumatico(numero_serie),
	posicion NVARCHAR(255) NOT NULL,
	presion DECIMAL(18,2) NOT NULL,
	profundidad DECIMAL(18,6) NOT NULL,
	temperatura DECIMAL(18,6) NOT NULL
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
	carrera_codigo INT NOT NULL FOREIGN KEY REFERENCES [Data_Center_Group].Carrera(codigo),
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
	sector_distancia DECIMAL(18,2) NOT NULL
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
EXEC [Data_Center_Group].cargarEscuderias
EXEC [Data_Center_Group].cargarPilotos
EXEC [Data_Center_Group].cargarAutos
EXEC [Data_Center_Group].cargarCajas
EXEC [Data_Center_Group].cargarMotores
EXEC [Data_Center_Group].cargarFrenos

DROP PROCEDURE [Data_Center_Group].cargarEscuderias
DROP PROCEDURE [Data_Center_Group].cargarPilotos
DROP PROCEDURE [Data_Center_Group].cargarAutos
DROP PROCEDURE [Data_Center_Group].cargarCajas
DROP PROCEDURE [Data_Center_Group].cargarMotores
DROP PROCEDURE [Data_Center_Group].cargarFrenos

----------------------------------------------------------
--------------------- FIN MIGRACION ----------------------
----------------------------------------------------------