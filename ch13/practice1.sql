-- 주문과 환불
CREATE TABLE orders (
    id            INT           PRIMARY KEY AUTO_INCREMENT,
    order_date    DATE          NOT NULL,
    customer_name VARCHAR(50)   NOT NULL,
    order_amount  DECIMAL(10,2) NOT NULL
);

CREATE TABLE refunds (
    id            INT           PRIMARY KEY AUTO_INCREMENT,
    order_id      INT           NOT NULL,
    refund_date   DATE          NOT NULL,
    refund_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

INSERT INTO orders (order_date, customer_name, order_amount) VALUES
('2024-06-01', '김철수', 100000),
('2024-06-02', '이영희', 200000),
('2024-06-03', '박민수', 150000);

INSERT INTO refunds (order_id, refund_date, refund_amount) VALUES
(1, '2024-06-04', 100000),
(3, '2024-06-05', 150000);

SELECT * FROM orders;
SELECT * FROM refunds;

-- 고객 문의 대응 화면에서 주문과 환불을 날짜순으로 함께 보여줘야 한다.
-- 컬럼 이름이 달라도 상관없고 자리만 맞추면 조합이 된다.
-- 주문(날짜, 고객명, 금액)
-- 환불(주문번호, 환불일, 환불금액)
SELECT o.order_date as 날짜, o.customer_name as 고객명, 
		o.order_amount as 금액, '주문' as 구분
FROM orders o
union all 
select r.refund_date, o.customer_name, r.refund_amount, '환불'
from refunds r
join orders o
on r.order_id = o.id;
