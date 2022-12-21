
drop schema if exists INTBK_HB_DEVDB;
create schema if not exists INTBK_HB_DEVDB;
use INTBK_HB_DEVDB;

drop table if exists CUSTOMER;
create table if not exists CUSTOMER (
ID int not null auto_increment,
DNI varchar(8) not null,
PASSWORD varchar(12) not null,
NAME varchar(20) not null,
FIRST_SURNAME varchar(20) not null,
SECOND_SURNAME varchar(20) not null,
EMAIL varchar(40) not null,
PHONE varchar(20) not null,
ACTIVE bit,
primary key (ID)
);

drop table if exists DEBIT_CARD_NAME;
create table if not exists DEBIT_CARD_NAME (
ID int not null auto_increment,
NAME varchar(40) not null,
ACTIVE bit,
primary key (ID)
);

drop table if exists CREDIT_CARD_NAME;
create table if not exists CREDIT_CARD_NAME (
ID int not null auto_increment,
NAME varchar(40) not null,
ACTIVE bit,
primary key (ID)
);

drop table if exists BRAND_CARD;
create table if not exists BRAND_CARD (
ID int not null auto_increment,
BRAND varchar(40) not null,
ACTIVE bit,
primary key (ID)
);

drop table if exists DEBIT_CARD;
create table if not exists DEBIT_CARD (
ID int not null auto_increment,
CUSTOMER_ID int not null,
DEBIT_CARD_NAME_ID int not null ,
BRAND_CARD_ID int not null,
ACCOUNT_NUMBER varchar(15) not null unique,
CARD_NUMBER varchar(19) not null unique,
BALANCE float(2) not null,
ACTIVE bit,
primary key (ID),
foreign key FK_CUSTOMER_ID(CUSTOMER_ID) REFERENCES CUSTOMER(ID),
foreign key FK_DEBIT_CARD_NAME_ID(DEBIT_CARD_NAME_ID) REFERENCES DEBIT_CARD_NAME(ID),
foreign key FK_BRAND_CARD_ID(BRAND_CARD_ID) REFERENCES BRAND_CARD(ID)
);

drop table if exists CREDIT_CARD;
create table if not exists CREDIT_CARD (
ID int not null auto_increment,
CUSTOMER_ID int not null,
CREDIT_CARD_NAME_ID int not null ,
BRAND_CARD_ID int not null,
ACCOUNT_NUMBER varchar(15) not null unique,
CARD_NUMBER varchar(19) not null unique,
CREDIT_LINE float(2) not null,
CREDIT_USED float(2) not null,
ACTIVE bit,
primary key (ID),
foreign key FK_CUSTOMER_ID(CUSTOMER_ID) REFERENCES CUSTOMER(ID),
foreign key FK_CREDIT_CARD_NAME_ID(CREDIT_CARD_NAME_ID) REFERENCES CREDIT_CARD_NAME(ID),
foreign key FK_BRAND_CARD_ID(BRAND_CARD_ID) REFERENCES BRAND_CARD(ID)
);

drop table if exists TXN_LOG;
create table if not exists TXN_LOG (
ID int not null auto_increment,
SENDER_ID int,
RECEIVER_ID int,
DESCRIPTION_TXN varchar(20),
AMOUNT float,
SENDER_ACCOUNT_NUMBER varchar(15),
RECEIVER_ACCOUNT_NUMBER varchar(15),
DATE timestamp,
primary key (ID),
foreign key FK_SENDER_ID(SENDER_ID) REFERENCES CUSTOMER(ID),
foreign key FK_RECEIVER_ID(RECEIVER_ID) REFERENCES CUSTOMER(ID)
);

-- CUSTOMER INSERTS
insert into customer (dni,password,name,first_surname,second_surname,email,phone,active) values ('70687797','123','Bryan','De La Cruz','Amar','bryan.delacruza@gmail.com','983854029',1);
insert into customer (dni,password,name,first_surname,second_surname,email,phone,active) values ('12345678','123','Juan','Perez','García','test1@gmail.com','987654321',0);
insert into customer (dni,password,name,first_surname,second_surname,email,phone,active) values ('87456321','123','Bruno','Black','Blue','test2@gmail.com','987654321',1);

