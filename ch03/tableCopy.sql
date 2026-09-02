-- 1. 테이블 복사 방법 (테이블 + 데이터)
-- 데이터는 그대로 들어오지만 제약 조건과 인덱스는 따라오지 않는다.
CREATE TABLE employees_copy AS SELECT * FROM employees;
select * from employees_copy;

-- 2. 구조만 복사
-- 위와 반대로 제약 조건과 인덱스를 그대로 가져 오지만 데이터는 가져오지 않는다.
CREATE TABLE employees_copy2 LIKE employees;
select * from employees_copy2;

-- 3. 완전 복사
CREATE TABLE employees_copy3 LIKE employees;
INSERT INTO employees_copy3 SELECT * FROM employees;
SELECT * FROM employees;
