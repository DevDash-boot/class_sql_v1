-- 1. [DDL] 부서(Department) 및 사원(Employee) 테이블 생성
DROP DATABASE IF EXISTS ncs;
create database ncs;
use ncs;
create table Department(
	dept_no int primary key,
    dept_name varchar(50) not null
);
create table Employee(
	emp_no int primary key,
    emp_name varchar(50) not null,
    dept_no int not null,
    foreign key (dept_no) references Department(dept_no)
);
select * from Department;
select * from Employee;

-- 2. [DML] 테스트 데이터 입력 및 조인 조회
insert into Department(dept_no, dept_name) values
(1, '영업부'),
(2, '인사부'),
(3, '경영기획부'),
(4, '재무/회계부');

insert into Employee values
(1, '홍길동',1),
(2, '김철수',2),
(3, '고길동',3),
(4, '김영희',4),
(5, '최둘리',1),
(6, '이꼬마',2),
(7, '박길동',3);

select e.emp_name, d.dept_name
from Department d
left join Employee e
on e.dept_no = d.dept_no;

-- 3. [DCL] 특정 사용자(dev_user)에게 테이블 조회 권한 부여
CREATE USER 'dev_user'@'localhost' IDENTIFIED BY 'password123';
grant SELECT on ncs.Employee to 'dev_user'@'localhost'
