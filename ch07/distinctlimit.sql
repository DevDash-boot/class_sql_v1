SELECT distinct department 
FROM tb_employees 
order by department asc;

SELECT distinct department, salary 
FROM tb_employees 
order by department asc;

SELECT * FROM tb_employees
limit 3 offset 1;

-- row 15개, 한 페이지 5개씩 출력
-- 1페이지
SELECT * FROM tb_employees
limit 5 offset 0;
-- 2페이지
SELECT * FROM tb_employees
limit 5 offset 5;
-- 3페이지
SELECT * FROM tb_employees
limit 5 offset 10;