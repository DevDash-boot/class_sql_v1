-- 데이터베이스 생성, 삭제, 사용
drop database if exists shopping_practice;
create database shopping_practice;
use shopping_practice;

-- 테이블 생성
create table customers(
	customer_id int primary key,
    name varchar(50) not null,
    email varchar(100) unique,
    age int, 
    city varchar(50),
    signup_date date
);

create table products(
	product_id int primary key,
    product_name varchar(100) not null,
    category varchar(50),
    price decimal(10,2),
    stock int,
    supplier varchar(50)
);

create table orders(
	order_id int primary key,
    customer_id int,
    product_id int,
    quantity int,
    order_date date,
    status varchar(20),
    foreign key(customer_id) references customers(customer_id),
    foreign key(product_id) references products(product_id)
);

-- 데이터 입력(추가)
insert into customers
(customer_id, name, email, age, city, signup_date)
values
(1, '김민수', 'minsu@gmail.com', 25, '서울', '2024-01-15'),
(2, '이서연', 'seoyeon@gmail.com', 32, '부산', '2024-03-22'),
(3, '박지훈', 'jihoon@gmail.com', 28, '대구', '2024-05-10'),
(4, '최유진', 'yujin@gmail.com', 41, '서울', '2024-07-18'),
(5, '정우성', 'woosung@gmail.com', 36, '인천', '2024-09-03'),
(6, '한지민', 'jimin@gmail.com', 29, '부산', '2025-01-11'),
(7, '강현우', 'hyunwoo@gmail.com', 45, '서울', '2025-03-27'),
(8, '윤하늘', 'haneul@gmail.com', 23, '대전', '2025-06-14'),
(9, '송예진', 'yejin@gmail.com', 38, '부산', '2025-08-21'),
(10, '오준혁', 'junhyuk@gmail.com', 52, '대구', '2026-02-05');

insert into products
(product_id, product_name, category, price, stock, supplier)
values
(1, '무선 이어폰', '전자기기', 89000, 25, '삼성전자'),
(2, '블루투스 스피커', '전자기기', 65000, 15, 'LG전자'),
(3, '기계식 키보드', '전자기기', 120000, 8, '앱코'),
(4, '게이밍 마우스', '전자기기', 55000, 30, '로지텍'),
(5, '후드티', '의류', 45000, 20, '나이키'),
(6, '청바지', '의류', 78000, 12, '리바이스'),
(7, '운동화', '의류', 135000, 7, '아디다스'),
(8, '유기농 과자 세트', '식품', 18000, 40, '오리온'),
(9, '커피 원두 1kg', '식품', 32000, 18, '스타벅스'),
(10, '생수 2L 6개입', '식품', 9000, 50, '제주삼다수'),
(11, '텀블러', '생활용품', 28000, 35, '락앤락'),
(12, '무선 청소기', '생활용품', 250000, 5, '다이슨');

insert into orders
(order_id, customer_id, product_id, quantity, order_date, status)
values
(1, 1, 1, 1, '2026-01-05', '배송완료'),
(2, 2, 5, 2, '2026-01-08', '배송완료'),
(3, 3, 3, 1, '2026-01-12', '배송중'),
(4, 4, 12, 1, '2026-01-15', '배송완료'),
(5, 5, 7, 2, '2026-01-18', '배송중'),
(6, 1, 9, 3, '2026-01-20', '배송완료'),
(7, 6, 4, 1, '2026-01-22', '배송완료'),
(8, 7, 12, 1, '2026-01-25', '배송중'),
(9, 8, 8, 4, '2026-01-27', '배송완료'),
(10, 9, 6, 2, '2026-02-01', '배송완료'),
(11, 10, 2, 1, '2026-02-03', '주문취소'),
(12, 2, 3, 2, '2026-02-05', '배송완료'),
(13, 3, 1, 2, '2026-02-08', '배송완료'),
(14, 4, 7, 1, '2026-02-10', '배송중'),
(15, 5, 6, 1, '2026-02-12', '배송완료'),
(16, 1, 11, 2, '2026-02-15', '배송완료'),
(17, 6, 10, 5, '2026-02-18', '배송완료'),
(18, 7, 5, 3, '2026-02-20', '주문취소'),
(19, 9, 12, 1, '2026-02-22', '배송완료'),
(20, 10, 4, 2, '2026-02-25', '배송중');

