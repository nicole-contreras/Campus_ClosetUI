

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
   conversation_id INT PRIMARY KEY AUTO_INCREMENT,
   to_user_id INT,
   from_user_id INT,
   conversation_history TEXT,
   FOREIGN KEY (to_user_id) REFERENCES user(user_id),
   FOREIGN KEY (from_user_id) REFERENCES user(user_id)
);


-- Insert statements for admin table
INSERT INTO admin (email, password) VALUES
('maverick.admin@example.com', 'P@ssword123'),
('cyber.wizard@example.com', 'SecureAdminPass'),
('galactic.admin@example.com', 'admin!@#456'),
('dreamweaver.admin@example.com', 'adm!nP@ss'),
('cryptic.master@example.com', 'Pass789Admin'),
('starry.admin@example.com', 'A$ecureP@ss'),
('nebula.commander@example.com', 'AdminPass@456'),
('phantom.ruler@example.com', 'passA789min'),
('infinite.admin@example.com', 'P@sswordAdmin'),
('time.traveler@example.com', 'Admin@789P@ss'),
('quantum.admin@example.com', '789Admin!@#'),
('cosmic.overlord@example.com', 'AdminP@ss123'),
('infinity.admin@example.com', 'Secur!tyP@ss'),
('lunar.monarch@example.com', 'A$ecureP@ss789'),
('supernova.admin@example.com', 'P@ssAdmin456'),
('celestial.master@example.com', 'P@ssAdminAdmin'),
('stellar.admin@example.com', 'AdminPassAdmin'),
('galaxy.ruler@example.com', 'Admin!@#123'),
('cosmic.commander@example.com', 'AdminA!@#Pass'),
('interstellar.admin@example.com', 'AdminP@ss123Admin'),
('zenith.admin@example.com', '456Admin!@#'),
('timeless.warden@example.com', 'A!@#P@ssAdmin456'),
('universal.admin@example.com', 'AdminAdmin@789'),
('quasar.commander@example.com', '789AdminA!@#'),
('astral.admin@example.com', 'Admin!@#789P@ss'),
('eternal.emperor@example.com', 'AdminAdminAdmin123'),
('nova.king@example.com', 'Admin123AdminAdmin'),
('infinity.ruler@example.com', 'AdminAdmin456Admin'),
('galactic.sovereign@example.com', 'AdminAdminAdmin456');


-- Insert statements for user table
INSERT INTO user (email, password, avg_rating) VALUES
('alice.user@example.com', 'alicepass123', 4.7),
('bob.dreamer@example.com', 'bobdream456', 3.5),
('charlie.adventurer@example.com', 'charliepass789', 4.1),
('diana.explorer@example.com', 'dianaexplore', 4.9),
('eric.trailblazer@example.com', 'erictrail123', 3.2),
('fiona.navigator@example.com', 'fionapass', 4.4),
('greg.pioneer@example.com', 'gregpass456', 3.8),
('hannah.seeker@example.com', 'hannahseek', 4.6),
('ian.voyager@example.com', 'ianvoyage789', 3.9),
('julie.adventuress@example.com', 'juliepass123', 4.2),
('kevin.wanderer@example.com', 'kevinwander', 4.5),
('linda.traveller@example.com', 'lindapass456', 3.7),
('mike.journeyman@example.com', 'mikejourney789', 4.0),
('nina.nomad@example.com', 'ninapass', 3.4),
('oliver.roamer@example.com', 'oliverroam456', 4.3),
('penelope.explorer@example.com', 'penelopeexplore', 4.8),
('quincy.pioneer@example.com', 'quincypass789', 3.6),
('rachel.adventurer@example.com', 'rachelpass', 4.2),
('sam.wanderlust@example.com', 'samwander123', 3.9),
('tina.explorer@example.com', 'tinapass', 4.6),
('ulrich.traveller@example.com', 'ulrichtravel456', 3.8),
('vivian.voyager@example.com', 'vivianvoyage789', 4.1),
('william.wayfarer@example.com', 'williampass', 3.5),
('xena.roamer@example.com', 'xenaroam456', 4.0),
('yannick.navigant@example.com', 'yannicknavigant789', 3.7),
('zara.adventurer@example.com', 'zarapass123', 4.4),
('adam.trekker@example.com', 'adampass', 3.6),
('bella.explorer@example.com', 'bellapass789', 4.5),
('chris.wanderer@example.com', 'chriswander123', 3.9),
('daisy.nomad@example.com', 'daisypass456', 4.1),
('edward.pioneer@example.com', 'edwardpioneer', 3.8),
('felicity.journeyer@example.com', 'felicityjourney789', 4.2),
('george.voyager@example.com', 'georgevoyage', 3.7),
('hazel.traveller@example.com', 'hazelpass123', 4.0),
('ian.explorer@example.com', 'ianexplore456', 3.5),
('jessica.wayfarer@example.com', 'jessicapass789', 4.3),
('kyle.roamer@example.com', 'kylepass', 3.6),
('lily.adventurer@example.com', 'lilypass123', 4.4),
('mason.trekker@example.com', 'masonpass456', 3.9),
('natalie.wanderlust@example.com', 'nataliewander', 4.1);




