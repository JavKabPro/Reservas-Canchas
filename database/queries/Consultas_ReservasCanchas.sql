/*=====================================================================
Insertar y/o actualizar, eliminar (Explique en que momento se
puede realizar inserciones y borrados teniendo en cuenta la
integridad referencial, es decir, las relaciones, las claves primarias
y foráneas)
=====================================================================*/

---------INSERTAR---------------------

IF OBJECT_ID('pa_InsertarUsuario') IS NOT NULL 
    DROP PROC pa_InsertarUsuario;
GO
CREATE PROCEDURE pa_InsertarUsuario
    @nombres VARCHAR(60),
    @apellidos VARCHAR(60),
    @documento VARCHAR(20),
    @telefono VARCHAR(20),
    @correo VARCHAR(100),
    @estadoUsuario VARCHAR(15)
AS
BEGIN
    INSERT INTO UsuarioDeportivo (nombres, apellidos, documento, telefono, correo, estadoUsuario)
    VALUES (@nombres, @apellidos, @documento, @telefono, @correo, @estadoUsuario);
END;
GO

EXEC pa_InsertarUsuario 
    @nombres = 'Juan', 
    @apellidos = 'Perez', 
    @documento = '1011', 
    @telefono = '3011111111', 
    @correo = 'juan.perez@mail.com', 
    @estadoUsuario = 'Activo';

 SELECT * FROM UsuarioDeportivo
--============================================================================================
 IF OBJECT_ID('pa_InsertarCancha') IS NOT NULL 
    DROP PROC pa_InsertarCancha;
GO
CREATE PROCEDURE pa_InsertarCancha
    @nombre VARCHAR(50),
    @tipo VARCHAR(20),
    @ubicacion VARCHAR(80),
    @estadoCancha VARCHAR(15)
AS
BEGIN
    INSERT INTO Cancha (nombre, tipo, ubicacion, estadoCancha)
    VALUES (@nombre, @tipo, @ubicacion, @estadoCancha);
END;
GO

EXEC pa_InsertarCancha 
    @nombre = 'Cancha Futbol 4', 
    @tipo = 'Futbol', 
    @ubicacion = 'Bloque G', 
    @estadoCancha = 'Disponible';

 SELECT * FROM Cancha
--=====================================================================================
IF OBJECT_ID('pa_InsertarHorario') IS NOT NULL 
    DROP PROC pa_InsertarHorario;
GO
CREATE PROCEDURE pa_InsertarHorario
    @idCancha INT,
    @fecha DATE,
    @horaInicio TIME,
    @horaFin TIME,
    @disponible BIT
AS
BEGIN
    INSERT INTO Horario (idCancha, fecha, horaInicio, horaFin, disponible)
    VALUES (@idCancha, @fecha, @horaInicio, @horaFin, @disponible);
END;
GO

EXEC pa_InsertarHorario 
    @idCancha = 11, 
    @fecha = '2026-04-20', 
    @horaInicio = '08:00', 
    @horaFin = '09:00', 
    @disponible = 1;

 SELECT * FROM Horario
 /*======================================================================================*/

 IF OBJECT_ID('pa_InsertarReserva') IS NOT NULL 
    DROP PROC pa_InsertarReserva;
GO
CREATE PROCEDURE pa_InsertarReserva
    @idUsuario INT,
    @idHorario INT,
    @fechaReserva DATETIME,
    @estadoReserva VARCHAR(15)
AS
BEGIN
    INSERT INTO Reserva (idUsuario, idHorario, fechaReserva, estadoReserva)
    VALUES (@idUsuario, @idHorario, @fechaReserva, @estadoReserva);
END;
GO

EXEC pa_InsertarReserva 
    @idUsuario = 11, 
    @idHorario = 11, 
    @fechaReserva = '2026-04-20 08:05:00', 
    @estadoReserva = 'Activa';

 SELECT * FROM Reserva

 ---------------------------------------------------------------------------------------------

 IF OBJECT_ID('pa_InsertarPago') IS NOT NULL 
    DROP PROC pa_InsertarPago;
GO
CREATE PROCEDURE pa_InsertarPago
    @idReserva INT,
    @fechaPago DATETIME,
    @valor DECIMAL(10,2),
    @metodoPago VARCHAR(20),
    @estadoPago VARCHAR(15)
