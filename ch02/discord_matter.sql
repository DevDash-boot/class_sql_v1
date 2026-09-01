use employees;

-- DB 파악 : 어떤 테이블이 존재, 어떤 의미인지 파악

-- 1일 1쿼리를 진행(스스로 문제를 만들어서 디스코드 채널 sql-연습문제를 올리기)
-- 단, employees DB안에서 문제 생성(진도 기준 1문제씩)

select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;

-- 디스코드 문제 9/1
-- 1. titles 테이블에서 title이 'Senior'로 시작하고, from_date가 1990-01-01 이전인 레코드를 출력하시오.
select * from titles where title like 'Senior%' and from_date < '1990-01-01';
-- 2. employees 테이블에서 emp_no가 10010인 사람을 검색하세요
select * from employees where emp_no =10010;
-- 3. salaries 테이블에서 salary가 100000 이상인 사람 조회
select * from salaries where salary >= 100000;
-- 4. dept_emp 테이블에서 to_date가 9999-01-01이 아닌 값을 출력하세요
select * from dept_emp where to_date != '9999-01-01';
-- 5. EMPLOYEES 테이블에서 남자 직원들을 조회하세요
select * from employees where gender = 'M';
-- 6. employees 테이블에서 birth_date 가 9월인 사람을 출력하시오.
select * from employees where birth_date like '%-09-%';
-- 7. employees 테이블에서 gender가 M인 first_name과 last_name만 출력하시오
select first_name, last_name from employees where gender = 'M';
-- 8. employees 테이블에서 emp_no가 10111인 사람을 검색하시오
select * from employees where emp_no = 10111;
-- 9. salaries 테이블에서 from_date가 2000-01-01 이전이고 to_date가 2000-01-01 이후인 salary만 출력해주세요
select salary from salaries where from_date < '2000-01-01' and to_date >= '2000-01-01';
-- 10. titles 테이블에서 from_date가  2001-10-11 일부터  2001-10-15 일 까지  인  titles  조회하기
select title from titles where from_date between '2001-10-11' and '2001-10-15';
-- 11. employees의 departments 테이블을 활용하여 부서번호 d001에서 d009까지만 조회하세요.
select * from departments where dept_no between 'd001' and 'd009';
-- 12. employees 테이블에서 여자 직원들중 birth_date가 3월인 사람을 조회하시오.
select * from employees where gender = 'F' and birth_date like '%-03-%';
-- 13. employees 테이블에서 emp_no가 10000~10050인것중에 성별이M인것을 조회하시오.
select * from employees where (emp_no between 10000 and 10050) and gender = 'M'; 