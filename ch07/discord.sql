select * from salaries;
select emp_no, round(avg(salary)) as avgSalary 
from salaries
group by emp_no
having emp_no <= 10005;

select *, price*stock as total_price 
from product
order by total_price desc;

use employees;
select * from employees;
select * from salaries;
select e.gender, avg(s.salary)
from employees e
left join salaries s
on e.emp_no = s.emp_no
where e.hire_date < "1990-01-01"
group by e.gender;

select * from dept_emp;
select * from departments;
select *, count(e.dept_no)
from departments d
left join dept_emp e
on d.dept_no = e.dept_no
group by d.dept_no
order by count(e.dept_no) desc
limit 5;
