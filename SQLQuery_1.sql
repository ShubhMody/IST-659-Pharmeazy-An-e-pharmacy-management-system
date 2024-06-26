drop DATABASE if exists pharmeazy;
GO

create database pharmeazy;

-- DOWN script

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_users_user_appointment_id')
    ALTER TABLE users DROP CONSTRAINT fk_users_user_appointment_id;
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_drugs_drug_expire_barcode')
    ALTER TABLE drugs DROP CONSTRAINT fk_drugs_drug_expire_barcode;
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_appointment_histories_appointment_history_id')
    ALTER TABLE appointment_histories DROP CONSTRAINT fk_appointment_histories_appointment_history_id;
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_appointments_appointment_city_id')
    ALTER TABLE appointments DROP CONSTRAINT fk_appointments_appointment_city_id;
GO
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_appointments_doctor_appointment_id')
    ALTER TABLE appointments DROP CONSTRAINT fk_appointments_doctor_appointment_id;
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_NAME = 'fk_purchases_purchase_user_id')
ALTER TABLE purchases DROP CONSTRAINT fk_purchases_purchase_user_id;
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_NAME = 'fk_prescription_doctor_id')
    ALTER TABLE prescriptions DROP CONSTRAINT fk_prescription_doctor_id;
GO

-- IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
-- WHERE CONSTRAINT_NAME = 'fk_cities_city_appointment_id')
-- ALTER TABLE cities DROP CONSTRAINT fk_cities_city_appointment_id;

----soft deletion of brdige table forien keysGO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_NAME = 'fk1_drugs_companies_drug_id')
ALTER TABLE drugs_companies DROP CONSTRAINT fk1_drugs_companies_drug_id;
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_NAME = 'fk2_drugs_companies_company_id')
ALTER TABLE drugs_companies DROP CONSTRAINT fk2_drugs_companies_company_id;
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_NAME = 'fk1_companies_users_company_id')
ALTER TABLE companies_users DROP CONSTRAINT fk1_companies_users_company_id;
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_NAME = 'fk2_companies_users_user_id')
ALTER TABLE companies_users DROP CONSTRAINT fk2_companies_users_user_id;
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_NAME = 'fk1_drugs_sales_drug_id')
ALTER TABLE drugs_sales DROP CONSTRAINT fk1_drugs_sales_drug_id;
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_NAME = 'fk2_drugs_sales_sale_id')
ALTER TABLE drugs_sales DROP CONSTRAINT fk2_drugs_sales_sale_id;
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_NAME = 'fk1_users_insurances_user_id')
ALTER TABLE users_insurances DROP CONSTRAINT fk1_users_insurances_user_id ;
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_NAME = 'fk2_users_insurances_insurance_number')
ALTER TABLE users_insurances DROP CONSTRAINT fk2_users_insurances_insurance_number;


GO

DROP TABLE IF EXISTS users;
GO

DROP TABLE IF EXISTS companies;
GO

DROP TABLE IF EXISTS drugs;
GO

DROP TABLE IF EXISTS expires;
GO

DROP TABLE IF EXISTS sales;
GO

DROP TABLE IF EXISTS drugs_sales;
GO

DROP TABLE IF EXISTS cities;
GO

DROP TABLE IF EXISTS insurances;
GO

DROP TABLE IF EXISTS prescriptions;
GO

DROP TABLE IF EXISTS doctors;
GO

DROP TABLE IF EXISTS users_insurances;
GO

DROP TABLE IF EXISTS drugs_companies;
GO

DROP TABLE IF EXISTS companies_users;
GO

DROP TABLE IF EXISTS purchases;
GO

DROP TABLE IF EXISTS appointments;
GO

DROP TABLE IF EXISTS appointment_histories;

-- UP Script
GO

CREATE TABLE appointment_histories(

    appointment_history_number int not null,
    appointment_history_id int not NULL,
    appointment_history_category varchar(50) not null,
    appointment_history_date date not null,
    appointment_history_time time not null,
    CONSTRAINT pk_appointment_histories_appointment_history_number PRIMARY key (appointment_history_number)

)
GO

