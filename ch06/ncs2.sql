-- 1. [DB 및 사용자 생성]
DROP DATABASE IF EXISTS shop_db;
create database shop_db;
use shop_db;
CREATE USER 'shop_admin'@'localhost' IDENTIFIED BY 'password123';
grant select, insert, update, delete, create, drop, alter on shop_db.* to 'shop_admin'@'localhost';
 
-- 2. [테이블 및 제약조건 생성]
create table Member(
	id int primary key,
    name varchar(50) not null,
    address varchar(50) not null, 
    phoneNumber varchar(50) not null
);

create table Product(
	pro_id int primary key,
    pro_name varchar(50) not null,
    price int not null check (price >= 0)
);

insert into Member(id, name, address, phoneNumber) values
	(1, '홍길동', '서울', '010-1111-1111'),
	(2, '김철수', '부산', '010-2222-2222'),
	(3, '고길동', '경기', '010-3333-3333'),
	(4, '박영희', '강원', '010-4444-4444');
insert into Product(pro_id, pro_name, price) values
	(1, '시계', 5000),
	(2, '티셔츠', 25000),
	(3, '텀블러', 12000),
	(4, '신방', 50000);
 
select * from Member;
select * from Product;

-- 3. [인덱스 생성] 검색 성능 향상
create index idx_name
on Member(name);
show index from member;