-- Insert statements for seller table
INSERT INTO seller (name, description, join_date) VALUES
('Fashion Haven', 'Your ultimate destination for trendy fashion', '2023-01-04 14:45:00'),
('Chic Couture', 'Elegance meets style in every piece', '2023-01-05 16:20:00'),
('Urban Threads', 'Discover the latest urban fashion trends', '2023-01-06 18:10:00'),
('Street Style Emporium', 'Casual and cool fashion for the streets', '2023-01-07 20:30:00'),
('Sophisticated Styles', 'Unleash your sophistication with our collections', '2023-01-08 22:45:00'),
('Trendy Threads', 'Stay on trend with our curated fashion picks', '2023-01-09 08:15:00'),
('Couture Closet', 'Where fashion dreams come to life', '2023-01-10 10:40:00'),
('Vintage Vogue', 'Timeless fashion for the modern era', '2023-01-11 12:25:00'),
('Tailored Trends', 'Perfectly tailored for your unique style', '2023-01-12 14:55:00'),
('Charming Chic Boutique', 'Charm your way through the latest fashion', '2023-01-13 16:35:00'),
('Dapper Denim', 'Denim delights for the fashion-forward', '2023-01-14 18:45:00'),
('Ethereal Elegance', 'Experience ethereal elegance in every piece', '2023-01-15 21:10:00'),
('Boho Chic Boutique', 'Bohemian vibes for a chic lifestyle', '2023-01-16 23:20:00'),
('Sassy Styles', 'Sassy and stylish fashion for the bold', '2023-01-17 09:30:00'),
('Haute Heritage', 'Heritage-inspired fashion for the modern you', '2023-01-18 11:55:00'),
('Luxe Layers', 'Layer up with our luxurious and stylish pieces', '2023-01-19 13:40:00'),
('Crisp Classics', 'Classic styles with a modern twist', '2023-01-20 15:25:00'),
('Modish Mania', 'Embrace the modish mania of contemporary fashion', '2023-01-21 17:15:00'),
('Casual Charm Co.', 'Casual yet charming fashion essentials', '2023-01-22 19:20:00'),
('Elegance Ensemble', 'Ensemble elegance for the fashion-forward', '2023-01-23 21:45:00'),
('Couture Carousel', 'Step into a carousel of couture fashion', '2023-01-24 23:55:00'),
('Stylish Strides', 'Take stylish strides with our trendy collections', '2023-01-25 08:00:00'),
('Effortless Elegance', 'Effortlessly elegant fashion for all occasions', '2023-01-26 09:30:00'),
('Timeless Trends', 'Timeless trends that transcend the seasons', '2023-01-27 11:15:00'),
('Flawless Fashion', 'Flawless fashion for the fashion aficionado', '2023-01-28 13:25:00'),
('Dress to Impress', 'Dress to impress with our stylish selections', '2023-01-29 15:50:00'),
('Sleek Silhouettes', 'Discover sleek silhouettes for a chic you', '2023-01-30 17:40:00'),
('Radiant Raiment', 'Radiant raiment for the fashion enthusiast', '2023-01-31 19:55:00'),
('Sartorial Splendor', 'Experience sartorial splendor in every piece', '2023-02-01 21:30:00'),
('Opulent Outfits', 'Opulent outfits for a luxurious lifestyle', '2023-02-02 23:45:00'),
('Haute Haberdashery', 'Haute haberdashery for the fashion elite', '2023-02-03 09:15:00'),
('Stylish Stitches', 'Stylish stitches for the discerning shopper', '2023-02-04 11:40:00'),
('Boho Bliss Boutique', 'Boho bliss awaits you at our boutique', '2023-02-05 13:25:00'),
('Elegant Ensembles', 'Elegant ensembles for the fashion connoisseur', '2023-02-06 15:55:00'),
('Chic Charm Co.', 'Chic charm for the modern fashionista', '2023-02-07 17:35:00'),
('Luxury Layers', 'Layer up with luxury in our exclusive pieces', '2023-02-08 19:45:00'),
('Bespoke Boutique', 'Discover bespoke fashion for a unique you', '2023-02-09 22:10:00');


