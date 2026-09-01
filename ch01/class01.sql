-- 데이터 집합 생성(DB 생성)
CREATE DATABASE db_tenco_market;

-- 어떤 데이터베이스를 사용할지 선택
use db_tenco_market;

-- 데이터 지합 삭제
DROP DATABASE db_tenco_market;

-- 대소문자 주의 
-- 키워드(SELECT, CREATE) 등 컬럼명은 대소문자를 구분하지 않는다.
-- 하지만 데이터베이스 명과 테이블 명은 운영체제에 따라 다를 수 있다.(대소문자 구분할 수도 있다)
-- Winodws(구별 x), Linux(구별 o) --> 만들 때 쓴 이름 그대로 쓰는 습관이 필요

CREATE DATABASE db_test1;
use db_test1;

-- 테이블 설계
CREATE TABLE userTBL(
	userName varchar(10) primary key,
    birthYear int not null,
    addr char(2) not null,
    mobile varchar(12) 
);

CREATE TABLE buyTBL(
	userName varchar(10) not null,
	prodName varchar(10) not null,
    price int not null,
    amount int not null,
    -- foreign key 만들기
    foreign key (userName) references userTBL (userName)
);

-- 테이블 보기
show tables;
-- 테이블 상세 내용 보기
desc userTBL;
desc buyTBL;

-- 테이블 정보 조회
select * from userTBL;
select * from buyTBL;

-- 컬럼에 대한 제약 수정
alter table userTBL modify column mobile varchar(13);

-- 고객 테이블에 데이터 삽입(저장)
insert into userTBL values ('이승기', 1987, '서울', '010-1111-1111');
-- 추가 고객 등록(컬럼명 명시)
insert into userTBL (userName, birthYear, addr) values ('윤종신', 1969, '경남');
-- 중복된 이름 저장 -> 작동 시 에러 발생
insert into userTBL (userName, birthYear, addr) values ('윤종신', 1969, '경남');

-- 구매 테이블 조회
select userName, prodName, price, amount from buyTBL;

-- 구매 테이블에 데이터 삽입
insert into buyTBL values ('이승기', '운동화', 30000, 1);

-- 고객 테이블과 구매 테이블은 현재 FK로 제약 설정이 되어있다.(userName)
-- 고객 테이블에 없는 userName은 구매 기록을 남길 수 없다. 
insert into buyTBL values ('홍길동', '컴퓨터', 1300000, 1); 

insert into buyTBL (userName, prodName, price, amount)
	values ('이승기', '컴퓨터', 1300000, 1); 