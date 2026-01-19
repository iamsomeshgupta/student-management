CREATE DATABASE student_system;
\c student_system
CREATE TABLE students(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email varchar(150) unique not null,
    age int CHECK(age>=16),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
create table courses(
    id serial primary key,
    title VARCHAR(100) not null,
    credits int check (credits>0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
create table enrollments(
    student_id int REFERENCES students(id) on delete CASCADE,
    course_id int references courses(id) on delete CASCADE,
    enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    grade CHAR(2),
    PRIMARY KEY (student_id,course_id)
);
INSERT INTO students (name,email,age) VALUES
('aman sharma','aman@gmail.com',20),
('riya singh','riya@gmail.com',19),
('kunal verma','kunal@gmail.com',21);
INSERT INTO courses (title,credits) VALUES
('database systems',4),
('operating systems',3),
('computer networks',3);
INSERT INTO enrollments(student_id,course_id,grade) VALUES
(1,1,'A'),
(1,2,'B'),
(2,1,'A'),
(3,3,'C');
SELECT * FROM students;
SELECT * from courses;

SELECT s.NAME, c.title
from students s
join enrollments e on s.id=e.student_id
join courses c on c.id=e.course_id
where c.title='database systems';

SELECT s.NAME, c.title,e.grade
from students s
join enrollments e on s.id=e.student_id
join courses c on c.id=e.course_id
ORDER BY s.name;

select c.title
from courses c
join enrollments e on c.id=e.course_id
join students s on s.id=e.student_id
where s.name='aman sharma';

select c.title,count(e.student_id) as total_students
from courses c
left JOIN enrollments e on c.id=e.course_id
GROUP BY c.title;

select course_id,avg(
    case grade
    when 'A' then 4
    when 'B' then 3
    when 'C' then 2 
    else 0
    end
) as avg_grade
from enrollments
GROUP by course_id;

create table attendance(
    student_id int REFERENCES students(id) on delete CASCADE,
    course_id int references courses(id) on delete CASCADE,
    date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) CHECK (status in ('present','absent'))
)
INSERT INTO attendance(student_id,course_id,status) VALUES
(1,1,'present'),
(2,1,'present'),
(3,3,'absent');
SELECT * from attendance;
SELECT s.name 
from attendance a
JOIN students s on s.id=a.student_id
where a.course_id=1
and a.date=CURRENT_DATE
and a.status='present';
select s.NAME