-- Insert statements for curator table
INSERT INTO curator (user_id, name, description, join_date) VALUES
(1, 'Curator 1', 'Curator 1 description', '2023-01-01 08:00:00'),
(2,  'Curator 2', 'Curator 2 description', '2023-01-02 09:30:00'),
(3, 'Curator 3', 'Curator 3 description', '2023-01-03 11:15:00'),
(4,  'Curator 4', 'Curator 4 description', '2023-01-04 14:45:00'),
(5,  'Curator 5', 'Curator 5 description', '2023-01-05 16:20:00'),
(6, 'Curator 6', 'Curator 6 description', '2023-01-06 18:10:00'),
(7,  'Curator 7', 'Curator 7 description', '2023-01-07 20:30:00'),
(8, 'Curator 8', 'Curator 8 description', '2023-01-08 22:45:00'),
(9,  'Curator 9', 'Curator 9 description', '2023-01-09 08:15:00'),
(10,  'Curator 10', 'Curator 10 description', '2023-01-10 10:40:00'),
(11,  'Curator 11', 'Curator 11 description', '2023-01-11 12:25:00'),
(12,  'Curator 12', 'Curator 12 description', '2023-01-12 14:55:00'),
(13,  'Curator 13', 'Curator 13 description', '2023-01-13 16:35:00'),
(14,  'Curator 14', 'Curator 14 description', '2023-01-14 18:45:00'),
(15,  'Curator 15', 'Curator 15 description', '2023-01-15 21:10:00'),
(16,  'Curator 16', 'Curator 16 description', '2023-01-16 23:20:00'),
(17,  'Curator 17', 'Curator 17 description', '2023-01-17 09:30:00'),
(18,  'Curator 18', 'Curator 18 description', '2023-01-18 11:55:00'),
(19, 'Curator 19', 'Curator 19 description', '2023-01-19 13:40:00'),
(20,  'Curator 20', 'Curator 20 description', '2023-01-20 15:25:00'),
(21,'Curator 21', 'Curator 21 description', '2023-01-21 17:15:00'),
(22,  'Curator 22', 'Curator 22 description', '2023-01-22 19:20:00'),
(23,  'Curator 23', 'Curator 23 description', '2023-01-23 21:45:00'),
(24, 'Curator 24', 'Curator 24 description', '2023-01-24 23:55:00'),
(25, 'Curator 25', 'Curator 25 description', '2023-01-25 08:00:00'),
(26,  'Curator 26', 'Curator 26 description', '2023-01-26 09:30:00'),
(27, 'Curator 27', 'Curator 27 description', '2023-01-27 11:15:00'),
(28,  'Curator 28', 'Curator 28 description', '2023-01-28 13:25:00'),
(29, 'Curator 29', 'Curator 29 description', '2023-01-29 15:50:00'),
(30,  'Curator 30', 'Curator 30 description', '2023-01-30 17:40:00');


-- Insert statements for buyer table
INSERT INTO buyer (user_id, name, description, join_date) VALUES
(1, 'John Doe', 'John Doe - A passionate shopper', '2023-01-01 08:00:00'),
(2, 'Mary Smith', 'Mary Smith - Always on the lookout for deals', '2023-01-02 09:30:00'),
(3,  'Robert Jones', 'Robert Jones - Fashion enthusiast', '2023-01-03 11:15:00'),
(4,  'Emily Wilson', 'Emily Wilson - Trendy and stylish', '2023-01-04 14:45:00'),
(5,  'David Miller', 'David Miller - Loves unique fashion finds', '2023-01-05 16:20:00'),
(6,  'Linda Taylor', 'Linda Taylor - Shopaholic in the making', '2023-01-06 18:10:00'),
(7,  'Samuel Anderson', 'Samuel Anderson - Fashion-forward individual', '2023-01-07 20:30:00'),
(8,  'Sophia Brown', 'Sophia Brown - Classic and timeless style', '2023-01-08 22:45:00'),
(9, 'Alexander Carter', 'Alexander Carter - Explorer of fashion trends', '2023-01-09 08:15:00'),
(10,  'Olivia Hall', 'Olivia Hall - Elegance meets casual', '2023-01-10 10:40:00'),
(11, 'Jacob Ward', 'Jacob Ward - Streetwear enthusiast', '2023-01-11 12:25:00'),
(12,  'Emma Baker', 'Emma Baker - Bohemian chic lover', '2023-01-12 14:55:00'),
(13,  'William Clark', 'William Clark - Vintage fashion fan', '2023-01-13 16:35:00'),
(14,  'Samantha White', 'Samantha White - Modern and eclectic taste', '2023-01-14 18:45:00'),
(15,  'Nathan Hall', 'Nathan Hall - Sporty and casual vibes', '2023-01-15 21:10:00'),
(16,  'Olivia Fisher', 'Olivia Fisher - Artistic and unique style', '2023-01-16 23:20:00'),
(17,  'Daniel Allen', 'Daniel Allen - Edgy and experimental', '2023-01-17 09:30:00'),
(18,  'Ava Jenkins', 'Ava Jenkins - Minimalist fashion lover', '2023-01-18 11:55:00'),
(19,  'Matthew Cooper', 'Matthew Cooper - Bold and vibrant fashion', '2023-01-19 13:40:00'),
(20,  'Sophie Bell', 'Sophie Bell - Casual with a touch of glamour', '2023-01-20 15:25:00'),
(21,  'Ryan Ross', 'Ryan Ross - Laid-back and easygoing style', '2023-01-21 17:15:00'),
(22,  'Eva Reed', 'Eva Reed - Retro and vintage enthusiast', '2023-01-22 19:20:00'),
(23,  'Leo Wilson', 'Leo Wilson - Urban streetwear lover', '2023-01-23 21:45:00'),
(24, 'Hannah Price', 'Hannah Price - Trendsetter and fashionista', '2023-01-24 23:55:00'),
(25,  'Michael Barnes', 'Michael Barnes - Dapper and polished style', '2023-01-25 08:00:00'),
(26,  'Claire Hall', 'Claire Hall - Elegant and refined taste', '2023-01-26 09:30:00'),
(27,  'Jackson Stewart', 'Jackson Stewart - Youthful and energetic style', '2023-01-27 11:15:00'),
(28,  'Amelia Hill', 'Amelia Hill - Quirky and eclectic fashion', '2023-01-28 13:25:00'),
(29,  'Aiden Davis', 'Aiden Davis - Fashion-forward and bold', '2023-01-29 15:50:00'),
(30,  'Madison Morris', 'Madison Morris - Glamorous and chic', '2023-01-30 17:40:00');




