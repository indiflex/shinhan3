select * from Student;

select * from Prof;

insert into Prof(name) values('김교슈');
insert into Prof(name) select '익교수';
insert into Prof(name) select concat('교수', id) from Prof;
insert into Prof(name) select concat('교수', id * 10) from Prof;

select * from Subject;
insert into Subject(name, prof) values('국어', 1);
insert into Subject(name, prof) values('수학', 2);

-- uniq error
insert into Subject(name, prof) values ('수학', 3), ('과학', 4);

insert ignore into Subject(name, prof) values ('수학', 3), ('과학', 4);

insert into Subject(name, prof) values ('수학', 6)
  on duplicate key update prof = 6;
  
insert into Subject(name, prof) values('미술', 7);

show create table Subject;
CREATE TABLE `Subject` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `createdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `workddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(31) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '과목명',
  `prof` mediumint unsigned DEFAULT NULL COMMENT '주임교수',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_name` (`name`),
  KEY `fk_prof` (`prof`),
  CONSTRAINT `subject_ibfk_1` FOREIGN KEY (`prof`) REFERENCES `Prof` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci