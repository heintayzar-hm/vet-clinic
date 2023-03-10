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

-- Insert the following data for vets:
-- Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
-- Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
-- Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
-- Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.


INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23'),
    ('Maisy Smith', 26, '2019-01-17'),
    ('Stephanie Mendez', 64, '1981-05-04'),
    ('Jack Harkness', 38, '2008-06-08');

-- Insert the following data for specialties:
-- Vet William Tatcher is specialized in Pokemon.
-- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
-- Vet Jack Harkness is specialized in Digimon.

INSERT INTO specializations (species_id, vet_id)
VALUES ((SELECT id FROM species WHERE name = 'Pokemon'), (SELECT id FROM vets WHERE name = 'William Tatcher')),
    ((SELECT id FROM species WHERE name = 'Pokemon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
    ((SELECT id FROM species WHERE name = 'Digimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
    ((SELECT id FROM species WHERE name = 'Digimon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'));

-- Insert the following data for visits:
-- Agumon visited William Tatcher on May 24th, 2020.
-- Agumon visited Stephanie Mendez on Jul 22th, 2020.
-- Gabumon visited Jack Harkness on Feb 2nd, 2021.
-- Pikachu visited Maisy Smith on Jan 5th, 2020.
-- Pikachu visited Maisy Smith on Mar 8th, 2020.
-- 5
-- Pikachu visited Maisy Smith on May 14th, 2020.
-- Devimon visited Stephanie Mendez on May 4th, 2021.
-- Charmander visited Jack Harkness on Feb 24th, 2021.
-- Plantmon visited Maisy Smith on Dec 21st, 2019.
-- Plantmon visited William Tatcher on Aug 10th, 2020.
-- 10
-- Plantmon visited Maisy Smith on Apr 7th, 2021.
-- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
-- Angemon visited Jack Harkness on Oct 3rd, 2020.
-- Angemon visited Jack Harkness on Nov 4th, 2020.
-- Boarmon visited Maisy Smith on Jan 24th, 2019.
-- 15
-- Boarmon visited Maisy Smith on May 15th, 2019.
-- Boarmon visited Maisy Smith on Feb 27th, 2020.
-- Boarmon visited Maisy Smith on Aug 3rd, 2020.
-- Blossom visited Stephanie Mendez on May 24th, 2020.
-- Blossom visited William Tatcher on Jan 11th, 2021.
-- 20

INSERT INTO visits (animal_id,vet_id,visit_date)
VALUES 
(
(SELECT id FROM animals WHERE name = 'Agumon'),
(SELECT id FROM vets WHERE name = 'William Tatcher'),
'2020-05-24'
),
(
(SELECT id FROM animals WHERE name = 'Agumon'),
(SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
'2020-07-22'
),
(
(SELECT id FROM animals WHERE name = 'Gabumon'),
(SELECT id FROM vets WHERE name = 'Jack Harkness'),
'2021-02-02'
),
(
(SELECT id FROM animals WHERE name = 'Pikachu'),
(SELECT id FROM vets WHERE name = 'Maisy Smith'),
'2020-01-05'
),
(
(SELECT id FROM animals WHERE name = 'Pikachu'),
(SELECT id FROM vets WHERE name = 'Maisy Smith'),
'2020-03-08'
);
-- 5
INSERT INTO visits (animal_id,vet_id,visit_date)
VALUES
(
(SELECT id FROM animals WHERE name = 'Pikachu'),
(SELECT id FROM vets WHERE name = 'Maisy Smith'),
'2020-05-14'
),
(
(SELECT id FROM animals WHERE name = 'Devimon'),
(SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
'2021-05-04'
),
(
(SELECT id FROM animals WHERE name = 'Charmander'),
(SELECT id FROM vets WHERE name = 'Jack Harkness'),
'2021-02-24'
),
(
(SELECT id FROM animals WHERE name = 'Plantmon'),
(SELECT id FROM vets WHERE name = 'Maisy Smith'),
'2019-12-21'
),
(
(SELECT id FROM animals WHERE name = 'Plantmon'),
(SELECT id FROM vets WHERE name = 'William Tatcher'),
'2020-08-10'
);
-- 10
INSERT INTO visits (animal_id,vet_id,visit_date)
VALUES
(
(SELECT id FROM animals WHERE name = 'Plantmon'), 
(SELECT id FROM vets WHERE name = 'Maisy Smith'), 
'2021-04-07'
),
(
(SELECT id FROM animals WHERE name = 'Squirtle'), 
(SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 
'2019-09-29'
),
(
(SELECT id FROM animals WHERE name = 'Angemon'),
(SELECT id FROM vets WHERE name = 'Jack Harkness'),
'2020-10-03'
),
(
(SELECT id FROM animals WHERE name = 'Angemon'), 
(SELECT id FROM vets WHERE name = 'Jack Harkness'), 
'2020-11-04'
),
(
(SELECT id FROM animals WHERE name = 'Boarmon'), 
(SELECT id FROM vets WHERE name = 'Maisy Smith'), 
'2019-01-24'
);
-- 15
INSERT INTO visits (animal_id,vet_id,visit_date)
VALUES
(
(SELECT id FROM animals WHERE name = 'Boarmon'),
(SELECT id FROM vets WHERE name = 'Maisy Smith'),
'2019-05-15'
),
(
(SELECT id FROM animals WHERE name = 'Boarmon'),
(SELECT id FROM vets WHERE name = 'Maisy Smith'),
'2020-02-27'
),
(
(SELECT id FROM animals WHERE name = 'Boarmon'),
(SELECT id FROM vets WHERE name = 'Maisy Smith'),
'2020-08-03'
),
(
(SELECT id FROM animals WHERE name = 'Blossom'),
(SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
'2020-05-24'
),
(
(SELECT id FROM animals WHERE name = 'Blossom'),
(SELECT id FROM vets WHERE name = 'William Tatcher'),
'2021-01-11'
);
-- 20

-- Looper
-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';






