CREATE DATABASE IF NOT EXISTS ecommerce_use_case;

USE ecommerce_use_case;

-- clients table.
CREATE TABLE clients (
	id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	name VARCHAR(300) NOT NULL COLLATE utf8_unicode_ci,
	email VARCHAR(320) NOT NULL UNIQUE COLLATE utf8_unicode_ci,
	address VARCHAR(100) NOT NULL COLLATE utf8_unicode_ci,
	PRIMARY KEY (id) USING BTREE,
	INDEX (email) USING BTREE
) COLLATE=utf8_unicode_ci ENGINE=InnoDB;

-- orders table.
CREATE TABLE orders (
	id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	client_id INT(10) UNSIGNED NOT NULL,
	total_value DECIMAL(8, 3) UNSIGNED NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	PRIMARY KEY (id) USING BTREE,
	CONSTRAINT fk_orders_clients FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE NO ACTION ON UPDATE CASCADE
) COLLATE=utf8_unicode_ci ENGINE=InnoDB;

-- categories table.
CREATE TABLE categories (
	id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL UNIQUE COLLATE utf8_unicode_ci,
	PRIMARY KEY (id) USING BTREE
) COLLATE=utf8_unicode_ci ENGINE=InnoDB;

-- products table.
CREATE TABLE products (
	id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	name VARCHAR(300) NOT NULL COLLATE utf8_unicode_ci,
	description TEXT NOT NULL COLLATE utf8_unicode_ci,
	price DECIMAL(8, 3) UNSIGNED NOT NULL,
	category_id INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (id) USING BTREE,
	INDEX (name) USING BTREE,
	INDEX (category_id) USING BTREE,
	CONSTRAINT fk_products_categories FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE ON UPDATE CASCADE
) COLLATE=utf8_unicode_ci ENGINE=InnoDB;

-- order_details table.
CREATE TABLE order_details (
	order_id INT(10) UNSIGNED NOT NULL,
	product_id INT(10) UNSIGNED NOT NULL,
	quantity INT(3) UNSIGNED NOT NULL DEFAULT 1,
	unitary_value DECIMAL(8, 3) UNSIGNED NOT NULL,
	CONSTRAINT fk_order_details_orders FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_order_details_products FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE ON UPDATE CASCADE
) COLLATE=utf8_unicode_ci ENGINE=InnoDB;
