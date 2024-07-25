use bookmarket;


select * from orders;

select * from book;
select * from orders;
select * from customer;


describe book;
describe orders;
describe customer;

-- 고객의 이름과 고객이 주문한 도서의 이름 , 고객이 주문한 주문 id 조회
select c.name , b.bookname , o.orderid
from customer c join book b join orders o
on o.bookid = b.bookid and o.cusid = c.cusid;


select c.name , b.bookname , o.orderid
from customer c , book b , orders o
where o.cusid = c.cusid and o.bookid = b.bookid;
-- 그냥 두면 카디션 프로덕트로 중복 제거 안 되고 하나씩 조회되지만, 이런 식으로

-- 1-5
select count(*) from book b join orders o join customer c
on o.cusid = c.cusid and o.bookid = b.bookid where c.name = '박지성';

-- 1-6
select distinct b.bookname as '이름' , b.price as '가격', b.price - o.saleprice as '정가와 판매가격의 차이' from book b join orders o join customer c
on o.cusid = c.cusid and o.bookid = b.bookid where c.name = '박지성';

-- 1-7
select b.bookname from book b join orders o join customer c
on o.cusid = c.cusid and o.bookid = b.bookid where c.name <> '박지성';

select * from book;


select b.bookname from customer c join orders o on c.cusid = o.cusid join book b on o.bookid = b.bookid where c.name <> '박지성';

use hr;


-- 지역 코드가 1700인 사원 이름 , 지역번호 , 부서번호 , 부서이름을 조회
select * from employees;

select e.name , l.location_id , d.department_id , d.department_name
from employees e
    join departments d
    on e.employee_id = d.manager_id
    and e.department_id = d.department_id
    join countries c on c.country_id =
from departments d join employees e on e.department_id = d.department_id join locations l on l.country_id =



select e.name , l.location_id , d.department_id , d.department_name
from employees e , locations l , departments d , countries c
where e.department_id = d.department_id and e.employee_id = d.manager_id and  = c.region_id;





select * from employees;
-- Employees : 사원테이블
create table employees(
    employee_id int unsigned not null,                          -- 직무번호
    first_name varchar(20),            -- 성
    last_name varchar(30) not null,             -- 이름
    email varchar(25) not null,
    phone_number varchar(20),          -- 전화번호
    hire_date date not null,             -- 입사일
    job_id varchar(10) not null,
    salary decimal(8,2) not null,                -- 월급
    commission_pct decimal(2,2),-- 커미션 (수당)
    manager_id integer unsigned,
    department_id integer unsigned,         -- 부서아이디
    primary key (employee_id)
);



create table departments(
     department_id int unsigned not null,
     department_name varchar(30) not null,
     manager_id int unsigned,
     location_id int unsigned,
     primary key (department_id)
);

-- 해결
create table regions(
     region_id int unsigned not null,
     region_name varchar(25),
     primary key (region_id)
);


-- 해결
create table countries(
        country_id CHAR(2) NOT NULL,
        country_name varchar(40),
        region_id int unsigned not null,
        primary key(country_id)
);

create table locations(
    location_id int unsigned not null auto_increment,
    street_address varchar(40),
    postal_code varchar(12),
    city varchar(30) not null,
    state_province varchar(30),
    country_id char(2) not null,
    primary key(location_id)
);


create table jobs(
     job_id varchar(20) not null,
     job_title varchar(40) not null,
     min_salary decimal(8,0) unsigned,
     max_salary decimal(8,0) unsigned,
     primary key(job_id)
);

create table job_history(
     employee_id int unsigned not null,
     start_date date not null,
     end_date date not null,
     job_id varchar(20) not null,
     department_id int unsigned not null
);




select * from employees;



-- 1. 모든 사원의 이름, 부서번호, 부서 이름을 조회하세요
select concat(e.first_name ,  ' ', e.last_name), d.department_id , d.department_name
from employees e join departments d on e.department_id = d.department_id ;

