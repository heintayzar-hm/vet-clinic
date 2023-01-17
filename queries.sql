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



-- Write queries to answer the following:
-- Who was the last animal seen by William Tatcher?
SELECT animals.name as the_last_animal_seen_by_William_Tatcher
FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.visit_date DESC
LIMIT 1
;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT visits.animal_id) as different_animals_did_Stephanie_Mendez
 FROM visits
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez'
;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name all_vets_and_their_specialties_including_vets_with_no_spec
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON species.id = specializations.species_id
;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name as all_animals_that_visit_Stephanie_Mendez_between_April_1st_and_August_30th_2020
FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez' and (visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30')
;

-- What animal has the most visits to vets?
SELECT animals.name as the_most_visits_to_vets
FROM animals
JOIN visits ON visits.animal_id = animals.id
GROUP BY visits.animal_id, animals.name
ORDER BY COUNT(visits.animal_id) DESC
LIMIT 1
;

-- Who was Maisy Smith's first visit?
SELECT animals.name as mary_first_visit
FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.visit_date ASC 
LIMIT 1
;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name as animal_information, vets.name as vet_information, visits.visit_date as date_of_visit
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
ORDER BY visits.visit_date DESC
LIMIT 1
;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(visits.id) as the_visits_that_vet_get_without_specialize
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
LEFT JOIN specializations ON specializations.species_id = animals.species_id AND specializations.vet_id = vets.id
WHERE specializations.species_id IS NULL
;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name as the_best_speciality
FROM vets
JOIN visits ON visits.vet_id = vets.id
JOIN animals ON animals.id = visits.animal_id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name, species.id
ORDER BY COUNT(species.name) DESC
LIMIT 1
;