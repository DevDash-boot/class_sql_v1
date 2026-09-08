DROP DATABASE IF EXISTS self_join;
CREATE DATABASE self_join;
USE self_join;

CREATE TABLE employees (
    employee_id   INT PRIMARY KEY,		-- 사번
    employee_name VARCHAR(50) NOT NULL,	-- 이름
    department    VARCHAR(20) NOT NULL, -- 부서
    salary        INT NOT NULL,        	-- 연봉, 만원 단위
    manager_id    INT                  	-- 상급자의 employee_id. 없으면 NULL
);

INSERT INTO employees VALUES
(1, '김민수', '경영', 9000, NULL),
(2, '박지훈', '개발', 7000, 1),
(3, '이서연', '영업', 6500, 1),
(4, '최준호', '개발', 5000, 2),
(5, '정하윤', '개발', 5500, 2),
(6, '강도현', '영업', 4800, 3);

SELECT * FROM employees;

-- 1. 계층 구조 조회(셀프 조인 활용)
-- 즉, 각 직원의 상급자 이름을 조회(결과 집합)
select * 
from employees e
left join employees m		-- 매니저 이름을 찾기 위한 사본 테이블
on e.manager_id = m.employee_id;

select e.*, m.employee_name as 상급자
from employees e
left join employees m		-- 매니저 이름을 찾기 위한 사본 테이블
on e.manager_id = m.employee_id;

-- LEFT JOIN을 INNER JOIN으로 변경해보기
select e.*, m.employee_name as 상급자
from employees e
INNER join employees m		-- 매니저 이름을 찾기 위한 사본 테이블
on e.manager_id = m.employee_id;

-- 상급자의 차상급자까지 찾기
select e.employee_id, e.employee_name, m.employee_id, 
	m.employee_name as 상급자, s.employee_id, s.employee_name as 차상급자
from employees e
left join employees m
on e.manager_id = m.employee_id
left join employees s
on m.manager_id = s.employee_id;

-- 용도 2. 같은 테이블 안에서 서로 다른 행을 비교할 수 있다.
-- 조건 : 같은 부서, 나보다 연봉이 높은 사람 
select e.employee_name as 직원, e.salary as 내연봉, h.employee_name as 더높은사람, h.salary as 높은사람연봉
from employees e
join employees h
on e.department = h.department and e.salary < h.salary
order by e.employee_name;

-- on에 조건을 2개 써야 하는 이유
-- 1. 만약 join 연산에서 on절이 없으면 크로스 조인이 된다.
-- 2. on 조건에서 부서만 있는 경우 확인
select e.*
from employees e
join employees h
on e.department = h.department
where e.department = '개발'
order by e.employee_name;

-- 3. on 조건에서 연봉만 있는 경우 확인
select e.*
from employees e
join employees h
on e.salary < h.salary	-- 부서 상관없이 나보다 높은 사람 다 조합
where e.employee_name = '강도현'
order by e.employee_name;

-- ON 과 WHERE 중 어디에 조건을 걸어야 할까?
-- 결과가 같다
select e.employee_name as 직원, e.salary as 내연봉, h.employee_name as 더높은사람, h.salary as 높은사람연봉
from employees e
LEFT join employees h
on e.department = h.department 
where e.salary < h.salary
order by e.employee_name;

-- 연습 문제 1. 각 직원의 (이름, 부서, 상급자 이름, 상급자의 부서)를 조회하세요. 상급자가 없는 직원도 결과에 나와야 합니다.
select e.employee_name, e.department, m.employee_name, m.department
from employees e
LEFT join employees m
on e.manager_id = m.employee_id
order by e.employee_name;

-- 연습 문제 2. 각 직원의 이름과 그 직원의 직속 부하 직원 이름을 조회하세요. 부하 직원이 없는 직원도 결과에 나와야 합니다.
select e.employee_name, m.employee_name
from employees e
left join employees m
on m.manager_id = e.employee_id 
order by e.employee_id;