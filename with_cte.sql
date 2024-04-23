WITH RECURSIVE fibonacci (n, fib_n, next_fib_n) AS
(
    select 1, 0, 1
    UNION ALL
    select n + 1, next_fib_n, fib_n + next_fib_n
      from fibonacci where n < 10
)
select * from fibonacci;



insert into Dept(pid, dname) values(6, '인프라셀');
insert into Dept(pid, dname) values(6, 'DB셀');
insert into Dept(pid, dname) values(7, '모바일셀');

select * from Dept;
WITH RECURSIVE CteDept(id, pid, pname, dname, d, h) AS 
(
    select id, pid, cast('' as char(31)), dname, 0, cast(id as char(10)) from Dept where pid = 0
    UNION ALL
    select d.id, d.pid, cte.dname, d.dname, d + 1, concat(cte.h, '-', d.id) from Dept d inner join CteDept cte on d.pid = cte.id
)
select /*+ SET_VAR(cte_max_recursion_depth = 5) */ d, dname, h from CteDept order by h;
