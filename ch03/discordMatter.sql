-- DB 파악 : 어떤 테이블이 존재, 어떤 의미인지 파악
-- 1일 1쿼리를 진행(스스로 문제를 만들어서 디스코드 채널 sql-연습문제를 올리기)
-- 단, employees DB안에서 문제 생성(진도 기준 1문제씩)

DROP TABLE IF EXISTS employees_copy;
create table employees_copy like employees;
insert into employees_copy select * from employees;
select * from employees_copy ;

DROP TABLE IF EXISTS dept_emp;
create table dept_emp_copy like dept_emp;
insert into dept_emp_copy select * from dept_emp;

-- 1. dept_emp_copy 테이블에서 from_date가 2000년도 이상 이면서 to_date가 '9999-01-01'가 아닌 값을 출력하세요 (employees 데이터베이스 기준입니다)
select * from dept_emp_copy 
where from_date >= 20000101 and to_date != 99990101;

-- 2. select_practice DB의 student테이블에 age컬럼을 추가하고 grade가 1학년인 학생의 age를 20으로 설정하세요.
USE select_practice;
alter table student add age int;
update student
set age = 20
where grade = 1;

-- 3. employees_copy의 dept_emp를 활용하여 emp_no가 10604이고 dept-no가 d005인 사원의 from_date를 1990-04-07에서 1990-04-08으로 수정해주세요.:)
update dept_emp_copy
set from_date = 19900408
where emp_no = 10604 and dept_no = 'd005';

-- 4. employees 데이터베이스의 employees_copy 테이블에 데이터를 실제로 삭제하지 않고 삭제 여부만 표시하는 기능(Soft Delete)을 추가하려고 합니다.
-- 삭제 여부를 저장할 is_deleted 컬럼을 추가하세요.
-- 데이터 타입은 BOOLEAN입니다.
-- 기본값은 FALSE입니다.
-- ALTER TABLE employees_copy ADD COLUMN is_deleted BOOLEAN DEFAULT FALSE;
-- hire_date가 1985-01-31 이하인 행의 is_deleted 값을 TRUE로 변경하세요
ALTER TABLE employees_copy ADD COLUMN is_deleted BOOLEAN DEFAULT FALSE;
update employees_copy
set is_deleted = 'TRUE'
where hire_date <= 19850131;

-- (어느 테이블인지 몰라서 풀기 어렵고 매니저가 된 사람이 아니라 고용일 같음..)
-- 5. 1996-01-03일에 매니저가 된 사람의 사원번호를 10998로 변경한뒤 변경된 사원번호에 매니저이름만 찾아주세요.
update employees_copy
set emp_no = 10998
where hire_date = 19960103;
select first_name from employees_copy
where emp_no = 10998;

-- 6. employees_copy DB에 email을 추가해주세요. (길이 50) email이 null인 사원은 '이메일이 등록되지 않았습니다.'를 채워주세요.
alter table employees_copy add email varchar(50);
update employees_copy
set email = '이메일이 등록되지 않았습니다.'
where email is null;

-- 7. employees_copy에서 hire_date가 1990-01-01 이하인 사원 중 gender가 'F' 인 사원들의  hire_date를 1990-10-31로 변경해주세요
update employees_copy
set hire_date = 19901031
where hire_date <= 19900101 and gender = 'F';

-- 8. employees DB에 있는 titles 테이블을 복사하고, to_date가 9999로 시작하는 값 삭제하세요.(titles에서 삭제 하지 않게 주의!)
DROP TABLE IF EXISTS titles_copy;
create table titles_copy like titles;
insert into titles_copy select * from titles;
select * from titles;
delete from titles_copy
where to_date like '9999%';
select * from titles_copy;

-- 9. employees_copy 테이블에 fired_date를 추가하고 디폴트값 null 넣어주세요.
alter table employees_copy add fired_date date default null;

-- 10. employees_copy에서 emp_no 10001~10012이면서  first_name이 P로 시작하는 사원의 gender를 F로 수정해주세요
update employees_copy
set gender = 'F'
where (emp_no between 10001 and 10012) and first_name like 'P%';

-- 11. employees_copy에서 first_name이 Aleksandar인 1950년대 출생인 사람을 조회해주세요
select * from employees_copy
where first_name = 'Aleksandar' and (birth_date >= 19500101 and birth_date < 19600101);

-- 12. 


-- 13. 


-- 14. 

