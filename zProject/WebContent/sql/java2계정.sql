select * from member;

purge RECYCLEBIN;

select * from member;

drop table member;

create table member (
userid varchar2(50) not null primary key,
passwd VARCHAR2(50) not null,
name varchar2(50) not null,
email varchar2(50),
hp varchar2(50),
zipcord varchar2(7),
address1 varchar2(200),
address2 varchar2(200),
join_date date default sysdate
);

insert into member(userid,passwd,name,email) values('kim','1234','梯繹熱','kim@naver.com');
insert into member(userid,passwd,name,email) values('hong','1234','�垮瘚�','hong@nate.com');
insert into member(userid,passwd,name,email) values('choi','1234','譆團熱','choi@nate.com');


commit;