AS
BEGIN
    INSERT INTO Pago (idReserva, fechaPago, valor, metodoPago, estadoPago)
    VALUES (@idReserva, @fechaPago, @valor, @metodoPago, @estadoPago);
END;
GO

EXEC pa_InsertarPago 
    @idReserva = 11, 
    @fechaPago = '2026-04-20 08:10:00', 
    @valor = 50000, 
    @metodoPago = 'Transferencia', 
    @estadoPago = 'Pagado';
 SELECT * FROM Pago

-------ACTUALIZAR----------------
CREATE PROCEDURE pa_ActualizarUsuario
    @idUsuario INT,
    @telefono VARCHAR(20),
    @correo VARCHAR(100),
    @estadoUsuario VARCHAR(15)
AS
BEGIN
    UPDATE UsuarioDeportivo
    SET telefono = @telefono,
        correo = @correo,
        estadoUsuario = @estadoUsuario
    WHERE idUsuario = @idUsuario;
END;

EXEC pa_ActualizarUsuario 
    @idUsuario = 1, 
    @telefono = '3001234567', 
    @correo = 'carlos.ramirez@nuevo.com', 
    @estadoUsuario = 'Activo';

 SELECT * FROM UsuarioDeportivo
------------------------------------------------

IF OBJECT_ID('pa_ActualizarCancha') IS NOT NULL 
   DROP PROC pa_ActualizarCancha;
GO

CREATE PROCEDURE pa_ActualizarCancha
    @idCancha INT,
    @estadoCancha VARCHAR(15),
    @ubicacion VARCHAR(80)
AS
BEGIN
    UPDATE Cancha
    SET estadoCancha = @estadoCancha,
        ubicacion = @ubicacion
    WHERE idCancha = @idCancha;
END;

EXEC pa_ActualizarCancha 
    @idCancha = 2, 
    @estadoCancha = 'Mantenimiento', 
    @ubicacion = 'Bloque Z';

 SELECT * FROM Cancha
 -----------------------------------------
IF OBJECT_ID('pa_ActualizarHorario') IS NOT NULL 
   DROP PROC pa_ActualizarHorario;
GO

 CREATE PROCEDURE pa_ActualizarHorario
    @idHorario INT,
    @horaInicio TIME,
    @horaFin TIME,
    @disponible BIT
AS
BEGIN
    UPDATE Horario
    SET horaInicio = @horaInicio,
        horaFin = @horaFin,
        disponible = @disponible
    WHERE idHorario = @idHorario;
END;

EXEC pa_ActualizarHorario 
    @idHorario = 3, 
    @horaInicio = '09:00', 
    @horaFin = '10:00', 
    @disponible = 1;

    
 SELECT * FROM Horario
--------------------------------------------
IF OBJECT_ID('pa_ActualizarReserva') IS NOT NULL 
   DROP PROC pa_ActualizarReserva;
GO

CREATE PROCEDURE pa_ActualizarReserva
    @idReserva INT,
    @estadoReserva VARCHAR(15)
AS
BEGIN
    UPDATE Reserva
    SET estadoReserva = @estadoReserva
    WHERE idReserva = @idReserva;
END;

EXEC pa_ActualizarReserva 
    @idReserva = 5, 
    @estadoReserva = 'Finalizada';

 SELECT * FROM Reserva
--------------------------------------------------
IF OBJECT_ID('pa_ActualizarPago') IS NOT NULL 
   DROP PROC pa_ActualizarPago;
GO

CREATE PROCEDURE pa_ActualizarPago
    @idPago INT,
    @estadoPago VARCHAR(15),
    @metodoPago VARCHAR(20)
AS
BEGIN
    UPDATE Pago
    SET estadoPago = @estadoPago,
        metodoPago = @metodoPago
    WHERE idPago = @idPago;
END;

EXEC pa_ActualizarPago 
    @idPago = 2, 
    @estadoPago = 'Pagado', 
    @metodoPago = 'Transferencia';
 SELECT * FROM Pago

------------------------------------
---ELIMINAR--------------------------
IF OBJECT_ID('pa_EliminarPago') IS NOT NULL 
   DROP PROC pa_EliminarPago;
GO

CREATE PROCEDURE pa_EliminarPago
    @idPago INT
