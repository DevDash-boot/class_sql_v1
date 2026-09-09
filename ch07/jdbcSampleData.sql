-- MySQL Workbench 에서 실행
Drop database shop2;
CREATE DATABASE IF NOT EXISTS shop2;
USE shop2;

CREATE TABLE IF NOT EXISTS product (
    id    INT          PRIMARY KEY AUTO_INCREMENT,
    name  VARCHAR(100) NOT NULL,
    price INT          NOT NULL,
    stock INT          DEFAULT 0
);

INSERT INTO product (name, price, stock) VALUES
('삼성 갤럭시 S24', 1200000, 50),
('자바 완전정복',     35000, 80),
('요가 매트',         45000, 150);

SELECT *  FROM product;

select * from product where price >= 40000;
-- SQL Injection 공격 시 or 1=1을 넣어 모든 정보 출력
select * from product where price >= 40000 or 1 = 1;
