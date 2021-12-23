-- Создать таблицу employees
-- id. serial,  primary key,
-- employee_name. Varchar(50), not null
-- Наполнить таблицу employee 70 строками

create table employees (
id serial primary key, 
employee_name varchar (50) not null 
); 

insert into employees (id, employee_name)
values (default, 'Вика');

select * from employees;

--------------------------------------
-- Создать таблицу salary
-- id. Serial  primary key,
-- monthly_salary. Int, not null
-- Наполнить таблицу salary 15 (17) строками

create table salary (
id serial primary key,
monthly_salary int not null);

insert into salary (id, monthly_salary)
values (default, 2500);

select * from salary;

-----------------------------------
-- Создать таблицу employee_salary
-- id. Serial  primary key,
-- employee_id. Int, not null, unique
-- salary_id. Int, not null
--Наполнить таблицу employee_salary 40 строками:
-- в 10 строк из 40 вставить несуществующие employee_id

create table employee_salary (
id serial primary key,
employee_id int not null unique,
salary_id int not null);

select * from employee_salary;

insert into employee_salary (id, employee_id, salary_id)
values (default, 108, 10); 
----------------------------
-- Создать таблицу roles
-- id. Serial  primary key,
-- role_name. int, not null, unique
-- Поменять тип столба role_name с int на varchar(30)
-- Наполнить таблицу roles 20 строками 

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
-- Создать таблицу roles_employee
-- id. Serial  primary key,
-- employee_id. Int, not null, unique (внешний ключ для таблицы employees, поле id)
-- role_id. Int, not null (внешний ключ для таблицы roles, поле id)
-- Наполнить таблицу roles_employee 40 строками

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
-- 1. Вывести всех работников чьи зарплаты есть в базе, вместе с зарплатами.
select employee_name, monthly_salary
from employees e
inner join employee_salary on employee_id = e.id 
inner join salary s on salary_id = s.id 


-- 2. Вывести всех работников у которых ЗП меньше 2000.
select employee_name, s.monthly_salary
from employees e 
inner join employee_salary on employee_id = e.id 
inner join salary s on salary_id = s.id 
where s.monthly_salary < 2000


-- 3. Вывести все зарплатные позиции, но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
select employee_name, s.monthly_salary 
from employees e
right join employee_salary es on employee_id = e.id 
join salary s on s.id = es.salary_id
where employee_name is null;


-- 4. Вывести все зарплатные позиции  меньше 2000 но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
select employee_name, s.monthly_salary 
from employees e
right join employee_salary es on employee_id = e.id 
join salary s on s.id = es.salary_id
where employee_name is null and monthly_salary < 2000;


-- 5. Найти всех работников кому не начислена ЗП.
select employee_name, monthly_salary
from employees 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on salary.id = employee_salary.salary_id
where monthly_salary is null ;


-- 6. Вывести всех работников с названиями их должности.
select employee_name, r.role_name
from employees e
inner join roles_employee on employee_id = e.id 
inner join roles r on role_id = r.id 


-- 7. Вывести имена и должность только Java разработчиков.
select employee_name, r.role_name
from employees e
inner join roles_employee on employee_id = e.id 
inner join roles r on role_id = r.id 
where role_name like '%Java %';

-- 8. Вывести имена и должность только Python разработчиков.
select employee_name, r.role_name
from employees e
inner join roles_employee on employee_id = e.id 
inner join roles r on role_id = r.id 
where role_name like '%Python%'


-- 9. Вывести имена и должность всех QA инженеров.
select employee_name, r.role_name
from employees e
inner join roles_employee on employee_id = e.id 
inner join roles r on role_id = r.id 
where role_name like '%QA%'


-- 10. Вывести имена и должность ручных QA инженеров.
select employee_name, r.role_name
from employees e 
inner join roles_employee on employee_id = e.id 
inner join roles r on role_id = r.id 
where role_name like '%Manual QA%'


-- 11. Вывести имена и должность автоматизаторов QA
select employee_name, r.role_name
from employees e 
inner join roles_employee on employee_id = e.id 
inner join roles r on role_id = r.id 
where role_name like '%Automation QA%'

-- 12. Вывести имена и зарплаты Junior специалистов
select employee_name, role_name, monthly_salary
from employees e
join roles r on e.id = r.id
inner join employee_salary on employee_id = e.id 
inner join salary s on salary_id = s.id 
where role_name like '%Junior %';


-- 13. Вывести имена и зарплаты Middle специалистов
select employee_name, role_name, monthly_salary
from employees e
join roles r on e.id = r.id
inner join employee_salary on employee_id = e.id 
inner join salary s on salary_id = s.id 
where role_name like '%Middle %';


-- 14. Вывести имена и зарплаты Senior специалистов
select employee_name, role_name, monthly_salary
from employees e
join roles r on e.id = r.id
inner join employee_salary on employee_id = e.id 
inner join salary s on salary_id = s.id 
where role_name like '%Senior %';