-- 2. 부서번호 80 에 속하는 모든 업무의 고유 목록을 작성하고 출력결과에 부서의 위치를 출력하세요
select distinct j.* , l.street_address
from departments d
    join job_history jh on d.department_id = jh.department_id
    join jobs j on jh.job_id = j.job_id
    join locations l on d.location_id = l.location_id
where d.department_id = 80;

-- 3. 커미션(수당)을 받는 사원의 이름, 부서 이름, 위치번호와 도시명을 조회하세요

select concat(e.first_name ,  ' ', e.last_name) , d.department_name , l.location_id  ,  l.city
from employees e
    join departments d on e.department_id = d.department_id
    join locations l on d.location_id = l.location_id
where e.commission_pct is not null;


-- 4. 이름에 a(소문자)가 포함된 모든 사원의 이름과 부서명을 조회하세요
select concat(e.first_name , ' ' , e.last_name) '사원이름',  d.department_name '부서명'
from employees e join departments d on e.department_id = d.department_id
where concat(e.first_name , e.last_name) like '%a%';

-- 5. 'Toronto'에서 근무하는 모든 사원의 이름, 업무, 부서 번호 와 부서명을 조회하세요
select concat(e.first_name , ' ', e.last_name) '사원이름' , j.job_id '업무번호', d.department_id '부서번호', d.department_name '부서명'
from employees e
    join departments d on e.department_id = d.department_id
    join jobs j on j.job_id = e.job_id
    join locations l on l.location_id = d.location_id
where l.city = 'Toronto';



-- 6. 사원의 이름 과 사원번호를 관리자의 이름과 관리자 아이디와 함께 표시하고 각각의 컬럼명을 Employee, Emp#, Manger, Mgr#으로 지정하세요
select concat(e.first_name , ' ',  e.last_name) , e.employee_id , concat(e.first_name , ' ',  e.last_name) ,  e.manager_id
from employees e join departments d on e.manager_id = d.manager_id;


-- 7. 사장인'King'을 포함하여 관리자가 없는 모든 사원을 조회하세요 (사원번호를 기준으로 정렬하세요)
select *
from employees e
where e.last_name != 'King';



-- 8. 지정한 사원의 이름, 부서 번호 와 지정한 사원과 동일한 부서에서 근무하는 모든 사원을 조회하세요
select concat(e.first_name , ' ', e.last_name) , d.department_id
from employees e join departments d on e.department_id = d.department_id



-- 9. JOB_GRADRES 테이블을 생성하고 모든 사원의 이름, 업무,부서이름, 급여 , 급여등급을 조회하세요
CREATE TABLE job_grades (
    grade_level	CHAR(1) PRIMARY KEY,
    lowest_sal 	INT NOT NULL,
    highest_sal	INT NOT NULL
);

/**
  * SQL Practice 1
 */
-- 엑셀과 SQL 분리 이것이 SRP이다 !
-- 문제 1-0
select e.employee_id , concat(e.first_name , ' ', e.last_name) 'Name' , e.salary , j.job_title , e.hire_date , e.manager_id
from employees e
    join jobs j on e.job_id = j.job_id
    join departments d on e.manager_id = d.manager_id and e.department_id = d.department_id


-- 문제 1-1
select concat(e.first_name , ' ', e.last_name) 'Name' , j.job_title , e.salary , (e.salary + 100)*12 'Increased Ann_Salary' , e.salary + 100 'Increased Salary'
from employees e join jobs j on e.job_id = j.job_id;


-- 문제 1-2
select  concat('이름: ',e.last_name , ' , 1 Year Salary = $',e.salary*12) '1 Year Salary'
from employees e;


-- 1-3
select j.job_title
from jobs j
    join employees e on j.job_id = e.job_id
    join departments d on e.department_id = d.department_id
group by d.department_id , j.job_title;


-- 2-0
select concat(e.first_name , ' ', e.last_name) , e.salary
from employees e
where salary not between 7000 and 10000
order by salary asc;


-- 2-1

select e.last_name 'e and o Name'
from employees e
where e.last_name like '%e%' and e.last_name like '%o%';


