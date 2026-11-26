CREATE TABLE IF NOT EXISTS libros (
    id SERIAL PRIMARY KEY,
    usuario_id INTEGER NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(255) DEFAULT 'Autor desconocido',
    descripcion TEXT,
    archivo_epub VARCHAR(255) NOT NULL,
    portada VARCHAR(255),
    fecha_importacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS progreso_lectura (
    id SERIAL PRIMARY KEY,
    libro_id INTEGER UNIQUE NOT NULL,
    posicion_cfi TEXT NOT NULL,
    porcentaje NUMERIC(5,2) DEFAULT 0
        CHECK (porcentaje BETWEEN 0 AND 100),
    ultima_lectura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (libro_id)
        REFERENCES libros(id)
        ON DELETE CASCADE
);