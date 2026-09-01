-- DCL

-- 사용자 계정 생성 
-- localhost는 내 컴퓨터 안에서 접근하는 계정
-- 외부에서 접근하려면 %, 192.168.4.12 처럼 ip주소를 명시해야한다.
CREATE USER 'user1'@'localhost' identified by 'password123';

-- 새로 생성한 user1에 조회 권한을 부여 -> school.studnet 테이블의 조회 권한만 부여
-- DCL 조회 권한 부여(GRANT)
GRANT select on school.student to 'user1'@'localhost';
-- DCL 삽입 권한 부여(GRANT)
GRANT INSERT ON school.student to 'user1'@'localhost';

-- GRANT은 권한을 덮어쓰기 하는 것이 아니라 더해지는 개념
-- 쉼표를 사용해서 한 번에 권한을 부여할 수 있다.
GRANT UPDATE, DELETE ON school.student to 'user1'@'localhost';

-- 권한 확인
show grants for 'user1'@'localhost';

-- 외부에서 접근할 수 있는 계정
CREATE USER 'user1'@'%' identified by 'password123';
show grants for 'user1'@'%';
GRANT select on school.student to 'user1'@'%';

-- DCL 권한 회수 (REVOKE)
REVOKE INSERT, UPDATE, DELETE ON school.student FROM 'user1'@'localhost';

-- 계정 삭제
DROP user 'user1'@'localhost';

SELECT current_user();

-- ////////////////////////////////////
-- 도전 과제 1. 외부에서 접근할 수 있는 계정 생성하고 권한 관리해서 테스트 해보기(팀장 및 팀원 테스트)
-- ////////////////////////////////////
CREATE USER 'user1'@'%' identified by 'password123';

