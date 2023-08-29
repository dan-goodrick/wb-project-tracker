-- ➜ wb-project-tracker createdb project-tracker
-- ➜ wb-project-tracker psql project-tracker
-- ➜ wb-project-tracker pg_dump project-tracker > project-tracker.sql
-- project-tracker-# psql project-tracker < project-tracker.sql
-- \s shows command history
-- psql --list shows all databases
FROM the command line or \l
FROM inside psql

CREATE TABLE students ( id serial primary key, github varchar(20), first_name varchar(20), last_name varchar(20));
INSERT INTO students values (default, 'jhacks', 'Jane', 'Hacker'), (default, 'sdevelops', 'Sarah', 'Developer');
INSERT INTO students values(default, 'stuff', 'first', 'last');

SELECT  last_name
FROM students;

SELECT  github
       ,first_name
FROM students;

SELECT  *
FROM students
WHERE first_name = 'Sarah';

SELECT  *
FROM students
WHERE github = 'sdevelops';

SELECT  first_name
       ,last_name
FROM students
WHERE github = 'jhacks';

CREATE TABLE projects (id serial primary key, title varchar(30) unique, description text, max_grade integer);
INSERT INTO projects values (default, 'Markov', 'Tweets generated from Markov chains', 50), (default, 'Blockly', 'Programmatic Logic Puzzle Game', 100);

SELECT  title
       ,max_grade
FROM projects
WHERE max_grade > 50;

SELECT  title
       ,max_grade
FROM projects
WHERE max_grade BETWEEN 10 AND 60;

SELECT  title
       ,max_grade
FROM projects
WHERE max_grade not BETWEEN 25 AND 75;

SELECT  *
FROM projects
ORDER BY max_grade;

CREATE TABLE grades (id serial primary key, student_github varchar(30) references students(github), project_title varchar(30) references projects(title), grade integer);
INSERT INTO grades values (default, 'jhacks', 'Markov', 10), (default, 'jhacks', 'Blockly', 2), (default, 'sdevelops', 'Markov', 5), (default, 'sdevelops', 'Blockly', 100);
;

DELETE
FROM grades
WHERE id = 1;
INSERT INTO grades (student_github, project_title, grade) values ('jhacks', 'Markov', 30);

SELECT  first_name
       ,last_name
FROM students
WHERE github = 'jhacks';

SELECT  project_title
       ,grade
FROM grades
WHERE student_github = 'jhacks';

SELECT  *
FROM students
JOIN grades
ON (students.github = grades.student_github);

SELECT  students.first_name
       ,students.last_name
       ,grades.project_title
       ,grades.grade
FROM students
JOIN grades
ON (students.github = grades.student_github);

SELECT  students.first_name
       ,students.last_name
       ,grades.project_title
       ,grades.grade
FROM students
JOIN grades
ON (students.github = grades.student_github)
JOIN projects
ON (projects.title = grades.project_title);

SELECT  students.first_name
       ,students.last_name
       ,grades.project_title
       ,grades.grade
FROM students
JOIN grades
ON (students.github = grades.student_github)
JOIN projects
ON (projects.title = grades.project_title)
WHERE github = 'jhacks';

SELECT  students.first_name
       ,students.last_name
       ,grades.project_title
       ,grades.grade
       ,projects.max_grade
FROM students
JOIN grades
ON (students.github = grades.student_github)
JOIN projects
ON (projects.title = grades.project_title)
WHERE github = 'jhacks';