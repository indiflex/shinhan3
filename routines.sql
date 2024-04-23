select e.*, d.dname
  from Emp e left outer join Dept d on e.dept = d.id;
  
select dname from v_emp where id = 10;
select dname from (select e.*, d.dname
  from Emp e left outer join Dept d on e.dept = d.id) sub;