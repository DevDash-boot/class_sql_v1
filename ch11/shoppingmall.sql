drop database if exists mall;
create database mall;
use mall;

-- 고객 테이블
create table customer(
	cid varchar(50) primary key,
    cpw varchar(255) not null,
    cname varchar(50) not null,
    address varchar(100) not null,
    tel varchar(20) not null,
    email varchar(20) not null,
    grade varchar(10)
);

-- 상품 테이블
create table product(
	pid int primary key auto_increment,
    pname varchar(100) not null,
    price int not null,
    sales int
);

-- 주문 테이블
create table orders(
	oid int primary key auto_increment, 
    payment varchar(50) not null,
    orderDate date not null,
    customerId varchar(50),
    foreign key(customerId) references customer(cid)
);

-- 주문 상세 테이블
create table orderItem(
	otid int primary key auto_increment, 
    orderId int null,
    productId int,
    quantity int not null,
	foreign key(productId) references product(pid),
	foreign key(orderId) references orders(oid)
);

insert into customer(cid, cpw, cname, address, tel, email, grade) values
('a123', '11111', '김김김', '서울', '010-1111-1111', '1111@gmail.com', null),
('b456', '22222', '이이이', '부산', '010-2222-2222', '2222@gmail.com', null),
('c789', '33333', '박박박', '경기', '010-3333-3333', '3333@gmail.com', 'gold'),
('d159', '44444', '최최최', '인천', '010-4444-4444', '4444@gmail.com', 'vip');

insert into product (pname, price, sales) values
('시계', 8000, 5000),
('가위', 2000, null),
('신발', 80000, 69000),
('티셔츠', 28000, 25000),
('의자', 18000, null),
('식탁', 208000, 189000),
('과자', 2000, 1600),
('모니터', 318000, 299000),
('텀블러', 13000, null),
('커피', 29000, 28500),
('화분', 17600, 17000);

insert into orders (payment, orderDate, customerId) values
('카드', 20260916, 'a123'),
('네이버페이', 20260914, 'b456'),
('카드', 20260917, 'c789'),
('계좌이체', 20260910, 'd159'),
('카드', 20260830, 'c789'),
('네이버페이', 20260901, 'b456');

insert into orderItem(orderId, productId, quantity) values
-- 주문 1 : 김김김
(1, 1, 1),  -- 시계 1개
(1, 3, 2),  -- 신발 2개
-- 주문 2 : 이이이
(2, 4, 1),  -- 티셔츠 1개
(2, 7, 3),  -- 과자 3개
-- 주문 3 : 박박박
(3, 6, 1),  -- 식탁 1개
(3, 8, 1),  -- 모니터 1개
-- 주문 4 : 최최최	
(4, 5, 4),  -- 의자 4개
(4, 9, 2),  -- 텀블러 2개
-- 주문 5 : 박박박
(5, 10, 2), -- 커피 2개
(5, 11, 1), -- 화분 1개
-- 주문 6 : 이이이
(6, 2, 2),  -- 가위 2개
(6, 7, 5);  -- 과자 5개

select * from customer;
select * from product;
select * from orders;
select * from orderItem;

-- 주문자, 상품명, 수량, 총가격(할인가가 있으면 할인가 적용)
select c.cname as 주문자, p.pname as 상품명, oi.quantity as 수량, o.payment as 결제수단,  oi.quantity * coalesce(p.sales, p.price) as 총금액 
from orderItem oi
join orders o
on o.oid = oi.orderId
join customer c
on c.cid = o.customerId
join product p
on p.pid = oi.productId
order by o.oid, oi.otid;

-- 주문자별 총 구매금액
select c.cname as 주문자, sum(oi.quantity * coalesce(p.sales, p.price)) as 총구매금액 
from orderItem oi
join orders o
on o.oid = oi.orderId
join customer c
on c.cid = o.customerId
join product p
on p.pid = oi.productId
group by c.cname
order by o.oid, oi.otid;

