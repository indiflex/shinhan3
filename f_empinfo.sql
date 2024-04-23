CREATE DEFINER=`root`@`%` FUNCTION `f_empinfo`(_id int unsigned) RETURNS varchar(64) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci
BEGIN
    declare v_ret varchar(64) default 'Not Found';
    
    -- concat(e.ename, '(', ifnull(d.dname, '미배정'), ')') into v_ret
    select (case when d.dname is null then e.ename
                else concat(e.ename, '(', d.dname, ')')
            end) into v_ret
      from Emp e left outer join Dept d on e.dept = d.id
     where e.id = _id;

RETURN v_ret;
END