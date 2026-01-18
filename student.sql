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
    enrolled_at TIMESTAMP DEFAULT CURRENT TIMESTAMP,
    grade CHAR(2),
    PRIMARY KEY (student_id,course_id)
);