-- DEBIT_CARD_NAME INSERTS
insert into debit_card_name (name,active) values ('Visa Débito Benefit',1);
insert into debit_card_name (name,active) values ('Visa Débito Clásica',0);
insert into debit_card_name (name,active) values ('Tarjeta Digital',1);

-- CREDIT_CARD_NAME INSERTS
insert into credit_card_name (name,active) values ('American Express Blue',1);
insert into credit_card_name (name,active) values ('American Express Gold',0);
insert into credit_card_name (name,active) values ('American Express',1);
insert into credit_card_name (name,active) values ('Visa Clásica',1);
insert into credit_card_name (name,active) values ('Visa Oro',0);
insert into credit_card_name (name,active) values ('Visa Signature',1);

-- BRAND_CARD INSERTS
insert into brand_card (brand,active) values ('VISA',1);
insert into brand_card (brand,active) values ('MASTERCARD',0);
insert into brand_card (brand,active) values ('AMERICAN EXPRESS',1);

-- DEBIT_CARD INSERTS
insert into debit_card (customer_id,debit_card_name_id,brand_card_id,account_number,card_number,balance,active) values (1,1,1,'123456789012341','2222555566667771',0,1);
insert into debit_card (customer_id,debit_card_name_id,brand_card_id,account_number,card_number,balance,active) values (2,2,1,'123456789012342','2222555566667772',0,1);
insert into debit_card (customer_id,debit_card_name_id,brand_card_id,account_number,card_number,balance,active) values (3,3,1,'123456789012343','1111555566667772',0,1);

-- CREDIT_CARD INSERTS
insert into credit_card (customer_id,credit_card_name_id,brand_card_id,account_number,card_number,credit_line,credit_used,active) values (1,1,1,'923456789012341','4444555566667771',5000,0,1);
insert into credit_card (customer_id,credit_card_name_id,brand_card_id,account_number,card_number,credit_line,credit_used,active) values (1,2,1,'923456789012342','4444555566667772',2000,0,0);
insert into credit_card (customer_id,credit_card_name_id,brand_card_id,account_number,card_number,credit_line,credit_used,active) values (2,3,1,'923456789012343','4444555566667773',1000,0,1);
insert into credit_card (customer_id,credit_card_name_id,brand_card_id,account_number,card_number,credit_line,credit_used,active) values (2,4,2,'923456789012344','1111555566667771',1500,0,0);
insert into credit_card (customer_id,credit_card_name_id,brand_card_id,account_number,card_number,credit_line,credit_used,active) values (3,5,2,'923456789012345','1111555566667772',2500,0,1);
insert into credit_card (customer_id,credit_card_name_id,brand_card_id,account_number,card_number,credit_line,credit_used,active) values (3,6,2,'923456789012346','1111555566667773',3500,0,0);

-- TXN_LOG INSERTS
insert into txn_log (sender_id,receiver_id,description_txn,amount,sender_account_number,receiver_account_number,date) values (1,2,'transf intbk',100,'123456789012341','123456789012342',20221221010001);
insert into txn_log (sender_id,receiver_id,description_txn,amount,sender_account_number,receiver_account_number,date) values (2,3,'transf intbk',200,'123456789012342','123456789012343',20221221020001);
insert into txn_log (sender_id,receiver_id,description_txn,amount,sender_account_number,receiver_account_number,date) values (2,3,'transf intbk',300,'123456789012343','123456789012341',20221221030001);
insert into txn_log (sender_id,receiver_id,description_txn,amount,sender_account_number,receiver_account_number,date) values (1,1,'pago tc intbk',400,'123456789012341','923456789012341',20221221040001);
insert into txn_log (sender_id,receiver_id,description_txn,amount,sender_account_number,receiver_account_number,date) values (2,2,'pago tc intbk',500,'123456789012342','923456789012343',20221221050001);
insert into txn_log (sender_id,receiver_id,description_txn,amount,sender_account_number,receiver_account_number,date) values (2,3,'pago tc intbk',600,'123456789012343','923456789012345',20221221060001);
