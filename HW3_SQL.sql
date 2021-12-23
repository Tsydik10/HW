-- ������� ������� employees
-- id. serial,  primary key,
-- employee_name. Varchar(50), not null
-- ��������� ������� employee 70 ��������

create table employees (
id serial primary key, 
employee_name varchar (50) not null 
); 

insert into employees (id, employee_name)
values (default, '����');

select * from employees;

--------------------------------------
-- ������� ������� salary
-- id. Serial  primary key,
-- monthly_salary. Int, not null
-- ��������� ������� salary 15 (17) ��������

create table salary (
id serial primary key,
monthly_salary int not null);

insert into salary (id, monthly_salary)
values (default, 2500);

select * from salary;

-----------------------------------
-- ������� ������� employee_salary
-- id. Serial  primary key,
-- employee_id. Int, not null, unique
-- salary_id. Int, not null
--��������� ������� employee_salary 40 ��������:
-- � 10 ����� �� 40 �������� �������������� employee_id

create table employee_salary (
id serial primary key,
employee_id int not null unique,
salary_id int not null);

select * from employee_salary;

insert into employee_salary (id, employee_id, salary_id)
values (default, 108, 10); 
----------------------------
-- ������� ������� roles
-- id. Serial  primary key,
-- role_name. int, not null, unique
-- �������� ��� ������ role_name � int �� varchar(30)
-- ��������� ������� roles 20 �������� 

create table roles (
id serial primary key,
role_name int not null unique
); 

alter table roles 
alter column role_name type varchar(30)
using role_name::varchar(30);

insert into roles (id, role_name)
values (default, 'Senior Automation QA engineer'); 

select * from roles; 

-------------------------------
-- ������� ������� roles_employee
-- id. Serial  primary key,
-- employee_id. Int, not null, unique (������� ���� ��� ������� employees, ���� id)
-- role_id. Int, not null (������� ���� ��� ������� roles, ���� id)
-- ��������� ������� roles_employee 40 ��������

create table roles_employee (
id serial primary key,
employee_id int not null unique,
role_id int not null, 
foreign key (employee_id)
  references employees (id),
foreign key (role_id)
  references roles (id)
);

insert into roles_employee (id, employee_id, role_id)
values (default, 53, 14);

select * from roles_employee;

---------------------------------------------------------
-- 1. ������� ���� ���������� ��� �������� ���� � ����, ������ � ����������.
select employee_name, monthly_salary
from employees e
inner join employee_salary on employee_id = e.id 
inner join salary s on salary_id = s.id 


-- 2. ������� ���� ���������� � ������� �� ������ 2000.
select employee_name, s.monthly_salary
from employees e 
inner join employee_salary on employee_id = e.id 
inner join salary s on salary_id = s.id 
where s.monthly_salary < 2000


-- 3. ������� ��� ���������� �������, �� �������� �� ��� �� ��������. (�� ����, �� �� ������� ��� � ��������.)
select employee_name, s.monthly_salary 
from employees e
right join employee_salary es on employee_id = e.id 
join salary s on s.id = es.salary_id
where employee_name is null;


-- 4. ������� ��� ���������� �������  ������ 2000 �� �������� �� ��� �� ��������. (�� ����, �� �� ������� ��� � ��������.)
select employee_name, s.monthly_salary 
from employees e
right join employee_salary es on employee_id = e.id 
join salary s on s.id = es.salary_id
where employee_name is null and monthly_salary < 2000;


-- 5. ����� ���� ���������� ���� �� ��������� ��.
select employee_name, monthly_salary
from employees 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on salary.id = employee_salary.salary_id
where monthly_salary is null ;


-- 6. ������� ���� ���������� � ���������� �� ���������.
select employee_name, r.role_name
from employees e
inner join roles_employee on employee_id = e.id 
inner join roles r on role_id = r.id 


-- 7. ������� ����� � ��������� ������ Java �������������.
select employee_name, r.role_name
from employees e
inner join roles_employee on employee_id = e.id 
inner join roles r on role_id = r.id 
where role_name like '%Java %';

-- 8. ������� ����� � ��������� ������ Python �������������.
select employee_name, r.role_name
from employees e
inner join roles_employee on employee_id = e.id 
inner join roles r on role_id = r.id 
where role_name like '%Python%'


-- 9. ������� ����� � ��������� ���� QA ���������.
select employee_name, r.role_name
from employees e
inner join roles_employee on employee_id = e.id 
inner join roles r on role_id = r.id 
where role_name like '%QA%'


-- 10. ������� ����� � ��������� ������ QA ���������.
select employee_name, r.role_name
from employees e 
inner join roles_employee on employee_id = e.id 
inner join roles r on role_id = r.id 
where role_name like '%Manual QA%'


-- 11. ������� ����� � ��������� ��������������� QA
select employee_name, r.role_name
from employees e 
inner join roles_employee on employee_id = e.id 
inner join roles r on role_id = r.id 
where role_name like '%Automation QA%'

-- 12. ������� ����� � �������� Junior ������������
select employee_name, role_name, monthly_salary
from employees e
join roles r on e.id = r.id
inner join employee_salary on employee_id = e.id 
inner join salary s on salary_id = s.id 
where role_name like '%Junior %';


