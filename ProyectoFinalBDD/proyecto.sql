CREATE TABLE Usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono_movil CHAR(10) NOT NULL,  
    telefono_convencional CHAR(8),     
    email VARCHAR(100) UNIQUE NOT NULL, 
    password VARCHAR(255) NOT NULL ,
    rol ENUM('admin', 'cliente') NOT NULL   
);


CREATE TABLE Administrador (
    idAdministrador INT PRIMARY KEY AUTO_INCREMENT,
    idUsuario INT,
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
);

CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY AUTO_INCREMENT,
    idUsuario INT,
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
);

CREATE TABLE Cancha (
    idCancha INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL, 
    estado ENUM('Disponible', 'Ocupada', 'Mantenimiento') NOT NULL,
    tipo ENUM('6', '7') NOT NULL,    
    idAdministrador INT,
    FOREIGN KEY (idAdministrador) REFERENCES Administrador(idAdministrador)
);

CREATE TABLE Horario (
    idHorario INT PRIMARY KEY AUTO_INCREMENT,
    estadoHorario ENUM('Disponible', 'Ocupado') NOT NULL, 
    rangoHorario_inicio DATETIME NOT NULL,
    rangoHorario_final DATETIME NOT NULL,
    idReserva INT,
    FOREIGN KEY (idReserva) REFERENCES Reserva(idReserva)
);

CREATE TABLE Cancha_Horario (
    idCancha_Horario INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL,             
    hora_inicio TIME NOT NULL,
    hora_final TIME NOT NULL,
    idCancha INT,
    idHorario INT,
    FOREIGN KEY (idCancha) REFERENCES Cancha(idCancha),
    FOREIGN KEY (idHorario) REFERENCES Horario(idHorario)
);

CREATE TABLE Reserva (
    idReserva INT PRIMARY KEY AUTO_INCREMENT,
    fechaUso DATE NOT NULL,
    horaUso TIME NOT NULL,
    comprobanteReserva VARCHAR(50),    
    fechaReserva DATETIME NOT NULL,
    idCliente INT,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Reporte (
    nroReporte INT PRIMARY KEY AUTO_INCREMENT,
    contenido TEXT,                  
    fechaGeneracion DATETIME NOT NULL,
    idUser INT,
    FOREIGN KEY (idUser) REFERENCES Usuario(idUsuario)
);

CREATE TABLE Estadistica (
    nroEstadistica INT PRIMARY KEY AUTO_INCREMENT,
    horarioMasSolicitado TIME,         
    canchaMasSolicitada VARCHAR(50),  
    idReporte INT,
    FOREIGN KEY (idReporte) REFERENCES Reporte(nroReporte)
);

CREATE TABLE Mantenimiento (
    idMantenimiento INT PRIMARY KEY AUTO_INCREMENT,
    fechaMantenimiento DATE NOT NULL,
    descripcion TEXT,               
    estadoCancha ENUM('En Mantenimiento', 'Disponible') NOT NULL, 
    idCancha INT,
    FOREIGN KEY (idCancha) REFERENCES Cancha(idCancha)
);






