create database library;
use library;

-- 학생 테이블
create table students(
	id int auto_increment primary key,
    name varchar(100) not null,
    student_id varchar(20) not null unique
);
desc students;

-- 도서 테이블
create table books(
	id int auto_increment primary key,
    title varchar(255) not null,
    author varchar(255) not null,
    publisher varchar(255) not null,
    publication_year int,
    isbn varchar(13),
    available boolean default true not null
);
desc books;

-- 대출 테이블
create table borrows(
	id int auto_increment primary key,
    book_id int,
    student_id int,
    borrow_date date not null,
    return_date date,
    foreign key (book_id) references books(id),
    foreign key (student_id) references students(id)
);
desc borrows;

drop table borrows;

-- 샘플 데이터
INSERT INTO books (title, author, publisher, publication_year, isbn, available) VALUES
('자바 프로그래밍 입문', '김영훈', '한빛미디어', 2023, '9788968481234', TRUE),
('데이터베이스 기초',   '이수진', '길벗',       2022, '9788968485678', TRUE),
('알고리즘 문제 해결', '박민수', '인사이트',    2021, '9788968489012', FALSE),
('웹 개발 입문',       '최지영', '한빛아카데미', 2024, '9788968483456', TRUE),
('소프트웨어 공학',    '정현우', '생능출판사',   2020, '9788970507890', FALSE);

INSERT INTO students (name, student_id) VALUES
('홍길동', '20230001'),
('김민서', '20230002'),
('이준호', '20230003');

INSERT INTO borrows (book_id, student_id, borrow_date, return_date) VALUES
(3, 1, '2025-05-01', NULL),  -- 홍길동 → 알고리즘 문제 해결 대출 중
(5, 2, '2025-05-03', NULL);  -- 김민서 → 소프트웨어 공학 대출 중

SELECT * FROM students;
select * from books;
select * from borrows;

update books set available = 1 where id = 1;

-- 제목으로 도서 검색 기능
SELECT * FROM books
WHERE title LIKE '%알고리즘%';

SELECT * FROM books
WHERE title LIKE '%입문%';

-- 도서 전체 검색 기능
SELECT * FROM books order by id;

INSERT INTO books (title, author, publisher, publication_year, isbn, available) VALUES
('테스트 책', '저자', '한빛미디어', 2026, '9788968481239', TRUE);

delete from books where title = '테스트 책';

-- 대출 중인 도서 조회
SELECT b.id, b.book_id, bk.title, b.student_id, s.name, b.borrow_date, b.return_date
FROM borrows b
INNER JOIN books bk ON b.book_id = bk.id
INNER JOIN students s ON b.student_id = s.id
WHERE b.return_date IS NULL
ORDER BY b.borrow_date ASC;




