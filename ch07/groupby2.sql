DROP TABLE IF EXISTS tb_employees;
CREATE DATABASE tb_employees;
use tb_employees;
CREATE TABLE tb_employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary INT NOT NULL
);

INSERT INTO tb_employees (name, department, salary) VALUES
('김도현', '영업',   48000000),
('이소영', '영업',   55000000),
('박지영', '마케팅', 50000000),
('최민재', '마케팅', 45000000),
('강민호', '인사',   35000000),
('오수진', '인사',   40000000),
('정우성', '개발',   75000000),
('한지은', '개발',   65000000),
('윤서현', '개발',   72000000),
('문태준', '개발',   68000000),
('신동엽', '영업',   52000000),
('장미란', '영업',   51000000),
('황아영', '마케팅', 47000000),
('류현진', '인사',   43000000),
('김나영', '인사',   39000000);

select * from tb_employees;

-- 1. 부서별 평균 급여
select department as 부서, round(avg(salary), 0) as 평균
from tb_employees
group by department;

-- 2. 부서별 평균 급여가 5000만원 이상인 부서만 결과 집합으로 출력
select department as 부서, round(avg(salary), 0) as 평균
from tb_employees
group by department
having avg(salary) >= 50000000;

-- 3. 부서별 최고 급여, 최저급여
select department as 부서, max(salary) as 최고급여, min(salary) as 최저급여
from tb_employees
group by department;

-- 4. 직원이 4명 이상인 부서만 출력
select department as 부서, count(*) as 직원수
from tb_employees
group by department
having count(*) >= 4;

-- 5. 부서별 평균 급여와 직원 수 출력
select department as 부서, round(avg(salary), 0) as 평균, count(*) as 직원수
from tb_employees
group by department;

-- 6. WHERE 절과 HAVING 절의 차이
-- WHERE : 묶기 전에 행을 걸러낸다.
-- 5000만원 미만인 직원을 먼저 제외한 뒤 부서별 평균을 구한다.
select department, round(avg(salary), 0) as 평균
from tb_employees
where salary >= 50000000
group by department;

-- HAVING : 묶은 후 그룹을 걸러낸다.
-- 부서별 평균을 구한 후 5000만원 미만인 부서를 걸러낸다.
select department, round(avg(salary), 0) as 평균
from tb_employees
group by department
having avg(salary) >= 50000000;

-- 실습 문제 : 각 부서의 급여 격차가 큰 곳을 찾으려고 합니다. 
-- 최고 급여와 최저 급여의 차이가 1000만원 이상인 부서의 부서명, 최고 급여, 최저 급여, 급여 차이를 조회
select department, max(salary) as 최고급여, min(salary) as 최저급여, max(salary)-min(salary) as 급여차이
from tb_employees
group by department
having max(salary)-min(salary) >= 10000000;