CREATE TABLE appointments(

    appointment_id int IDENTITY not null,
    appointment_address varchar(100) not null,
    appointment_category varchar(50) not null,
    appointment_location varchar(50) not null,
    appointment_date date not null,
    appointment_time time not null,
    doctor_appointment_id int NOT null,
    appointment_city_id int not null,
    CONSTRAINT pk_appointments_appointment_id PRIMARY KEY (appointment_id),
    CONSTRAINT u_appointments_appointment_address UNIQUE (appointment_address)
)
GO

CREATE TABLE purchases(

    purchase_id int IDENTITY not null,
    purchase_user_id int not null,
    purchase_drugname varchar(50) not null,
    constraint pk_purchases_purchase_id primary key (purchase_id),
    CONSTRAINT u_purchases_purchase_drugname UNIQUE (purchase_drugname)

)


GO

CREATE TABLE doctors(

    doctor_id int IDENTITY not null,
    doctor_email varchar(50) not null,
    doctor_firstname varchar(50) not null,
    doctor_lastname varchar(50) not null,
    doctor_qualification varchar(50) not null,
    doctor_speciality varchar(50) not null,
    CONSTRAINT pk_doctors_doctor_id PRIMARY key (doctor_id),
    CONSTRAINT u_doctors_doctor_email UNIQUE (doctor_email)

)
GO

CREATE TABLE prescriptions(

    prescription_id int IDENTITY not null,
    prescription_number int not null,
    prescription_date date not null,
    prescription_doctor_id int not null,
    CONSTRAINT pk_prescriptions_prescription_id PRIMARY key (prescription_id),
    CONSTRAINT u_prescriptions_prescription_number UNIQUE (prescription_number)

)
GO

CREATE TABLE insurances(

    insurance_number int not null,
    insurance_category varchar(50) not null,
    insurance_startdate date not null,
    insurance_enddate date not null,
    CONSTRAINT pk_insurances_insurance_number PRIMARY key (insurance_number)

)
GO

CREATE TABLE cities(
    city_id int IDENTITY not null,
    city_name varchar(50) not null,
    city_pincode int not null,
    city_street varchar(100) not null,
    city_appointment_id int not null,
    CONSTRAINT pk_cities_city_id PRIMARY key (city_id),
    CONSTRAINT u_cities_city_name UNIQUE (city_name)
)
GO

CREATE TABLE sales(

    sale_id int IDENTITY not null,
    sale_drug_name varchar(50) not null,
    sale_drug_type varchar(50) not null,
    sale_drug_dose varchar(50) not null,
    sale_drug_quantity int not null,
    sale_drug_price decimal not null,
    sale_date date not null ,
    CONSTRAINT pk_sales_sales_id PRIMARY key (sale_id),
    CONSTRAINT u_sales_sale_drug_name UNIQUE (sale_drug_name)
)
GO

CREATE TABLE expires(

    expiry_barcode VARCHAR(50) not null,
    expiry_drug_name varchar(50) not null,
    expiry_quantity_remain int not null,
    expiration_date date not null
    CONSTRAINT pk_expires_expiry_barcode primary key (expiry_barcode),
    CONSTRAINT u_expires_expiry_drug_name UNIQUE (expiry_drug_name)

)
GO

CREATE TABLE drugs(

    drug_id int not null,
    drug_name VARCHAR(50) not null,
    drug_type varchar(50) not null,
    drug_dose varchar(10) not null,
    drug_expiry_barcode VARCHAR(50) not null,
    drug_cost_price int not null,
    drug_selling_price int not null,
    drug_expiry varchar(20) not null,
    drug_company_name VARCHAR(50) not null,
    drug_production_date date not null,
    drug_quantity int not null,
    CONSTRAINT pk_drugs_drug_id primary key (drug_id),
    CONSTRAINT u_drugs_drug_name UNIQUE (drug_name)

)
GO

CREATE TABLE companies (

    company_id int IDENTITY not null,
    company_name varchar(50) not null,
    company_contact VARCHAR(20) not null, 
    company_address varchar(100) not null,
    CONSTRAINT pk_companies_company_id primary key (company_id),
    CONSTRAINT u_companies_company_address UNIQUE (company_address)

)
GO

CREATE TABLE users (

    user_id int IDENTITY not null,
    user_firstname varchar(50) not null,
    user_lastname varchar(50) not null,
    user_birthdate date not null,
    user_contactnumber int not null,
    user_password varchar(20) not null,
    user_appointment_id int not null,
    CONSTRAINT pk_users_user_id primary key (user_id),
    CONSTRAINT u_users_contact unique (user_contactnumber) 

)
-----bridge tables begin
GO

