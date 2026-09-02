-- 앞 차시에서 만든 shop 이 남아있으면 지우고 시작
DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;
USE shop;

-- 회원 테이블 생성 (PRIMARY KEY, UNIQUE KEY 사용)
CREATE TABLE member (
  id INT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(100) UNIQUE,
  name VARCHAR(50) NOT NULL,
  phone VARCHAR(20),
  join_date DATE NOT NULL
);

-- 상품 테이블 생성 (PRIMARY KEY 사용)
CREATE TABLE product (
  product_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  price INT NOT NULL,
  stock INT NOT NULL
);

-- 주문 테이블 생성 (FOREIGN KEY 사용)
CREATE TABLE orders (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  member_id INT,
  product_id INT,
  quantity INT NOT NULL,
  order_date DATE NOT NULL,
  FOREIGN KEY (member_id) REFERENCES member(id),
  FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- 회원 데이터 삽입
INSERT INTO member (email, name, phone, join_date) VALUES
('hong@test.com', '홍길동', '010-1234-5678', '2023-01-15'),
('kim@test.com', '김영희', '010-2345-6789', '2023-02-20'),
('lee@test.com', '이철수', '010-3456-7890', '2023-03-10');

-- 상품 데이터 삽입
INSERT INTO product (product_id, name, price, stock) VALUES
(1, '노트북', 1500000, 50),
(2, '스마트폰', 800000, 100),
(3, '헤드폰', 200000, 200);

-- 주문 데이터 삽입
INSERT INTO orders (member_id, product_id, quantity, order_date) VALUES
(1, 1, 1, '2023-03-25'),
(2, 2, 2, '2023-04-02'),
(3, 3, 3, '2023-04-03');

select * from member;
select * from product;
select * from orders;

-- /////////////////////////
-- 연습 문제
-- /////////////////////////
-- user 테이블 설계
create table user(
	id int primary key auto_increment,
    username varchar(50) unique,
    email varchar(50) unique,
    password varchar(50) not null,
    created_at datetime default current_timestamp
);

select * from user;

-- 정상 데이터
INSERT INTO user (username, email, password)
VALUES ('gildong', 'gildong@test.com', 'pass123');

-- 중복된 username
INSERT INTO user (username, email, password)
VALUES ('gildong', 'gildong2@test.com', 'pass234');
-- ERROR 1062 (23000): Duplicate entry 'gildong' for key 'username'

-- 중복된 email
INSERT INTO user (username, email, password)
VALUES ('hong', 'gildong@test.com', 'pass345');
-- ERROR 1062 (23000): Duplicate entry 'gildong@test.com' for key 'email'

-- /////////////////////////
-- 1. DDL 연습
-- /////////////////////////
-- category 테이블 생성
create table category (
  category_id int primary key,
  name varchar(50) not null
);

-- product 테이블에 category_id 컬럼 추가 및 외래키 설정
alter table product
add column category_id int,
add foreign key (category_id) references category(category_id);

-- orders 테이블에 인덱스 추가
create index idx_order_date on orders (order_date);

select * from category;

-- /////////////////////////
-- 2. DML 연습
-- /////////////////////////
-- category 테이블에 데이터 삽입
insert into category (category_id, name) values
(1, '전자제품'), (2, '가전제품');
select * from category;

-- product 테이블의 category_id 업데이트
update product 
set category_id = 1
where category_id is null;
select * from product;

-- 새로운 회원 추가
INSERT INTO member (email, name, phone, join_date) VALUES
('park@test.com', '박민지', '010-4567-8901', 20230405);
select * from member;

-- /////////////////////////
-- 3. SELECT 연습
-- /////////////////////////
-- 2023년 3월 이후 가입한 회원 조회
select * from member
where join_date >= 20230301;

-- 가격이 500,000원 이상인 상품 조회
select * from product
where price >= 500000;

-- /////////////////////////
-- 4. UPDATE 연습
-- /////////////////////////
-- 이철수의 전화번호를 '010-9999-0000'으로 변경
update member
set phone = '010-9999-0000'
where name = '이철수';
select * from member;

-- 재고가 100개 미만인 상품의 가격을 10% 인상
update product
set price = price * 1.1
where stock < 100;

select * from product;

-- /////////////////////////
-- 5. DELETE 연습
-- /////////////////////////
-- 2023년 4월 1일 이전 주문 삭제
delete from orders where order_date < 20230401;

-- 재고가 0인 상품 삭제
delete from orders where product_id = 1;
delete from product where stock =0;

select * from orders;

-- /////////////////////////
-- 6. 키 제약 조건 및 인덱스 연습
-- /////////////////////////
-- 중복 이메일 삽입 시도
INSERT INTO user (username, email, password)
VALUES ('hong', 'gildong@test.com', 'pass345');

-- 존재하지 않는 회원의 주문 추가 시도
INSERT INTO orders (member_id, product_id, quantity, order_date) VALUES
(6, 1, 1, '2023-03-25');

-- orders 테이블에서 member_id와 order_date로 복합 인덱스 생성
create index idx_member_id_order_date on orders (member_id, order_date);

-- 인덱스 활용 확인
show index from orders;
select * from orders
where order_date >=20230403;

-- /////////////////////////
-- 7. DCL
-- /////////////////////////
-- 새로운 사용자 생성 및 권한 부여 (test_user) - localhost 로 생성 
create user 'test_user'@'localhost' identified by 'password123';
grant select on shop.member to 'test_user'@'localhost';

-- 권한 확인
show grants for 'test_user'@'localhost';

-- 권한 회수
revoke select on shop.member from 'test_user'@'localhost';

-- /////////////////////////
-- 8. 테이블 설계와 제약 사항 설정 
-- /////////////////////////
create table movie(
	id int primary key auto_increment,
    title varchar(50) not null,
    director varchar(50) not null,
    release_date date not null,
    genre varchar(50) not null,
    rating decimal(4,2) not null
);

insert into movie (title, director, release_date, genre, rating) values
('괴물', '봉준호', 20060727, '드라마', 8.28),
('극한직업', '이병헌', '2019-01-23', '코미디', 9.20),
('명량', '김한민', '2014-07-30', '사극', 9.17),
('신과함께-죄와 벌', '김용화', '2017-12-20', '판타지', 7.56),
('밀양', '임권택', '2016-09-07', '드라마', 7.56),
('반도', '연상호', '2020-07-15', '액션', 6.71),
('베테랑', '류승완', '2015-08-05', '액션', 8.49),
('변호인', '양우석', '2013-12-18', '드라마', 8.41),
('군함도', '류승완', '2017-07-26', '사극', 8.01),
('군함도', '최동훈', '2015-07-22', '액션', 8.37);

select * from movie;