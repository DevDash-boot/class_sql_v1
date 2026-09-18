CREATE DATABASE IF NOT EXISTS normalization;
USE normalization;

DROP TABLE IF EXISTS employee_bad;

-- 일부러 3NF 를 위반한 테이블
CREATE TABLE employee_bad (
    emp_id        INT          PRIMARY KEY,
    emp_name      VARCHAR(50)  NOT NULL,
    dept_code     VARCHAR(10)  NOT NULL,
    dept_name     VARCHAR(50)  NOT NULL,   -- 부서코드를 거쳐 종속
    dept_location VARCHAR(100) NOT NULL    -- 부서코드를 거쳐 종속
);

INSERT INTO employee_bad VALUES
(1, '홍길동', 'D01', '개발팀', '서울 강남'),
(2, '이순신', 'D02', '영업팀', '부산 해운대'),
(3, '김유신', 'D01', '개발팀', '서울 강남'),
(4, '최사원', 'D01', '개발팀', '서울 강남');

SELECT * FROM employee_bad;

-- 3정규화를 만족하도록 테이블을 분리
create table department(
	dept_code varchar(50) primary key,
    dept_name varchar(50) not null,
    dept_location varchar(50)
);

create table employee(
	emp_id int primary key auto_increment,
    emp_name varchar(50) not null,
    dept_code varchar(50),
	foreign key (dept_code) references department(dept_code) 
);

INSERT INTO department VALUES
('D01', '개발팀', '서울 강남'),
('D02', '영업팀', '부산 해운대'),
('D03', '기획팀', '서울 마포');

INSERT INTO employee (emp_name, dept_code) VALUES
('홍길동', 'D01'),
('이순신', 'D02'),
('김유신', 'D01'),
('최사원', 'D01');

-- ------------------------------------------
create table movie(
	movie_id int primary key auto_increment,
    movie_title varchar(50) not null,
    open_date date not null,
    genre varchar(50) not null
);

create table director(
	di_name varchar(50) primary key,
    di_address varchar(50) not null,
    movie_id int,
    foreign key (movie_id) references movie(movie_id)
);

insert into movie(movie_title, open_date, genre)values
('기생충', 20190530, '드라마'), 
('옥자', 20170629, 'SF'), 
('인셉션', 20100721, 'SF');

insert into director(di_name, di_address) values
('봉준호', '서울 마포구'),
('놀란', 'LA 엘름가');

select * from movie;
select * from director;

update director set di_address = '서울 강남구' where di_name = '봉준호';
insert into director(di_name, di_address) values ('홍길동', '서울 용산구');