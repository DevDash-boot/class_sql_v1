DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;
USE shop;

CREATE TABLE user (
    id         INT          PRIMARY KEY AUTO_INCREMENT,
    username   VARCHAR(50)  NOT NULL UNIQUE,
    password   VARCHAR(255) NOT NULL,
    email      VARCHAR(100) NOT NULL UNIQUE,
    address    VARCHAR(255),
    is_deleted TINYINT(1)   NOT NULL DEFAULT 0,
    deleted_at DATETIME     NULL,
    created_at DATETIME     DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE product (
    id          INT           PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(100)  NOT NULL,
    description TEXT,
    price       DECIMAL(10,2) NOT NULL,
    stock       INT           DEFAULT 0,
    is_deleted  TINYINT(1)    NOT NULL DEFAULT 0,
    created_at  DATETIME      DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
    id               INT           PRIMARY KEY AUTO_INCREMENT,
    user_id          INT           ,
    total_price      DECIMAL(10,2) NOT NULL,
    status           VARCHAR(20)   NOT NULL DEFAULT '결제완료',
    delivery_address VARCHAR(255)  NOT NULL,
    created_at       DATETIME      DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE order_details (
    id         INT           PRIMARY KEY AUTO_INCREMENT,
    order_id   INT           NOT NULL,
    product_id INT           NOT NULL,
    quantity   INT           NOT NULL,
    price      DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id)   REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(id)
);
INSERT INTO user (username, password, email, address) VALUES
('hong', '1234', 'hong@test.com', '서울시 강남구'),
('kim',  '1234', 'kim@test.com',  '부산시 해운대구'),
('lee',  '1234', 'lee@test.com',  '대구시 수성구'),
('park', '1234', 'park@test.com', '인천시 연수구');

INSERT INTO product (name, price, stock, description) VALUES
('갤럭시 S24',      1200000,  50, '삼성 최신 스마트폰'),
('노트북 그램',     1800000,  30, '초경량 노트북'),
('에어팟 프로',      329000, 200, '노이즈 캔슬링 이어폰'),
('블루투스 키보드',   89000, 120, '무선 기계식 키보드'),
('요가 매트',         45000, 150, '친환경 TPE 요가 매트'),
('자바 완전정복',     35000,  80, '자바 입문서');

INSERT INTO orders (user_id, total_price, status, delivery_address) VALUES
(1, 1529000, '배송완료', '서울시 강남구'),
(1,  124000, '배송중',   '서울시 마포구 회사'),
(2, 1800000, '배송완료', '부산시 해운대구'),
(3,   80000, '결제완료', '대구시 수성구'),
(null,   80000, '결제완료', '대구시 수성구');

INSERT INTO order_details (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 1200000),
(1, 3, 1,  329000),
(2, 4, 1,   89000),
(2, 5, 1,   35000),
(3, 2, 1, 1800000),
(4, 5, 1,   45000),
(4, 6, 1,   35000);

SELECT * FROM user;
SELECT * FROM product;
SELECT * FROM orders;

-- where 절 서브 쿼리(중첩 서브쿼리)
-- 문제 : 평균 가격보다 비싼 상품
select * from product;

-- 1단계 : 평균 가격을 확인하자
select round(avg(price), 2) as 평균가격 from product;

-- 2단계 : 상품 테이블 중 상품 가격이 평균 가격보다 높은 상품만 조회
select * from product where price > 583000.00;

-- 3단계 : 
select *
from product
where price > (select avg(price) from product)
order by price desc;

-- 도전 문제 : 한 번이라도 주문한 회원을 조회
-- 사고 과정 : 한 단계씩 천천히 하고 마지막에 서브쿼리를 활용
-- username as 사용자, email as 이메일

-- 1단계
select * from orders;

-- 2단계
select * from user where id = 1 or id = 2 or id = 3;
select * from user where id in(1,2,3);

-- =는 1개의 값만 가능한데 4개의 결과가 return되어서 오류 발생
select * from user where id = (select user_id from orders);
-- 그래서 in을 사용
-- 3단계
select * from user where id in(select user_id from orders);
select distinct user_id from orders;

-- 최종
select username as 사용자, email as 이메일
from user
where id in(select distinct user_id from orders);

-- 도전문제 2 : 한 번이라도 주문하지 않은 회원을 조회
select username as 사용자, email as 이메일
from user
where id not in(select distinct user_id from orders);
-- not in을 사용할 때 함정이 있을 수 있다.
-- 0 건이 나오게 된다

select * from user where id <> 1 and id <>2 and id <>null;
-- id <> null은 참도 거짓도 아닌 알 수 없음이 된다.
-- AND 로 이어져 있기 때문에 전체가 참이 될 수 없다.
-- 어떤 행도 조건을 통과하지 못한다.

-- 해결 방안
select username as 사용자, email as 이메일
from user
where id not in(
	select distinct user_id 
    from orders 
    where user_id is not null);