-- object: external_reviews | type: SCHEMA --
-- DROP SCHEMA external_reviews CASCADE;
CREATE SCHEMA external_reviews;
-- ddl-end --

-- object: external_reviews.patient_pk_seq | type: SEQUENCE --
-- DROP SEQUENCE external_reviews.patient_pk_seq;
CREATE SEQUENCE external_reviews.patient_pk_seq
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --

-- object: external_reviews.provider_pk_seq | type: SEQUENCE --
-- DROP SEQUENCE stealthis.provider_pk_seq;
CREATE SEQUENCE external_reviews.provider_pk_seq
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --

-- object: external_reviews.insurer_pk_seq | type: SEQUENCE --
-- DROP SEQUENCE stealthis.insurer_pk_seq;
CREATE SEQUENCE external_reviews.insurer_pk_seq
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --

-- object: external_reviews.iro_pk_seq | type: SEQUENCE --
-- DROP SEQUENCE external_reviews.iro_pk_seq;
CREATE SEQUENCE external_reviews.iro_pk_seq
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --

-- Tables --

-- object: external_reviews.patient | type: TABLE --
-- DROP TABLE external_reviews.patient;
CREATE TABLE patient (
patient_id serial NOT NULL PRIMARY KEY,
patient_f_name character(20) NOT NULL,
patient_l_name character(30) NOT NULL,
patient_email varchar(75),
patient_dob date,
patient_address_1 character(30),
patient_address_2 character(20),
patient_zip character(5),
deleted_at timestamp
);
-- ddl-end --


-- object: external_reviews.insurer | type: TABLE --
-- DROP TABLE external_reviews.insurer;
CREATE TABLE insurer (
insurer_id serial NOT NULL PRIMARY KEY,
insurer_name varchar(60) NOT NULL,
insurer_address_1 varchar(30),
insurer_address_2 varchar(20),
insurer_zip varchar(5),
insurer_contact_f_name varchar(20),
insurer_contact_l_name varchar(30),
insurer_phone varchar(14),
insurer_email varchar(40),
deleted_at timestamp
);
-- ddl-end --

-- object: external_reviews.user | type: TABLE --
-- DROP TABLE external_reviews.user;
CREATE TABLE users (
user_id serial NOT NULL PRIMARY KEY,
username varchar(60) NOT NULL,
hash_pass varchar(255) NOT NULL,
token varchar(255),
created_at timestamp,
deleted_at timestamp
);
-- ddl-end --


-- object: external_reviews.provider | type: TABLE --
-- DROP TABLE external_reviews.provider;
CREATE TABLE provider (
provider_id serial NOT NULL PRIMARY KEY,
provider_name varchar(70) NOT NULL,
provider_address_1 varchar(30),
provider_address_2 varchar(20),
provider_zip varchar(5),
provider_contact_f_name varchar(20),
provider_contact_l_name varchar(30),
provider_phone varchar(14),
deleted_at timestamp,
created_by int,
CONSTRAINT fk_provider_created FOREIGN KEY (created_by) REFERENCES users (user_id)
);
-- ddl-end --


-- object: external_reviews.iro | type: TABLE --
-- DROP TABLE external_reviews.iro;
CREATE TABLE iro (
iro_id serial NOT NULL PRIMARY KEY,
iro_name varchar(60) NOT NULL,
iro_address_1 varchar(30),
iro_address_2 varchar(20),
iro_zip varchar(5),
iro_contact_f_name varchar(20),
iro_contact_l_name varchar(30),
iro_email varchar(40),
iro_license_expiration Date,
deleted_at timestamp
);
-- ddl-end --