-- 전체 고객 조회
select * from customers;
select * from products;
select * from orders;

-- 30세 이상인 고객 조회
select name, age, city from customers where age >= 30;

-- 가격이 50,000원 이상이면서 재고가 10개 이상인 상품을 조회
select product_name, category, price, stock
from products
where price >= 50000 and stock >= 10;

-- 카테고리가 전자기기 또는 의류인 상품을 조회
select * from products
where category = "전자기기" or category = "의류"
order by price desc;

-- 모든 상품을 가격이 비싼 순서대로 조회
select * from products
order by price desc
limit 5;

-- 상품을 가격이 낮은 순서대로 정렬한 뒤 6번째 상품부터 5개를 조회
select * from products
order by price asc
limit 5
offset 5;

-- 각 도시마다 몇 명의 고객이 가입했는지 조회
select city, count(*) as customer_count from customers
group by city;

-- 각 상품 카테고리별 평균 가격을 조회
select category, round(avg(price),2) as average_price
from products
group by category;

-- 각 카테고리에 등록된 상품이 몇 개인지 조회
select category, count(*) as count
from products
group by category;

-- 카테고리별 평균 상품 가격을 구한 뒤, 평균 가격이 50,000원 이상인 카테고리만 조회
select category, round(avg(price),2) as average_price
from products
group by category
having avg(price) >= 50000;

-- 고객별 주문 횟수를 조회
select customer_id, count(*) as orderCount
from orders
group by customer_id
order by count(*) desc;

-- 고객별 주문 횟수를 계산하고 2번 이상 주문한 고객만 조회
select customer_id, count(*) as orderCount from orders
group by customer_id
having count(*) >= 2;

-- 고객의 이름과 주문 정보를 함께 조회
select c.name, o.product_id, o.quantity, o.order_date, o.status
from customers c
left join orders o
on c.customer_id = o.customer_id;

-- 주문 내역을 조회할 때 고객의 이름과 상품 이름까지 함께 표시
select c.name, p.product_name, p.category, o.quantity, o.order_date, o.status
from orders o
left join products p
on o.product_id = p.product_id
left join customers c
on c.customer_id = o.customer_id;

-- 각 주문에 대해 실제 주문 금액을 계산
select o.order_id,
       c.name,
       p.product_name,
       p.price,
       o.quantity,
       p.price * o.quantity as order_price
from orders o
left join products p
on o.product_id = p.product_id
left join customers c
on c.customer_id = o.customer_id;

-- 고객별로 지금까지 구매한 총 금액을 계산
select c.name,
       sum(p.price * o.quantity) as total_price
from orders o
left join products p
on o.product_id = p.product_id
left join customers c
on c.customer_id = o.customer_id
group by c.customer_id, c.name
order by total_price desc;

-- 상품 ID가 5인 상품의 재고를 50개로 변경
update products
set stock = 50
where product_id = 5;

-- 식품 카테고리의 상품 중 가격이 10,000원 미만인 상품의 가격을 10% 인상
update products
set price = price*1.1
where category = '식품' and price < 10000;

-- 주문 ID가 10인 주문의 상태를 변경
update orders 
set status = '배송중'
where order_id = 10;

-- 주문 ID가 20인 주문을 삭제
delete from orders where order_id =20;

-- 재고가 0이고 카테고리가 생활용품인 상품을 삭제
delete from products where category = '생활용품' and stock =0;

-- 쇼핑몰 관리자가 "가장 많이 팔린 상품 TOP 5"를 조회
select p.product_name,
       sum(o.quantity) as total_quantity
from orders o
left join products p
on p.product_id = o.product_id
where o.status != '주문취소'
group by p.product_id, p.product_name
order by total_quantity desc
limit 5;

-- 쇼핑몰 관리자가 "우수 고객"을 찾으려고 한다.
select c.name,
       count(*) as order_count,
       sum(p.price * o.quantity) as total_price
from orders o
left join products p
on p.product_id = o.product_id
left join customers c
on c.customer_id = o.customer_id
group by c.customer_id, c.name
having count(*) >= 2
   and sum(p.price * o.quantity) >= 300000
order by total_price desc;










