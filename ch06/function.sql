DROP DATABASE IF EXISTS ansi_practice;
CREATE DATABASE ansi_practice;
USE ansi_practice;

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2),   -- 최대 99999999.99
    hire_date DATE
);
INSERT INTO employees (id, name, email, department, salary, hire_date) VALUES
(1, '김철수', 'kim@test.com',  '인사부',   3000000.00, '2024-03-01'),
(2, '박영희', 'park@test.com', '개발부',   4000000.00, '2024-06-15'),
(3, '이민준', 'lee@test.com',  '기획부',   3500000.00, '2023-01-10'),
(4, '최지아', 'choi@test.com', '마케팅부', 3200000.00, '2024-05-21'),
(5, '한수연', 'han@test.com',  '영업부',   2900000.00, '2021-12-30'),
(6, '정우성', 'jung@test.com', NULL,       3100000.00, '2025-02-01');

SELECT * FROM employees;

-- 테이블 복사 쿼리
create table new_employee
as select * from employees
where id < 5;

-- CATS(create table as select) 라고 불리는 SQL 문법 
-- 위 코드로는 제약조건(기본키, 외래키) 등은 복사가 안됨
-- 다른 DB에 있는 테이블도 복사해서 가져올 수 있다.
use ansi_practice;
create table new_departments
as select* from employees.departments;
-- where id < 5;

-- 주요 함수 사용해보기
-- 1. 집계함수
-- 문제 1 : 전체 직원 수아 부서가 정해진 직원 수 (count)
select * from employees;

select count(*) as 전체, count(department) as 부서있음
from employees;
-- count(컬럼) 컬럼이 NULL이 아닌 행만 센다.

-- 문제 2 : 평균 급여, 최고 급여, 최저 급여 (sum, avg, max, min)
select round(avg(salary),2) as 평균, max(salary) as 최고, 
	min(salary) as 최저, sum(salary) as 합계
from employees;

-- 주의
select round(avg(salary),2) as 평균, max(salary) as 최고, 
	min(salary) as 최저, sum(salary) as 합계, 
    name	-- 오류 : 집계 결과는 1행인데 name은 6행이라 어느것을 보여줄지 사실 정할 수 없다,
    -- 현재 버전에서는 제일 위의 값이 출력된다. 하지만 논리적 모순이다.
from employees;

-- 2. 문자열 함수
-- 문제 3 : 이름 뒤에 '님'을 붙이고, 성씨만 뽑기(concat, substring)
select name, concat(name, ' 님') as 호칭,
	-- substring(name, 1(첫 번째 글자부터), 1(n번째 글자까지))
    substring(name, 1, 1) as 성씨,
    -- 성씨 한 글자만 남기고 나머지는 *로 남기는 방법
    concat(substring(name, 1, 1), '**') as 마스킹
from employees;

-- 문제 4 : 이메일을 대문자로 바꾸고, 앞 4글자 뽑기(upper, lower)
-- 단, 한글에는 대소문자 구분이 없어서 아무 변화가 없다.
select email, 
	upper(email) as 대문자, 
	lower(email) as 소문자,
    substring(email, 1, 4) as 앞4글자
from employees;

-- 논리 및 조건 함수
-- 문제 5 : 급여에 따라서 등급을 나누기(CASE)
select name, salary,
	case 
		when salary >= 3500000 then '상'
        when salary >= 3000000 then '중'
        else '하'
    end as 등급
from employees
order by 등급 asc;
-- 주의. 조건에 쓴 컬럼의 값이 salary null 이라면 when에 걸리지 않고 else로 바로 떨어진다.

-- 도전 과제 5-1 : 만약 부서가 없으면 '미배정'으로 출력하기
select *from employees;

select name, department,
	case 
		when department IS NULL then '미배정'
        else department
    end as 표시부서
from employees;

-- 문제 6 : 부서가 없으면 '미배정'으로 표시(COALESCE)
select name, department,
	coalesce(department, '미배정') as 표시부서
    -- 첫 번째 인자 값이 null 이라면 두 번째 값을 반환
from employees;

-- 4. 날짜 및 시간 함수
-- 문제 7 : 오늘 날짜와 현재 시간을 표시
select current_date() as 오늘,
	current_time() as 현재시간,
    current_timestamp() as 현재일시;

-- 문제 8 : 입사 연도와 월 추출 또는 입사일 추출해보기
-- EXTRACT(단위 FROM 날짜) 단위에는 YEAR, MONTH, DAY, HOUR 등이 들어갈 수 있다.
select name, hire_date, 
	extract(year from hire_date) as 입사연도,
	extract(month from hire_date) as 입사월,
	extract(day from hire_date) as 입사일,
	extract(hour from hire_date) as 입사시간
from employees
limit 3; 

-- 문제 9 : 근속 일수 계산(DATEDIFF)
-- DATEDIFF 함수는 MySQL 전용 함수이다.
select name, hire_date, 
	datediff(current_date, hire_date) as 근무일수
from employees;

-- 근속년수
select name, hire_date, 
	datediff(current_date, hire_date) as 근무일수,
	floor(datediff(current_date, hire_date) / 365.0) as 근무년수
from employees;

-- 5. 형 변환 함수
-- 문제 10 : CAST
-- signed : 부호 있는 정수, 음수를 담을 수 있다.
select cast('123' as signed) as 숫자변환;
select cast('-123' as signed) as 숫자변환;

-- unsigned : 부호가 없는 정수, 0 이상만 담을 수 있다.
select cast('123' as unsigned) as 숫자변환;
select cast('-123' as unsigned) as 숫자변환; -- 18446744073~ 출력됨

-- MySQL 에서는 문자열 + 숫자는 숫자로 계산됨(자바랑 다름)
select '123' + 3 as 문자열덧셈;	-- 126

-- 만약 위 결과를 1233으로 표시하고 싶다면 
SELECT '123' + '3' AS 문자열덧셈; -- 126
-- MySQL에서는 문자열을 이을려면 반드시 concat을 사용해야한다.
select concat('123', 3) as 문자열더하기; -- 1233

-- 문자열 형 변환 시 varchar 대신 var를 사용해야 한다.
select cast(123 as char) as 확인;