-- Insert statements for wishlist table
INSERT INTO wishlist (buyer_id, title, description) VALUES
(1, 'Johns Trendy Picks', 'Curated list of the latest fashion trends'),
(2, 'Marys Stylish Must-Haves', 'Essential items for a chic wardrobe'),
(3, 'Roberts Streetwear Wishes', 'Top picks for an urban streetwear look'),
(4, 'Emilys Elegant Collection', 'Timeless and sophisticated pieces'),
(5, 'Davids Casual Comforts', 'Comfortable yet stylish everyday wear'),
(6, 'Lindas Boho Vibes', 'Free-spirited and bohemian-inspired favorites'),
(7, 'Samuels Athleisure Faves', 'Sporty and trendy activewear selections'),
(8, 'Sophias Classic Essentials', 'Must-have classics for any wardrobe'),
(9, 'Alexanders Fashion Explorer', 'Discovering the latest fashion frontiers'),
(10, 'Olivias Casual Elegance', 'Effortless style for various occasions'),
(11, 'Jacobs Street Style Wishlist', 'Street-smart and edgy fashion picks'),
(12, 'Emmas Artsy Finds', 'Expressing creativity through unique pieces'),
(13, 'Williams Vintage Dreams', 'Nostalgic treasures from the past'),
(14, 'Samanthas Eclectic Collection', 'Mix and match for a unique look'),
(15, 'Nathans Sporty Chic', 'Blending sporty and chic elements seamlessly'),
(16, 'Olivias Artistic Flair', 'Clothing thats a canvas for self-expression'),
(17, 'Daniels Edgy Ensembles', 'Bold and daring choices for the fashion-forward'),
(18, 'Avas Minimalist Delights', 'Simplicity and elegance in every piece'),
(19, 'Matthews Vibrant Wardrobe', 'Adding a splash of color to the closet'),
(20, 'Sophies Glamorous Picks', 'For those who love a touch of glamour'),
(21, 'Ryans Laid-Back Staples', 'Easygoing essentials for everyday wear'),
(22, 'Evas Retro Revival', 'Reviving the charm of yesteryear in style'),
(23, 'Leos Urban Streetwear', 'Keeping it cool and casual on the streets'),
(24, 'Hannahs Trendsetting List', 'Ahead of the curve and setting trends'),
(25, 'Michaels Dapper Selections', 'Polished choices for a refined wardrobe'),
(26, 'Claires Elegant Ensemble', 'Elegance and sophistication in every piece'),
(27, 'Jacksons Youthful Energy', 'Clothes that match a youthful and energetic spirit'),
(28, 'Amelias Quirky Collection', 'Unconventional and eclectic fashion choices'),
(29, 'Aidens Bold Fashion Statements', 'Making a statement with bold and unique pieces'),
(30, 'Madisons Chic Wishes', 'Chic and fashionable items for any occasion');


-- Insert statements for item table
INSERT INTO item (category, price, size, seller_id, buyer_id, bundle_id) VALUES
('T-Shirt', 19.99, 'Medium', 1, 11, NULL),
('Jeans', 59.99, '32/32', 2, 12, NULL),
('Dress', 39.99, 'Small', 3, 13, NULL),
('Sneakers', 79.99, 'US 9', 4, 14, NULL),
('Jacket', 89.99, 'Large', 5, 15, NULL),
('Skirt', 29.99, 'X-Small', 6, 16, NULL),
('Hoodie', 49.99, 'Medium', 7, 17, NULL),
('Leggings', 24.99, 'Small', 8, 18, NULL),
('Blouse', 34.99, 'Medium', 9, 19, NULL),
('Pants', 44.99, '34/30', 10, 20, NULL),
('Sweater', 54.99, 'Large', 11, 21, NULL),
('Shorts', 19.99, 'X-Large', 12, 22, NULL),
('Blazer', 74.99, 'Medium', 13, 23, NULL),
('Cardigan', 39.99, 'Small', 14, 24, NULL),
('Shirt', 29.99, 'Large', 15, 25, NULL),
('Jumpsuit', 69.99, 'Medium', 16, 26, NULL),
('Coat', 99.99, 'X-Large', 17, 27, NULL),
('Polo Shirt', 27.99, 'Large', 18, 28, NULL),
('Sweatpants', 34.99, 'Medium', 19, 29, NULL),
('Tank Top', 14.99, 'Small', 20, 30, NULL),
('Cropped Jeans', 49.99, '26/28', 21, 1, NULL),
('Maxi Dress', 59.99, 'Medium', 22, 2, NULL),
('High Heels', 69.99, 'US 8', 23, 3, NULL),
('Leather Jacket', 89.99, 'Small', 24, 4, NULL),
('Denim Skirt', 29.99, 'X-Small', 25, 5, NULL),
('Sweatshirt', 44.99, 'Large', 26, 6, NULL),
('Pencil Skirt', 34.99, 'Medium', 27, 7, NULL),
('Beanie', 12.99, NULL, 28, 8, NULL),
('Flannel Shirt', 39.99, 'X-Large', 29, 9, NULL),
('Trench Coat', 79.99, 'Large', 30, 10, NULL);


