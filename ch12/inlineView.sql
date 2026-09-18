-- FROM 절 서브 쿼리(인라인 뷰)
-- 서브쿼리 결과를 임시 테이블처럼 FROM 절에 두는 방식이다.
-- 앞 차시의 뷰와 무엇이 다른가?

-- 뷰 : create view 로 미리 만둘어두고 이름을 부른다.
-- 인라인 뷰 : 미리 만들지 않고 FROM 절에 직접 써 넣는다.
-- 인라인 뷰는 언제 필요한가?
-- 집계한 결과를 다시 집계해야 할 때 사용할 수 있다.

-- 문제 상황 : 고객 1명이 평균 얼마나 쓰는지 알고 싶을 때
select * from orders;
-- 1. 고객별 총 구매금액을 구한다. -> 집계
-- 2. 그 총액들의 평균을 구한다 -> 집계를 또 집계
-- 주의! : 집계 함수를 겹쳐 사용할 수 없다.
SELECT AVG (SUM(total_price)) from orders group by user_id;
-- Error Code: 1111. Invalid use of group function

-- 고객별 총 구맥금액
select user_id, sum(total_price) as 총액
from orders
group by user_id;

-- 그 총액들의 평균을 구한다.
select round(avg(s.총액),2) as 고객당_평균구매액
from (select user_id, sum(total_price) as 총액
		from orders
		group by user_id) 
as s;

select user_id, sum(total_price) as 총액
from orders
group by user_id;

-- 주의점 : 인라인 뷰가 필요 없는 경우
-- 집계 결과에 조건만 거는 것이라면 HAVING 으로 충분하다.
SELECT u.username as 고객, sum(o.total_price) as 총액
from orders o
join user u on o.user_id = u.id
group by u.id, u.username
having sum(o.total_price) > (select avg(total_price) from orders );

-- select 절 서브 쿼리(스칼라 서브쿼리)
-- 평균 대비 차이
select name as 상품명, price as 가격, 
	price - (select avg(price) from product) as 평균대비차이
from product;

SELECT p.name AS 상품명,
       (SELECT SUM(od.quantity)
        FROM order_details od
        WHERE od.product_id = p.id) AS 판매수량
FROM product p;

/* 연습문제1. 가장 비싼 상품
 product 테이블에서 가격이 가장 비싼 상품의 이름과 가격을 조회합니다.
 최고 가격을 숫자로 적지 말고 서브쿼리로 구합니다.
 WHERE 절 서브쿼리. MAX 는 결과가 1행이므로 = 를 씁니다.
 */
select * from product;
SELECT * from product 
where price = (select max(price) from product );


/* 연습문제 2.에어팟 프로를 주문한 회원
 에어팟 프로를 한 번이라도 주문한 회원의 사용자명과 이메일을 조회합니다.
 상품 번호를 숫자로 적지 말고 이름으로 찾습니다.
 WHERE 절 서브쿼리. 상품 이름으로 상품 번호를 찾고, 그 번호로 주문한
 회원 번호를 찾습니다. 서브쿼리가 두 겹입니다.
*/

-- 1. 에어팟 프로의 상품 번호를 찾는다 - product의 id:3
select * from product where name = '에어팟 프로';

-- 2. 3번 상품이 들어 있는 주문의 회원 번호를 찾는다.
select * 
from orders o
join order_details od 
on o.id = od.order_id
where od.product_id = 3;

select * 
	from orders o
	join order_details od 
	on o.id = od.order_id
	where od.product_id = (
		select id from product 
        where name = '에어팟 프로'
        );

-- 3. user 테이블에서 사용자 이름과 이메일을 join연산
select username as 사용자, email as 이메일
from user u 
where id in (
	select o.user_id
	from orders o
	join order_details od 
	on o.id = od.order_id
	where od.product_id = (
		select id from product 
        where name = '에어팟 프로'
	)
);

/* 연습문제 3. 주문 금액과 평균의 차이
 orders 테이블에서 각 주문의 번호, 금액, 그리고 전체 주문 평균과의 차이를 
 조회합니다. 차이가 큰 순서로 정렬합니다.
 SELECT 절 서브쿼리. 본문의 "평균 대비 가격 차이" 예제와 같은 구조입니다.
*/

-- 독립 서브쿼리
select id as 주문번호, total_price as 주문금액,
	round(total_price - (select avg(total_price) from orders)) as 평균대비차이
from orders
order by 평균대비차이 desc;



