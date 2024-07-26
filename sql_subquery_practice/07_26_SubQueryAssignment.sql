use hr;

-- 1
select concat(e.first_name , ' ' , e.last_name) 'Name' , j.job_title , e.salary
from employees e join jobs j on e.job_id = j.job_id
where e.salary >  (
        select e1.salary
        from employees e1
        where e1.last_name = 'Tucker'
);


-- 2
select concat(e.first_name , ' ' , e.last_name) 'Name' , j.job_title , e.salary , e.hire_date
from employees e join jobs j on e.job_id = j.job_id
where e.salary >  (
        select e1.salary
        from employees e1
        where e1.last_name = 'Tucker'
);


-- 3
select concat(e.first_name , ' ' , e.last_name) 'Name' , e.salary , d.department_id , j.jobs_title
from employees e
where e.salary > (
        select e1.salary
        from employees
        where

    )

use hr;
-- 4
select e.employee_id , concat(e.first_name , ' ' , e.last_name) 'Name' , j.job_title , e.hire_date
from employees e
    join jobs j on e.job_id = j.job_id
    join departments d on e.department_id = d.department_id
where d.location_id =  (
            select location_id
            from locations
            where city = 'O%'

          );


-- 5
select concat(e.first_name , ' ' , e.last_name) 'Name' , j.job_title , e.salary , d.department_id , avg(e.salary) 'Department Avg Salary'
from employees e
    join jobs j on e.job_id = j.job_id
    join departments d on e.department_id = d.department_id
where d.location_id =  (
            select location_id
            from locations
            where city = 'O%'

          );

-- 6
select e.employee_id , concat(e.first_name , ' ' , e.last_name) 'Name' , j.job_title
from employees e join jobs j on e.job_id = j.job_id
where e.salary> (
            select salary
            from employees
            where last_name = 'Kochhar'
       );

 -- 조인 : 공통필드를 조회하기 위함
-- 7
select e.employee_id , concat(e.first_name , ' ' , e.last_name) 'Name' , j.job_title , e.salary , d.department_id
from employees e join jobs j on e.job_id = j.job_id join departments d on e.department_id = d.department_id
where e.salary < (
            select avg(salary)
            from employees
       );



-- 8
select *
from departments d join employees e on d.department_id = e.department_id
where e.salary > (
            select min(e1.salary)
            from departments d1 join employees e1 on d1.department_id = e1.department_id
            where d1.department_id=100
       );




-- 9
select e.employee_id , concat(e.first_name , ' ' , e.last_name) 'Name' , j.job_title , d.department_id
from employees e join jobs j on e.job_id = j.job_id join departments d on e.department_id = d.department_id
where e.salary = (
            select min(e1.salary)
            from jobs j1 join employees e1 on j1.job_id = e1.job_id

       )
order by j.job_title;



-- 10
select *
from departments d join employees e on d.department_id = e.department_id
where e.salary > (
            select min(e1.salary)
            from departments d1 join employees e1 on d1.department_id = e1.department_id
            where d1.department_id=100
       );


-- 11
select concat(e.first_name , ' ' , e.last_name) 'Name' , j.job_title , d.department_name , l.city
from employees e join jobs j on e.job_id = j.job_id
    join departments d on e.department_id = d.department_id
    join locations l on l.location_id = d.location_id
where e.employee_id IN (
        select e1.employee_id
        from employees e1
        where e1.job_id = 'SA_MAN'
    );


-- 12
select e.employee_id , concat(e.first_name , ' ' , e.last_name) 'Name'
from employees e
where e.manager_id = (
        select count(e1.employee_id)
        from employees e1
        where count(*
    );


-- 13
select e.employee_id , concat(e.first_name , ' ' , e.last_name) 'Name' , j.job_title , e.salary
from employees e join jobs j on e.job_id = j.job_id
where j.job_id =  (
        select j1.job_id
        from employees e1 join jobs j1 on e1.job_id = j1.job_id
        where e1.employee_id = 123
    )
and e.salary >(
        select e1.salary
        from employees e1
        where e1.employee_id = 192
    );
-- 굳이 서브쿼리에서 조건들을 다 하지 않아려 해도 됨 , 메인 쿼리에서도 가능 , 근데 이건 문제 스킬인듯 ㅇㅇ

-- 14
select e.employee_id , concat(e.first_name , ' ' , e.last_name) 'Name' , j.job_title , e.hire_date , e.salary , d.department_id
from employees e join jobs j on e.job_id = j.job_id
    join departments d on e.department_id = d.department_id
where e.salary > (
        select min(e1.salary)
        from departments d1 join employees e1 on d1.department_id = e1.department_id
        where d1.department_id = 50
    ) and e.department_id != 50;


-- 15
select e.employee_id , concat(e.first_name , ' ' , e.last_name) 'Name' , j.job_title , e.hire_date , e.salary , d.department_id
from employees e join jobs j on e.job_id = j.job_id
    join departments d on e.department_id = d.department_id
where e.salary > (
        select max(e1.salary)
        from departments d1 join employees e1 on d1.department_id = e1.department_id
        where d1.department_id = 50
    ) and e.department_id != 50;
