-- 호텔 객실과 예약
CREATE TABLE rooms (
    room_id     INT PRIMARY KEY AUTO_INCREMENT,
    room_number INT NOT NULL
);

CREATE TABLE reservations (
    id               INT         PRIMARY KEY AUTO_INCREMENT,
    room_id          INT         NOT NULL,
    reservation_date DATE        NOT NULL,
    guest_name       VARCHAR(50) NOT NULL,
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

INSERT INTO rooms (room_number) VALUES (101), (102), (103);

INSERT INTO reservations (room_id, reservation_date, guest_name) VALUES
(1, '2024-06-01', '김철수'),
(2, '2024-06-02', '이영희'),
(3, '2024-06-03', '박민수');

select * from rooms;
select * from reservations;

-- 시나리오 1. 현재 객실 3개가 있고, 날짜별로 예약이 가능한지 표를 만들어보자
-- 문제 상황 : 예약 테이블에는 예약된 것만 있고, 예약이 없는 날은 테이블 어디에도 없다.
-- 어떻게 조회하는가?

-- 1단계 : 날짜 목록을 만든다.
-- 날짜 테이블이 없으므로 UNION ALL을 사용해서 즉석으로 만들 수 있다.
select '2024-06-01' as 날짜
union all
select '2024-06-02'
union all
select '2024-06-03';

-- 2단계 : 모든 날짜와 모든 객실을 조합한다.
-- 날짜 3개와 객실 3개의 모든 조합이 필요하다.
-- 3 x 3 = 9
select cal.날짜, r.room_number as 객실번호
from (
	select '2024-06-01' as 날짜
	union all
	select '2024-06-02'
	union all
	select '2024-06-03'
) as cal
cross join rooms as r
order by 날짜, 객실번호 asc;

-- 3단계 : 예약 정보를 붙인다.
select cal.날짜, r.room_number as 객실번호, 
	res.room_id as 예약된_객실번호, 
    if(res.room_id is null, '예약 가능', '예약 불가') as 상태
from (
	select '2024-06-01' as 날짜
	union all
	select '2024-06-02'
	union all
	select '2024-06-03'
) as cal
cross join rooms as r
left join reservations as res
on res.room_id = r.room_id
and res.reservation_date = cal.날짜
order by 날짜, 객실번호 asc;




