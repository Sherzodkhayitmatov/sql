DROP TABLE IF EXISTS books;

CREATE TABLE books
(
    book_id INT IDENTITY PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) CHECK(price > 0),
    genre VARCHAR(100) DEFAULT 'Unknown'
);

INSERT INTO books(title, price)
VALUES ('mathematics', 12.5);

SELECT * FROM books;
