-- 1.	book: A list of all books available in the store.
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    language_id INT,
    publisher_id INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

-- 2.	book_author: A table to manage the many-to-many relationship between books and authors.
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);


-- 3.	author: A list of all authors.
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);


-- 4.	book_language: A list of the possible languages of books.
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50) NOT NULL
);


-- 5.	publisher: A list of publishers for books.
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(100) NOT NULL
);

