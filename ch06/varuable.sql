DROP DATABASE IF EXISTS alias_practice;
CREATE DATABASE alias_practice;
USE alias_practice;

CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    score INT
);

INSERT INTO students VALUES (1, '홍길동', 75), (2, '김철수', 55);

SELECT * FROM students;

-- 1. 별칭
select 100 as student_id, '반장' as title;

-- 2. 테이블에 별칭 부여
select s.name
from students as s;

-- 사용자 변수란?
-- MySQL에서 @기호를 사용하여 사용자 정의 변수를 선언하고 사용할 수 있다.
-- 이 변수는 세션 단위로 유지되며, 간단한 데이터 저장과 조건 확인에 유용합니다.

-- 변수에 값 저장
set @score = 85;
-- 변수 출력
select @score as 점수;

-- 주의점. 선언하지 않은 변수를 출력하면 NULL
select @never_set;	-- 오류가 발생하지 않음(변수명 오타 조심)

-- 3. 변수에 쿼리 결과 저장하기
-- 문법 : SELECT 컬럼 INTO 변수 FROM 테이블 WHERE 조건;
-- SELECT ... INTO : 쿼리 결과를 변수에 저장할 수 있다..

-- students 테이블에서 점수를 가져와서 변수에 저장 가능
select score into @student_score from students where id = 1;
-- 확인
select @student_score;
-- 단, 컬럼과 변수의 개수가 맞아야하며, 앞에서부터 순서대로 짝지어진다.
select name, score into @n, @s from students where id=2;
select @n as name, @s as score;

-- 에러 확인
select score into @s2 from students;
-- Error Code: 1172. Result consisted of more than one row

-- 주의 : 0행일 때 에러가 발생하지 않는다.
set @zero = null;
select score into @zero from students where id = 99;
select @zero;

-- 4. if 함수 사용하기
select name, score, if(score >= 60, 'PASS', 'FAIL') as result
from students ;