-- Insert statements for review table
INSERT INTO review (rating, comment, user_id, verified_purchase, helpfulness) VALUES
(4, 'Impressive quality and fit!', 1, TRUE, 12),
(5, 'Love it! Fast shipping too.', 2, TRUE, 18),
(3, 'Decent product, but a bit pricey', 3, FALSE, 7),
(4, 'Exactly as described. Happy with my purchase.', 4, TRUE, 14),
(2, 'Disappointed with the size. Too small.', 5, FALSE, 3),
(5, 'Amazing customer service. Highly recommend!', 6, TRUE, 20),
(4, 'Good value for money. Will buy again.', 7, TRUE, 11),
(3, 'Average quality. Expected better.', 8, FALSE, 6),
(5, 'Super comfortable. Great for everyday wear.', 9, TRUE, 16),
(2, 'Not what I expected. Returning the item.', 10, FALSE, 4),
(4, 'Fast delivery and well-packaged.', 11, TRUE, 13),
(3, 'Satisfied with the purchase. Thank you!', 12, TRUE, 9),
(5, 'Top-notch product! Exceeded my expectations.', 13, TRUE, 19),
(4, 'Prompt shipping. Product matches the description.', 14, TRUE, 15),
(2, 'Poor quality. Wouldnt recommend.', 15, FALSE, 5),
(5, 'Excellent craftsmanship. Fits perfectly.', 16, TRUE, 17),
(3, 'Average product. Nothing special.', 17, FALSE, 8),
(4, 'Great seller communication. A positive experience.', 18, TRUE, 14),
(2, 'Not worth the price. Expected better.', 19, FALSE, 6),
(5, 'Outstanding service. Highly satisfied!', 20, TRUE, 20),
(4, 'Impressed with the quality. Would buy again.', 21, TRUE, 11),
(3, 'Slightly disappointed. Not as described.', 22, FALSE, 9),
(5, 'Fantastic product! Quick delivery too.', 23, TRUE, 16),
(4, 'Good value for money. Happy with my purchase.', 24, TRUE, 12),
(2, 'Unhappy with the size. Too big.', 25, FALSE, 4),
(5, 'Exceptional customer service. Highly recommend!', 26, TRUE, 18),
(4, 'Solid product. No complaints.', 27, TRUE, 13),
(3, 'Could be better. Expected more.', 28, FALSE, 7),
(5, 'Extremely comfortable. Perfect for my needs.', 29, TRUE, 19),
(2, 'Not what I expected. Dissatisfied with the purchase.', 30, FALSE, 5),
(4, 'Quick shipping. Product as described.', 31, TRUE, 15),
(3, 'Fairly satisfied. Room for improvement.', 32, FALSE, 8),
(5, 'Seller went above and beyond. Excellent experience!', 33, TRUE, 20),
(4, 'High-quality product. Met my expectations.', 34, TRUE, 10),
(2, 'Disappointed with the quality. Not durable.', 35, FALSE, 6),
(5, 'Outstanding service. Will definitely shop again!', 36, TRUE, 18),
(4, 'Well-made product. Happy with my purchase.', 37, TRUE, 14),
(3, 'Average experience. Expected more.', 38, FALSE, 7),
(5, 'Exceptional quality. Worth every penny!', 39, TRUE, 19),
(4, 'Prompt delivery. Product exceeded expectations.', 40, TRUE, 16);


-- Insert statements for item_wishlist table
INSERT INTO item_wishlist (item_id, wishlist_id, cost) VALUES
(1, 1, 29.99),
(2, 1, 149.99),
(3, 2, 149.99),
(3, 1, 45.00),
(4, 2, 79.99),
(5, 3, 89.99),
(6, 3, 29.99),
(7, 4, 49.99),
(8, 4, 24.99),
(9, 5, 34.99),
(10, 5, 44.99),
(11, 6, 54.99),
(12, 6, 19.99),
(13, 7, 74.99),
(14, 7, 39.99),
(15, 8, 29.99),
(16, 8, 69.99),
(17, 9, 99.99),
(18, 9, 27.99),
(19, 10, 34.99),
(20, 10, 14.99),
(21, 11, 49.99),
(22, 11, 59.99),
(23, 12, 69.99),
(24, 12, 89.99),
(25, 13, 29.99),
(26, 13, 44.99),
(27, 14, 34.99),
(28, 14, 12.99),
(29, 15, 39.99),
(30, 15, 79.99),
(1, 16, 59.99),
(2, 16, 69.99),
(3, 17, 89.99),
(3, 18, 29.99),
(4, 18, 54.99),
(5, 19, 89.99),
(6, 19, 44.99),
(7, 20, 64.99),
(8, 20, 19.99),
(9, 21, 39.99),
(10, 21, 49.99),
(11, 22, 74.99),
(12, 22, 29.99),
(13, 23, 54.99),
(14, 23, 89.99),
(15, 24, 34.99),
(16, 24, 59.99),
(17, 25, 69.99),
(18, 25, 34.99),
(19, 26, 44.99),
(20, 26, 54.99),
(21, 27, 29.99),
(22, 27, 74.99),
(23, 28, 89.99),
(24, 28, 19.99),
(25, 29, 39.99),
(26, 29, 49.99),
(27, 30, 69.99),
(28, 30, 89.99),
(29, 1, 29.99),
(30, 1, 149.99);