-- object: external_reviews.patient | type: TABLE --
-- DROP TABLE external_reviews.eligible_case;
CREATE TABLE eligible_case (
eligible_case_id serial NOT NULL PRIMARY KEY,
patient_id int NOT NULL,
insurer_id int NOT NULL,
iro_id int,
provider_id int,
denial_reason varchar(200),
expedited bit,
date_forwarded Date,
eligibility_notice Date,
eligible_correspondence Date,
insurer_notified Date,
decision_date Date,
iro_decision varchar(20),
file_closed Date,
invoice_amount double precision,
deleted_at timestamp,
CONSTRAINT fk_Ins FOREIGN KEY (insurer_id) REFERENCES insurer (insurer_id),
CONSTRAINT fk_iro FOREIGN KEY (iro_id) REFERENCES iro (iro_id),
CONSTRAINT fk_provider FOREIGN KEY (provider_id) REFERENCES provider (provider_id),
CONSTRAINT fk_patient FOREIGN KEY (patient_id) REFERENCES patient (patient_id)
);
-- ddl-end --


-- Populating the Tables -- 
-- patient Table --

INSERT INTO patient (patient_id, patient_f_name, patient_l_name, patient_dob, patient_address_1, patient_address_2, patient_zip)
VALUES 
(1, 'Jim', 'Smith', '1958-02-10', '2244 South 13th St.', NULL, '68106'),
(2, 'Connie', 'June', '1989-01-15', '888 South 17th St.', NULL, '68506'),
(3, 'Ray', 'Bulger', '1999-04-10', '1414 18th St.', NULL, '50308'),
(4, 'Louise', 'Berg', '1977-07-19', '189 North 199th St.', NULL, '68186'),
(5, 'John', 'Queen', '1945-09-03', '2558 North 3rd St.', 'Apt. #44', '68901'),
(6, 'Mike', 'Ryanes', '1988-01-14', '101 17th Ave.', NULL, '68132'),
(7, 'Kevin', 'Jacobsen', '1994-05-16', '2332 South 139th St.', NULL, '68144'),
(8, 'Rob', 'Smallzanski', '2009-01-19', '900 Western Ave.', 'Apt. #3', '68132'),
(9, 'Ryan', 'Kools', '1977-04-16', '231 So. 67th Ave.', NULL, '68114'),
(10, 'Torry', 'Flanders', '1988-08-02', '434 South 173rd St.', NULL, '68186'),
(11, 'Rob', 'Jones', '1998-07-07', '223 Bowling Ln.', NULL, '68847'),
(12, 'Jason', 'Lucas', '1955-09-10', '909 N. Ashland Dr.', NULL, '68640'),
(13, 'Lisa', 'Robinson', '1974-12-02', '2474 South 133rd St.', NULL, '68144'),
(14, 'Paul', 'Barbs', '1990-05-06', '20900 South 63rd St.', NULL, '68132'),
(15, 'Larry', 'Paul', '1993-02-12', '901 Jensen Ave.', NULL, '68850'),
(16, 'Kim', 'Reynolds', '1983-09-02', '1200 North Dolio Blvd.', NULL, '50010')
;

-- insurer Table -- 

