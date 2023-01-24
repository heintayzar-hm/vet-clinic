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

CREATE TABLE vets (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    age INTEGER,
    date_of_graduation DATE,
    PRIMARY KEY (id)
);

CREATE TABLE specializations (
    id SERIAL PRIMARY KEY,
    species_id INTEGER REFERENCES species(id) ON DELETE CASCADE ON UPDATE CASCADE,
    vet_id INTEGER REFERENCES vets(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    animal_id INTEGER REFERENCES animals(id) ON DELETE CASCADE ON UPDATE CASCADE,
    vet_id INTEGER REFERENCES vets(id) ON DELETE CASCADE ON UPDATE CASCADE,
    visit_date DATE NOT NULL
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- create index on visits(animal_id) in ascending order;
CREATE INDEX animal_id_index ON visits (animal_id);

-- create index on visits(vet_id) in ascending order;
CREATE INDEX vet_id_index ON visits (vet_id);

-- create index on visits(email) in ascending order;
CREATE INDEX owners_email_index ON owners(email);