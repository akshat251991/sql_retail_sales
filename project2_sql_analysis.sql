SELECT * FROM books;
SELECT * FROM return_status;
SELECT * FROM employees;
SELECT * FROM branch;
SELECT * FROM members;
SELECT * FROM issued_status;


--Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;

--Task 2: Update an Existing Member's Address
update members
set member_address = '125 Oak St'
where number_id='C103';

--Task 3: Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
DELETE FROM issued_status
where issued_id='IS121';

--Task 4: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E101'.

select * from books
select * from employees
select * from members
select * from issued_status
select * from return_status
select * from branch

select * from issued_status
where issued_emp_id='E101'

--Task 5: List Members Who Have Issued More Than One Book 
-- Objective: Use GROUP BY to find members who have issued more than one book.

select issued_emp_id,count(*) as book_cnt
from issued_status
group by issued_emp_id
having count(*) >1

--Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results
-- - each book and total book_issued_cnt**
--CTAS (CREATE TABLE AS SELECT) Imp.
CREATE TABLE book_issued_cnt AS
select b.isbn,b.book_title,count(ist.issued_id) as issue_count
from issued_status ist
inner join books as b
on b.isbn=ist.issued_book_isbn
group by b.isbn,b.book_title;

select * from book_issued_cnt order by issue_count desc;


--4. Data Analysis & Findings

--Task 7. Retrieve All Books in a Specific Category:

SELECT * FROM books
WHERE category = 'Classic';

--Task 8: Find Total Rental Income by Category:
SELECT * FROM books;
SELECT * FROM return_status;
SELECT * FROM employees;
SELECT * FROM branch;
SELECT * FROM members;
SELECT * FROM issued_status;

select count(*),category,sum(rental_price) as Rental_Income
from books
group by category
order by sum(rental_price) desc


SELECT 
    b.category,
    SUM(b.rental_price),
    COUNT(*)
FROM 
issued_status as ist
JOIN
books as b
ON b.isbn = ist.issued_book_isbn
GROUP BY 1

--List Members Who Registered in the Last 180 Days:

select * from members
where reg_date>= current_date - interval '180 days'

insert into members(member_id,member_name,member_address,reg_date)
values
('C118','Sam','145 Main St','2024-06-01'),
('C119','John','133 Main St','2024-05-01');

select * from members


--List Employees with Their Branch Manager's Name and their branch details:
SELECT * FROM employees;
SELECT * FROM branch;

select emp_id,emp_name,positions from employees
where positions='Manager' 



--Solution 1:
select e.emp_id,e.emp_name,b.manager_id,b.branch_id,e.positions,b.branch_address,f.emp_name as Manager
from employees e inner join branch b
on e.branch_id = b.branch_id
inner join employees f
on f.emp_id=b.manager_id

--Solution 2:
SELECT 
    e1.emp_id,
    e1.emp_name,
    e1.positions,
    e1.salary,
    b.*,
    e2.emp_name as manager
FROM employees as e1
JOIN 
branch as b
ON e1.branch_id = b.branch_id    
JOIN
employees as e2
ON e2.emp_id = b.manager_id


--Task 11. Create a Table of Books with Rental Price Above a Certain Threshold:
create table expensive_books as
select * from books
where rental_price>7


--Task 12: Retrieve the List of Books Not Yet Returned
select * from return_status
select * from issued_status 

--Sol 1
select * from 
(
select ist.issued_book_name,ist.issued_id,rst.return_id from issued_status ist
left join return_status rst
on ist.issued_id=rst.issued_id
)
where return_id is null

--Sol2
SELECT * FROM issued_status as ist
LEFT JOIN
return_status as rs
ON rs.issued_id = ist.issued_id
WHERE rs.return_id IS NULL;