create table drugs_companies(

    drug_id INT not null,
    company_id int not null,
    CONSTRAINT pk_drugs_companies_drug_id_company_id PRIMARY key (drug_id,company_id),

)
GO

CREATE TABLE companies_users(

    company_id int not null,
    user_id int not null,
    CONSTRAINT pk_companies_users_company_id_user_id PRIMARY key (user_id,company_id)

)
GO

CREATE table drugs_sales(

    drug_id INT not null,
    sale_id int not null,
    CONSTRAINT pk_drugs_sales_drug_id_sale_id PRIMARY key (drug_id,sale_id)
)
GO

CREATE table users_insurances(

    user_id int not null,
    insurance_number int not null,
    CONSTRAINT pk_users_insurances_user_id_insurance_number PRIMARY key (user_id,insurance_number)

)

------bridge table end


------alter table code
GO

ALTER table drugs_companies 
add CONSTRAINT fk1_drugs_companies_drug_id FOREIGN KEY(drug_id) REFERENCES drugs (drug_id),
    CONSTRAINT fk2_drugs_companies_company_id FOREIGN KEY(company_id) REFERENCES companies (company_id)
GO

ALTER table companies_users 
add CONSTRAINT fk1_companies_users_company_id FOREIGN KEY(company_id) REFERENCES companies (company_id),
    CONSTRAINT fk2_drugs_companies_user_id FOREIGN KEY(user_id) REFERENCES users (user_id);
GO

ALTER table drugs_sales 
add CONSTRAINT fk1_drugs_sales_drug_id FOREIGN KEY(drug_id) REFERENCES drugs (drug_id),
    CONSTRAINT fk2_drugs_sales_sale_id FOREIGN KEY(sale_id) REFERENCES sales (sale_id);
GO

ALTER table users_insurances 
add CONSTRAINT fk1_users_insurances_user_id FOREIGN KEY(user_id) REFERENCES users (user_id),
    CONSTRAINT fk2_users_insurances_insurance_number FOREIGN KEY(insurance_number) REFERENCES insurances (insurance_number);

GO

ALTER table appointment_histories 
ADD CONSTRAINT fk_appointment_histories_appointment_history_id foreign key (appointment_history_id) REFERENCES appointments (appointment_id);
GO

ALTER table appointments 
ADD CONSTRAINT fk_appointments_appointment_city_id foreign key (appointment_city_id) REFERENCES cities (city_id),
CONSTRAINT fk_appointments_doctor_appointment_id foreign key (doctor_appointment_id) REFERENCES doctors (doctor_id);
GO

ALTER table purchases 
ADD CONSTRAINT fk_purchases_purchase_user_id foreign key (purchase_user_id) REFERENCES users (user_id);
GO

ALTER table prescriptions 
ADD  CONSTRAINT fk_prescriptions_prescription_doctor_id foreign key (prescription_doctor_id) REFERENCES doctors (doctor_id);
GO

-- ALTER table cities 
-- ADD CONSTRAINT fk_cities_city_appointment_id foreign key (city_appointment_id) REFERENCES appointments (appointment_id);
-- GO

ALTER table cities
drop COLUMN city_appointment_id;

ALTER table drugs 
ADD CONSTRAINT fk_drugs_drug_expiry_barcode foreign key (drug_expiry_barcode) REFERENCES expires (expiry_barcode);
GO

ALTER table users 
ADD CONSTRAINT fk_users_user_appointment_id foreign key (user_appointment_id) REFERENCES appointments (appointment_id);
GO

ALTER TABLE users
DROP CONSTRAINT u_users_contact;

ALTER table users
ALTER COLUMN user_contactnumber varchar(20);

ALTER TABLE users
ADD CONSTRAINT u_users_user_contact UNIQUE (user_contactnumber);


-- INSERT

INSERT INTO insurances VALUES
   (123463748,'Standard','2020-12-15','2020-12-15'),
    (123463749,'Premium','2019-12-15','2021-12-15'),
    (123463750,'Standard','2020-07-21','2020-07-21'),
    (123463751,'Platinum','2017-02-15','2027-02-15'),
    (123463752,'Platinum','2019-11-30','2029-11-15'),
    (123463753,'Standard','2020-07-21','2020-07-21'),
    (123463754,'Platinum','2020-07-21','2020-07-21')

