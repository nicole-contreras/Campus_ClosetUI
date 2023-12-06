
CREATE DATABASE IF NOT EXISTS campusCloset;


grant all privileges on campusCloset.* to 'webapp'@'%';
flush privileges;

USE campusCloset;



CREATE TABLE admin (
   admin_id INT PRIMARY KEY AUTO_INCREMENT,
   email VARCHAR(255) NOT NULL,
   password VARCHAR(255) NOT NULL
);


CREATE TABLE technical_issue (
   description TEXT,
   status VARCHAR(50),
   resolution_details TEXT,
   admin_id INT,
   reported_at TIMESTAMP default CURRENT_TIMESTAMP,
   resolved_at TIMESTAMP default CURRENT_TIMESTAMP,
   FOREIGN KEY (admin_id) REFERENCES admin(admin_id)
);


CREATE TABLE user (
   user_id INT PRIMARY KEY AUTO_INCREMENT,
   email VARCHAR(255) NOT NULL,
   password VARCHAR(255) NOT NULL,
   avg_rating DECIMAL(10,2)
);


CREATE TABLE seller (
   seller_id INT PRIMARY KEY AUTO_INCREMENT,
   user_id INT,
   name varchar(50) NOT NULL,
   description TEXT,
   join_date TIMESTAMP default CURRENT_TIMESTAMP,
   FOREIGN KEY (user_id) REFERENCES user(user_id)
);


CREATE TABLE curator (
   curator_id INT PRIMARY KEY AUTO_INCREMENT,
   user_id INT,
   name varchar(50) NOT NULL,
   description TEXT,
   join_date TIMESTAMP default CURRENT_TIMESTAMP,
   FOREIGN KEY (user_id) REFERENCES user(user_id)
);