-- 2-2
select CURDATE() '현재날짜', concat(e.first_name , ' ', e.last_name) 'Name' , e.employee_id '사원번호' , e.hire_date '고용일자'
from employees e
where e.hire_date between '2006-05-20' and '2007-05-20'
order by e.hire_date;


-- 2-3
select concat(e.first_name , ' ', e.last_name) 'Name', e.salary , j.job_title , e.commission_pct
from employees e join jobs j on j.job_id = e.job_id
order by e.salary desc , e.commission_pct desc;


-- 3-0
select e.employee_id , concat(e.first_name , ' ', e.last_name) 'Name' , e.salary '급여' , ROUND(e.salary * 12.3) 'Increased Salary'
from employees e join departments d on e.department_id = d.department_id
where d.department_id = 60;

-- 3-1
select CONCAT(UPPER(LEFT(e.first_name , 1)), LOWER(SUBSTRING(e.first_name, 2)) , ' ' , UPPER(LEFT(e.last_name , 1)), LOWER(SUBSTRING(e.last_name, 2))) 'Employee JOBs' , 'is a' , UPPER(j.job_title)
from employees e join jobs j on e.job_id = j.job_id
where e.last_name like '%s';


-- 3-2
select concat(e.first_name , ' ', e.last_name) 'Name', e.salary , if(e.commission_pct is not null , 'Salary + Commission' , 'Salary only') 수당여부
from employees e
order by salary desc;


-- 3-3
select concat(e.first_name , ' ', e.last_name) 'Name' ,
       jh.start_date ,
       (case weekday(jh.start_date)
         WHEN '1' THEN '월'
    WHEN '2' THEN '화'
    WHEN '3' THEN '수'
    WHEN '4' THEN '목'
    WHEN '5' THEN '금'
    WHEN '6' THEN '토'
    WHEN '7' THEN '일' end) from employees e join job_history jh on jh.employee_id = e.employee_id;


use hr;
-- 4-0
select concat(e.first_name , ' ', e.last_name) '매니저명' , count(e1.first_name) '사원 수'
from employees e join employees e1 on e.employee_id = e1.manager_id
group by concat(e.first_name , ' ', e.last_name);

-- 4-1
select d.department_name , sum(e.salary) , avg(e.salary) , max(e.salary) , min(e.salary) , count(e.salary)
from employees e join departments d on e.department_id = d.department_id
group by e.department_id
order by e.department_id asc;



-- 4-2
select j.job_title , avg(e.salary)
from employees e join jobs j on e.job_id = j.job_id
where j.job_title != '%CLERK%'
group by j.job_id
having avg(e.salary) >= 10000
order by avg(e.salary) desc;


/**
  * SQL Practice 2
 */

-- 0
select 'Han-Bit', concat(e.first_name , ' ', e.last_name) 'Name' , j.job_title , d.department_name , l.city
from employees e join departments d on e.department_id = d.department_id join locations l on d.location_id = l.location_id join jobs j on j.job_id = e.job_id
where l.city = 'Oxford';


-- 1
SELECT d.department_name, COUNT(e.employee_id) AS employee_count
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) >= 5;


-- 2 : 잘 모르겠음 ㅇㅇ
select concat(e.first_name , ' ', e.last_name) 'Name' , j.job_title , d.department_name , jh.start_date , e.salary , jg.grade_level
from employees e
    join departments d on e.department_id = d.department_id
    join jobs j on j.job_id = e.job_id
    join job_history jh on jh.employee_id = e.employee_id
    join job_grades jg on e.salary between jg.lowest_sal and jg.highest_sal; -- 낮은 월급부터 높은 월급 사이에 현재 월급을 조인하는 것이니 그에 따른 등급 출력

-- 3 : 셀프 조인 문제
select concat(e.first_name , ' ', e.last_name) , 'report to' , ifnull(UPPER(concat(e1.first_name , ' ', e1.last_name)) , concat(e.first_name , ' ', e.last_name))
from employees e join employees e1 on e.employee_id = e1.manager_id;




