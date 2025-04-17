drop table if exists Book, Member, Loan

CREATE TABLE Book
(
    book_id INT IDENTITY PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(100),
    published_year INT
);

CREATE TABLE Member
(
    member_id INT IDENTITY PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(50)
);

CREATE TABLE Loan
(
    loan_id INT IDENTITY PRIMARY KEY,
    book_id INT REFERENCES Book(book_id),
    member_id INT REFERENCES Member(member_id),
    loan_date DATE,
    return_date DATE
);

-- Then you can insert without specifying IDs
INSERT INTO Book (title, author, published_year)
VALUES 
('1984', 'George Orwell', 1949),
('The Alchemist', 'Paulo Coelho', 1988);

INSERT INTO Member (name, email, phone_number)
VALUES 
('Alice Smith', 'alice@example.com', '123-456-7890'),
('Bob Johnson', 'bob@example.com', '987-654-3210');

INSERT INTO Loan (book_id, member_id, loan_date, return_date)
VALUES 
(1, 1, '2025-04-01', NULL),
(2, 2, '2025-04-10', '2025-04-15');
