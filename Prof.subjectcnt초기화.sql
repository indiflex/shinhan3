start transaction;

create temporary table tmp_subject AS
select prof, count(*) cnt
  from Subject
 group by prof;
 
select * from tmp_subject;

update Prof p inner join tmp_subject t on p.id = t.prof
  set p.subjectcnt = t.cnt;

select * 
  from Prof p inner join tmp_subject t on p.id = t.prof;

commit;