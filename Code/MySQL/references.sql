show databases

CREATE DATABASE MelbDatathon2017
USE MelbDatathon2017


----------------------------
-- PATIENTS
----------------------------

CREATE TABLE patients
(
	Patient_ID	int
,	gender	varchar(1)
,	year_of_birth	smallint
,	postcode	varchar(4) 
)


LOAD DATA LOCAL INFILE '/Volumes/JetDrive/Root/Datasets/Datathon/Lookups/patients.txt'
INTO TABLE patients
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;



----------------------------
-- STORES
----------------------------

CREATE TABLE stores
(
	Store_ID	smallint
,	StateCode	varchar(3)
,	postcode	varchar(4)
,	IsBannerGroup	smallint
)


LOAD DATA LOCAL INFILE '/Volumes/JetDrive/Root/Datasets/Datathon/Lookups/stores.txt'
INTO TABLE stores
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
----------------------------
-- DRUGS
----------------------------

CREATE TABLE Drug_LookUp
(
	MasterProductID	smallint
,	MasterProductCode	varchar(9)
,	MasterProductFullName	varchar(61)
,	BrandName	varchar(30)
,	FormCode	varchar(10)
,	StrengthCode	varchar(21)
,	PackSizeNumber	smallint
,	GenericIngredientName	varchar(30)
,	EthicalSubCategoryName	varchar(21)
,	EthicalCategoryName	varchar(16)
,	ManufacturerCode	varchar(9)
,	ManufacturerName	varchar(27)
,	ManufacturerGroupID	smallint
,	ManufacturerGroupCode	varchar(43)
,	ChemistListPrice	float
,	ATCLevel5Code	varchar(7)
,	ATCLevel4Code	varchar(5)
,	ATCLevel3Code	varchar(4)
,	ATCLevel2Code	varchar(3)
,	ATCLevel1Code	varchar(2)
)

LOAD DATA LOCAL INFILE '/Volumes/JetDrive/Root/Datasets/Datathon/Lookups/Drug_LookUp.txt'
INTO TABLE Drug_LookUp
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;



----------------------------
-- CHRONIC ILLNESS
----------------------------

CREATE TABLE ChronicIllness_LookUp
(
	ChronicIllness	varchar(44)
,	MasterProductID	smallint
,	MasterProductFullName	varchar(59)
)

LOAD DATA LOCAL INFILE '/Volumes/JetDrive/Root/Datasets/Datathon/Lookups/ChronicIllness_LookUp.txt'
INTO TABLE ChronicIllness_LookUp
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;




----------------------------
-- ATC
----------------------------

CREATE TABLE ATC_LookUp
(
	ATCLevel1Code	varchar(2)
,	ATCLevel1Name	varchar(63)
,	ATCLevel2Code	varchar(3)
,	ATCLevel2Name	varchar(64)
,	ATCLevel3Code	varchar(4)
,	ATCLevel3Name	varchar(71)
,	ATCLevel4Code	varchar(5)
,	ATCLevel4Name	varchar(92)
,	ATCLevel5Code	varchar(7)
,	ATCLevel5Name	varchar(78)
)


LOAD DATA LOCAL INFILE '/Volumes/JetDrive/Root/Datasets/Datathon/Lookups/ATC_LookUp.txt'
INTO TABLE ATC_LookUp
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
