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

CREATE TABLE owners (
   id INTEGER GENERATED ALWAYS AS IDENTITY,
   full_name VARCHAR(255),
   age INTEGER,
   PRIMARY KEY(id)
)

CREATE TABLE species (
  id INTEGER  GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(255),
  PRIMARY KEY(id)
);

-- Modify animals table: ~
-- Make sure that id is set as autoincremented PRIMARY KEY ~
-- Remove column species

ALTER TABLE animals
DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table

ALTER TABLE animals
ADD COLUMN species_id INTEGER REFERENCES species(id);


-- Add column owner_id which is a foreign key referencing the owners table

ALTER TABLE animals
ADD COLUMN owner_id INTEGER REFERENCES owners(id);