INSERT INTO insurer (insurer_id, insurer_name, insurer_address_1, insurer_address_2, insurer_zip, insurer_contact_f_name, insurer_contact_l_name, insurer_phone, insurer_email)
VALUES
(1, 'Blue Cross Blue Shield of Nebraska', '1919 Aksarben Dr.', NULL, '68180', 'Lisa', 'Maple', '402-333-5555', 'bcbs@insurance.com'),
(2, 'Golden Rule', '7440 Woodland Dr.', NULL, '46278', 'Lee', 'Moose', '317-715-7644', 'gr@insurance.com'),
(3, 'Bright Health', 'P.O. Box 16275', NULL, '19612', 'Tim', 'Howdy', '800-237-2767', 'bh@insurance.com'),
(4, 'Cigna', '900 Cottage Grove Rd.', NULL, '06002', 'Jim', 'Howard', '855-626-0721', 'cigna@insurance.com'),
(5, 'Medica', '401 Carlson Parkway', NULL, '55305', 'Howard', 'Cosell', '800-952-3455', 'medica@insurance.com'),
(6, 'United Healthcare', 'P.O. Box 1459', NULL, '55440', 'Kevin', 'Smith', '800-328-5979', 'uhc@insurance.com'),
(7, 'Aetna', '151 Farmington Ave.', NULL, '06156', 'Rebecca', 'James', '800-872-3862', 'aetna@insurance.com'),
(8, 'Coventry Healthcare', '6720-B Rockledge Drive', 'Suite 800', '20817', 'Timmy', 'Green', '301-581-0600', 'ch@insurance.com'),
(9, 'Federated Insurance', '121 East Park Square', NULL, '55060', 'Cosmo', 'Kramer', '507-455-5200', 'fi@insurance.com'),
(10, 'Companion Life', 'PO Box 100102', NULL, '29202', 'Lori', 'Smithers', '803-333-2233', 'cl@insurance.com'),
(11, 'Aspen American Insurance', '175 Capital Blvd.', 'Suite 300', '06067', 'Keith', 'Jones', '877-245-3510', 'aai@insurance.com'),
(12, 'National Health Insurance Company', '2221 E. Lamar Blvd.', 'Suite 960', '76006', 'Raymond', 'Barre', '800-237-1900', 'nhic@insurance.com'),
(13, 'Souther Guaranty Insurance Company', '13600 A ICOT Blvd.', NULL, '33760', 'Stu', 'Gotz', '888-912-4767', 'sgic@insurance.com'),
(14, 'Meritain Health', '300 Corporate Pkwy.', NULL, '14226', 'Jason', 'Leisure', '888-324-5789', 'mh@insurance.com'),
(15, 'Independance American Insurance Company', '485 Madison Ave.', '14th Floor', '10022', 'Ian', 'Reynolds', '212-355-4141', 'iaic@insurance.com')
;


-- provider Table --

INSERT INTO provider (provider_id, provider_name, provider_address_1, provider_address_2, provider_zip, provider_contact_f_name, provider_contact_l_name, provider_phone)
VALUES
(1, 'Neurology Consultants of Nebraska', '4242 Farnam St.', 'Suite 500', '68131', 'Alfons', 'McGillicuddy', '1-402-992-3993'),
(2, 'PRIA Healthcare', '32 City Hall Ave.', NULL, '06790', 'Robert', 'Williams', '1-402-332-3355'),
(3, 'Nebraska Advanced Radiology', '117 N. 32nd Ave.', 'Suite 100', '68131', 'Vincent', 'Gill', '1-402-902-4493'),
(4, 'Center of Dermatology, P.C.', '10110 Nicholas St.', 'Suite 103', '68114', 'Lucille', 'Ostero', '1-402-552-6643'),
(5, 'Capital Foot and Ankle', '5055 A St.', 'Suite 400', '68510', 'Jimmy', 'Stewart', '1-531-223-3453'),
(6, 'Health 360', '2301 0 St.', NULL, '68510', 'Hugh', 'Jackson', '1-531-874-2522'),
(7, 'Chldrens Physicians', '110 N. 175th St.', 'Suite 1000', '68118', 'Jennifer', 'Lopez', '1-402-992-2323'),
(8, 'Boone County Medical Clinic', '1019 South 8th St.', NULL, '68620', 'Rene', 'Descartes', '1-402-222-6644'),
(9, 'Fallbrook Family Health Center', '755 Fallbrook Blvd.', 'Suite 100', '68521', 'Keith', 'Slime', '1-402-333-4423'),
(10, 'Mayo Clinic', '200 First Street SW', NULL, '55905', 'Larry', 'June', '1-531-631-0033'),
(11, 'Childrens Hospital and Medical Center', '8200 Dodge St.', NULL, '68114', 'Lucy', 'Smith', '1-402-434-3555'),
(12, 'Genoa Medical Facilities', 'P.O. Box 310', NULL, '68640', 'Gene', 'Parmesean', '1-402-666-3966'),
(13, 'Nebraska Medicine Heart and Vascular Center', '989510 Nebraska Medical Center', NULL, '68198', 'Gob', 'Bluth', '1-402-776-7776'),
(14, 'CHI Health Kearney', '3219 Central Ave.', 'Suite 110', '68847', 'Michael', 'Bluth', '1-402-776-3785'),
(15, 'Lincoln Orthopaedic Center, P.C.', '6900 A St.', 'Suite 100', '68510', 'Tobias', 'Funke', '1-402-977-3955'),
(16, 'Gastroenterology Specialties', '4545 R St.', NULL, '68503', 'Stan', 'Sitwell', '1-402-955-3493')
;


