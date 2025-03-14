USE socialmedia;

-- login table
INSERT INTO login (email, user_password) VALUES
('john.doe@example.com', 'password123'),
('alice.smith@example.com', 'pass456'),
('bob.jones@example.com', 'secret789'),
('emma.white@example.com', 'securePassword'),
('ryan.miller@example.com', 'strongPass'),
('sara.brown@example.com', 'password321'),
('kevin.jenkins@example.com', 'passWord123'),
('olivia.green@example.com', 'securePass123'),
('michael.black@example.com', 'password987'),
('jessica.taylor@example.com', 'pass456');

-- users
INSERT INTO users (username, profile_photo_url, bio, dob, login_id) VALUES
('john_doe', 'profile1.jpg', 'Hi, I am John Doe', '1990-05-15', 1),
('alice_smith', 'profile2.jpg', 'Hello, I am Alice Smith', '1988-11-25', 2),
('bob_jones', 'profile3.jpg', 'Hey there, I am Bob Jones', '1995-03-10', 3),
('emma_white', 'profile4.jpg', 'Greetings! I am Emma White', '1992-08-30', 4),
('ryan_miller', 'profile5.jpg', 'Hi, I am Ryan Miller', '1987-06-12', 5),
('sara_brown', 'profile6.jpg', 'Hello, I am Sara Brown', '1998-02-28', 6),
('kevin_jenkins', 'profile7.jpg', 'Hey there, I am Kevin Jenkins', '1993-07-05', 7),
('olivia_green', 'profile8.jpg', 'Greetings! I am Olivia Green', '1991-12-18', 8),
('michael_black', 'profile9.jpg', 'Hi, I am Michael Black', '1989-09-22', 9),
('jessica_taylor', 'profile10.jpg', 'Hello, I am Jessica Taylor', '1996-04-03', 10);


-- post
INSERT INTO post (post_id, username, photo_url, video_url, caption, location, size) VALUES
(1, 'john_doe', 'photo1.jpg', NULL, 'Beautiful Sunset', 'Beach', 5.8),
(2, 'alice_smith', 'photo2.jpg', NULL, 'Exploring Nature', 'Forest', 6.2),
(3, 'bob_jones', 'photo3.jpg', NULL, 'City Lights', 'City', 4.5),
(4, 'emma_white', 'photo4.jpg', NULL, 'Countryside Serenity', 'Countryside', 7.1),
(5, 'ryan_miller', 'photo5.jpg', 'video1.mp4', 'Adventures Await', 'Mountains', 8.3),
(6, 'sara_brown', 'photo6.jpg', NULL, 'Relaxing by the Lake', 'Lake', 6.9),
(7, 'kevin_jenkins', 'photo7.jpg', NULL, 'Urban Exploration', 'City', 5.4),
(8, 'olivia_green', 'photo8.jpg', NULL, 'Sunrise at the Peak', 'Mountain', 9.0),
(9, 'michael_black', 'photo9.jpg', 'video2.mp4', 'Chasing Waterfalls', 'Waterfall', 7.5),
(10, 'jessica_taylor', 'photo10.jpg', NULL, 'Cityscape Beauty', 'City', 5.6);



-- comments
INSERT INTO comments (comment_id, comment_text, post_id, username) VALUES
(1, 'Nice photo!', 1, 'alice_smith'),
(2, 'Amazing view!', 2, 'bob_jones'),
(3, 'Great shot!', 3, 'emma_white'),
(4, 'Beautiful scenery!', 4, 'ryan_miller'),
(5, 'Love it!', 5, 'sara_brown'),
(6, 'So peaceful!', 6, 'kevin_jenkins'),
(7, 'Urban vibes!', 7, 'olivia_green'),
(8, 'Stunning!', 8, 'michael_black'),
(9, 'Awesome video!', 9, 'jessica_taylor'),
(10, 'Fantastic!', 10, 'john_doe');





-- post_likes
INSERT INTO post_likes (username, post_id, user_likes) VALUES
('alice_smith', 2, 'john_doe');

INSERT INTO post_likes (username, post_id, user_likes) VALUES
('bob_jones', 3, 'alice_smith'),
('emma_white', 4, 'john_doe'),
('ryan_miller', 5, 'sara_brown'),
('sara_brown', 6, 'alice_smith'),
('kevin_jenkins', 7, 'ryan_miller'),
('olivia_green', 8, 'jessica_taylor'),
('michael_black', 9, 'john_doe'),
('jessica_taylor', 10, 'kevin_jenkins'),
('john_doe', 1, 'emma_white');


-- comment_likes

INSERT INTO comment_likes (username, comment_id, userlikescomment) VALUES
('john_doe', 1, 'alice_smith'),
('alice_smith', 2, 'bob_jones'),
('bob_jones', 3, 'emma_white'),
('emma_white', 4, 'ryan_miller'),
('ryan_miller', 5, 'sara_brown'),
('sara_brown', 6, 'kevin_jenkins'),
('kevin_jenkins', 7, 'olivia_green'),
('olivia_green', 8, 'michael_black'),
('michael_black', 9, 'jessica_taylor'),
('jessica_taylor', 10, 'john_doe');


-- userfollows
INSERT INTO userfollows (follower_id, followee_id) VALUES
('john_doe', 'alice_smith'),
('alice_smith', 'bob_jones'),
('bob_jones', 'emma_white'),
('emma_white', 'ryan_miller'),
('ryan_miller', 'sara_brown'),
('sara_brown', 'kevin_jenkins'),
('kevin_jenkins', 'olivia_green'),
('olivia_green', 'michael_black'),
('michael_black', 'jessica_taylor'),
('jessica_taylor', 'john_doe');