-- 13. ������� ����� � �������� Middle ������������
select employee_name, role_name, monthly_salary
from employees e
join roles r on e.id = r.id
inner join employee_salary on employee_id = e.id 
inner join salary s on salary_id = s.id 
where role_name like '%Middle %';


-- 14. ������� ����� � �������� Senior ������������
select employee_name, role_name, monthly_salary
from employees e
join roles r on e.id = r.id
inner join employee_salary on employee_id = e.id 
inner join salary s on salary_id = s.id 
where role_name like '%Senior %';


-- 15. ������� �������� Java �������������
select employee_name, role_name, monthly_salary
from employees e
join roles r on e.id = r.id
inner join employee_salary on employee_id = e.id 
inner join salary s on salary_id = s.id 
where role_name like '%Java %';


-- 16. ������� �������� Python �������������
select employee_name, role_name, monthly_salary
from employees e
join roles r on e.id = r.id
inner join employee_salary on employee_id = e.id 
inner join salary s on salary_id = s.id 
where role_name like '%Python %';



-- 17. ������� ����� � �������� Junior Python �������������
select employee_name, role_name, monthly_salary
from employees e
join roles r on e.id = r.id
inner join employee_salary on employee_id = e.id 
inner join salary s on salary_id = s.id 
where role_name like '%Junior Python %';


-- 18. ������� ����� � �������� Middle JS �������������
select employee_name, role_name, monthly_salary
from employees e
join roles r on e.id = r.id
inner join employee_salary on employee_id = e.id 
inner join salary s on salary_id = s.id 
where role_name like '%Middle JavaScript %';


-- 19. ������� ����� � �������� Senior Java �������������
select employee_name, role_name, monthly_salary
from employees e
join roles r on e.id = r.id
inner join employee_salary on employee_id = e.id 
inner join salary s on salary_id = s.id 
where role_name like '%Senior Java %';


-- 20. ������� �������� Junior QA ���������
select employee_name, role_name, monthly_salary
from employees e
join roles r on e.id = r.id
join employee_salary on employee_id = e.id 
join salary s on salary_id = s.id 
where role_name like '%Junior%QA%';


-- 21. ������� ������� �������� ���� Junior ������������
select avg (monthly_salary)
from employees e
join roles r on e.id = r.id
join employee_salary on employee_id = e.id 
join salary s on salary_id = s.id
where role_name like '%Junior%';

-- 22. ������� ����� ������� JS �������������
select sum (monthly_salary)
from employees e 
join roles r on e.id = r.id 
join employee_salary on employee_id = e.id 
join salary s on salary_id = s.id 
where role_name like '%JavaScript%'; 


-- 23. ������� ����������� �� QA ���������
select min (monthly_salary)
from employees e
join employee_salary on employee_id = e.id 
join roles r on e.id = r.id 
join salary s on salary_id = s.id 
where role_name like '%QA%'


-- 24. ������� ������������ �� QA ���������
select max (monthly_salary)
from employees e
join employee_salary on employee_id = e.id 
join roles r on e.id = r.id 
join salary s on salary_id = s.id 
where role_name like '%QA%';


-- 25. ������� ���������� QA ���������
select count (employee_id)
from employees e 
join roles_employee on employee_id = e.id
join roles r on role_id = r.id 
where role_name like '%QA%';


-- 26. ������� ���������� Middle ������������.
select count (employee_id)
from employees e 
join roles_employee on employee_id = e.id
join roles r on role_id = r.id 
where role_name like '%Middle%';


-- 27. ������� ���������� �������������
select count (employee_id)
from employees e 
join roles_employee on employee_id = e.id
join roles r on role_id = r.id 
where role_name like '%developer%';


-- 28. ������� ���� (�����) �������� �������������.
select sum (monthly_salary)
from employees e
join employee_salary on employee_id = e.id 
join salary s on salary_id = s.id
join roles r on employee_id = r.id
where role_name like '%developer%';


-- 29. ������� �����, ��������� � �� ���� ������������ �� �����������
select monthly_salary, role_name, employee_name
from employees e 
join employee_salary on employee_id = e.id 
join salary s on salary_id = s.id 
join roles_employee re on e.id = re.id
join roles r on role_id = r.id 
order by monthly_salary;


-- 30. ������� �����, ��������� � �� ���� ������������ �� ����������� � ������������ � ������� �� �� 1700 �� 2300
select monthly_salary, role_name, employee_name
from employees e 
join employee_salary on employee_id = e.id 
join salary s on salary_id = s.id 
join roles_employee re on e.id = re.id
join roles r on role_id = r.id 
where monthly_salary  between 1700 and 2300
order by monthly_salary;


-- 31. ������� �����, ��������� � �� ���� ������������ �� ����������� � ������������ � ������� �� ������ 2300
select monthly_salary, role_name, employee_name
from employees e 
join employee_salary on employee_id = e.id 
join salary s on salary_id = s.id 
join roles_employee re on e.id = re.id
join roles r on role_id = r.id 
where monthly_salary < 2300
order by monthly_salary;


-- 32. ������� �����, ��������� � �� ���� ������������ �� ����������� � ������������ � ������� �� ����� 1100, 1500, 2000
select monthly_salary, role_name, employee_name
from employees e 
join employee_salary on employee_id = e.id 
join salary s on salary_id = s.id 
join roles_employee re on e.id = re.id
join roles r on role_id = r.id 
where monthly_salary in (1100 , 1500, 2000)
order by monthly_salary;

