select e.*, d.dname
  from Emp e left outer join Dept d on e.dept = d.id;
  
select dname from v_emp where id = 10;
select dname from (select e.*, d.dname
  from Emp e left outer join Dept d on e.dept = d.id) sub;
  
select * from Dept;
select * from Emp;
insert into Emp(ename, dept, auth, salary) values('AAA', 1, 5, 200);
delete from Emp where ename='AAA';
update Emp set dept = 5 where id = 2;
update Emp set ename='유세희' where id = 2;

select dept, count(*) from Emp group by dept;
  
-- 초기화
-- select d.dname, d.id, sub.cnt  from
update 
  Dept d inner join (select dept, count(*) cnt from Emp group by dept) sub
        on d.id = sub.dept
  set d.empcnt = sub.cnt;

alter table Dept add column empcnt smallint unsigned not null default 0 comment '부서별 직원수';

create trigger tr_emp_after_insert after insert
  on Emp for each row
  update Dept set empcnt = empcnt + 1
   where id = NEW.dept;

create trigger tr_emp_after_update after update
  on Emp for each row
  update Dept set empcnt = if(id = NEW.dept, empcnt + 1, empcnt - 1)
   where id in (NEW.dept, OLD.dept) and NEW.dept <> OLD.dept;
   
create trigger tr_emp_after_delete after delete
  on Emp for each row
  update Dept set empcnt = empcnt - 1
   where id = OLD.dept;
   
   
select f_empinfo(e.id), concat(e.ename, '(', ifnull(d.dname, '미배정'), ')')
  from Emp e left outer join Dept d on e.dept = d.id
 where e.id = 3;
 
select f_empinfo(100);
   