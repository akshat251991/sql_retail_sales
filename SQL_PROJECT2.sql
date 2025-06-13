-- create branch table
drop table if exists branch;
create table branch
(
branch_id varchar(5) primary key,
manager_id varchar(5),
branch_address varchar(50),
contact_no varchar(15)
);

--create employees table
drop table if exists employees;
create table employees
(
emp_id varchar(5) primary key,
emp_name varchar(30),
positions varchar(25),
salary decimal(10,2),
branch_id varchar(5), -- from branch
FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

--create members table
drop table if exists members;
create table members
(
member_id varchar(5) primary key,
member_name varchar(30),
member_address varchar(60),
reg_date date
);

--create books table
drop table if exists books;
create table books
(
isbn varchar(25) primary key,
book_title varchar(25),
category varchar(25),
rental_price float,
status varchar(25),
author varchar(25),
publisher varchar(50)
);

--create issued_status table
drop table if exists issued_status;
create table issued_status
(
issued_id varchar(7) primary key,
issued_member_id varchar(5),-- from members
issued_book_name varchar(50),
issued_date date,
issued_book_isbn varchar(30), -- from books
issued_emp_id varchar(5),-- from employees
foreign key (issued_member_id) references members(member_id),
foreign key (issued_book_isbn) references books(isbn),
foreign key (issued_emp_id) references employees(emp_id)
);

--create return_status table
drop table if exists return_status;
create table return_status
(
return_id varchar(15) primary key,
issued_id varchar(30),
return_book_name varchar(50),
return_date date,
return_book_isbn varchar(25),
FOREIGN KEY (return_book_isbn) REFERENCES books(isbn)
);