CREATE DATABASE normalization;
USE normalization;

-- 일부러 정규화하지 않은 테이블
CREATE TABLE 수강생_수업 (
    학생ID   INT         NOT NULL,
    학생이름 VARCHAR(20) NOT NULL,
    학생주소 VARCHAR(50) NOT NULL,
    강사ID   INT         NOT NULL,
    강사이름 VARCHAR(20) NOT NULL,
    강의명   VARCHAR(30) NOT NULL,
    수강료   INT         NOT NULL,
    PRIMARY KEY (학생ID, 강사ID)
);

INSERT INTO 수강생_수업 VALUES
(1, '홍길동', '서울 강남',   101, '김강사', '자바 기초',  500000),
(1, '홍길동', '서울 강남',   102, '이강사', 'MySQL 활용', 400000),
(2, '이순신', '부산 해운대', 101, '김강사', '자바 기초',  500000),
(3, '김유신', '대구 수성',   101, '김강사', '자바 기초',  500000);

SELECT * FROM 수강생_수업;

-- 한 테이블에 학생 정보, 강사 정보, 강의 정보가 모두 들어있는 상태이다.
-- 시나리오 1. 홍길동이 이사를 갔다면 위 데이터를 수정해야 한다.
start transaction;
update 수강생_수업 set 학생주소 = '부산진구'
where 학생ID = 1 and 강사ID = 101;

-- 1번과 2번 행을 모두 수정해야 한다.
-- 실수로 한 줄만 수정하면 같은 사람의 주소가 두 가지가 된다.
-- 즉, 이런 상황을 수정 이상 이라고 한다.(Update Anomaly)라고 한다.

rollback;

-- 시나리오 2. 자바 기초 수강료가 올랐다.
-- 50만원에서 60만원으로 인상
-- 1, 2, 3, 4 행을 모두 수정해야한다.
-- 하나라도 빠뜨리면 수강료가 제각각이 된다.

-- 시나리오 3. 홍길동이 MySQL 수강을 취소했다.
start transaction;
delete from 수강생_수업 where 학생ID = 1 and 강사ID = 102;
select * from 수강생_수업;
-- 이강사(102)의 정보가 통째로 사라진다. 
-- 삭제 이상
rollback;

-- 시나리오 4. 새 강사를 등록하고 싶은 경우
insert into 수강생_수업(강사ID, 강사이름) values (103, '박강사');
-- Error Code: 1364. Field '학생ID' doesn't have a default value
-- 박강사를 채용했지만 아직 배정된 강의가 없다.
-- 학생ID, 학생이름, 강의명이 not null이면 박강사의 정보를 저장할 수 없다.
-- 현재 스키마에서 강사만 따로 등록할 방법이 없다.
-- 삽입 이상

-- 정규화란?
-- 정규화(Normalization) 는 삽입이상, 삭제이상, 수정이상 등을 방지하기 위해
-- 테이블을 올바르게 분리하는 설계원칙이다.
-- 핵심 목표
-- 1. 데이터 중복 제거
-- 2. 수정, 삭제, 삽입 이상 방지
-- 3. 데이터 무결성 유지

