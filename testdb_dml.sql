select * from Dept;

select d.*, e.ename
  from Dept d inner join Emp e on d.captain = e.id;
  
-- case when, if(), NVL()
select d.*, ifnull(e.ename, '공석')  as captain_name, 
       (case when pid = 0 then '최상위부서' else '하위부서' end) as depth1,
       if (d.pid = 0, '최상위부서', '하위부서') as depth11,
       (case when pid = 0 then '최상위부서' when pid = 1 then '중간부서' else '하위부서' end) as depth2,
       (case pid when 0 then '최상위부서' when 1 then '중간부서' else '하위부서' end) as depth3,
       if (d.pid = 0, '최상위부서', if(d.pid = 1, '중간부서', '하위부서')) as depth33
  from Dept d left outer join Emp e on d.captain = e.id;
  
-- sub-query
select * from Emp
 where id > (select max(captain) from Dept where id = 5 or id = 7); -- 15, 17
 
select * from Emp
 where id < ANY (select captain from Dept where id = 5 or id = 7); -- 15, 17
 
select * from Emp
 where id < ALL (select captain from Dept where id = 5 or id = 7); -- 15, 17
 
select * from Emp
 where id in (select captain from Dept where id = 5 or id = 7); -- 15, 17
 
select * from Emp
 where id not in (select captain from Dept where id = 5 or id = 7); -- 15, 17
 
select * from Emp where ename like '%마%';
select * from Emp where ename like '마%';
select * from Emp where ename like '%성%';
select * from Emp where ename like '_성_';
select * from Emp where ename not like '_성_';
select * from Emp where ename like '_성%';

select * from Emp;
select FLOOR(rand() * 10) + 1;
update Emp set auth = FLOOR(rand() * 10) + 1 where id > 0;
 
select sub.dname from (select id, dname, captain from Dept where id=5) sub;

select * from Emp where id >= 10 and id <= 20;
select * from Emp where id between 10 and 20;
select count(distinct auth) from Emp;
select distinct captain from Dept where captain is not null;
select * from Dept where captain is null;

select 1;

select (@rownum := @rownum + 1) rownum, e.*
 from Emp e, (select @rownum := 0) rn order by id;
 
select * from Dept order by id;
select * from Emp order by ename;
select id, ename as name from Emp order by ename limit 10;
select id, ename as name from Emp order by ename limit 5, 10;

select * from Emp order by rand() limit 10;

select d.id, max(d.dname) dname, FLOOR(AVG(e.salary)) as sal_avg
  from Emp e inner join Dept d on e.dept = d.id
 group by d.id
 having sal_avg > 500
 order by sal_avg;
 
select d.dname, count(*) as cnt
  from Emp e inner join Dept d on e.dept = d.id
 group by d.id
 having cnt >= 40;
 
select salary, count(*) from Emp group by salary order by salary;
  select * from Dept;
  
-- 캡틴이 15 이상이고, 직원 중 최고 연봉자의 부서명 끝에 *를 붙이세요.
select * from Dept
-- update Dept set dname = concat(dname, '*')
 where id = (select dept from Emp order by salary desc limit 1);

select * from Emp order by salary;

-- 캡틴이 14 이상이고, 직원 중 최저 연봉자의 부서명 끝에 *를 붙이세요.
select d.*
  from Emp e inner join Dept d on e.dept = d.id
 where d.captain >= 14 and e.salary = (select min(salary) from Emp);
 
update Emp e inner join Dept d on e.dept = d.id
   set d.dname = concat(dname, '*')
 where d.captain >= 14 and e.salary = (select min(salary) from Emp);
 
select * from Dept;

select power(2, 3), conv('EF', 16, 10);

select id, cast(id AS char), CONVERT(1.567, Signed Integer) from Dept order by id;

update Dept set createdate = '2018-12-03' where id = 1;
update Dept set createdate = str_to_date('2018-12-03', '%Y-%m-%d') where id = 2;

select sha2('data', 256), sha2('data', 512);

select dname, AES_ENCRYPT(dname, '암호키'), HEX(AES_ENCRYPT(dname, '암호키')) from Dept;

select cast(aes_decrypt(sub.enc1, '암호키') as char),
       cast(aes_decrypt(unhex(enc2), '암호키') as char)
 from (select dname, AES_ENCRYPT(dname, '암호키') enc1, HEX(AES_ENCRYPT(dname, '암호키')) enc2
         from Dept) sub;
