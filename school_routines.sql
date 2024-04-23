CREATE VIEW v_subject AS
  select s.id, s.name, p.name prof_name
    from Subject s inner join Prof p on s.prof = p.id;
    
select prof_name from v_subject where id=6;

select * from v_subject where id=6;

update v_subject set name='Science' where id=6;

select * from Prof;
select * from Subject;
update Subject set prof = 1 where id = 1;

insert into Subject(name, prof) values('음악', 2);
delete from Subject where id=12;

update Prof set subjectcnt = 0;
update Prof set subjectcnt = 1 where id = 1;

select id,name,subjectcnt, (select count(*) from Subject where prof = p.id)
 from Prof p;

update Prof p set p.subjectcnt = (select count(*) from Subject where prof = p.id)
 where p.id > 0;
 
-- update Prof p inner join (select count(*) from Subject where prof = p.id) sub
--  on p.id = sub.prof;

alter table Prof add column subjectcnt tinyint unsigned not null default 0;

create trigger tr_prof_subjectcnt after insert 
 on Subject for each row
 update Prof set subjectcnt = subjectcnt + 1
  where id = NEW.prof;

create trigger tr_prof_subjectcnt_up after update 
  on Subject for each row
  update Prof set subjectcnt = if(id = NEW.prof, subjectcnt + 1, subjectcnt - 1)
   where id in (OLD.prof, NEW.prof) and OLD.prof <> NEW.prof;
 
select * from Prof;
select * from Subject; -- id=2 ( 1 -> 7)
update Subject set prof = 7 where id = 2;
update Subject set name='Math' where id = 2;

drop trigger tr_prof_subjectcnt_up;
 
create trigger tr_prof_subjectcnt_del after delete 
 on Subject for each row
 update Prof set subjectcnt = subjectcnt - 1
  where id = OLD.prof and subjectcnt > 0;