AS
BEGIN
    DELETE FROM Pago
    WHERE idPago = @idPago;
END;

EXEC pa_EliminarPago @idPago = 3;

 SELECT * FROM Pago
---------------------------------------------------
IF OBJECT_ID('pa_EliminarReserva') IS NOT NULL 
   DROP PROC pa_EliminarReserva;
GO

 CREATE PROCEDURE pa_EliminarReserva
    @idReserva INT
AS
BEGIN
    DELETE FROM Reserva
    WHERE idReserva = @idReserva;
END;


EXEC pa_EliminarReserva @idReserva = 3;

 SELECT * FROM Reserva
---------------------------------------------

IF OBJECT_ID('pa_EliminarHorario') IS NOT NULL 
   DROP PROC pa_EliminarHorario;
GO

 CREATE PROCEDURE pa_EliminarHorario
    @idHorario INT
AS
BEGIN
    DELETE FROM Horario
    WHERE idHorario = @idHorario;
END;

EXEC pa_EliminarHorario @idHorario = 3;
SELECT * FROM Horario
----------------------------------------------------------

CREATE PROCEDURE pa_EliminarCancha
    @idCancha INT
AS
BEGIN
    DELETE FROM Cancha
    WHERE idCancha = @idCancha;
END;

EXEC pa_EliminarCancha @idCancha = 6;
 SELECT * FROM Cancha
-----------------------------------------------------------
IF OBJECT_ID('pa_EliminarUsuario') IS NOT NULL 
   DROP PROC pa_EliminarUsuario;
GO

CREATE PROCEDURE pa_EliminarUsuario -- Esta funcion elimina usuarios
    @idUsuario INT
AS
BEGIN
    DELETE FROM UsuarioDeportivo
    WHERE idUsuario = @idUsuario;
END;

EXEC pa_EliminarUsuario @idUsuario = 3;
SELECT * FROM UsuarioDeportivo

/*=========================================================
Una consulta con inner join y otra tipo resumen (group by y
having
=========================================================*/

/*==============================================================================================================
En esta consulta ver el detalle de las reservas, uniendo la información del usuario, 
la cancha y el horario ocupado. 
Objetivo: Mostrar el nombre completo del usuario, el nombre de la cancha reservada, la fecha y la hora de inicio.
===============================================================================================================*/

SELECT U.nombres + ' '  + U.apellidos AS Usuario,
       C.nombre AS Canchas,
       H.fecha AS Fecha,
       H.horainicio AS [Hora Inicio]
       FROM Reserva R
       INNER JOIN UsuarioDeportivo U ON R.idUsuario = U.idUsuario
       INNER JOIN Horario H ON R.idHorario = H.idHorario
       INNER JOIN Cancha C ON H.idCancha = C.idCancha;
                                                    

/*=============================================================
 Objetivo: Contar cuántos tipos de reservas tiene cada usuario, 
 pero solo mostrar a aquellos que tengan cierto tipo de reserva.
 ============================================================*/

 SELECT  U.nombres AS Nombres,
         COUNT(R.idReserva) AS [Total Reservas Canceladas]
         FROM UsuarioDeportivo U
         INNER JOIN Reserva R ON U.idUsuario = R.idUsuario
         WHERE R.estadoReserva = 'Cancelada'
         GROUP BY U.nombres
         HAVING COUNT(R.idReserva) = 1; 



/*==============================================================
 Consultas con varias tablas mínimo 2 (inner join) y de resumen
estás también con mínimo dos tablas (group by y having) deben
tener su respectivo enunciado
==============================================================*/
------------------------------------------------------------------
-- Obtener un listado detallado de las reservas que incluya el ---
-- nombre completo del usuario, el nombre de la cancha reservada,- 
-- el tipo de deporte y la fecha del horario solicitado.".      --
------------------------------------------------------------------

SELECT 
    U.nombres + ' ' + U.apellidos AS Nombre_Usuario, 
    C.nombre AS NombreCancha, 
    C.tipo AS Deporte,
    H.fecha AS FechaEncuentro
FROM Reserva R
INNER JOIN UsuarioDeportivo U ON R.idUsuario = U.idUsuario  -- Une reserva con la persona
INNER JOIN Horario H ON R.idHorario = H.idHorario           -- Une reserva con el bloque de tiempo
INNER JOIN Cancha C ON H.idCancha = C.idCancha;             -- Une el horario con el nombre de la cancha