-- Insert statements for bundle table
INSERT INTO bundle (cost, title, buyer_id, curator_id) VALUES
(199.99, 'Fashion Forward Bundle', 1, 1),
(299.99, 'Chic and Stylish Collection', 2, 2),
(149.99, 'Casual Comfort Bundle', 3, 3),
(249.99, 'Streetwear Essentials Pack', 4, 4),
(159.99, 'Elegant Classics Set', 5, 5),
(189.99, 'Boho Chic Ensemble', 6, 6),
(279.99, 'Active Lifestyle Kit', 7, 7),
(199.99, 'Timeless Elegance Package', 8, 8),
(229.99, 'Fashion Explorer Box', 9, 9),
(169.99, 'Effortless Casual Combo', 10, 10),
(209.99, 'Street Style Extravaganza', 11, 11),
(149.99, 'Bohemian Dreams Bundle', 12, 12),
(259.99, 'Professional Wardrobe Kit', 13, 13),
(179.99, 'Eclectic Mix Set', 14, 14),
(219.99, 'Versatile Styles Collection', 15, 15),
(189.99, 'Urban Streetwear Box', 16, 16),
(199.99, 'Modern Artistry Bundle', 17, 17),
(249.99, 'Minimalist Delights Pack', 18, 18),
(209.99, 'Vibrant Colors Package', 19, 19),
(179.99, 'Glamorous Essentials Kit', 20, 20),
(269.99, 'Laid-Back Lifestyle Box', 21, 21),
(149.99, 'Retro Revival Set', 22, 22),
(239.99, 'Streetwear Trends Collection', 23, 23),
(199.99, 'Trendsetters Kit', 24, 24),
(189.99, 'Youthful Energy Bundle', 25, 25),
(279.99, 'Quirky and Fun Selection', 26, 26),
(169.99, 'Bold Fashion Statements Box', 27, 27),
(219.99, 'Glamorous Chic Combo', 28, 28),
(259.99, 'Sophisticated Elegance Set', 29, 29),
(149.99, 'Casual and Comfortable Kit', 30, 30);


-- Insert statement for conversation table
INSERT INTO conversation (to_user_id, from_user_id, conversation_history) VALUES
(1, 1, 'User 1 to User 1: Hi, how are you?'),
(2, 3, 'User 2 to User 3: Hello! I\'m good, thanks.'),
(3, 2, 'User 3 to User 2: Hey there! What\'s up?'),
(4, 4, 'User 4 to User 4: Greetings! How\'s your day?'),
(5, 6, 'User 5 to User 6: Hi! Any exciting plans for the weekend?'),
(6, 5, 'User 6 to User 5: Not much, just relaxing. How about you?'),
(7, 7, 'User 7 to User 7: Hello! Anything interesting happening today?'),
(8, 9, 'User 8 to User 9: Hey! Did you check out the latest fashion trends?'),
(9, 8, 'User 9 to User 8: Yes, I saw some cool styles. Do you have any favorites?'),
(10, 10, 'User 10 to User 10: Hi there! What\'s new in your world?'),
(11, 12, 'User 11 to User 12: Hello! Have you tried any new restaurants lately?'),
(12, 11, 'User 12 to User 11: Yes, I found a great place with delicious food.'),
(13, 14, 'User 13 to User 14: Hey! How\'s your day shaping up?'),
(14, 13, 'User 14 to User 13: It\'s going well. Just busy with work. How about you?'),
(15, 15, 'User 15 to User 15: Hi! What\'s your favorite type of music?'),
(16, 17, 'User 16 to User 17: Hello! Do you enjoy outdoor activities?'),
(17, 16, 'User 17 to User 16: Absolutely! I love hiking and camping.'),
(18, 18, 'User 18 to User 18: Hey there! Watching any good movies lately?'),
(19, 20, 'User 19 to User 20: Hi! Have you read any interesting books recently?'),
(20, 19, 'User 20 to User 19: Yes, I just finished a great novel. Would you like a recommendation?'),
(21, 21, 'User 21 to User 21: Hello! How\'s your day going so far?'),
(22, 23, 'User 22 to User 23: Hey! Do you follow any sports teams?'),
(23, 22, 'User 23 to User 22: Not really, but I enjoy watching the occasional game.'),
(24, 24, 'User 24 to User 24: Hi! Do you have any travel plans coming up?'),
(25, 26, 'User 25 to User 26: Hello! Do you have a favorite type of cuisine?'),
(26, 25, 'User 26 to User 25: I love Italian food. How about you?'),
(27, 27, 'User 27 to User 27: Hi there! Whats your go-to workout routine?'),
(28, 29, 'User 28 to User 29: Hey! Any exciting projects on the horizon?'),
(29, 28, 'User 29 to User 28: Yes, Im working on a new creative endeavor.'),
(30, 30, 'User 30 to User 30: Hello! How do you like to spend your weekends?'),
(1, 2, 'User 1 to User 2: Hi! Have you checked out the latest tech gadgets?'),
(2, 1, 'User 2 to User 1: Yes, I saw some cool gadgets. Anything specific you recommend?'),
(3, 1, 'User 3 to User 1: Hey there! Do you have any favorite video games?'),
(4, 5, 'User 4 to User 5: Greetings! Do you enjoy gardening as a hobby?'),
(5, 4, 'User 5 to User 4: Yes, I find gardening very therapeutic.'),
(6, 7, 'User 6 to User 7: Hi! Have you attended any live concerts lately?'),
(7, 6, 'User 7 to User 6: Not recently, but I love live music. Do you have a favorite genre?'),
(8, 8, 'User 8 to User 8: Hello! Are you into photography?'),
(9, 10, 'User 9 to User 10: Hey! Do you enjoy trying new recipes in the kitchen?'),
(10, 9, 'User 10 to User 9: Absolutely! Cooking is one of my favorite hobbies.'),
(11, 11, 'User 11 to User 11: Hi there! Are you a fan of science fiction movies?'),
(12, 13, 'User 12 to User 13: Hello! Do you like outdoor painting?'),
(13, 12, 'User 13 to User 12: Yes, I find it very relaxing.'),
(14, 15, 'User 14 to User 15: Hey! Do you follow any specific artists or bands?'),
(15, 14, 'User 15 to User 14: Im a fan of classic rock. How about you?'),
(16, 17, 'User 16 to User 17: Hi there! Have you tried any new fitness classes?'),
(17, 16, 'User 17 to User 16: Yes, I recently started yoga and love it.'),
(18, 18, 'User 18 to User 18: Greetings! Do you enjoy reading science fiction novels?'),
(19, 20, 'User 19 to User 20: Hello! Are you a fan of historical fiction?'),
(20, 19, 'User 20 to User 19: Yes, I find historical fiction fascinating.'),
(21, 21, 'User 21 to User 21: Hi there! Do you have any favorite board games?'),
(22, 23, 'User 22 to User 23: Hey! Are you into any water sports?'),
(23, 22, 'User 23 to User 22: I enjoy kayaking during the summer.'),
(24, 24, 'User 24 to User 24: Hello! Have you visited any art galleries recently?'),
(25, 26, 'User 25 to User 26: Hi! Do you have a favorite type of dessert?'),
(26, 25, 'User 26 to User 25: I love chocolate desserts. How about you?'),
(27, 27, 'User 27 to User 27: Greetings! Whats your preferred workout routine?');



