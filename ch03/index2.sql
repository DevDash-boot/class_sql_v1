use employees;
select * from employees_copy3;
desc employees_copy3;
-- 인덱스 조회
show index from employees_copy3;

-- 인덱스 생성 후 다시 검색
select * from employees_copy3
where gender = 'M';

-- gender에 인덱스 추가
alter table employees_copy3
add index idx_gender (gender);

select * from employees_copy3
where emp_no = 15689;

-- 실습 : 인덱스 키 직접 생성
-- 쿼리 앞에 EXPLAIN을 사용하면 쿼리 실행 계획을 바로 확인할 수 있다.
EXPLAIN select * from employees_copy3
where last_name = 'Berztiss';

alter table employees_copy3
add index idx_last_name (last_name);