-------------------------------------------------------------------------------------
-- Generar un resumen estadístico que muestre los diferentes tipos de              --
-- deportes (Fútbol, Tenis, etc.) y la cantidad total de reservas  confirmadas     --  
-- para cada uno, filtrando el reporte para mostrar únicamente aquellas categorías --
-- que han tenido una demanda superior a una reserva                               --
-------------------------------------------------------------------------------------

SELECT 
    C.tipo AS [Tipo de Deporte], 
    COUNT(R.idReserva) AS [Total de Reservas]
FROM Reserva R                                          -- Partimos de la tabla (Reserva)
INNER JOIN Horario H ON R.idHorario = H.idHorario       -- Unimos con Horario 
INNER JOIN Cancha C ON H.idCancha = C.idCancha          -- Unimos con Cancha 
GROUP BY C.tipo                                         -- Agrupamos por el nombre del tipo de deporte
HAVING COUNT(R.idReserva) <=2 ;                         -- Aplicamos HAVING 

/*===========================================================================
Realizar un procedimiento almacenado, que tenga parámetros, que busque un
elemento en una tabla, si lo encuentra que lo devuelva, sino lo encuentre que
devuelva un mensaje indicándolo, el stored procedure debe tener consultas de
mas de una tabla y el procedimiento debe tener explicado en un comentario que
es lo que hace.
===========================================================================*/
IF OBJECT_ID('pa_ConsultarDetalleReservaUsuario') IS NOT NULL 
    DROP PROCEDURE pa_ConsultarDetalleReservaUsuario;
GO

CREATE PROCEDURE pa_ConsultarDetalleReservaUsuario
    @documentoBusqueda VARCHAR(20)                      -- Parámetro para buscar al usuario por su documento
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM UsuarioDeportivo U 
        INNER JOIN Reserva R ON U.idUsuario = R.idUsuario 
        WHERE U.documento = @documentoBusqueda
    )
    BEGIN
        SELECT                                          -- Consulta de más de una tabla 
            U.nombres + ' ' + U.apellidos AS [Nombre del Deportista],
            C.nombre AS [Cancha Reservada],
            C.tipo AS [Deporte],
            H.fecha AS [Fecha del Encuentro],
            R.estadoReserva AS [Estado de la Reserva]
        FROM UsuarioDeportivo U
        INNER JOIN Reserva R ON U.idUsuario = R.idUsuario
        INNER JOIN Horario H ON R.idHorario = H.idHorario
        INNER JOIN Cancha C ON H.idCancha = C.idCancha
        WHERE U.documento = @documentoBusqueda;
    END
    ELSE
    BEGIN
        SELECT 'No se encontraron reservas activas o registradas para el usuario con documento: ' + @documentoBusqueda AS Mensaje;
    END
END;
GO

EXEC pa_ConsultarDetalleReservaUsuario '1001'

EXEC pa_ConsultarDetalleReservaUsuario '9999';

/*================================================================================================
Este procedimiento tiene como objetivo buscar y devolver el listado detallado de reservas 
asociadas a un usuario específico mediante su número de documento. 
Realiza una consulta que une las tablas UsuarioDeportivo, Reserva, Horario y Cancha.
Si el usuario tiene reservas, devuelve el detalle; de lo contrario, muestra un mensaje indicándolo.
=================================================================================================*/

/*========================================================
Construya 2 funciones con parámetros. dentro de la función 
debe tener instrucciones sql con mas de una tabla y debe 
tener en comentarios de lo que hace la función, la consulta 
debe realizarse desde 0.
==========================================================*/

-- Función: fdu_TotalPagadoPorUsuario
-- Esta función calcula el monto acumulado de todos los pagos 
-- realizados por un deportista específico utilizando su número de documento.
-- Verificar y eliminar si ya existe (buena práctica)

IF OBJECT_ID ('fdu_TotalPagadoPorUsuario') IS NOT NULL
    DROP FUNCTION fdu_TotalPagadoPorUsuario;
