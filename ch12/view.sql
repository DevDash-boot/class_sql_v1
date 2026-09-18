use shop;

select * from user;
select * from orders;
select * from order_details;
select * from product;

-- 시나리오 1.
-- 쇼핑몰을 운영하면서 주문 목록을 아주 많이 조회하게됨
select o.id as 주문번호, u.username as 주문자, 
o.total_price as 총금액, o.status as 상태
from orders o
join user u on o.user_id = u.id;

-- 이 쿼리는 관리자 화면, 통계 화면에서 배송화면을 사용할 수 있다.
-- 문제
-- 같은 join을 화면마다 다시 쓴다.
-- 컬럼이 하나 추가되면 여러 곳을 고쳐야 한다.
-- 누군가 join 조건을 잘못 쓰면 그 화면만 틀린것을 보여줄 수 있다.
-- 자주 쓰는 조회에 이름을 붙여두고 테이블 처럼 사용 -> 뷰

-- 시나리오 2. 뷰 만들기
create view v_order_summary as
select o.id as 주문번호, u.username as 주문자, 
o.total_price as 총금액, o.status as 상태
from orders o
join user u on o.user_id = u.id;

select * from v_order_summary;
select * from v_order_summary where 상태 = '배송완료';

select 주문자, sum(총금액) as 총액
from v_order_summary
group by 주문자
order by 총액 desc;

-- 중간 결론 : 원래대로 했다면 매번 화면마다 join을 다시 써야 했다.

-- 시나리오 3. 원본 테이블의 값을 수정해보자.
update orders set status = '구매확정' where id = 1;

-- 그리고 다시 뷰를 조회
select * from v_order_summary;
-- 뷰를 건드리지 않았는데 값이 변경됨

-- 뷰를 지워보자
drop view v_order_summary;

-- 쿼리를 통해서 뷰, 기본 테이블 목록을 확인하는 명령어를 실행
select table_name, table_type
from information_schema.tables
where table_schema = 'shop';