CREATE TABLE buyer (
   buyer_id INT PRIMARY KEY AUTO_INCREMENT,
   user_id INT,
   name varchar(50) NOT NULL,
   description TEXT,
   join_date TIMESTAMP default CURRENT_TIMESTAMP,
   FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE dispute (
   dispute_id INT PRIMARY KEY AUTO_INCREMENT,
   description TEXT,
   status VARCHAR(50),
   resolution_details TEXT,
   admin_ID INT,
   user_id INT,
   reported_at TIMESTAMP default CURRENT_TIMESTAMP,
   resolved_at TIMESTAMP default CURRENT_TIMESTAMP,
   FOREIGN KEY (admin_ID) REFERENCES admin(admin_ID),
   FOREIGN KEY (user_id) REFERENCES user(user_id)

);

CREATE TABLE wishlist (
   wishlist_id INT PRIMARY KEY AUTO_INCREMENT,
   buyer_id INT,
   title TEXT,
   description TEXT,
   FOREIGN KEY buyer(buyer_id) REFERENCES buyer(buyer_id)
);



CREATE TABLE review (
   rating INT,
   comment VARCHAR(255),
   user_id INT,
   review_date TIMESTAMP default CURRENT_TIMESTAMP,
   verified_purchase BOOLEAN default FALSE,
   helpfulness INT default 0,
   PRIMARY KEY(user_id, rating, comment),
   FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE bundle (
   bundle_id INT PRIMARY KEY AUTO_INCREMENT,
   cost INT,
   title TEXT,
   buyer_id INT,
   curator_id INT,
   FOREIGN KEY (buyer_id) REFERENCES buyer(buyer_id),
   FOREIGN KEY (curator_id) REFERENCES curator(curator_id)
);

CREATE TABLE item (
   item_id INT PRIMARY KEY AUTO_INCREMENT,
   category VARCHAR(50),
   price DECIMAL(10, 2),
   size VARCHAR(10),
   seller_id INT,
   buyer_id INT,
   bundle_id INT,
   FOREIGN KEY (seller_id) REFERENCES seller(seller_id),
   FOREIGN KEY (buyer_id) REFERENCES buyer(buyer_id),
   FOREIGN KEY (bundle_id) REFERENCES bundle(bundle_id)
);

CREATE TABLE item_wishlist (
   item_id INT,
   wishlist_id INT,
   cost int,
   PRIMARY KEY (item_id, wishlist_id, cost),
   FOREIGN KEY (item_id) REFERENCES item(item_id),
   FOREIGN KEY (wishlist_id) REFERENCES wishlist(wishlist_id)
);






CREATE TABLE conversation (
    conversation_id INT PRIMARY KEY,
    to_user_id INT,
    from_user_id INT,
    conversation_history TEXT,
    FOREIGN KEY (to_user_id) REFERENCES user(user_id),
    FOREIGN KEY (from_user_id) REFERENCES user(user_id)
);

-- Insert statements for admin table
INSERT INTO admin (admin_id, email, password) VALUES
(1, 'admin1@example.com', 'admin123'),
(2, 'admin2@example.com', 'secretadmin'),
(3, 'admin3@example.com', 'adminadmin');

-- Insert statements for user table
INSERT INTO user (user_id, email, password, avg_rating) VALUES
(101, 'user1@example.com', 'userpass1', 4.5),
(102, 'user2@example.com', 'userpass2', 3.8),
(103, 'user3@example.com', 'userpass3', 4.2);


-- Insert statements for seller table
INSERT INTO seller (seller_id, user_id, name, description, join_date) VALUES
(1, 101, 'Seller 1', 'Seller 1 description', '2023-01-01 08:00:00'),
(2, 102, 'Seller 2', 'Seller 2 description', '2023-01-02 09:30:00'),
(3, 103, 'Seller 3', 'Seller 3 description', '2023-01-03 11:15:00');

-- Insert statements for curator table
INSERT INTO curator (curator_id, user_id, name, description, join_date) VALUES
(1, 101, 'Curator 1', 'Curator 1 description', '2023-01-01 08:00:00'),
(2, 102, 'Curator 2', 'Curator 2 description', '2023-01-02 09:30:00'),
(3, 103, 'Curator 3', 'Curator 3 description', '2023-01-03 11:15:00');

-- Insert statements for buyer table
INSERT INTO buyer (buyer_id, user_id, name, description, join_date) VALUES
(101, 101, 'Buyer 1', 'Buyer 1 description', '2023-01-01 08:00:00'),
(102, 102, 'Buyer 2', 'Buyer 2 description', '2023-01-02 09:30:00'),
(103, 103, 'Buyer 3', 'Buyer 3 description', '2023-01-03 11:15:00');


-- Insert statements for wishlist table
INSERT INTO wishlist (wishlist_id, buyer_id, title, description) VALUES
(1, 101, 'Wishlist 1 title', 'Wishlist 1 description'),
(2, 102, 'Wishlist 2 title', 'Wishlist 2 description'),
(3, 103, 'Wishlist 3 title', 'Wishlist 3 description');

-- Insert statements for item table
INSERT INTO item (item_id, category, price, size, seller_id, buyer_id, bundle_id) VALUES
(1, 'Clothing', 29.99, 'Medium', 1, 101, NULL),
(2, 'Electronics', 149.99, NULL, 2, 102, NULL),
(3, 'Home Decor', 45.00, NULL, 3, 103, NULL);

-- Insert statements for review table
INSERT INTO review (rating, comment, user_id, verified_purchase, helpfulness) VALUES
(4, 'Great product!', 101, TRUE, 10),
(3, 'Not bad, but could be better', 102, FALSE, 5),
(5, 'Excellent service from the seller', 103, TRUE, 15);

-- Insert statements for item_wishlist table
INSERT INTO item_wishlist (item_id, wishlist_id, cost) VALUES
(1, 1, 29.99),
(2, 1, 149.99),
(3, 2, 149.99),
(3, 1, 45.00);

-- Insert statements for bundle table
INSERT INTO bundle (bundle_id, cost, title, buyer_id, curator_id) VALUES
(1, 199.99, 'Bundle 1 title', 101, 1),
(2, 299.99, 'Bundle 2 title', 102, 2),
(3, 149.99, 'Bundle 3 title', 103, 3);

-- Insert statement for conversation table
INSERT INTO conversation (conversation_id, to_user_id, from_user_id, conversation_history) VALUES
(1, 101, 102, 'User 1 to User 2: Hi, how are you?'),
(2, 102, 103, 'User 2 to User 3: Hello! Im good, thanks.'),
(3, 103, 101, 'User 3 to User 1: Hey there! Whats up?');

-- Insert statements for dispute table
INSERT INTO dispute (dispute_id, description, status, resolution_details, admin_id, user_id, reported_at, resolved_at) VALUES
(1, 'Dispute 1 description', 'Open', 'Resolution 1', 1, 101, '2023-01-01 12:00:00', '2023-01-05 14:30:00'),
(2, 'Dispute 2 description', 'Closed', 'Resolution 2', 2, 102, '2023-01-02 10:30:00', '2023-01-06 16:45:00'),
(3, 'Dispute 3 description', 'Open', 'Resolution 3', 3, 103, '2023-01-03 08:45:00', '2023-01-07 18:15:00');

-- Insert statements for technical_issue table
INSERT INTO technical_issue (description, status, resolution_details, admin_id, reported_at, resolved_at) VALUES
('Technical issue 1 details', 'Open', 'Resolution 1', 1, '2023-01-01 14:00:00', '2023-01-05 16:45:00'),
('Technical issue 2 details', 'Closed', 'Resolution 2', 2, '2023-01-02 12:30:00', '2023-01-06 20:00:00'),
('Technical issue 3 details', 'Open', 'Resolution 3', 3, '2023-01-03 10:15:00', '2023-01-07 22:30:00');
