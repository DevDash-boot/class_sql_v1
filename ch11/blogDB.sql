drop database if exists blog;
create database blog;
use blog;

-- user 테이블 생성
create table user(
	id int primary key auto_increment,
	username varchar(100) not null unique,
    password varchar(255) not null,
    email varchar(100) not null unique,
    address varchar(100),
    userRole varchar(20),
    createDate dateTime default current_timestamp
);

-- 글 저장 테이블 생성
create table board(
	id int primary key auto_increment,
    title varchar(100) not null,
    content longtext,
	readCount int default 0,
    userId int,
    createDate dateTime default current_timestamp,
    foreign key (userId) references user(id) on delete set null
);

-- 댓글 테이블 생성
create table reply(
	id int primary key auto_increment,
    content varchar(300) not null,
    createDate dateTime default current_timestamp,
    boardId int,
    userId int,
    FOREIGN KEY(userId) REFERENCES user(id) ON DELETE SET NULL,
    FOREIGN KEY(boardId) REFERENCES board(id) ON DELETE CASCADE
);

select * from user;
select * from board;
select * from reply;

-- 샘플 데이터
INSERT INTO user (username, password, email, address, userRole) VALUES
('hong', '1234', 'hong@example.com', '서울시 강남구',   'admin'),
('lee',  '1234', 'lee@example.com',  '부산시 해운대구', 'user'),
('kim',  '1234', 'kim@example.com',  '대구시 수성구',   'user'),
('park', '1234', 'park@example.com', '인천시 연수구',   'user');

INSERT INTO board (userId, title, content, readCount) VALUES
(1, '자바 스터디 모집합니다', '함께 공부하실 분 구해요!',      150),
(2, '부산 맛집 추천',        '해운대 주변 맛집 소개합니다.',   45),
(3, '대구 코딩 모임',        '대구에서 코딩 모임 시작합니다.', 30);

INSERT INTO reply (userId, boardId, content) VALUES
(2, 1, '저도 참여하고 싶어요!'),
(3, 1, '좋은 취지네요, 응원합니다.'),
(1, 2, '저도 부산 가면 꼭 가볼게요!'),
(1, 3, '대구 모임 화이팅!');

SELECT * FROM user;
SELECT * FROM board;
SELECT * FROM reply;

-- 조회 테스트 
-- 1. 게시글 목록(board) 에 작성자(user)와 댓글(reply) 수 붙이기
-- COUNT(*)는 LEFT JOIN이 만든 NULL 행도 1행으로 센다.
select b.title, b.readCount, u.username as 작성자, count(r.id) as 댓글수
from board b
left join user u
on b.userId = u.id
left join reply r
on b.id = r.boardId
group by b.id, b.title, u.username, b.readCount;

-- 사용자별 게시글 수
select b.title, u.username, count(b.id) as 게시글수
from user u
join board b
on b.userId = u.id
group by u.username, u.id;

-- 회원 탈퇴 시나리오
delete from user where username = 'lee';

-- FK 추가하기
/* 
ALTER TABLE 자식_테이블명 
ADD CONSTRAINT 제약조건명 
FOREIGN KEY(외래키_컬럼명) REFERENCES 부모_테이블명 (부모_컬럼명)
[ON DELETE 옵션] [ON UPDATE 옵션] ;
*/

-- 1. board 테이블에 user 테이블을 참조하는 FK 추가
ALTER TABLE board
ADD CONSTRAINT fk_board_userId
FOREIGN KEY(userId) REFERENCES user(id)
ON DELETE SET NULL;

-- 2. reply 테이블에 user 테이블을 참조하는 FK 추가
ALTER TABLE reply
ADD CONSTRAINT fk_reply_userId
FOREIGN KEY(userId) REFERENCES user(id)
ON DELETE SET NULL;

-- 3. reply 테이블에 board 테이블을 참조하는 FK 추가
ALTER TABLE reply
ADD CONSTRAINT fk_reply_boardId
FOREIGN KEY(boardId) REFERENCES board(id)
ON DELETE CASCADE;







