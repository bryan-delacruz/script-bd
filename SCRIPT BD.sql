
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

drop table if exists BRAND_CARD;
create table if not exists BRAND_CARD (
ID int not null auto_increment,
BRAND varchar(40) not null,
ACTIVE bit,
primary key (ID)
);

drop table if exists DEBIT_CARD_NAME;
create table if not exists DEBIT_CARD_NAME (
ID int not null auto_increment,
NAME varchar(40) not null,
BRAND_CARD_ID int not null,
ACTIVE bit,
primary key (ID),
foreign key FK_BRAND_CARD_ID(BRAND_CARD_ID) REFERENCES BRAND_CARD(ID)
);

drop table if exists CREDIT_CARD_NAME;
create table if not exists CREDIT_CARD_NAME (
ID int not null auto_increment,
NAME varchar(40) not null,
BRAND_CARD_ID int not null,
ACTIVE bit,
primary key (ID),
foreign key FK_BRAND_CARD_ID(BRAND_CARD_ID) REFERENCES BRAND_CARD(ID)
);

drop table if exists DEBIT_CARD;
create table if not exists DEBIT_CARD (
ID int not null auto_increment,
CUSTOMER_ID int not null,
DEBIT_CARD_NAME_ID int not null,
ACCOUNT_NUMBER varchar(15) not null unique,
CARD_NUMBER varchar(19) not null unique,
BALANCE float(2) not null,
ACTIVE bit,
primary key (ID),
foreign key FK_CUSTOMER_ID(CUSTOMER_ID) REFERENCES CUSTOMER(ID),
foreign key FK_DEBIT_CARD_NAME_ID(DEBIT_CARD_NAME_ID) REFERENCES DEBIT_CARD_NAME(ID)
);

