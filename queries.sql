/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = true;

SELECT * FROM animals WHERE name != 'Gabumon';

SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


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


-- Write queries (using JOIN) to answer the following questions:
-- What animals belong to Melody Pond?

SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).

SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.

SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON animals.owner_id = owners.id;

-- How many animals are there per species?

SELECT species.name, COUNT(animals.species_id) as number_of_animals
FROM species
LEFT JOIN animals
ON species.id = animals.species_id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.

SELECT animals.name 
FROM animals
JOIN owners ON owners.id = animals.owner_id
JOIN species ON species.id = animals.species_id
WHERE owners.full_name = 'Jennifer Orwell' and species.name = 'Digimon';
-- List all animals owned by Dean Winchester that haven't tried to escape.

SELECT animals.name 
FROM animals
JOIN owners ON owners.id = animals.owner_id
WHERE owners.full_name = 'Dean Winchester' and animals.escape_attempts = 0;
-- Who owns the most animals?

SELECT owners.full_name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.id
ORDER BY COUNT(animals.id) DESC
LIMIT 1;
