create table time_slot_header (
	time_slot_id	character varying(4),
	primary key(time_slot_id)
);
insert into time_slot_header(time_slot_id) select distinct time_slot_id from section;
alter table section
	add foreign key (time_slot_id) references time_slot_header(time_slot_id);

alter table student 
drop constraint student_dept_name_fkey;
alter table instructor 
drop constraint instructor_dept_name_fkey;
alter table course
drop constraint course_dept_name_fkey;
alter table department 
drop constraint department_pkey;

alter table department 
add department_id	serial;
alter table department 
add primary key (department_id);
alter table department 
add unique (dept_name);

alter table student add column department_id serial;
update student set department_id= (
	select department_id from department
	where department.dept_name=student.dept_name
);
alter table student
add foreign key (department_id) references department(department_id);
alter table student drop column dept_name;

alter table course add column department_id	serial;
update course set department_id= (
	select department_id from department
	where department.dept_name=course.dept_name
);
alter table course
add foreign key (department_id) references department(department_id);
alter table course drop column dept_name;

alter table instructor add column department_id	serial;
update instructor set department_id= (
	select department_id from department
	where department.dept_name=instructor.dept_name
);
alter table instructor
add foreign key (department_id) references department(department_id);
alter table instructor drop column dept_name;


