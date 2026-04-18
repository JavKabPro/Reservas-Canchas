INSERT INTO UsuarioDeportivo (nombres, apellidos, documento, telefono, correo,
estadoUsuario)
VALUES
('Carlos', 'Ramirez', '1001', '3001111111', 'carlos.ramirez@mail.com', 'Activo'),
('Luisa', 'Fernandez', '1002', '3002222222', 'luisa.fernandez@mail.com', 'Activo'),
('Andres', 'Gomez', '1003', '3003333333', 'andres.gomez@mail.com', 'Inactivo'),
('Maria', 'Lopez', '1004', '3004444444', 'maria.lopez@mail.com', 'Activo'),
('Jorge', 'Martinez', '1005', '3005555555', 'jorge.martinez@mail.com', 'Activo'),
('Paula', 'Diaz', '1006', '3006666666', 'paula.diaz@mail.com', 'Activo'),
('Felipe', 'Torres', '1007', '3007777777', 'felipe.torres@mail.com', 'Activo'),
('Sandra', 'Moreno', '1008', '3008888888', 'sandra.moreno@mail.com', 'Activo'),
('Diego', 'Castro', '1009', '3009999999', 'diego.castro@mail.com', 'Activo'),
('Valentina', 'Rojas', '1010', '3010000000', 'valentina.rojas@mail.com',
'Inactivo');
GO

SELECT * FROM UsuarioDeportivo

INSERT INTO Cancha (nombre, tipo, ubicacion, estadoCancha)
VALUES
('Cancha Futbol 1', 'Futbol', 'Bloque A', 'Disponible'),
('Cancha Futbol 2', 'Futbol', 'Bloque A', 'Disponible'),
('Cancha Tenis 1', 'Tenis', 'Bloque B', 'Mantenimiento'),
('Cancha Tenis 2', 'Tenis', 'Bloque B', 'Disponible'),
('Cancha Squash 1', 'Squash', 'Bloque C', 'Disponible'),
('Cancha Squash 2', 'Squash', 'Bloque C', 'Mantenimiento'),
('Cancha Voleibol 1', 'Voleibol', 'Bloque D', 'Disponible'),
('Cancha Voleibol 2', 'Voleibol', 'Bloque D', 'Disponible'),
('Cancha Futbol 3', 'Futbol', 'Bloque E', 'Disponible'),
('Cancha Tenis 3', 'Tenis', 'Bloque F', 'Inactiva');
GO

SELECT * FROM Cancha

INSERT INTO Horario (idCancha, fecha, horaInicio, horaFin, disponible)
VALUES
(1, '2026-04-01', '06:00', '07:00', 0),
(2, '2026-04-01', '07:00', '08:00', 0),
(3, '2026-04-01', '08:00', '09:00', 0),
(4, '2026-04-01', '09:00', '10:00', 0),
(5, '2026-04-01', '10:00', '11:00', 0),
(7, '2026-04-01', '11:00', '12:00', 0),
(8, '2026-04-01', '12:00', '13:00', 0),
(9, '2026-04-01', '13:00', '14:00', 0),
(1, '2026-04-02', '14:00', '15:00', 0),
(3, '2026-04-02', '15:00', '16:00', 0);
GO

SELECT * FROM Horario

INSERT INTO Reserva (idUsuario, idHorario, fechaReserva, estadoReserva)
VALUES
(1, 1, '2026-03-27 08:10:00', 'Activa'),
(2, 2, '2026-03-27 08:20:00', 'Activa'),
(3, 3, '2026-03-27 08:30:00', 'Activa'),
(4, 4, '2026-03-27 08:40:00', 'Cancelada'),
(5, 5, '2026-03-27 08:50:00', 'Activa'),
(6, 6, '2026-03-27 09:00:00', 'Cancelada'),
(7, 7, '2026-03-27 09:10:00', 'Activa'),
(8, 8, '2026-03-27 09:20:00', 'Activa'),
(9, 9, '2026-03-27 09:30:00', 'Activa'),
(10, 10, '2026-03-27 09:40:00', 'Finalizada');
GO

SELECT * FROM Reserva

INSERT INTO Pago (idReserva, fechaPago, valor, metodoPago, estadoPago)
VALUES
(1, '2026-03-27 08:11:00', 50000, 'Transferencia', 'Pendiente'),
(2, '2026-03-27 08:21:00', 50000, 'Tarjeta', 'Rechazado'),
(3, '2026-03-27 08:31:00', 40000, 'Nequi', 'Pagado'),
(4, '2026-03-27 08:41:00', 40000, 'Efectivo', 'Pendiente'),
(5, '2026-03-27 08:51:00', 35000, 'Daviplata', 'Pendiente'),
(6, '2026-03-27 09:01:00', 45000, 'Transferencia', 'Pagado'),
(7, '2026-03-27 09:11:00', 45000, 'Tarjeta', 'Rechazado'),
(8, '2026-03-27 09:21:00', 55000, 'Nequi', 'Pagado'),
(9, '2026-03-27 09:31:00', 60000, 'Transferencia', 'Pagado'),
(10, '2026-03-27 09:41:00', 40000, 'Efectivo', 'Pagado');
GO

SELECT * FROM Pago

/*===============================================================================
Se cambiaron algunos datos de las tablas ya que las mayorías permanecían iguales
esto con la intención de que podamos realizar diferentes consultas dependiendo
de la instrucción y/o restricción.
===============================================================================*/