select * from insurances

INSERT INTO companies VALUES
('GSK','3153452345','222 south crouse'),
('Roche','3153452346','223 new south crouse'),
('Pfizer','3153452347','221 hinds hall'),
('J&J','3153452348','maryland mall'),
('Novartis','3153452349','hinds hall'),
('Merck','3153452350','ostrom avenue'),
('Sanofi','3153452351','Destiny USA')
select * from companies


INSERT INTO expires VALUES
('hdejwcvbfqw','Crocin',50,'2029-06-12'),
('shaudfjcahs','Dolo-625',150,'2031-05-20'),
('basugvcau','Dolo-150',123,'2032-02-10'),
('dhusjvcfsr','ibuprofen',100,'2031-01-21'),
('cviytauvfejbhd','volini',40,'2032-07-12'),
('uhcadchcbfje','Benadryl',20,'2023-01-18'),
('ydjgcgbkbjjbh','Eno',67,'2029-06-09')
select * from expires

INSERT INTO sales VALUES
('Crocin','OTC','50mg',40,15,'2022-12-01'),
('Dolo-625','OTC','50mg',100,20,'2022-12-10'),
('Dolo-150','OTC','50mg',02,21,'2022-12-09'),
('ibuprofen','Prescription','50mg',12,20,'2022-12-08'),
('volini','OTC','50mg',23,5,'2022-12-02'),
('Benadryl','Prescription','50mg',40,04,'2022-12-03'),
('Eno','OTC','50mg',120,15,'2022-12-05')
select * from sales

INSERT INTO doctors VALUES
('shubh@syr.edu','Shubh','Mody','MD','nurse'),
('sushma@syr.edu','Sushma','Deshmukh','MD','Neurologist'),
('kartik@syr.edu','Kartik','Kaul','MD','Psychologist'),
('aditi@syr.edu','Aditi','Pala','MD','Pediatrician'),
('ashwin@syr.edu','Ashwin','Moody','MD','OBGYN'),
('Kareena@syr.edu','Kareena','Kapoor','MD','Nurse'),
('Glenda@syr.edu','Glenda','Kaulist','MD','Psychologist')
select * from doctors



INSERT INTO prescriptions VALUES
(12,'2022-12-01',1),
(13,'2022-12-02',1),
(14,'2022-04-12',2),
(15,'2022-03-10',3),
(16,'2022-06-03',3),
(17,'2022-09-02',4),
(18,'2022-04-10',5),
(19,'2022-07-17',6),
(20,'2022-09-13',7)
select * from prescriptions


INSERT INTO drugs VALUES
(1,'Crocin','OTC','50mg','hdejwcvbfqw',30,50,'2029-12-12','GSK','2018-01-01',40),
(2,'Dolo-625','OTC','50mg','shaudfjcahs',30,50,'2029-12-12','Roche','2019-01-01',40),
(3,'Dolo-150','OTC','50mg','basugvcau',30,55,'2031-06-10','Pfizer','2019-05-01',90),
(4,'ibuprofen','Prescription','50mg','dhusjvcfsr',10,22,'2032-04-11','J&J','2020-05-01',20),
(5,'volini','OTC','50mg','cviytauvfejbhd',12,33,'2032-05-15','Novartis','2020-05-01',120),
(6,'Benadryl','Prescription','50mg','uhcadchcbfje',12,50,'2031-01-09','Merck','2018-02-01',19),
(7,'Eno','OTC','50mg','ydjgcgbkbjjbh',44,60,'2031-01-09','Sanofi','2018-01-01',80)
select * from drugs

INSERT INTO expires VALUES
('hdejwcvbfqw','Crocin',50,'2029-06-12'),
('shaudfjcahs','Dolo-625',150,'2031-05-20'),
('basugvcau','Dolo-150',123,'2032-02-10'),
('dhusjvcfsr','ibuprofen',100,'2031-01-21'),
('cviytauvfejbhd','volini',40,'2032-07-12'),
('uhcadchcbfje','Benadryl',20,'2023-01-18'),
('ydjgcgbkbjjbh','Eno',67,'2029-06-09')
select * from expires

