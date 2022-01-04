DROP DATABASE IF EXISTS employeesNEW;
CREATE DATABASE IF NOT EXISTS employeesNEW;
USE employeesNEW;

SELECT 'CREATING DATABASE STRUCTURE' as 'INFO';

drop table if exists DEPARTMENT;
drop table if exists DEPARTMENT_EMPLOYEE;
drop table if exists DEPARTMENT_MANAGER;
drop table if exists EMPLOYEE;
drop table if exists EMPLOYESS_MAINTENANCE_MEMBERS;
drop table if exists MEDICAL_LEAVE;
drop table if exists SALARIES;
drop table if exists TITLES;
drop table if exists VACATION;
drop table if exists VEHICLE;
drop table if exists VEHICLE_USAGE;

set default_storage_engine = InnoDB;
select CONCAT('storage engine: ', @@default_storage_engine) as INFO;

/*==============================================================*/
/* Table: EMPLOYEE                                              */
/*==============================================================*/
create table EMPLOYEE
(
   EMPLOYE_NUMBER       int not null,
   EMPLOYE_BIRTH_DATE   date not null,
   EMPLOYE_FIRST_NAME   varchar(14) not null,
   EMPLOYE_LAST_NAME    varchar(16) not null,
   EMPLOYE_SEX          ENUM ('M','F') not null,
   EMPLOYE_HIRE_DATE    date not null,
   primary key (EMPLOYE_NUMBER)
);

/*==============================================================*/
/* Table: DEPARTMENT                                            */
/*==============================================================*/
create table DEPARTMENT
(
   DEPARTMENT_NUMBER    char(4) not null,
   DEPARTMENT_NAME      varchar(40) not null,
   primary key (DEPARTMENT_NUMBER),
   UNIQUE  KEY (DEPARTMENT_NAME)
);

/*==============================================================*/
/* Table: DEPARTMENT_MANAGER                                    */
/*==============================================================*/
create table DEPARTMENT_MANAGER
(
   EMPLOYE_NUMBER       int not null,
   DEPARTMENT_NUMBER    char(4) not null,
   FROM_DATE            date not null,
   TO_DATE              date not null,
   FOREIGN KEY (EMPLOYE_NUMBER)  REFERENCES EMPLOYEE (EMPLOYE_NUMBER) ON DELETE CASCADE,
   FOREIGN KEY (DEPARTMENT_NUMBER) REFERENCES DEPARTMENT (DEPARTMENT_NUMBER) ON DELETE CASCADE,
   primary key (EMPLOYE_NUMBER, DEPARTMENT_NUMBER)
);

/*==============================================================*/
/* Table: DEPARTMENT_EMPLOYEE                                   */
/*==============================================================*/
create table DEPARTMENT_EMPLOYEE
(
   EMPLOYE_NUMBER       int not null,
   DEPARTMENT_NUMBER    char(4) not null,
   FROM_DATE            date not null,
   TO_DATE              date not null,
   FOREIGN KEY (EMPLOYE_NUMBER)  REFERENCES EMPLOYEE (EMPLOYE_NUMBER) ON DELETE CASCADE,
   FOREIGN KEY (DEPARTMENT_NUMBER) REFERENCES DEPARTMENT (DEPARTMENT_NUMBER) ON DELETE CASCADE,
   primary key (EMPLOYE_NUMBER, DEPARTMENT_NUMBER)
);

/*==============================================================*/
/* Table: EMPLOYESS_MAINTENANCE_MEMBERS                         */
/*==============================================================*/
create table EMPLOYESS_MAINTENANCE_MEMBERS
(
   EMPLOYE_NUMBER       int not null,
   MEMBER_NUMBER        int not null,
   MEMBER_FIRST_NAME    varchar(14),
   MEMBER_LAST_NAME     varchar(16),
   MEMBER_TYPE          ENUM ('P','C'),
   MEMBER_SEX           ENUM ('M','F'),
   FOREIGN KEY (EMPLOYE_NUMBER)  REFERENCES EMPLOYEE (EMPLOYE_NUMBER) ON DELETE CASCADE,
   primary key (EMPLOYE_NUMBER, MEMBER_NUMBER)
);

/*==============================================================*/
/* Table: MEDICAL_LEAVE                                         */
/*==============================================================*/
create table MEDICAL_LEAVE
(
   FROM_DATE            date not null,
   EMPLOYE_NUMBER       int not null,
   TO_DATE              date,
   REASON               text,
   FOREIGN KEY (EMPLOYE_NUMBER)  REFERENCES EMPLOYEE (EMPLOYE_NUMBER) ON DELETE CASCADE,
   primary key (FROM_DATE, EMPLOYE_NUMBER)
);

/*==============================================================*/
/* Table: SALARIES                                              */
/*==============================================================*/
create table SALARIES
(
   EMPLOYE_NUMBER       int not null,
   FROM_DATE            date not null,
   SALARY               int not null,
   TO_DATE              date,
   FOREIGN KEY (EMPLOYE_NUMBER)  REFERENCES EMPLOYEE (EMPLOYE_NUMBER) ON DELETE CASCADE,
   primary key (EMPLOYE_NUMBER, FROM_DATE)
);

/*==============================================================*/
/* Table: TITLES                                                */
/*==============================================================*/
create table TITLES
(
   EMPLOYE_NUMBER       int not null,
   TITLE                varchar(40) not null,
   FROM_DATE            date not null,
   TO_DATE              date,
   FOREIGN KEY (EMPLOYE_NUMBER)  REFERENCES EMPLOYEE (EMPLOYE_NUMBER) ON DELETE CASCADE,
   primary key (EMPLOYE_NUMBER, TITLE, FROM_DATE)
);

/*==============================================================*/
/* Table: VACATION                                              */
/*==============================================================*/
create table VACATION
(
   FROM_DATE            date not null,
   EMPLOYE_NUMBER       int not null,
   TO_DATE              date,
   FOREIGN KEY (EMPLOYE_NUMBER)  REFERENCES EMPLOYEE (EMPLOYE_NUMBER) ON DELETE CASCADE,
   primary key (FROM_DATE, EMPLOYE_NUMBER)
);

/*==============================================================*/
/* Table: VEHICLE                                               */
/*==============================================================*/
create table VEHICLE
(
   VEHICLE_NUMBER       int not null,
   VHEICLE_BRAND        varchar(15),
   VHEICLE_MODEL        varchar(15),
   primary key (VEHICLE_NUMBER)
);

/*==============================================================*/
/* Table: VEHICLE_USAGE                                         */
/*==============================================================*/
create table VEHICLE_USAGE
(
   EMPLOYE_NUMBER       int not null,
   VEHICLE_NUMBER       int not null,
   FROM_DATE            date,
   TO_DATE              date,
   FOREIGN KEY (EMPLOYE_NUMBER)  REFERENCES EMPLOYEE (EMPLOYE_NUMBER) ON DELETE CASCADE,
   FOREIGN KEY (VEHICLE_NUMBER)  REFERENCES VEHICLE (VEHICLE_NUMBER) ON DELETE CASCADE,
   primary key (EMPLOYE_NUMBER, VEHICLE_NUMBER, FROM_DATE)
);