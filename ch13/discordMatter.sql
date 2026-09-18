use employees;
select * from employees;
select * from salaries;
select * from dept_emp;
select * from dept_manager;
select * from titles;
select * from departments;

select gender as 성별 from employees
union 
select gender as 성별 from employees;

/*
3.
사용 테이블 : dept_no
출력할 컬럼 : emp_no

다음 두 부서의 직원 번호를 UNION으로 합치고, to_date가 1993년인 경우를 오름차순으로 출력하세요.
dept_no = 'd001'
dept_no = 'd002'
*/


select emp_no from dept_emp where dept_no ='d001' and to_date like '1993%'
union
select emp_no from dept_emp where dept_no ='d002' and to_date like '1993%'
order by emp_no asc;

select * from employees;
select * from dept_emp;
select * from dept_manager;
select * from departments;


/*
employees 데이터베이스에서 현재 부서장과 일반 사원을 각각 조회한 뒤, 두 조회 결과를 UNION ALL로 합쳐 하나의 명단으로 출력하세요.

조건:
현재 근무 중인 기록(dept_manager 및 dept_emp의 to_date = '9999-01-01')만 출력하세요.
현재 부서장은 dept_manager, employees, departments 테이블을 JOIN하여 조회합니다.
일반 사원은 dept_emp, employees, departments 테이블을 JOIN하여 조회합니다. 현재 부서장인 사원은 서브쿼리를 사용해 일반 사원 명단에서 제외해야 합니다.
부서 번호, 사원 구분, 사번 순서의 오름차순으로 결과를 정렬하세요.

출력할 컬럼:
부서 번호
부서명
사원 구분 (부서장 또는 일반 사원)
사원 번호
사원 이름
*/
-- 부서장
select d.dept_no, d.dept_name, e.emp_no, e.first_name
from dept_manager dm
join employees e
on e.emp_no = dm.emp_no
join departments d
on d.dept_no = dm.dept_no
where dm.to_date = '9999-01-01';

-- 일반 사원
select d.dept_no, d.dept_name, e.emp_no, e.first_name
from dept_emp de
join employees e
on e.emp_no = de.emp_no
join departments d
on d.dept_no = de.dept_no
where dm.to_date = '9999-01-01';

select d.dept_no, d.dept_name, e.emp_no, e.first_name
from dept_emp de
join employees e
on e.emp_no = de.emp_no
join departments d
on d.dept_no = de.dept_no
where e.emp_no not in(
	select dm.emp_no 
    from dept_manager dm
    where dm.to_date = '9999-01-01'
);

select d.dept_no, d.dept_name,'부서장' as 직책, e.emp_no, e.first_name
from dept_manager dm
join employees e
on e.emp_no = dm.emp_no
join departments d
on d.dept_no = dm.dept_no
where dm.to_date = '9999-01-01'
union all
select d.dept_no, d.dept_name,'일반사원', e.emp_no, e.first_name
from dept_emp de
join employees e
on e.emp_no = de.emp_no
join departments d
on d.dept_no = de.dept_no 
where de.to_date = '9999-01-01'
and e.emp_no not in(
	select dm.emp_no 
    from dept_manager dm
    where dm.to_date = '9999-01-01'
)
order by dept_no, 직책, emp_no asc;

-- -------------------
/*
사용 테이블 : dept_manager, dept_emp
출력할 컬럼 : dept_no, emp_no, from_date, 직급

요규사항
-- 부서번호가 d001 이며 to_date가  '9999-01-01'인 값만 출력하세요
-- 직급은 dept_manager에서 가져온 데이터는 '매니저',.
-- dept_emp에서 가져온 데이터는 '직원'이라고 출력하세요
*/
select * from dept_emp;
select * from dept_manager;

select dept_no, emp_no, from_date, '매니저' as 직급 
from dept_manager 
where dept_no = 'd001' and to_date = '9999-01-01'
union 
select dept_no, emp_no, from_date, '직원' as 직급 
from dept_emp
where dept_no = 'd001' and to_date = '9999-01-01';

-- ---------
/*
조회 대상: 사원번호(emp_no)가 10001번부터 11000번 사이인 사원을 대상으로 합니다.

최신 데이터 추출: 사원별로 가장 최근 연봉 데이터 1건만 조회합니다.

등급 분류: 최신 연봉이 100,000달러 이상이면 'High', 100,000달러 미만이면 'Low'로 분류하세요.

결과 통합 및 정렬: UNION ALL을 사용해 두 결과를 하나로 합치고, 사원번호(emp_no) 기준 오름차순으로 정렬하세요.

출력 컬럼: emp_no, salary, status
*/

select * from employees;
select * from salaries;

select e.emp_no, s.salary, 'High' as status
from employees e
join salaries s
on e.emp_no = s.emp_no
where e.emp_no between 10001 and 11000 
and s.to_date = '9999-01-01'
and s.salary >= 100000

union all

select e.emp_no, s.salary, 'Low' as status
from employees e
join salaries s
on e.emp_no = s.emp_no
where e.emp_no between 10001 and 11000
and s.to_date = '9999-01-01'
and s.salary < 100000

order by emp_no asc;





