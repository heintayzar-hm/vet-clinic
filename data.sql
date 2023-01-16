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

-- TODO: Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.

-- Start the transaction by using the BEGIN statement

BEGIN;

-- Update the "species" column to "unspecified" using the UPDATE statement:

UPDATE animals SET species = 'unspecified';

-- -- Verify

-- SELECT * FROM animals;

-- ROLLBACK;

-- -- Verify

-- SELECT * FROM animals;

-- Inside a transaction:

BEGIN;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.

UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

-- Commit the transaction.

COMMIT;

-- Verify that change was made and persists after commit.

-- SELECT * FROM animals;

-- Now, take a deep breath and... Inside a transaction 

BEGIN;

-- delete all records in the animals table, 

DELETE FROM animals;

-- then roll back the transaction.

ROLLBACK;

-- After the rollback verify if all records in the animals table still exists. After that, you can start breathing as usual ;)
-- SELECT * FROM animals;


-- Inside a transaction:

BEGIN;

-- Delete all animals born after Jan 1st, 2022.

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

-- Create a savepoint for the transaction.

SAVEPOINT delete_animal_after_Jan_1st_2022;

-- Update all animals' weight to be their weight multiplied by -1.

UPDATE animals SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint

ROLLBACK TO delete_animal_after_Jan_1st_2022;

-- Update all animals' weights that are negative to be their weight multiplied by -1.

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

-- Commit transaction

COMMIT;

-- Write queries to answer the following questions:


-- How many animals are there?

SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?

SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?

SELECT COUNT(CASE WHEN neutered = true THEN 1 ELSE NULL END) as neutered_count,
       COUNT(CASE WHEN neutered = false THEN 1 ELSE NULL END) as not_neutered_count
FROM animals;


-- What is the minimum and maximum weight of each type of animal?

SELECT species, MIN(weight_kg) as min_weight, MAX(weight_kg) as max_weight
FROM animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?

SELECT species, AVG(escape_attempts) as avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;





