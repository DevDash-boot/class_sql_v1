create database school;
use school;
create table student(
	student_id int primary key,
    name varchar(50) not null,
    grade int not null, 
    major varchar(50) not null,
    phone varchar(20) 
);

desc student;

-- DDL 컬럼 추가
alter table student add column email varchar(100);

-- DDL 컬럼 수정 - phone 길이를 20에서 30으로 바꾸기(modify)
alter table student modify column phone varchar(30);

-- DDL 컬럼 수정 - email을 email_address 로 바꾸면서 길이도 150으로 늘린다.(change)
alter table student change column email email_address varchar(150) not null;

-- DDL 컬럼 수정 - 이름만 변경 (8.0 이상 버전에서는 RENAME 사용)
alter table student rename column email_address TO email;

-- DDL 컬럼 삭제 
alter table student drop column email;

-- DDL 테이블 삭제
drop table student;

-- DDL 데이터베이스 삭제
drop database school;