-- Insert statements for dispute table
INSERT INTO dispute (description, status, resolution_details, admin_id, user_id, reported_at, resolved_at) VALUES
('Product not as described', 'Open', 'Waiting for investigation', 1, 1, '2023-01-01 12:00:00', NULL),
('Late delivery issue', 'Closed', 'Refund issued', 2, 2, '2023-01-02 10:30:00', '2023-01-06 16:45:00'),
('Quality concern with item', 'Open', 'Under review', 3, 3, '2023-01-03 08:45:00', NULL),
('Item damaged during shipping', 'Closed', 'Replacement sent', 4, 4, '2023-01-04 14:20:00', '2023-01-08 11:10:00'),
('Billing discrepancy', 'Open', 'Investigating billing records', 5, 5, '2023-01-05 11:00:00', NULL),
('Order never received', 'Closed', 'Full refund issued', 6, 6, '2023-01-06 09:15:00', '2023-01-10 13:30:00'),
('Unauthorized transaction', 'Open', 'Checking account activity', 7, 7, '2023-01-07 15:30:00', NULL),
('Defective product received', 'Closed', 'Item returned and refunded', 8, 8, '2023-01-08 16:45:00', '2023-01-12 08:40:00'),
('Shipping cost dispute', 'Open', 'Gathering shipping details', 9, 9, '2023-01-09 13:20:00', NULL),
('Size mismatch in clothing', 'Closed', 'Exchange processed', 10, 10, '2023-01-10 07:45:00', '2023-01-14 17:25:00'),
('Missing accessories', 'Open', 'Confirming order contents', 11, 11, '2023-01-11 14:30:00', NULL),
('Refund request for canceled order', 'Closed', 'Refund processed', 12, 12, '2023-01-12 12:10:00', '2023-01-16 10:15:00'),
('Item not meeting expectations', 'Open', 'Requesting additional information', 13, 13, '2023-01-13 09:30:00', NULL),
('Late refund processing', 'Closed', 'Refund completed', 14, 14, '2023-01-14 11:20:00', '2023-01-18 14:50:00'),
('Package lost during transit', 'Open', 'Tracing package location', 15, 15, '2023-01-15 08:00:00', NULL),
('Defective electronic item', 'Closed', 'Replacement dispatched', 16, 16, '2023-01-16 10:45:00', '2023-01-20 16:30:00'),
('Incorrect item received', 'Open', 'Verifying order details', 17, 17, '2023-01-17 13:15:00', NULL),
('Discrepancy in item color', 'Closed', 'Item exchanged', 18, 18, '2023-01-18 14:30:00', '2023-01-22 11:55:00'),
('Double charged for order', 'Open', 'Checking payment records', 19, 19, '2023-01-19 11:40:00', NULL),
('Product not matching description', 'Closed', 'Refund issued', 20, 20, '2023-01-20 09:30:00', '2023-01-24 15:10:00'),
('Quality issues with clothing', 'Open', 'Reviewing product photos', 21, 21, '2023-01-21 16:20:00', NULL),
('Delayed processing of return', 'Closed', 'Return processed', 22, 22, '2023-01-22 13:50:00', '2023-01-26 09:30:00'),
('Incorrect size shipped', 'Open', 'Checking order fulfillment', 23, 23, '2023-01-23 10:10:00', NULL),
('Unauthorized charge on credit card', 'Closed', 'Investigation complete', 24, 24, '2023-01-24 15:45:00', '2023-01-28 12:20:00'),
('Missing components in electronic item', 'Open', 'Contacting manufacturer', 25, 25, '2023-01-25 12:30:00', NULL),
('Refund not received', 'Closed', 'Refund processed', 26, 26, '2023-01-26 08:40:00', '2023-01-30 14:15:00'),
('Product received after cancellation', 'Open', 'Confirming delivery details', 27, 27, '2023-01-27 09:50:00', NULL),
('Defective home decor item', 'Closed', 'Refund issued', 28, 28, '2023-01-28 16:10:00', '2023-02-01 11:40:00'),
('Wrong item shipped', 'Open', 'Verifying order and shipping details', 29, 29, '2023-01-29 14:20:00', NULL);


