DROP DATABASE IF EXISTS pfe;
CREATE DATABASE pfe;

\c pfe;

create type sexe as enum('F', 'M');
create type pathologie as enum( 'parkinson', 'fracture');
create type service as enum('pediatrie', 'hematologie', 'interne', 'neurologie', 'psychiatrie', 'radiologie', 'rhumatologie');
create type specialite as enum( 'chirurgie', 'pediatrie', 'hematologie', 'interne', 'neurologie', 'psychiatrie', 'radiologie', 'rhumatologie');
create type label as enum('pied', 'genou', 'cuisse', 'mollet', 'bassin', 'dos');
create type type_capteur as enum ('accelerometre', 'gyroscope');

create table medecins (
	id_medecin serial primary key,
	nom varchar(80),
	prenom varchar(80),
	service service,
	specialite specialite
);

create table patients (
	id_patient serial primary key,
	nom varchar(80),
	prenom varchar(80),
	sexe sexe,
	naissance date,
	pathologie pathologie
);

create table suivis (
	id_suivi serial primary key,
	id_medecin int references medecins,
	id_patient int references patients,
	debut_traitement date,
	fin_traitement date
);

create table mesures (
	id_mesure serial primary key,
	id_suivi int references suivis,
	debut_acquisition timestamp,
	fin_acquisition timestamp
);

create table placements (
	id_placement serial primary key,
	label label
);

create table capteurs (
	id_capteur serial primary key,
	type type_capteur,
	adresse_physique int
);

create table deploiements (
	id_deploiement serial primary key,
	id_capteur int references capteurs,
	id_placement int references placements,
	id_mesure int references mesures,
	frequence int
);

create table donnees (
	id_deploiement int references deploiements,
	temps time,
	x float,
	y float,
	z float
);


insert into patients (nom,prenom,sexe,naissance, pathologie) values ('Soule', 'Clothilde', 'F', '23-1-1994', 'parkinson');
insert into patients (nom,prenom,sexe,naissance, pathologie) values ('Flores', 'Thelma', 'F', '28-2-1994', 'parkinson');
insert into medecins (nom,prenom,service,specialite) values ('Dussac', 'Cecile', 'pediatrie', 'chirurgie');
insert into suivis (id_medecin,id_patient,debut_traitement,fin_traitement) values (1,2, '2-2-2015', '1-1-2016');
insert into mesures (id_suivi, debut_acquisition, fin_acquisition) values (1, '2016-2-2 10:24:55', '2016-2-2 10:43:22');
insert into placements (label) values ('pied');
insert into placements (label) values ('genou');
insert into placements (label) values ('cuisse');
insert into capteurs (type, adresse_physique) values ('accelerometre', '12345');
insert into capteurs (type, adresse_physique) values ('gyroscope', '1244345');
insert into deploiements (id_capteur, id_placement, id_mesure, frequence) values (2,2,1,50);
insert into deploiements (id_capteur, id_placement, id_mesure, frequence) values (1,2,1,50);
insert into donnees values (1, '2:10:3',12.6,14.95,33.5);
insert into donnees values (1, '2:10:4',52.6,14.55,43.5);
insert into donnees values (1, '2:10:5',52.4,44.55,42.5);