-- iro Table --

INSERT INTO iro (iro_id, iro_name, iro_address_1, iro_address_2, iro_zip, iro_contact_f_name, iro_contact_l_name, iro_email, iro_license_expiration)
VALUES
(1, 'MCMC Services', '1451 Rockville Pike', 'Suite 440', '20852', 'Arbiter', 'McGillicuddy', 'mcmc@iro.com', '2022-09-09'),
(2, 'Medical Consultants Network', '1301 5th Ave.', 'Suite 2900', '98101', 'Mike', 'Ryan', 'mcn@iro.com', '2022-06-29'),
(3, 'H.H.C Group', '438 N. Frederick Ave.', 'Suite 200A', '20877', 'Juan', 'Wiener', 'hhc@iro.com', '2022-07-11'),
(4, 'MRIoA', '2875 S. Decker Lake Dr.', 'Suite 300', '84119', 'Billy', 'Gil', 'mrioa@iro.com', '2022-06-25'),
(5, 'MET Healthcare Solutions', '2211 W. 34th St.', NULL, '77018', 'Greg', 'Cote', 'met@iro.com', '2022-10-02'),
(6, 'CoreVisory', '4490 W. 12 Mile Rd.', NULL, '48377', 'Chris', 'Cote', 'cv@iro.com', '2022-08-03'),
(7, 'Network Medical Review', '4960 E. State Street', NULL, '61108', 'Roy', 'Bellamy', 'nmr@iro.com', '2023-09-03'),
(8, 'ProPeer Resources', '500 N. Marketplace Dr.', 'Suite 202', '84014', 'Allison', 'Turner', 'ppr@iro.com', '2023-03-30'),
(9, 'National Medical Reviews', '607 Louis Drive', 'Suite C', '18974', 'Mina', 'Kimes', 'Natmr@iro.com', '2021-12-30'),
(10, 'Maximus Federal Services', '3750 Monroe Ave.', 'Suite 705', '14534', 'Willie', 'Thrower', 'mfs@iro.com', '2022-12-12'),
(11, 'Advanced Medical Reviews', '600 Corporate Pointe', 'Suite 300', '90230', 'James', 'Cagney', 'amr@iro.com', '2022-11-24'),
(12, 'Claims Eval', '4980 Rocklin Road', NULL, '95677', 'Tim', 'Jones', 'ce@iro.com', '2022-04-13'),
(13, 'Dane Street', '7111 Fariway Dr.', 'Suite 201', '33418', 'Dan', 'LeBatard', 'ds@iro.com', '2023-01-22'),
(14, 'EdiPhy Advisors', '1500 Urban Center Dr.', 'Suite 325', '35242', 'John', 'Tess', 'epa@iro.com', '2022-04-22'),
(15, 'MES Peer Review Services', '100 Morse St.', NULL, '02062', 'Julie', 'Jones', 'mes@iro.com', '2022-09-03')
;


-- EligibleCases Table --

