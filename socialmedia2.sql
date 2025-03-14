DROP DATABASE IF EXISTS socialmedia;

CREATE DATABASE socialmedia;

USE socialmedia;

-- login
DROP TABLE IF EXISTS login;
CREATE TABLE login (
  login_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) NOT NULL,
  user_password VARCHAR(255) NOT NULL,
  login_time TIMESTAMP NOT NULL DEFAULT NOW()
);


-- users table
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    username VARCHAR(255) PRIMARY KEY,
    profile_photo_url VARCHAR(255),
    bio VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW(),
    dob DATE,
    login_id INT,
    FOREIGN KEY(login_id) REFERENCES login(login_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


-- post table
DROP TABLE IF EXISTS post;
CREATE TABLE post (
    post_id INTEGER ,
    username VARCHAR(255),
    photo_url VARCHAR(255),
    video_url VARCHAR(255),
    caption VARCHAR(200), 
    location VARCHAR(50) ,
    size FLOAT CHECK (size<10),
    created_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY(username, post_id),
    CONSTRAINT fk_username
        FOREIGN KEY (username) REFERENCES users(username)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- post_likes table
DROP TABLE IF EXISTS post_likes;
CREATE TABLE post_likes (
    username VARCHAR(255) NOT NULL,
    post_id INTEGER NOT NULL,
    user_likes VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY(username, post_id, user_likes),
    FOREIGN KEY(username, post_id) REFERENCES post(username, post_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (user_likes) REFERENCES users(username)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Add an index on the 'post_id' column in the 'post' table
CREATE INDEX idx_post_id ON post(post_id);

CREATE TABLE comments (
    comment_id INTEGER,
    comment_text VARCHAR(255) NOT NULL,
    post_id INTEGER NOT NULL,
    username VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY(comment_id, username),
    CONSTRAINT fk_post_id_comments
        FOREIGN KEY (post_id) REFERENCES post(post_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_username_comments
        FOREIGN KEY (username) REFERENCES post(username)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE INDEX idx_comment_id ON comments(comment_id);

-- comment_likes table
DROP TABLE IF EXISTS comment_likes;
CREATE TABLE comment_likes (
    username VARCHAR(255) NOT NULL,
    comment_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    userlikescomment VARCHAR(255) NOT NULL,
    PRIMARY KEY(username, comment_id),
    FOREIGN KEY(username) REFERENCES users(username)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY(comment_id) REFERENCES comments(comment_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (userlikescomment) REFERENCES users(username)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- userfollows table
DROP TABLE IF EXISTS userfollows;
CREATE TABLE userfollows (
    follower_id VARCHAR(255) NOT NULL,
    followee_id VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY(follower_id, followee_id),
    FOREIGN KEY(follower_id) REFERENCES users(username)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY(followee_id) REFERENCES users(username)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
