-- DML 데이터 추가(INSERT)
insert into student values(1001, '김철수', 2, '컴퓨터공학', '010-1111-1111');
insert into student values(1002, '이영희', 1, '경영학', '010-2222-2222'),
						(1003, '둘리', 4, '전자공학', '010-3333-3333'),
						(1004, '짱구', 3, '생명공학', '010-4444-4444');

-- DML 데이터 조회(SELECT)          
select * from student;              
select name, major from student;
select name, major from student where grade=4;

-- DML 데이터 수정(UPDATE ~ SET ~)	
-- 수정에서 where이 없으면 전체 행(row)을 수정하라는 명령어라서 가능한 절대 WHERE 없이 가능한 사용하지 않기
UPDATE student SET major = '컴공';
UPDATE student SET grade = 4 where student_id = 1001;

-- DML 데이터 삭제(DELETE)
-- 삭제 시에도 WHERE 절을 확인하자. WHETE 없이 삭제시 테이블이 지워질 수 있다.
DELETE FROM student ;
-- 삭제 쿼리는 없는 데이어 삭제 요청을 하더라도 오류가 아니다.
DELETE FROM student WHERE student_id;
