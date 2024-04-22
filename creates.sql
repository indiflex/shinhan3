use mysql;

create database schooldb;

create user school@'%' identified by 'school';

grant all privileges on schooldb.* to school@'%';

flush privileges;

-- 학과테이블
create table Major(
    id smallint unsigned auto_increment primary key comment '학과번호',
    name varchar(31) not null comment '학과 이름'
);

select * from Major;

insert Major(name) values('철학과');
insert Major(name) values('컴퓨터공학과');
insert Major(name) values('건축과');

-- 학생
create table Student(
    id int unsigned auto_increment primary key,
    name varchar(31) not null comment '학생 이름',
    birthdt date not null comment '생년월일',
    major smallint not null comment '학과 id',
    mobile varchar(13) not null comment '휴대전화',
    email varchar(255) not null comment '이메일주소',
    gender tinyint(1) not null comment '성별',
    graduatedt varchar(10) null comment '졸업일'
);

ALTER TABLE `schooldb`.`Student` 
CHANGE COLUMN `gender` `gender` boolean NOT NULL COMMENT '성별' ;

desc Student;
desc Major;

select * from Student;
-- truncate table Student;
insert into Student(name, birthdt, major, mobile, email, gender)
 values ('김일수', '1998-10-05', 1, '01012341234', 'kim@gmail.com', true);
 
insert into Student(name, birthdt, major, mobile, email, gender)
  values ('김이수', '1998-10-06', 1, '01012341235', 'kim2@gmail.com', true),
         ('김삼수', '1998-10-07', 1, '01012341236', 'kim3@gmail.com', true);


alter table Student add Column createdate timestamp not null default current_timestamp;

alter table Student modify Column createdate timestamp not null
  default current_timestamp after id;
  
alter table Student add Column workdate timestamp not null 
  default current_timestamp on update current_timestamp after createdate;
  
show create table Student;

show index from Student;

-- type 일치시키기
alter table Student modify column major smallint unsigned not null comment '학과 id';

-- fk 생성(default key-name)
alter table Student add constraint foreign key (major) references Major(id);

-- fk 삭제
alter table Student drop constraint student_ibfk_1;
alter table Student drop index major;

-- fk 생성(fk name)
alter table Student add constraint fk_major_Major_id foreign key (major) references Major(id);
alter table Student add constraint fk_major foreign key (major) references Major(id);