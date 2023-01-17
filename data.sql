/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) 
VALUES ('Agumon', '2020-02-03', 10.23, true, 0);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) 
VALUES ('Gabumon', '2018-11-15', 8.00, true, 2);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) 
VALUES ('Pikachu', '2021-01-07', 15.04, false, 1);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) 
VALUES ('Devimon', '2017-05-12', 11.00, true, 5);

INSERT INTO animals (name, date_of_birth, neutered, escape_attempts, weight_kg,species)
VALUES ('Charmander', '2020-02-08', false, 0, -11, NULL),
       ('Plantmon', '2021-11-15', true, 2, -5.7, NULL),
       ('Squirtle', '1993-04-02', false, 3, -12.13, NULL),
       ('Angemon', '2005-06-12', true, 1, -45, NULL),
       ('Boarmon', '2005-07-06', true, 7, 20.4, NULL),
       ('Blossom', '1998-10-13', true, 3, 17, NULL),
       ('Ditto', '2022-05-14', true, 4, 22, NULL);

INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
       ('Jennifer Orwell', 19),
       ('Bob', 45),
       ('Melody Pond', 77),
       ('Dean Winchester', 14),
       ('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES ('Pokemon'),
       ('Digimon');


UPDATE animals
SET species_id = species.id
FROM species
WHERE species.name = 'Digimon' and animals.name like '%mon';

-- 

UPDATE animals
SET species_id = species.id
FROM species
WHERE species.name = 'Pokemon' and animals.name NOT LIKE '%mon';

--

UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE owners.full_name = 'Sam Smith' and animals.name IN ('Agumon');

UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE owners.full_name = 'Jennifer Orwell' and animals.name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE owners.full_name = 'Bob' and animals.name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE owners.full_name = 'Melody Pond' and animals.name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE owners.full_name = 'Dean Winchester' and animals.name IN ('Angemon', 'Boarmon');