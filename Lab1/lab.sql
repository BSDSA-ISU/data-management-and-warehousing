-- Activity By Cyrus Troy "AlieeLinux" Bazar
-- Note:
--  All details here are fictional

CREATE DATABASE students;

SHOW DATABASES;

USE students;

CREATE TABLE students (
    student_name VARCHAR(150),
    age INTEGER(3),
    address VARCHAR(50),
    email VARCHAR(100),
    course VARCHAR(20),
    section VARCHAR(20)
);

DESCRIBE students;

INSERT INTO students (student_name, age, address, email, course, section)
VALUES (
    'Kamishirasawa Keine',
    19,
    "Tokyo, Japan",
    'tensorry@github.com',
    "BSAI",
    "3-1"
),
(
    "Pauli Rasanen",
    20,
    "Helsinki, Finland",
    "Paulirasanen333@google.com",
    "BSIT",
    "4-1"
),
(
    "Satori Komeiji",
    19,
    "Nagasaki, Japan",
    "icareboutkoishi@yahoo.com",
    "BSDSA",
    "3-1"
),
(
    "Koishi Komeiji",
    18,
    "Nagasaki, Japan",
    "icareboutsatori1@yahoo.com",
    "BSDSA",
    "3-1"
),
(
    "Cyrus Troy Bazar",
    20,
    "Isabela, Philippines",
    "youmukonpaku1998@gmail.com",
    "BSDSA",
    "3-1"
)
;

SELECT * FROM students;