GO
CREATE FUNCTION fdu_TotalPagadoPorUsuario (@documento VARCHAR(20))
RETURNS DECIMAL (10,2)
AS
BEGIN 
    DECLARE @montoTotal DECIMAL(10,2);
    SELECT @montoTotal = SUM(P.valor)
    FROM Pago P
    INNER JOIN Reserva R ON  P.idReserva = R.idReserva
    INNER JOIN UsuarioDeportivo U ON R.idUsuario = U.idUsuario
    WHERE U.documento = DOCUMENTO;

    RETURN ISNULL(@montoTotal, 0);
    END;
    GO

    SELECT dbo.fdu_TotalPagadoPorUsuario ('1004') AS [Total Pagado];

/*==========================================================================
Esta función tiene como objetivo obtener el recaudo total de dinero 
generado por un usuario. Para ello, realiza un INNER JOIN entre las 
tablas Pago, Reserva y UsuarioDeportivo, filtrando por el documento. 
Esto permite conectar el dinero recaudado con el titular de la reserva.
==========================================================================*/


-------------------------------------------------------------------------------- 
-- Función: fdu_ContarReservasPorDeporte
-- Esta función devuelve la cantidad total de reservas que se han realizado para 
-- una categoría de deporte específica (ej. 'Futbol', 'Tenis'), permitiendo medir la demanda por disciplina.

IF OBJECT_ID('fdu_ContarReservaPorDeporte') IS NOT NULL
    DROP FUNCTION fdu_ContarReservaPorDeporte;
GO

CREATE FUNCTION fdu_ContarReservaPorDeporte (@tipoDeporte VARCHAR(20))
RETURNS INT
AS BEGIN
    DECLARE @totalReservas INT
    SELECT @totalReservas = COUNT(R.idReserva)
    FROM Reserva R
    INNER JOIN Horario H ON R.idHorario = H.idHorario
    INNER JOIN Cancha C ON H.idCancha = C.idCancha
    WHERE C.Tipo  = @tipoDeporte;
    RETURN ISNULL (@totalReservas, 0);
    END;
GO

SELECT  dbo.fdu_ContarReservaPorDeporte('Squash') AS [CAntidad de Reservas]

/*=======================================================================
Esta función calcula cuántas reservas se han registrado para un deporte 
específico. Para lograrlo, une tres tablas: Reserva (movimiento), 
Horario (puente) y Cancha (donde está el tipo de deporte). 
Se utiliza para análisis estadístico de uso de las instalaciones.    
========================================================================*/


/*=============================================================
Un trigger y en los comentarios debe indicar que es lo que hace
=============================================================*/

-- Encrear un Trigger de Auditoría para la tabla Cancha. Cada vez
-- que se registre una nueva cancha, el sistema guardará automáticamente 
-- un rastro de esa acción en una tabla secundaria.

-- Creamos una tabla sencilla para guardar el rastro de movimientos
CREATE TABLE AuditoriaAcciones(
    idLog INT IDENTITY(1,1) PRIMARY KEY,
    idRegistro INT,
    tablaAfectada VARCHAR(50),
    mensaje VARCHAR(100),
    fechaAccion DATETIME DEFAULT GETDATE()
);
GO

-- Verificación.
IF OBJECT_ID('tr_AuditoriaCanchaInsert') IS NOT NULL 
    DROP TRIGGER tr_AuditoriaCanchaInsert;
GO

-- Creación del trigger similar a la de funcion
CREATE TRIGGER tr_AuditoriaCanchaInsert
ON Cancha
AFTER INSERT
AS
BEGIN
    INSERT INTO AuditoriaAcciones (idRegistro, tablaAfectada, mensaje)
    SELECT idCancha, 'Cancha', 'Se ha registrado una nueva cancha deportiva'
    FROM inserted;
END;
GO

SELECT * FROM AuditoriaAcciones;

INSERT INTO Cancha (nombre, tipo, ubicacion, estadoCancha) VALUES ('Cancha VIP', 'Tenis', 'Zona Norte', 'Disponible')

SELECT * FROM AuditoriaAcciones;
/* ============================================================================
Este disparador tiene un fin de auditoría. Se ejecuta automáticamente 
después de que se inserta una nueva cancha. Obtiene el 'idCancha' desde 
la tabla virtual 'inserted' y registra el evento en la tabla 'AuditoriaAcciones' 
con la fecha y hora exacta del sistema.
==============================================================================*/

SELECT * FROM Cancha