INSERT INTO cities VALUES
('Syracuse',13210,'South Crouse'),
('Dallas',13211,'Maryland'),
('New York',13212,'Westcott'),
('Atlanta',13213,'Crouse ave'),
('Houston',13214,'Ostrom')
select * from cities

INSERT INTO cities VALUES
('Syracuse',13210,'South Crouse'),
('Dallas',13211,'Maryland'),
('New York',13211,'Westcott'),
('Atlanta',13212,'Crouse ave'),
('Houston',13213,'Ostrom')
select * from cities

INSERT INTO doctors VALUES
('shubh@syr.edu','Shubh','Mody','MD','nurse'),
('sushma@syr.edu','Sushma','Deshmukh','MD','Neurologist'),
('kartik@syr.edu','Kartik','Kaul','MD','Psychologist'),
('aditi@syr.edu','Aditi','Pala','MD','Pediatrician'),
('ashwin@syr.edu','Ashwin','Moody','MD','OBGYN'),
('Kareena@syr.edu','Kareena','Kapoor','MD','Nurse'),
('Glenda@syr.edu','Glenda','Kaulist','MD','Psychologist')
select * from doctors
select * from cities
insert into appointments values
('South Crouse','Non-urgent','Syracuse','2022-12-10','10:00',2,2),
('Maryland','Non-urgent','Dallas','2022-12-11','10:00',1,3),
('Westcott','Urgent','New York','2022-12-10','11:00',3,4),
('Crouse Ave','Non-urgent','Atlanta','2022-12-11','12:00',5,5),
('Ostrom','Urgent','Houston','2022-12-12','13:00',6,5)
select * from appointments



insert into appointment_histories VALUES
(2022001, 26, 'Non-urgent', '2022-12-10', '10:00'),
(2022002, 27, 'Urgent', '2022-12-11', '10:00'),
(2022003, 28, 'Non-urgent', '2022-12-10', '11:00'),
(2022004, 29, 'Urgent', '2022-12-12', '11:30'),
(2022005, 30, 'Non-urgent', '2022-11-11', '12:30')


select * from appointment_histories



insert into users VALUES
( 'Shubh', 'Mody', '2000-05-27', '3156367392', 'password1', 57),
('Kartik', 'Kaul', '2000-04-17', '3156635299', 'password2', 15),
('Aditi', 'Pala', '1992-03-17', '3156362512', 'password3', 58),
('John', 'Cena', '1980-09-21', '3156331342', 'password4', 60),
('Dave', 'Bautista', '1978-05-12', '3156123462', 'password5', 57)
select * from users
    
insert into users_insurances VALUES
(4,123463748),
(5,123463749),
(6,123463751),
(7,123463753)
select * from users_insurances

insert into companies_users VALUES
(1,4),
(2,5),
(3,6),
(5,7),
(6,8)
select * from companies_users

insert into drugs_companies VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,3),
(6,6),
(7,7)
select * from drugs_companies


insert into drugs_sales values
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7)
select * from drugs_sales


Drop view if exists cities_VIEW; 
GO 

CREATE VIEW v_cities AS 
    SELECT  city_name, city_pincode, city_street
    FROM  cities
GO
Select * from v_cities
GO

drop PROCEDURE if EXISTS insurance_details
GO
create PROCEDURE insurance_details
(
    @insurance_number as int,
    @insurance_category as varchar(50)
) AS

BEGIN
    if EXISTS(select insurance_category from insurances where insurance_number = @insurance_number)
    BEGIN
     update insurances
        set insurance_category=@insurance_category
        where insurance_number=@insurance_number
    END
    END
GO

exec insurance_details @insurance_number=123463752, @insurance_category="xyz";
GO



DROP VIEW IF EXISTS v_doctor_appointments;
GO

CREATE VIEW v_doctor_appointments AS 
    SELECT  d.doctor_id, d.doctor_firstname + ' ' + d.doctor_lastname as doctor_name,
      a.appointment_id, a.appointment_address, a.appointment_category, a.appointment_location, a.appointment_date
    FROM  doctors d
    JOIN appointments a ON d.doctor_id = a.doctor_appointment_id 
GO

Select * from v_doctor_appointments
GO


