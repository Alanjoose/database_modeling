CREATE DATABASE IF NOT EXISTS library_use_case;

USE library_use_case;

-- library_users table.
CREATE TABLE library_users(
	id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	name VARCHAR(300) NOT NULL COLLATE utf8_unicode_ci,
	email VARCHAR(320) NOT NULL COLLATE utf8_unicode_ci UNIQUE,
	address VARCHAR(100) NOT NULL COLLATE utf8_unicode_ci,
	PRIMARY KEY (id) USING BTREE,
	INDEX (email) USING BTREE,
) COLLATE=utf8_unicode_ci ENGINE=InnoDB;

-- library_publishers table.
CREATE TABLE library_publishers(
	id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	name VARCHAR(300) NOT NULL COLLATE utf8_unicode_ci,
	location VARCHAR(100) NOT NULL COLLATE utf8_unicode_ci,
	PRIMARY KEY (id) USING BTREE
) COLLATE=utf8_unicode_ci ENGINE=InnoDB;

-- library_authors table.
CREATE TABLE library_authors(
	id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	name VARCHAR(300) NOT NULL COLLATE utf8_unicode_ci,
	nationality CHAR(3) NOT NULL COLLATE utf8_unicode_ci COMMENT "The CHAR type stores a 3 bytes value in nationality column.",
	PRIMARY KEY (id) USING BTREE
) COLLATE=utf8_unicode_ci ENGINE=InnoDB;

-- books table.
CREATE TABLE books(
	id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	title VARCHAR(320) NOT NULL COLLATE utf8_unicode_ci UNIQUE,
	publish_year YEAR NOT NULL COMMENT "The YEAR type has 4 digits by default.",
	author_id INT(10) UNSIGNED NOT NULL,
	publisher_id INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (id) USING BTREE,
	INDEX (title) USING BTREE,
	CONSTRAINT books_author_id_foreign FOREIGN KEY (author_id) REFERENCES library_authors (id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT books_publisher_id_foreign FOREIGN KEY (publisher_id) REFERENCES library_publishers (id) ON DELETE CASCADE ON UPDATE CASCADE
) COLLATE=utf8_unicode_ci ENGINE=InnoDB;

-- loans table.
CREATE TABLE loans(
	id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	book_id INT(10) UNSIGNED NOT NULL,
	user_id INT(10) UNSIGNED NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	returned_at TIMESTAMP NULL DEFAULT NULL,
	PRIMARY KEY (id) USING BTREE,
	CONSTRAINT loans_book_id_foreign FOREIGN KEY (book_id) REFERENCES library_books (id) ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT loans_user_id_foreign FOREIGN KEY (user_id) REFERENCES library_users (id) ON DELETE NO ACTION ON UPDATE CASCADE
) COLLATE=utf8_unicode_ci ENGINE=InnoDB;