drop table if exists CREDIT_CARD;
create table if not exists CREDIT_CARD (
ID int not null auto_increment,
CUSTOMER_ID int not null,
CREDIT_CARD_NAME_ID int not null ,
ACCOUNT_NUMBER varchar(15) not null unique,
CARD_NUMBER varchar(19) not null unique,
CREDIT_LINE float(2) not null,
CREDIT_USED float(2) not null,
ACTIVE bit,
primary key (ID),
foreign key FK_CUSTOMER_ID(CUSTOMER_ID) REFERENCES CUSTOMER(ID),
foreign key FK_CREDIT_CARD_NAME_ID(CREDIT_CARD_NAME_ID) REFERENCES CREDIT_CARD_NAME(ID)
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
insert into customer (dni,password,name,first_surname,second_surname,email,phone,active) values ('12345678','123','Juan','Perez','Garc??a','test1@gmail.com','987654321',0);
insert into customer (dni,password,name,first_surname,second_surname,email,phone,active) values ('87456321','123','Bruno','Black','Blue','test2@gmail.com','987654321',1);

-- BRAND_CARD INSERTS
insert into brand_card (brand,active) values ('VISA',1);
insert into brand_card (brand,active) values ('MASTERCARD',0);
insert into brand_card (brand,active) values ('AMERICAN EXPRESS',1);

-- DEBIT_CARD_NAME INSERTS
insert into debit_card_name (name,brand_card_id,active) values ('Visa D??bito Benefit',1,1);
insert into debit_card_name (name,brand_card_id,active) values ('Visa D??bito Cl??sica',1,0);

-- CREDIT_CARD_NAME INSERTS
insert into credit_card_name (name,brand_card_id,active) values ('American Express Blue',3,1);
insert into credit_card_name (name,brand_card_id,active) values ('American Express Gold',3,0);
insert into credit_card_name (name,brand_card_id,active) values ('American Express',3,1);
insert into credit_card_name (name,brand_card_id,active) values ('Visa Cl??sica',1,1);
insert into credit_card_name (name,brand_card_id,active) values ('Visa Oro',1,0);
insert into credit_card_name (name,brand_card_id,active) values ('Visa Signature',1,1);

-- DEBIT_CARD INSERTS
insert into debit_card (customer_id,debit_card_name_id,account_number,card_number,balance,active) values (1,1,'123456789012341','2222555566667771',0,1);
insert into debit_card (customer_id,debit_card_name_id,account_number,card_number,balance,active) values (2,2,'123456789012342','2222555566667772',0,1);
insert into debit_card (customer_id,debit_card_name_id,account_number,card_number,balance,active) values (1,2,'123456789012343','1111555566667772',0,1);

-- CREDIT_CARD INSERTS
insert into credit_card (customer_id,credit_card_name_id,account_number,card_number,credit_line,credit_used,active) values (1,1,'923456789012341','4444555566667771',5000,0,1);
insert into credit_card (customer_id,credit_card_name_id,account_number,card_number,credit_line,credit_used,active) values (1,2,'923456789012342','4444555566667772',2000,0,0);
insert into credit_card (customer_id,credit_card_name_id,account_number,card_number,credit_line,credit_used,active) values (2,3,'923456789012343','4444555566667773',1000,0,1);
insert into credit_card (customer_id,credit_card_name_id,account_number,card_number,credit_line,credit_used,active) values (2,4,'923456789012344','1111555566667771',1500,0,0);
insert into credit_card (customer_id,credit_card_name_id,account_number,card_number,credit_line,credit_used,active) values (3,5,'923456789012345','1111555566667772',2500,0,1);
insert into credit_card (customer_id,credit_card_name_id,account_number,card_number,credit_line,credit_used,active) values (3,6,'923456789012346','1111555566667773',3500,0,0);

-- TXN_LOG INSERTS
insert into txn_log (sender_id,receiver_id,description_txn,amount,sender_account_number,receiver_account_number,date) values (1,2,'transf intbk',100,'123456789012341','123456789012342',20221221010001);
insert into txn_log (sender_id,receiver_id,description_txn,amount,sender_account_number,receiver_account_number,date) values (2,3,'transf intbk',200,'123456789012342','123456789012343',20221221020001);
insert into txn_log (sender_id,receiver_id,description_txn,amount,sender_account_number,receiver_account_number,date) values (2,3,'transf intbk',300,'123456789012343','123456789012341',20221221030001);
insert into txn_log (sender_id,receiver_id,description_txn,amount,sender_account_number,receiver_account_number,date) values (1,1,'pago tc intbk',400,'123456789012341','923456789012341',20221221040001);
insert into txn_log (sender_id,receiver_id,description_txn,amount,sender_account_number,receiver_account_number,date) values (2,2,'pago tc intbk',500,'123456789012342','923456789012343',20221221050001);
insert into txn_log (sender_id,receiver_id,description_txn,amount,sender_account_number,receiver_account_number,date) values (2,3,'pago tc intbk',600,'123456789012343','923456789012345',20221221060001);

create or replace view customers_by_debit_card as
	(select DNI,NAME,FIRST_SURNAME,SECOND_SURNAME,ctm.ACTIVE as CTM_ACTIVE,
		CARD_NUMBER,BALANCE,dc.ACTIVE as DC_ACTIVE 
        from customer as ctm
		inner join debit_card as dc
        on dc.CUSTOMER_ID=ctm.ID);
        
select * from customers_by_debit_card;
        
create or replace view customers_by_credit_card as
	(select DNI,NAME,FIRST_SURNAME,SECOND_SURNAME,ctm.ACTIVE as CTM_ACTIVE,
		CARD_NUMBER,CREDIT_LINE,CREDIT_USED,cc.ACTIVE as CC_ACTIVE 
		from customer as ctm
		inner join credit_card as cc
        on cc.CUSTOMER_ID=ctm.ID);
        
select * from customers_by_credit_card;
        
create or replace view customers_by_brand_for_debit_card as
	(select DNI,ctm.NAME as CTM_NAME,FIRST_SURNAME,SECOND_SURNAME,ctm.ACTIVE as CTM_ACTIVE,
		CARD_NUMBER,BALANCE,dc.ACTIVE,
        dcn.NAME as DCN_NAME, dcn.ACTIVE as DCN_ACTIVE,
        BRAND
		from customer as ctm
		inner join debit_card as dc
        on dc.CUSTOMER_ID=ctm.ID 
        inner join debit_card_name as dcn
        on dcn.ID=dc.DEBIT_CARD_NAME_ID
        inner join brand_card as bc
        on bc.ID=dcn.BRAND_CARD_ID);
        
select * from customers_by_brand_for_debit_card;

create or replace view customers_by_brand_for_credit_card as
	(select DNI,ctm.NAME as CTM_NAME,FIRST_SURNAME,SECOND_SURNAME,ctm.ACTIVE as CTM_ACTIVE,
		CARD_NUMBER,CREDIT_LINE,CREDIT_USED,cc.ACTIVE as CC_ACTIVE,
        ccn.NAME as DCN_NAME, ccn.ACTIVE as CCN_ACTIVE,
        BRAND
		from customer as ctm
		inner join credit_card as cc
        on cc.CUSTOMER_ID=ctm.ID 
        inner join credit_card_name as ccn
        on ccn.ID=cc.CREDIT_CARD_NAME_ID
        inner join brand_card as bc
        on bc.ID=ccn.BRAND_CARD_ID);
        
select * from customers_by_brand_for_credit_card;

create or replace view txn_by_customer as
	(select dni,concat(ctm.NAME ,' ',FIRST_SURNAME,' ',SECOND_SURNAME) as FULL_NAME,
		sum(AMOUNT),count(tl.ID),avg(AMOUNT)
		from customer as ctm
		inner join txn_log as tl
        on tl.SENDER_ID=ctm.ID
			group by dni,full_name);

select * from txn_by_customer;
