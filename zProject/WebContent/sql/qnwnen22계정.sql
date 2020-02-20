select * from web;

create table web(
userid varchar2(50) primary key,
userpw varchar2(50) not null,
username varchar2(50) not null,
email varchar2(50),
hp varchar2(50)
);

insert into web (userid,userpw,username,email,hp) values ('aaa','111','ÀÌ¿øÇõ','aaa@naver.com','000-1234-1234');

commit;
