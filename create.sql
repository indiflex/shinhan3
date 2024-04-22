
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
  after createdate;
  
alter table Dept add column createdate timestamp not null 
  default current_timestamp comment '생성일시' after pid;

select * from Emp;
desc Emp;

show index from Dept;
show create table Dept;

  
alter table Emp add column auth tinyint not null 
  default 9 comment '권한(0:sys, 1:super, …, 9:guest)' after dept;
  
update Emp set auth = 9 where id > 0;

-- Dept.captain - Emp.id
alter table Dept add column captain int unsigned null comment '부서장';
 
alter table Dept add constraint fk_captain_Emp foreign key (captain) references Emp(id)
  on delete set null on update cascade;

-- 
update Dept set captain = id + 10 where id > 0;
select * from Emp order by id desc;

select * from Dept;
select * from Emp
-- update Emp set id=253
-- delete from Emp
 where id=253;
select d.*, e.ename as captain_name from Dept d inner join Emp e on d.captain = e.id;

-- EmailLog
create table EmailLog(
    id int not null auto_increment primary key,
    sender int unsigned not null comment '발송직원',
    receiver varchar(1024) not null comment '수신 정보',
    subject varchar(255) not null default '무제(냉무)' comment '제목',
    body text null comment '내용',
    foreign key fk_sender_Emp(sender) references Emp(id)
      on delete cascade on update cascade
);

show index from EmailLog;
select * from EmailLog;

select enc,  CAST(aes_decrypt(unhex(enc), '암호키') as char), CAST(aes_decrypt(ee, '암호키') as char)
  from (select dname, HEX(AES_ENCRYPT(dname, '암호키')) enc, 
               AES_ENCRYPT(dname, '암호키') ee from Dept) sub;
               
select str_to_date('2018-12-03', '%Y-%m-%d');