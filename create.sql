use mysql;

create database schooldb;

create user school@'%' identified by 'school';

grant all privileges on schooldb.* to school@'%';

flush privileges;

use testdb;

desc Emp;

CREATE TABLE `Emp` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `ename` varchar(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dept` tinyint unsigned NOT NULL,
  `salary` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `dept` (`dept`),
  CONSTRAINT `emp_ibfk_1` FOREIGN KEY (`dept`) REFERENCES `Dept` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci

select * from Emp
-- update Emp set salary=500
 where id < 5;
 
create table Emp2 like Emp;
show create table Emp2;
CREATE TABLE `Emp2` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `ename` varchar(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dept` tinyint unsigned NOT NULL,
  `salary` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `dept` (`dept`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

select * from Emp2;
insert into Emp2 select * from Emp where id > 0;

 
-- select * from Emp where id < 5;

create table EmpBackup AS select * from Emp;

select * from EmpBackup;

show create table EmpBackup;

CREATE TABLE `EmpBackup` (
  `id` int unsigned NOT NULL DEFAULT '0',
  `ename` varchar(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dept` tinyint unsigned NOT NULL,
  `salary` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

show variables like '%time_zone%';    -- with system_time_zone
select now(), sysdate();

select * from Emp2 order by id desc;
insert into Emp2(ename, dept, salary) values('테스트', 4, 500);

delete from Emp2 where id > 0;
truncate table Emp2;

select * from Dept;

alter table Dept drop column workdate;

alter table Dept add column workdate timestamp not null 
  default current_timestamp
  on update current_timestamp
  comment '작업일시';
  
alter table Dept modify column workdate timestamp not null 
  default current_timestamp
  on update current_timestamp
  comment '작업일시'
  after pid;
  
alter table Dept add column createdate timestamp not null 
  default current_timestamp comment '생성일시' after pid;

select * from Emp;

alter table Emp add column auth tinyint not null 
  default 0 comment '권한(0:sys, 1:super, …, 9:guest)' after dept;
  
alter table Emp modify column auth tinyint not null 
  default 9 comment '권한(0:sys, 1:super, …, 9:guest)' after dept;
  
update Emp set auth = 9 where id > 0;

