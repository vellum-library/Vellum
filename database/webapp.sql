CREATE TABLE IF NOT EXISTS usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS estanterias (
    id SERIAL PRIMARY KEY,
    usuario_id INTEGER NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    imagen VARCHAR(255),
    predeterminada BOOLEAN DEFAULT FALSE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id)
        ON DELETE CASCADE,

    UNIQUE (usuario_id, nombre)
);

CREATE TABLE IF NOT EXISTS estanterias_libros (
    estanteria_id INTEGER NOT NULL,
    libro_id INTEGER NOT NULL,
    fecha_agregado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (estanteria_id, libro_id),

    FOREIGN KEY (estanteria_id)
        REFERENCES estanterias(id)
        ON DELETE CASCADE
);