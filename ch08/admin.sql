create table admins(
	id int primary key auto_increment,
	admin_id varchar(50) not null unique,
	password varchar(50) not null,
	name varchar(50) not null
);

ALTER TABLE admins
MODIFY password VARCHAR(255) NOT NULL;

insert into admins (admin_id, password, name)values
('admin1', 'admin123', '박지훈' ),
('admin2', 'ad123', '이서연');

SELECT id, admin_id, password, name 
FROM admins
where admin_id = 'admin2';
