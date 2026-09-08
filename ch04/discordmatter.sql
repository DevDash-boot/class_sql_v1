use employees;

-- INNER JOIN 문제
-- employees DB에 있는 departments 테이블과 dept_manager 테이블을 이용해서 
-- dept_no가 d006인 dept_no, dept_name, from_date, to_date를 조회하세요.
select * from departments;
select * from dept_emp;
select * from dept_manager;

select d.*, m.from_date, m.to_date
from departments d
inner join dept_manager m
on d.dept_no = m.dept_no
where d.dept_no = 'd006';

-- LEFT JOIN 문제
-- employees DB에 있는 dept_emp 테이블과 dept_manager 테이블에서
-- e의 from_date가 1985년이면서 m의 from_date가 1991년인 e.dept_no, e.from_date, m.from_date의 정보를 조회하세요.
-- e는 dept_emp의 별칭, m은 dept_manager의 별칭입니다.
select e.dept_no, e.from_date, m.from_date
from dept_emp e
left join dept_manager m
on e.dept_no = m.dept_no
where e.from_date like '1985%' and  m.from_date like '1991%';

-- 1. employees 데이터 베이스에서 dept_manager 테이블와 titles 테이블 inner join를 구하세요
-- inner join 문제
select * from dept_manager m
inner join titles t
on m.emp_no = t.emp_no;

-- 2.[inner join] 
-- employees db와 inner join을 활용하여 아래의 결과가 출력되도록 해주세요
-- from_date가 '1985-02-03' 또는 '1985-02-05'인 사원의 emp_no와 dept_no 조회

select e.emp_no, m.dept_no
from dept_emp e
inner join dept_manager m 
on e.dept_no = m.dept_no
where e.from_date = 19850203 or e.from_date = 19850205;

-- [outer join] employees db와 outer join을 활용하여 아래의 결과가 출력되도록 해주세요.  
-- departments 정보와 LEFT JOIN 을 사용하여 from_date가 '1985-02-03' 또는 '1985-02-05'인 사원의 정보를 조회해주세요.
-- 조건 1. 사원의 정보는 dept_no, dept_name, emp_no, from_date, to_date가 줄력되어야 합니다.
-- 조건 2. 중복된 컬럼없이 출력하세요.


-- 3.여러 테이블을 연결할 때 LEFT JOIN과 RIGHT JOIN을 섞어 쓰면, 어느 테이블의 데이터가 모두 남는지 계속 방향을 바꿔 가며 생각해야 합니다. 가독성과 유지 보수를 위해 RIGHT JOIN 사용을 제한하는 규칙을 실무에서 적용하기도 합니다.
-- 이 SQL을 다음 조건에 맞게 다시 작성하세요. 
-- 조회 결과는 원래 SQL과 같아야 합니다.
-- RIGHT JOIN은 하나도 사용하지 마세요.
-- 모든 테이블을 LEFT JOIN으로 연결하세요

SELECT e.emp_no
    , e.first_name
    , e.last_name
    , de.dept_no
    , d.dept_name
    , de.from_date
FROM departments d
RIGHT JOIN dept_emp de
    ON d.dept_no = de.dept_no
RIGHT JOIN employees e
    ON de.emp_no = e.emp_no
WHERE e.emp_no BETWEEN 10001 AND 10100;

SELECT e.emp_no
    , e.first_name
    , e.last_name
    , de.dept_no
    , d.dept_name
    , de.from_date
FROM dept_emp de
left JOIN departments d
    ON d.dept_no = de.dept_no
left JOIN employees e
    ON de.emp_no = e.emp_no
WHERE e.emp_no BETWEEN 10001 AND 10100;

