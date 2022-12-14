
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
EMAIL varchar(20) not null,
PHONE varchar(20) not null,
ACTIVE bit,
primary key (ID)
);

drop table if exists DEBIT_CARD_NAME;
create table if not exists DEBIT_CARD_NAME (
ID int not null auto_increment,
NAME varchar(20) not null,
ACTIVE bit,
primary key (ID)
);

drop table if exists CREDIT_CARD_NAME;
create table if not exists CREDIT_CARD_NAME (
ID int not null auto_increment,
NAME varchar(20) not null,
ACTIVE bit,
primary key (ID)
);

drop table if exists BRAND_CARD;
create table if not exists BRAND_CARD (
ID int not null auto_increment,
BRAND varchar(20) not null,
ACTIVE bit,
primary key (ID)
);

drop table if exists DEBIT_CARD;
create table if not exists DEBIT_CARD (
ID int not null auto_increment,
CUSTOMER_ID int not null,
DEBIT_CARD_NAME_ID int not null ,
BRAND_CARD_ID int not null,
ACCOUNT_NUMBER int not null,
CARD_NUMBER int not null,
BALANCE int not null,
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
CARD_NUMBER int not null,
BALANCE int not null,
ACTIVE bit,
primary key (ID),
foreign key FK_CUSTOMER_ID(CUSTOMER_ID) REFERENCES CUSTOMER(ID),
foreign key FK_CREDIT_CARD_NAME_ID(CREDIT_CARD_NAME_ID) REFERENCES CREDIT_CARD_NAME(ID),
foreign key FK_BRAND_CARD_ID(BRAND_CARD_ID) REFERENCES BRAND_CARD(ID)
);

drop table if exists SERVICE;
create table if not exists SERVICE (
ID int not null auto_increment,
NAME varchar(20) not null,
primary key (ID)
);

drop table if exists DEBT_SERVICE_CUSTOMER;
create table if not exists DEBT_SERVICE_CUSTOMER (
ID int not null auto_increment,
SERVICE_ID int not null,
CUSTOMER_ID int not null ,
primary key (ID),
foreign key FK_SERVICE_ID(SERVICE_ID) REFERENCES SERVICE(ID),
foreign key FK_CUSTOMER_ID(CUSTOMER_ID) REFERENCES CUSTOMER(ID)
);




