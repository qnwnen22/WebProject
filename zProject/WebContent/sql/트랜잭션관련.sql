select * from emp;

select * from emp2;

drop table emp2;

--테이블 복사(레코드는 복사되지 않음), 1=0은 false를 의미
create table emp2 as select * from emp where 1=0;

desc emp2;

alter table emp2 modify empno number(10);
alter table emp2 modify ename varchar2(20);
alter table emp2 modify deptno number(10);

commit;

select count(*) from emp2;
