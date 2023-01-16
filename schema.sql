/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
   id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   name VARCHAR(255),
   date_of_birth DATE,
   escape_attempts INT,
   neutered BOOLEAN,
   weight_kg DECIMAL(10, 2)
);

ALTER TABLE animals
ADD COLUMN species VARCHAR(255) DEFAULT NULL;
