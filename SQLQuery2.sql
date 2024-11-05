CREATE DATABASE classicmodels;

Use classicmodels;
  SELECT table_name = t.name
  FROM sys.tables t

  create table student
  (st_roll int, age int, name varchar(30),mark float);

  --delimeter //

  --create trigger marks_verify_st
  --before insert on student 
  --for each row
  --if new marks<0 then set new.marks =50;
  --end if ;//

  insert into student
  values (501,10,'Ruth', 75.0),
  (502,12,'Mike',79.5),
    (503,13,'Dave',79.5),
	  (502,12,'kelvin',99.5);

	SELECT * from student;

	create table demo(st_id int,st_name varchar(20));
	insert into demo
	values(101,'shane'),
	(102,'bradley'),
    (103,'havertz'),
	(104,'Kalulu'),
	(105,'kelvin'),
	(106, 'simi'),
	(105,'kelvin'),
	(102,'bradely')

	select* from demo
	select  st_id,st_name,row_number() over
	(partition by st_id,st_name order by st_id )as row_num
	from demo;

create table demo1(VAR_A INT);

insert into demo1
value(101),(102),(103),(104),(105),(106),(107),(103),(103);

select var_a,
rank() over (order by var_a) as test_rank