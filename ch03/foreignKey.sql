-- 앞에서 만든 테이블이 남아있으면 지우고 시작
-- orders 가 member 를 참조하므로 자식 테이블을 먼저 지웁니다
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS member;

CREATE TABLE member (
  id INT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(100) UNIQUE,
  name VARCHAR(50) NOT NULL,
  phone VARCHAR(20)
);

INSERT INTO member (email, name, phone) VALUES
('hong@test.com', '홍길동', '010-1234-5678'),
('kim@test.com', '김영희', '010-2345-6789'),
('lee@test.com', '이철수', '010-3456-7890');

CREATE TABLE orders (
  id INT PRIMARY KEY AUTO_INCREMENT,
  member_id INT,
  order_date DATE,
  amount INT,
  FOREIGN KEY (member_id) REFERENCES member(id)
);

INSERT INTO orders (member_id, order_date, amount) VALUES
(1, '2023-10-01', 50000),
(2, '2023-10-02', 75000),
(3, '2023-10-03', 30000);

-- 실습
select * from member;
select * from orders;

-- 1. 중복 이메일 저장 시도 -> UNIQUE라 중복된 데이터 저장 안됨
INSERT INTO member (email, name, phone) VALUES
('hong@test.com', '고길동', '010-1234-5678');
-- Error Code: 1062. Duplicate entry 'hong@test.com' for key 'member.email'

-- 2. 존재하지 않는 회원의 주문 저장
-- 외래키를 설정했다면 제약 사항이 발생(무결성, 일관성)
-- 외래키 제약 사항 위반(1000번 id를 가진 회원은 member 테이블에 없다.)
INSERT INTO orders (member_id, order_date, amount) VALUES
(1000, 20260901, 10);
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`type_practice`.`orders`, CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`))

-- 3. 회원 삭제 시도(참조된 데이터만)
-- member 테이블과 orders 테이블간 연결된 member_id가 있어서 삭제 불가
-- 하위 테이블에서 먼저 삭제하고 상위 테이블에서 삭제 가능
delete from member where id =1;
-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`type_practice`.`orders`, CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`))

-- 4. 외래키 삭제하는 방법
alter table orders 
drop foreign key orders_ibfk_1;

-- 5. 테이블 생성 이후에 외래키 추가하는 방법
alter table orders
add constraint fk_member 
foreign key(member_id) references member(id);

alter table orders
drop foreign key fk_member;

-- cascade : 부모 테이블에 참조된 대상이 삭제된다면 관련된 데이터 자동으로 삭제
alter table orders
add constraint fk_member
foreign key(member_id) references member(id)
on delete cascade on update cascade;

-- 오류 없이 잘 삭제 됨
delete from member
where id = 1;