INSERT INTO eligible_case (eligible_case_id, patient_id, insurer_id, iro_id, provider_id, denial_reason, expedited, date_forwarded, eligibility_notice, eligible_correspondence, insurer_notified, decision_date, iro_decision, file_closed, Invoice_amount)
VALUES
(1, 1, 1, 2, 4, 'Denial of CT Scan', (CAST(1 AS bit)), '2021-02-10', '2021-02-11', '2021-02-11', '2021-02-11', '2021-02-14', 'Overturned', '2021-02-14', 750.00),
(2, 7, 5, 11, 1, 'Denial of Lexapro', (CAST(0 AS bit)), '2021-03-10', '2021-03-10', '2021-03-10', '2021-03-10', '2021-04-10', 'Upheld', '2021-04-10', 250.00),
(3, 1, 12, 7, 12, 'Denial of Mastectomy', (CAST(1 AS bit)), '2021-04-10', '2021-04-10', '2021-04-10', '2021-04-10', '2021-04-12', 'Overturned', '2021-04-12', 250.00),
(4, 4, 1, 15, 13, 'Denial of Arterial Stent', (CAST(1 AS bit)), '2021-02-19', '2021-02-11', '2021-02-11', '2021-02-11', '2021-02-14', 'Overturned', '2021-02-14', 550.00),
(5, 3, 1, 2, 2, 'Denial of Humira', (CAST(0 AS bit)), '2021-02-10', '2021-02-16', '2021-02-11', '2021-02-11', '2021-02-14', 'Overturned', '2021-02-14', 250.00),
(6, 7, 1, 11, 5, 'Denial of Repatha', (CAST(0 AS bit)), '2021-02-10', '2021-02-23', '2021-02-11', '2021-02-11', '2021-02-14', 'Upheld', '2021-02-14', 250.00),
(7, 7, 1, 2, 8, 'Denial of MRI', (CAST(1 AS bit)), '2021-02-10', '2021-03-02', '2021-02-11', '2021-02-11', '2021-02-14', 'Upheld', '2021-02-14', 250.00),
(8, 1, 2, 9, 8, 'Denial of Lumbar Surgery', (CAST(1 AS bit)), '2021-03-13', '2021-03-13', '2021-03-13', '2021-03-13', '2021-03-16', 'Upheld', '2021-03-16', 500.00),
(9, 1, 14, 5, 4, 'Denial of Air Ambulance Transport', (CAST(0 AS bit)), '2021-04-01', '2021-04-01', '2021-04-01', '2021-04-01', NULL, NULL, NULL, NULL),
(10, 5, 9, 1, 10, 'Denial of Repatha', (CAST(0 AS bit)), '2021-04-11', '2021-04-11', '2021-04-11', '2021-04-11', NULL, NULL, NULL, NULL),
(11, 3, 1, 5, 11, 'Denial of PET Scan', (CAST(0 AS bit)), '2021-02-10', '2021-03-09', '2021-02-11', '2021-02-11', '2021-02-14', 'Upheld', '2021-02-14', 250.00),
(12, 10, 1, 7, 7, 'Denial of Discectomy', (CAST(1 AS bit)), '2021-02-10', '2021-02-18', '2021-02-11', '2021-02-11', '2021-02-14', 'Overturned', '2021-02-14', 750.00),
(13, 2, 3, 3, 1, 'Denial of ABA Therapy', (CAST(0 AS bit)), '2021-02-10', '2021-02-16', '2021-02-11', '2021-02-11', '2021-02-14', 'Upheld', '2021-02-14', 250.00),
(14, 2, 1, 2, 2, 'Denial of Sucraid', (CAST(0 AS bit)), '2021-02-10', '2021-02-27', '2021-02-11', '2021-02-11', '2021-02-14', 'Overturned', '2021-02-14', 250.00),
(15, 6, 4, 1, 4, 'Denial of CT Scan', (CAST(0 AS bit)), '2021-02-10', '2021-03-01', '2021-02-11', '2021-02-11', '2021-02-14', 'Overturned', '2021-02-14', 250.00)
;
