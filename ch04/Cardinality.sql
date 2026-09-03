DROP DATABASE IF EXISTS relation_practice;
CREATE DATABASE relation_practice;
USE relation_practice;

-- 실습 1. 1:1 관계를 코드로 만들어보기
create table tb_person(
	person_id int auto_increment,
    name varchar(50) not null,
    primary key (person_id)
);

create table tb_passport(
	passport_id int auto_increment,
    passport_number varchar(20) not null,
    person_id int unique, -- UNIQUE가 1:1 관계를 만들어줌
    primary key (passport_id),
    foreign key (person_id) references tb_person(person_id)
);

insert into tb_person (name) values ('홍길동'), ('김영희'), ('이철수');
select * from tb_person;

insert into tb_passport (passport_number, person_id) values 
('p123', 1), ('p456', 2), ('p789', 3);
select * from tb_passport;

-- 외래키, 유니크 설정이 되어 있어 1:1 관계를 보장
insert into tb_passport (passport_number, person_id) values 
('p100', 1);
-- Error Code: 1062. Duplicate entry '1' for key 'tb_passport.person_id'

-- 실습 2. 1:N 관계를 코드로 만들어보기
create table tb_customer(
	customer_id int auto_increment,
    name varchar(50) not null, 
    primary key(customer_id)
);
select * from tb_customer;

create table tb_order(
	order_id int auto_increment,
    product_name varchar(50) not null, 
    customer_id int, -- UNIQUE 가 없다 --> 1:N 구조
    primary key (order_id),
    foreign key (customer_id) references tb_customer(customer_id)
);
select * from tb_order; 

insert into tb_customer (name) values
(1, '박민지'), (2, '최재영');

insert into tb_order (order_id, product_name, customer_id) values
(201, '노트북', 1), (202,'마우스', 1), (203,'키보드', 2);

-- 실습 3. N:M 관계를 코드로 만들어보기
create table tb_student (
	student_id int auto_increment,
	name varchar(50) not null,
    primary key (student_id)
);

create table tb_course (
	course_id int auto_increment,
	title varchar(50) not null,
    primary key (course_id)
);

-- 교차 테이블
create table tb_student_course(
	student_id int,
    course_id int,
    primary key (student_id, course_id),
    foreign key (student_id) references tb_student (student_id),
    foreign key (course_id) references tb_course (course_id)
);

select * from tb_student;
select * from tb_course;
select * from tb_student_course;

insert into tb_student (name) values
('홍길동'), ('김영희'), ('박민지');

insert into tb_course (course_id, title) values
(101, '자바'), (102, 'DB'), (103, '웹개발');

-- tb_student_course
insert into tb_student_course (student_id, course_id) values
(1, 101), (1, 102), (2, 102), (2, 103), (3, 101);

-- 잘못된 데이터 입력
insert into tb_student_course (student_id, course_id) values
(7, 101);
insert into tb_student_course (student_id, course_id) values
(1, 108);
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`relation_practice`.`tb_student_course`, CONSTRAINT `tb_student_course_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `tb_student` (`student_id`))
insert into tb_student_course (student_id, course_id) values
(1, 101);
-- Error Code: 1062. Duplicate entry '1-101' for key 'tb_student_course.PRIMARY'

-- 도전과제. 1:1, 1:N, N:M 관계 테이블 설계
-- 1:1 관계
create table tb_member(
	member_id int primary key auto_increment,
    name varchar(50) not null
);

create table tb_profile(
	profile_id int primary key auto_increment,
    email varchar(50) not null,
    birthday date,
    member_id int unique,
    foreign key (member_id) references tb_member(member_id)
);

insert into tb_member(name) values 
('홍길동'), ('김영희'), ('박민지');

insert into tb_profile(email, birthday, member_id) values
('a@naver.com', '2000-01-01', 1), 
('b@naver.com', '2000-02-02', 2),
('c@naver.com', '2000-03-03', 3); 

select * from tb_member;
select * from tb_profile;

-- 1:N 관계
create table tb_house(
	apart_id int primary key auto_increment,
	apart_name varchar(50) not null,
    address varchar(50) not null
);

create table tb_room(
	room_id int primary key,
    room_size int not null,
    move_date date not null,
    apart_id int not null, 
    foreign key (apart_id) references tb_house (apart_id)
);

insert into tb_house(apart_name, address) values
('A아파트', '서울'),
('B아파트', '부산'),
('C아파트', '인천');

insert into tb_room values 
(101, 24, '2010-09-15', 1),
(102, 24, '2011-12-26', 1),
(103, 24, '2015-07-01', 1),
(201, 33, '2018-07-23', 2),
(301, 16, '2022-01-09', 3);

select * from tb_house;
select * from tb_room;

-- N:M 관계
create table tb_menu(
	menu_id int auto_increment primary key,
    menu_name varchar(50) not null,
    price int not null
);

create table tb_ingredient(
    ingredient_id int auto_increment primary key,
    ingredient_name varchar(50) not null,
    amount varchar(50) not null
);

create table tb_menu_ingredient(
    menu_id int,
    ingredient_id int,
    primary key (menu_id, ingredient_id),
    foreign key (menu_id) references tb_menu(menu_id),
    foreign key (ingredient_id) references tb_ingredient(ingredient_id)
);
insert into tb_menu (menu_name, price) values
('김치볶음밥', 8000),
('김치찌개', 10000);
insert into tb_ingredient (ingredient_id, ingredient_name, amount) values
(10, '김치', '100g'),
(11, '고기', '20g'),
(12, '파', '10g');

insert into tb_menu_ingredient values
(1, 10),
(1, 11),
(1, 12),
(2, 10),
(2, 12);
