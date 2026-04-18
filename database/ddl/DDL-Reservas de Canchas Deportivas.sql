/* =========================================
BASE DE DATOS
========================================= */
IF DB_ID('ReservasCanchas') IS NOT NULL
BEGIN
ALTER DATABASE ReservasCanchas SET SINGLE_USER WITH ROLLBACK
IMMEDIATE;
DROP DATABASE ReservasCanchas;
END
GO

CREATE DATABASE ReservasCanchas;
GO

USE ReservasCanchas;
GO

/* =========================================
TABLA: UsuarioDeportivo
========================================= */
CREATE TABLE UsuarioDeportivo(
idUsuario INT IDENTITY(1,1) PRIMARY KEY,
nombres VARCHAR(60) NOT NULL,
apellidos VARCHAR(60) NOT NULL,
documento VARCHAR(20) NOT NULL UNIQUE,
telefono VARCHAR(20) NOT NULL,
correo VARCHAR(100) NOT NULL UNIQUE,
estadoUsuario VARCHAR(15) NOT NULL
CONSTRAINT CK_UsuarioDeportivo_Estado
CHECK (estadoUsuario IN ('Activo', 'Inactivo'))

);
GO
/*=============================================
OBSERVACIÓN:  Se cambia 'estado' por 'estadoUsuario'
para evitar confusiones o ambigüedades
=============================================*/

/* =========================================
TABLA: Cancha
========================================= */
CREATE TABLE Cancha(
idCancha INT IDENTITY(1,1) PRIMARY KEY,
nombre VARCHAR(50) NOT NULL UNIQUE,
tipo VARCHAR(20) NOT NULL
CONSTRAINT CK_Cancha_Tipo
CHECK (tipo IN ('Futbol', 'Tenis', 'Squash', 'Voleibol')),
ubicacion VARCHAR(80) NOT NULL,
estadoCancha VARCHAR(15) NOT NULL
CONSTRAINT CK_Cancha_Estado
CHECK (estadoCancha IN ('Disponible', 'Mantenimiento', 'Inactiva'))
);
GO

/*=============================================
OBSERVACIÓN:  Se cambia 'estado' por 'estadoCancha'
para evitar confusiones o ambigüedades
=============================================*/

/* =========================================
TABLA: Horario
========================================= */
CREATE TABLE Horario(
idHorario INT IDENTITY(1,1) PRIMARY KEY,
idCancha INT NOT NULL,
fecha DATE NOT NULL,

horaInicio TIME NOT NULL,
horaFin TIME NOT NULL,
disponible BIT NOT NULL DEFAULT 1,

CONSTRAINT FK_Horario_Cancha
FOREIGN KEY (idCancha) REFERENCES Cancha(idCancha),

CONSTRAINT CK_Horario_Horas
CHECK (horaInicio < horaFin),

CONSTRAINT UQ_Horario_Cancha_Fecha_Hora
UNIQUE (idCancha, fecha, horaInicio, horaFin)
);
GO

/* =========================================
TABLA: Reserva
========================================= */
CREATE TABLE Reserva(
idReserva INT IDENTITY(1,1) PRIMARY KEY,
idUsuario INT NOT NULL,
idHorario INT NOT NULL,
fechaReserva DATETIME NOT NULL DEFAULT GETDATE(),
estadoReserva VARCHAR(15) NOT NULL
CONSTRAINT CK_Reserva_Estado
CHECK (estadoReserva IN ('Activa', 'Cancelada', 'Finalizada')),

CONSTRAINT FK_Reserva_Usuario
FOREIGN KEY (idUsuario) REFERENCES UsuarioDeportivo(idUsuario),

CONSTRAINT FK_Reserva_Horario
FOREIGN KEY (idHorario) REFERENCES Horario(idHorario),

CONSTRAINT UQ_Reserva_Horario
UNIQUE (idHorario)
);
GO

/*=========================================
OBSERVACIÓN: Reserva – Restricción: 
Cada horario solo puede tener una reserva.
Se cambia 'estado' por 'estadoReerva' para evitar
confusiones o ambigüedades
=========================================*/

/* =========================================
TABLA: Pago
========================================= */
CREATE TABLE Pago(
idPago INT IDENTITY(1,1) PRIMARY KEY,
idReserva INT NOT NULL,
fechaPago DATETIME NOT NULL DEFAULT GETDATE(),
valor DECIMAL(10,2) NOT NULL
CONSTRAINT CK_Pago_Valor CHECK (valor > 0),
metodoPago VARCHAR(20) NOT NULL
CONSTRAINT CK_Pago_Metodo
CHECK (metodoPago IN ('Efectivo', 'Tarjeta', 'Transferencia', 'Nequi', 'Daviplata')),
estadoPago VARCHAR(15) NOT NULL
CONSTRAINT CK_Pago_Estado

CHECK (estadoPago IN ('Pagado', 'Pendiente', 'Rechazado')),

CONSTRAINT FK_Pago_Reserva
FOREIGN KEY (idReserva) REFERENCES Reserva(idReserva),

CONSTRAINT UQ_Pago_Reserva
UNIQUE (idReserva)
);
GO

/*=====================================
OBSERVACIÓN:	Pago – Restricción
Cada reserva solo puede tener un pago.
=====================================*/