-- 15. Вывести зарплаты Java разработчиков
select employee_name, role_name, monthly_salary
from employees e
join roles r on e.id = r.id
inner join employee_salary on employee_id = e.id 
inner join salary s on salary_id = s.id 
where role_name like '%Java %';


-- 16. Вывести зарплаты Python разработчиков
select employee_name, role_name, monthly_salary
from employees e
join roles r on e.id = r.id
inner join employee_salary on employee_id = e.id 
inner join salary s on salary_id = s.id 
where role_name like '%Python %';



-- 17. Вывести имена и зарплаты Junior Python разработчиков
select employee_name, role_name, monthly_salary
from employees e
join roles r on e.id = r.id
inner join employee_salary on employee_id = e.id 
inner join salary s on salary_id = s.id 
where role_name like '%Junior Python %';


-- 18. Вывести имена и зарплаты Middle JS разработчиков
select employee_name, role_name, monthly_salary
from employees e
join roles r on e.id = r.id
inner join employee_salary on employee_id = e.id 
inner join salary s on salary_id = s.id 
where role_name like '%Middle JavaScript %';


-- 19. Вывести имена и зарплаты Senior Java разработчиков
select employee_name, role_name, monthly_salary
from employees e
join roles r on e.id = r.id
inner join employee_salary on employee_id = e.id 
inner join salary s on salary_id = s.id 
where role_name like '%Senior Java %';


-- 20. Вывести зарплаты Junior QA инженеров
select employee_name, role_name, monthly_salary
from employees e
join roles r on e.id = r.id
join employee_salary on employee_id = e.id 
join salary s on salary_id = s.id 
where role_name like '%Junior%QA%';


-- 21. Вывести среднюю зарплату всех Junior специалистов
select avg (monthly_salary)
from employees e
join roles r on e.id = r.id
join employee_salary on employee_id = e.id 
join salary s on salary_id = s.id
where role_name like '%Junior%';

-- 22. Вывести сумму зарплат JS разработчиков
select sum (monthly_salary)
from employees e 
join roles r on e.id = r.id 
join employee_salary on employee_id = e.id 
join salary s on salary_id = s.id 
where role_name like '%JavaScript%'; 


-- 23. Вывести минимальную ЗП QA инженеров
select min (monthly_salary)
from employees e
join employee_salary on employee_id = e.id 
join roles r on e.id = r.id 
join salary s on salary_id = s.id 
where role_name like '%QA%'


-- 24. Вывести максимальную ЗП QA инженеров
select max (monthly_salary)
from employees e
join employee_salary on employee_id = e.id 
join roles r on e.id = r.id 
join salary s on salary_id = s.id 
where role_name like '%QA%';


-- 25. Вывести количество QA инженеров
select count (employee_id)
from employees e 
join roles_employee on employee_id = e.id
join roles r on role_id = r.id 
where role_name like '%QA%';


-- 26. Вывести количество Middle специалистов.
select count (employee_id)
from employees e 
join roles_employee on employee_id = e.id
join roles r on role_id = r.id 
where role_name like '%Middle%';


-- 27. Вывести количество разработчиков
select count (employee_id)
from employees e 
join roles_employee on employee_id = e.id
join roles r on role_id = r.id 
where role_name like '%developer%';


-- 28. Вывести фонд (сумму) зарплаты разработчиков.
select sum (monthly_salary)
from employees e
join employee_salary on employee_id = e.id 
join salary s on salary_id = s.id
join roles r on employee_id = r.id
where role_name like '%developer%';


-- 29. Вывести имена, должности и ЗП всех специалистов по возрастанию
select monthly_salary, role_name, employee_name
from employees e 
join employee_salary on employee_id = e.id 
join salary s on salary_id = s.id 
join roles_employee re on e.id = re.id
join roles r on role_id = r.id 
order by monthly_salary;


-- 30. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП от 1700 до 2300
select monthly_salary, role_name, employee_name
from employees e 
join employee_salary on employee_id = e.id 
join salary s on salary_id = s.id 
join roles_employee re on e.id = re.id
join roles r on role_id = r.id 
where monthly_salary  between 1700 and 2300
order by monthly_salary;


-- 31. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП меньше 2300
select monthly_salary, role_name, employee_name
from employees e 
join employee_salary on employee_id = e.id 
join salary s on salary_id = s.id 
join roles_employee re on e.id = re.id
join roles r on role_id = r.id 
where monthly_salary < 2300
order by monthly_salary;


-- 32. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП равна 1100, 1500, 2000
select monthly_salary, role_name, employee_name
from employees e 
join employee_salary on employee_id = e.id 
join salary s on salary_id = s.id 
join roles_employee re on e.id = re.id
join roles r on role_id = r.id 
where monthly_salary in (1100 , 1500, 2000)
order by monthly_salary;