-- Insert statements for technical_issue table
INSERT INTO technical_issue (description, status, resolution_details, admin_id, reported_at, resolved_at) VALUES
('Login button not working', 'Open', 'Investigating the login functionality', 1, '2023-01-01 14:00:00', NULL),
('Slow website performance', 'Closed', 'Optimized server configurations', 2, '2023-01-02 12:30:00', '2023-01-06 20:00:00'),
('Payment processing error', 'Open', 'Reviewing payment gateway integration', 3, '2023-01-03 10:15:00', NULL),
('Images not loading on product pages', 'Closed', 'Resolved caching issues', 4, '2023-01-04 16:45:00', '2023-01-08 11:30:00'),
('Error in checkout process', 'Open', 'Identifying and fixing checkout bugs', 5, '2023-01-05 13:20:00', NULL),
('Incorrect product prices displayed', 'Closed', 'Updated product pricing database', 6, '2023-01-06 11:45:00', '2023-01-10 15:15:00'),
('Email notifications not being sent', 'Open', 'Checking email server configurations', 7, '2023-01-07 18:30:00', NULL),
('Search feature not returning accurate results', 'Closed', 'Enhanced search algorithm', 8, '2023-01-08 16:15:00', '2023-01-12 10:20:00'),
('Site downtime during maintenance', 'Open', 'Investigating server outage', 9, '2023-01-09 14:40:00', NULL),
('SSL certificate expiration issue', 'Closed', 'Renewed SSL certificate', 10, '2023-01-10 08:55:00', '2023-01-14 18:25:00'),
('Mobile app crashing on launch', 'Open', 'Debugging mobile app codebase', 11, '2023-01-11 15:20:00', NULL),
('Browser compatibility problem', 'Closed', 'Resolved CSS compatibility issues', 12, '2023-01-12 13:00:00', '2023-01-16 11:05:00'),
('User registration not working', 'Open', 'Investigating registration process', 13, '2023-01-13 11:30:00', NULL),
('API integration failure', 'Closed', 'Fixed API communication errors', 14, '2023-01-14 14:40:00', '2023-01-18 16:50:00'),
('Database connection error', 'Open', 'Checking database server status', 15, '2023-01-15 09:00:00', NULL),
('404 errors on certain pages', 'Closed', 'Fixed broken links and page routing', 16, '2023-01-16 12:45:00', '2023-01-20 17:30:00'),
('Issue with order tracking functionality', 'Open', 'Reviewing order tracking system', 17, '2023-01-17 16:15:00', NULL),
('Inconsistent display of product information', 'Closed', 'Updated product information database', 18, '2023-01-18 17:30:00', '2023-01-22 12:55:00'),
('Server overload during high traffic', 'Open', 'Optimizing server resources', 19, '2023-01-19 15:45:00', NULL),
('Logout button not functioning', 'Closed', 'Resolved logout functionality issues', 20, '2023-01-20 13:35:00', '2023-01-24 19:10:00'),
('Problem with user account authentication', 'Open', 'Reviewing authentication process', 21, '2023-01-21 18:20:00', NULL),
('Integration issue with third-party service', 'Closed', 'Reconfigured third-party API integration', 22, '2023-01-22 14:50:00', '2023-01-26 09:30:00'),
('Missing data in user profiles', 'Open', 'Restoring missing user profile data', 23, '2023-01-23 12:30:00', NULL),
('Social media sharing not working', 'Closed', 'Updated social media integration code', 24, '2023-01-24 16:45:00', '2023-01-28 13:20:00'),
('Error in discount code application', 'Open', 'Investigating discount code system', 25, '2023-01-25 15:20:00', NULL),
('Issue with order confirmation emails', 'Closed', 'Resolved email notification system bug', 26, '2023-01-26 11:10:00', '2023-01-30 16:45:00'),
('Problem with product review submission', 'Open', 'Reviewing product review process', 27, '2023-01-27 18:30:00', NULL),
('Error in generating invoices', 'Closed', 'Fixed invoice generation algorithm', 28, '2023-01-28 16:10:00', '2023-02-01 11:40:00');




