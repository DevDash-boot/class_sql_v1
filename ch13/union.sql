DROP DATABASE IF EXISTS union_practice;
CREATE DATABASE union_practice;
USE union_practice;

-- 재학생과 졸업생
CREATE TABLE students (
    id    INT         PRIMARY KEY AUTO_INCREMENT,
    name  VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL
);

CREATE TABLE alumni (
    id    INT         PRIMARY KEY AUTO_INCREMENT,
    name  VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL
);

INSERT INTO students (name, email) VALUES
('김철수', 'chulsoo@example.com'),
('이영희', 'younghee@example.com'),
('박민수', 'minsoo@example.com');

INSERT INTO alumni (name, email) VALUES
('김철수', 'chulsoo@example.com'),    -- 재학생과 중복
('최영수', 'youngsoo@example.com'),
('이영희', 'younghee@example.com');   -- 재학생과 중복

select * from students;
select * from alumni;

-- 1. UNION ALL : 전부 이어 붙이기
select name, email from students 
UNION ALL
select name, email from alumni;

-- 2. UNION : 중복을 제거한다.
select name, email from students 
UNION
select name, email from alumni;

-- 중복의 판단 기준 : 선택한 모든 컬럼의 값이 같으면 중복으로 판단한다.
-- 하나라도 값이 다르면 중복이 아니다

-- 어느 것을 사용할까?
--  UNION ALL : 중복이 없다고 확신할 때 
-- 				주문과 환불처럼 성격이 다른 데이터를 합칠 때
-- 				UNION 보다 빠르다(장점)

--  UNION : 중복을 없애야 할 때
-- 			중복을 찾기 위해 전체를 정렬하고 비교해야 하기 때문에 느리다.

-- UNION 규칙
-- 규칙 1. 컬럼 수가 같아야 한다.
select name from students 
union
select name, email from alumni;
-- Error Code: 1222. The used SELECT statements have a different number of columns

-- 규칙 2. 타입이 달라도 오류는 나지 않는다.(조심해야 할 부분)
select name from students
union 
select id from alumni;
-- 합치기 전에 확인할 것
-- 두 SELECT의 컬럼 개수가 같은지?
-- 같은 자리의 컬럼이 같은 뜻인지?

-- 규칙 3. 컬럼명은 첫 번째 SELECT 의 기준이 된다.
select name as 이름 from students 
union 
select name as 성명 from alumni;

-- 규칙 4. ORDER BY 맨 끝에 한번만 사용해야 된다.
select name as 이름 from students order by name
union 
select name as 성명 from alumni order by name;
-- Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'union  select name as 성명 from alumni order by name' at line 2
select name as 이름 from students 
union 
select name as 성명 from alumni 
order by 이름;
-- 별칭이 있다면 첫 번째 SELECT의 별칭 값으로 정렬

-- 규칙 5. ORDER BY가 없으면 순서는 보장되지 않는다. 




