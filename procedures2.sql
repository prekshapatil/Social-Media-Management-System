USE socialmedia;

/* A procedure to create new post */
DROP PROCEDURE IF EXISTS CreateNewPost;

DELIMITER //
CREATE PROCEDURE CreateNewPost(
    IN p_username VARCHAR(255),
    IN p_photo_url VARCHAR(255),
    IN p_video_url VARCHAR(255),
    IN p_caption VARCHAR(200),
    IN p_location VARCHAR(50),
    IN p_size FLOAT
)
BEGIN
    DECLARE new_post_id INT;
    -- generate a new post_id 
    SELECT IFNULL(MAX(post_id), 0) + 1 INTO new_post_id FROM post;
    -- Insert the new post
    INSERT INTO post (post_id, username, photo_url, video_url, caption, location, size)
    VALUES (new_post_id, p_username, p_photo_url, p_video_url, p_caption, p_location, p_size);
    SELECT 'Post created successfully' AS result;
END //
DELIMITER ;

-- Call the CreateNewPost procedure with specific values
CALL CreateNewPost('john_doe', 'new_photo.jpg', NULL, 'Exciting Adventure', 'Mountain', 7.8);

----------------------
/* Procedure to create a new user */

DROP PROCEDURE IF EXISTS CreateNewUser;

DELIMITER //
CREATE PROCEDURE CreateNewUser(
    IN p_username VARCHAR(255),
    IN p_profile_photo_url VARCHAR(255),
    IN p_bio VARCHAR(255),
    IN p_dob DATE,
    IN p_email VARCHAR(255),
    IN p_user_password VARCHAR(255)
)
BEGIN
    -- Declare a variable to store the new user's login ID
    DECLARE new_login_id INT;

    -- Insert into the login table
    INSERT INTO login (email, user_password)
    VALUES (p_email, p_user_password);

    -- Retrieve the login ID of the newly inserted record
    SET new_login_id = LAST_INSERT_ID();

    -- Insert into the users table
    INSERT INTO users (username, profile_photo_url, bio, dob, login_id)
    VALUES (p_username, p_profile_photo_url, p_bio, p_dob, new_login_id);
END //
DELIMITER ;

-- call
CALL CreateNewUser('new_user', 'new_profile.jpg', 'Hello, I am a new user', '1995-01-01', 'new_user@example.com', 'new_password123');
CALL CreateNewUser('new_user2', 'new_profile.jpg', 'Hello, I am a new user', '1995-01-01', 'new_user@example.com', 'new_password123');

----------------------
/* This procedure allows a user to add a comment to a post.*/

DROP PROCEDURE IF EXISTS AddCommentToPost;

DELIMITER //
CREATE PROCEDURE AddCommentToPost(
    IN p_comment_text VARCHAR(255),
    IN p_post_id INT,
    IN p_username VARCHAR(255)
)
BEGIN
    DECLARE new_comment_id INT;

    -- Generate a new comment_id (you can use your own logic here)
    SELECT IFNULL(MAX(comment_id), 0) + 1 INTO new_comment_id FROM comments;

    -- Insert the new comment
    INSERT INTO comments (comment_id, comment_text, post_id, username)
    VALUES (new_comment_id, p_comment_text, p_post_id, p_username);

    SELECT 'Comment added successfully' AS result;
END //
DELIMITER ;

-- call 
CALL AddCommentToPost('Great photo!', 1, 'alice_smith');

/*. procedure to like a post */

-- This procedure allows a user to like a post.
-- This procedure allows a user to like a post.
DROP PROCEDURE IF EXISTS LikePost;
 
DELIMITER //
 
CREATE PROCEDURE LikePost(
    IN p_liking_username VARCHAR(255),
    IN p_post_id INT
)
BEGIN
    DECLARE post_creator_username VARCHAR(255);
    DECLARE existing_likes INT;
 
    -- Find the username of the user who created the post
    SELECT username INTO post_creator_username
    FROM post
    WHERE post_id = p_post_id;
 
    -- Check if the liking user has already liked the post
    SELECT COUNT(*) INTO existing_likes
    FROM post_likes
    WHERE post_id = p_post_id AND user_likes = p_liking_username;
 
    -- If the user hasn't liked the post, insert the like
    IF existing_likes = 0 THEN
        INSERT INTO post_likes (username, post_id, user_likes, created_at)
        VALUES (post_creator_username, p_post_id, p_liking_username, NOW());
        SELECT 'Like added successfully.' AS result;
    ELSE
        SELECT 'User has already liked the post.' AS result;
    END IF;
END //
DELIMITER ;

 
-- call
CALL LikePost('ryan_miller', 2);


/* This function returns the number of likes for a given post. */

DROP FUNCTION IF EXISTS GetPostLikesCount;

DELIMITER //
CREATE FUNCTION GetPostLikesCount(p_post_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE likes_count INT;

    SELECT COUNT(*) INTO likes_count
    FROM post_likes
    WHERE post_id = p_post_id;

    RETURN likes_count;
END //
DELIMITER ;

-- call
SELECT GetPostLikesCount(2) AS likes_count;

/* This function returns the number of followers for a given user. */

DROP FUNCTION IF EXISTS GetFollowersCount;

DELIMITER //
CREATE FUNCTION GetFollowersCount(user_id VARCHAR(255)) RETURNS INT
READS SQL DATA
BEGIN
    DECLARE followers_count INT;

    SELECT COUNT(*) INTO followers_count
    FROM userfollows
    WHERE followee_id = user_id;

    RETURN followers_count;
END //
DELIMITER ;

-- Call the function
SELECT GetFollowersCount('alice_smith') AS FollowersCount;

/* This procedure allows a user to like a comment. */

DROP PROCEDURE IF EXISTS LikeComment;

DELIMITER //
CREATE PROCEDURE LikeComment(
    IN p_username VARCHAR(255),
    IN p_comment_id INT,
    IN p_user_likes_comment VARCHAR(255)
)
BEGIN
    DECLARE user_exists INT;
    DECLARE comment_exists INT;

    -- Check if the user exists
    SELECT COUNT(*) INTO user_exists FROM users WHERE username = p_username;

    -- Check if the comment exists
    SELECT COUNT(*) INTO comment_exists FROM comments WHERE comment_id = p_comment_id;

    -- If the user and comment exist, proceed with the like
    IF user_exists = 1 AND comment_exists = 1 THEN
        -- Check if the like already exists to avoid duplicates
        IF NOT EXISTS (
            SELECT 1 FROM comment_likes
            WHERE username = p_username AND comment_id = p_comment_id AND userlikescomment = p_user_likes_comment
        ) THEN
            -- Insert the like
            INSERT INTO comment_likes (username, comment_id, userlikescomment, created_at)
            VALUES (p_username, p_comment_id, p_user_likes_comment, NOW());

            SELECT 'Like added successfully.' AS result;
        ELSE
            SELECT 'You have already liked this comment.' AS result;
        END IF;
    ELSE
        SELECT 'User or comment does not exist.' AS result;
    END IF;
END //
DELIMITER ;

-- call
CALL LikeComment('john_doe', 1, 'alice_smith');

/* This procedure allows a user to follow another user */

DROP PROCEDURE IF EXISTS FollowUser;
-- Procedure to allow a user to follow another user
DELIMITER //
CREATE PROCEDURE FollowUser(
    IN p_follower_id VARCHAR(255),
    IN p_followee_id VARCHAR(255)
)
BEGIN
    DECLARE follower_exists INT;
    DECLARE followee_exists INT;

    -- Check if the follower user exists
    SELECT COUNT(*) INTO follower_exists FROM users WHERE username = p_follower_id;

    -- Check if the followee user exists
    SELECT COUNT(*) INTO followee_exists FROM users WHERE username = p_followee_id;

    -- If both users exist, proceed with the follow
    IF follower_exists = 1 AND followee_exists = 1 THEN
        -- Check if the follow relationship already exists to avoid duplicates
        IF NOT EXISTS (
            SELECT 1 FROM userfollows
            WHERE follower_id = p_follower_id AND followee_id = p_followee_id
        ) THEN
            -- Insert the follow relationship
            INSERT INTO userfollows (follower_id, followee_id, created_at)
            VALUES (p_follower_id, p_followee_id, NOW());

            SELECT 'User followed successfully.' AS result;
        ELSE
            SELECT 'You are already following this user.' AS result;
        END IF;
    ELSE
        SELECT 'Follower or followee user does not exist.' AS result;
    END IF;
END //
DELIMITER ;

-- call
CALL FollowUser('john_doe', 'alice_smith');

/* This procedure allows a user to delete one of their posts */

DROP PROCEDURE IF EXISTS DeleteUserPost;

DELIMITER //
CREATE PROCEDURE DeleteUserPost(
    IN p_username VARCHAR(255),
    IN p_post_id INT
)
BEGIN
    DECLARE post_exists INT;

    -- Check if the post exists and belongs to the user
    SELECT COUNT(*) INTO post_exists
    FROM post
    WHERE username = p_username AND post_id = p_post_id;

    IF post_exists = 1 THEN
        -- Disable foreign key checks
        SET foreign_key_checks = 0;

        -- Delete associated comments
        DELETE FROM comments
        WHERE username = p_username AND post_id = p_post_id;

        -- Delete likes on the post
        DELETE FROM post_likes
        WHERE username = p_username AND post_id = p_post_id;

        -- Delete the post
        DELETE FROM post
        WHERE username = p_username AND post_id = p_post_id;

        -- Enable foreign key checks
        SET foreign_key_checks = 1;

        SELECT 'Post deleted successfully.' AS result;
    ELSE
        SELECT 'Post not found or does not belong to the user.' AS result;
    END IF;
END //
DELIMITER ;

-- call
CALL DeleteUserPost('john_doe', 1);


/* This function returns the number of likes for a given comment */

DROP FUNCTION IF EXISTS GetCommentLikescount;

-- Function to return the number of likes for a given comment
DELIMITER //
CREATE FUNCTION GetCommentLikesCount(
    p_comment_id INT
) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE likes_count INT;

    -- Count the number of likes for the comment
    SELECT COUNT(*) INTO likes_count
    FROM comment_likes
    WHERE comment_id = p_comment_id;

    RETURN likes_count;
END //
DELIMITER ;

-- test
SELECT GetCommentLikesCount(1) AS likes_count;

/* This function checks if a user follows another user */

DROP FUNCTION IF EXISTS IsUserFollowing;
-- Function to check if a user follows another user
DELIMITER //
CREATE FUNCTION IsUserFollowing(
    p_follower_id VARCHAR(255),
    p_followee_id VARCHAR(255)
) RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE is_following BOOLEAN;

    -- Check if there is a record in userfollows for the given follower and followee
    SELECT COUNT(*) INTO is_following
    FROM userfollows
    WHERE follower_id = p_follower_id AND followee_id = p_followee_id;

    RETURN is_following;
END //
DELIMITER ;

-- test
SELECT IsUserFollowing('john_doe', 'alice_smith') AS IsJohnFollowingAlice;


/* Procedure to delete a user */

DROP PROCEDURE IF EXISTS DeleteUser;

DELIMITER //
CREATE PROCEDURE DeleteUser(
    IN p_username VARCHAR(255)
)
BEGIN
    -- Delete from userfollows table
    DELETE FROM userfollows WHERE follower_id = p_username OR followee_id = p_username;

    -- Delete from comment_likes table
    DELETE FROM comment_likes WHERE username = p_username;

    -- Delete from post_likes table
    DELETE FROM post_likes WHERE username = p_username;

    -- Delete from comments table
    DELETE FROM comments WHERE username = p_username;

    -- Delete from post table
    DELETE FROM post WHERE username = p_username;

    -- Delete from users table
    DELETE FROM users WHERE username = p_username;
END //
DELIMITER ;

-- call
CALL DeleteUser('john_doe');


/* Delete a comment */

DROP PROCEDURE if exists DeleteComment;
DELIMITER //
CREATE PROCEDURE DeleteComment(
    IN p_comment_id INT
)
BEGIN
    -- Declare a variable to store the username associated with the comment
    DECLARE comment_username VARCHAR(255);

    -- Get the username associated with the comment
    SELECT username INTO comment_username
    FROM comments
    WHERE comment_id = p_comment_id;

    -- Delete the comment from the comments table
    DELETE FROM comments
    WHERE comment_id = p_comment_id;

    -- If the username is not null, delete associated likes
    IF comment_username IS NOT NULL THEN
        DELETE FROM comment_likes
        WHERE comment_id = p_comment_id;
    END IF;
END //
DELIMITER ;

-- call
CALL DeleteComment(1);


/* Procedure to unlike a post */

DROP PROCEDURE IF EXISTS UnlikePost;
-- Create a procedure to unlike a post
DELIMITER //
CREATE PROCEDURE UnlikePost(
    IN p_post_id INT,
    IN p_username VARCHAR(255)
)
BEGIN
    -- Delete the like record for the specified post and user
    DELETE FROM post_likes
    WHERE post_id = p_post_id AND username = p_username;

    -- You can perform additional actions if needed, such as updating like counts on the post table
END //

DELIMITER ;

-- call
CALL UnlikePost(1, 'alice_smith');

/* a procedure to unlike a comment */

DROP PROCEDURE IF EXISTS UnlikeComment;
-- Create a procedure to unlike a comment
DELIMITER //

CREATE PROCEDURE UnlikeComment(
    IN p_comment_id INT,
    IN p_username VARCHAR(255)
)
BEGIN
    -- Delete the like record for the specified comment and user
    DELETE FROM comment_likes
    WHERE comment_id = p_comment_id AND username = p_username;

    -- You can perform additional actions if needed, such as updating like counts on the comments table
END //

DELIMITER ;

-- call
CALL UnlikeComment(1, 'alice_smith');

/* a procedure to unfollow a user */

DROP PROCEDURE IF EXISTS UnfollowUser;

DELIMITER //
CREATE PROCEDURE UnfollowUser(
    IN p_follower_id VARCHAR(255),
    IN p_followee_id VARCHAR(255)
)
BEGIN
    -- Delete the follow relationship for the specified follower and followee
    DELETE FROM userfollows
    WHERE follower_id = p_follower_id AND followee_id = p_followee_id;

    -- You can perform additional actions if needed, such as updating follower/following counts
END //

DELIMITER ;

-- call
CALL UnfollowUser('john_doe', 'alice_smith');


/* a procedure to update a post */

DROP PROCEDURE IF EXISTS UpdatePost;

-- Create a procedure to update a post
DELIMITER //

CREATE PROCEDURE UpdatePost(
    IN p_post_id INTEGER,
    IN p_caption VARCHAR(200),
    IN p_location VARCHAR(50),
    IN p_size FLOAT
)
BEGIN
    -- Update the post with the specified post_id
    UPDATE post
    SET caption = p_caption,
        location = p_location,
        size = p_size
    WHERE post_id = p_post_id;

END //

DELIMITER ;

-- call
CALL UpdatePost(1, 'Its a beautiful world', 'Boston', 6.0);


/* a procedure to update a comment */

DROP PROCEDURE IF EXISTS UpdateComment;

-- Create a procedure to update a comment
DELIMITER //

CREATE PROCEDURE UpdateComment(
    IN p_comment_id INTEGER,
    IN p_comment_text VARCHAR(255)
)
BEGIN
    -- Update the comment with the specified comment_id
    UPDATE comments
    SET comment_text = p_comment_text
    WHERE comment_id = p_comment_id;

    -- You can perform additional actions if needed
END //

DELIMITER ;

-- call
CALL UpdateComment(1, 'Updated Comment Text');


/* A procedure to update user */

DROP PROCEDURE IF EXISTS UpdateUser;

-- Create a procedure to update user details
DELIMITER //

CREATE PROCEDURE UpdateUser(
    IN p_username VARCHAR(255),
    IN p_profile_photo_url VARCHAR(255),
    IN p_bio VARCHAR(255),
    IN p_dob DATE
)
BEGIN
    -- Update the user details with the specified username
    UPDATE users
    SET
        profile_photo_url = p_profile_photo_url,
        bio = p_bio,
        dob = p_dob
    WHERE username = p_username;

    -- You can perform additional actions if needed
END //

DELIMITER ;

-- call
CALL UpdateUser('john_doe', 'new_profile.jpg', 'Updated bio', '1990-05-15');

/* Read all data given particular username */

DROP PROCEDURE IF EXISTS GetUserDetails;
--  a procedure to read data from the database using joins
DELIMITER //

CREATE PROCEDURE GetUserDetails(username_param VARCHAR(255))
BEGIN
    SELECT
        p.post_id,
        p.photo_url,
        p.video_url,
        p.caption,
        p.location,
        p.size,
        p.created_at,
        c.comment_id,
        c.comment_text,
        c.created_at AS comment_created_at,
        cl.userlikescomment,
        uf.follower_id,
        uf.followee_id
    FROM
        post p
    LEFT JOIN comments c ON p.post_id = c.post_id
    LEFT JOIN comment_likes cl ON c.comment_id = cl.comment_id
    LEFT JOIN userfollows uf ON p.username = uf.follower_id
    WHERE
        p.username = username_param;
END //

DELIMITER ;

-- call
CALL GetUserDetails('john_doe');


--------------------------------
/* TRIGGERS */

-- This trigger will automatically set the created_at timestamp before inserting a new row into the post table.
DELIMITER //
CREATE TRIGGER before_post_insert
BEFORE INSERT ON post
FOR EACH ROW
SET NEW.created_at = IFNULL(NEW.created_at, NOW());
//
DELIMITER ;


-- This trigger will prevent inserting comments that exceed a certain length.

DELIMITER //

CREATE TRIGGER before_comment_insert
BEFORE INSERT ON comments
FOR EACH ROW
BEGIN
    IF LENGTH(NEW.comment_text) > 255 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Comment text exceeds the maximum length of 255 characters.';
    END IF;
END;

//

DELIMITER ;


/* EVENTS */

-- Event to Update User Activity Timestamp: This event updates the last_activity timestamp for users every day.
DELIMITER //
CREATE EVENT update_user_activity
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    UPDATE users
    SET last_activity = NOW();
END;

//
DELIMITER ;
DeleteUser

-- Event to Archive Old Posts: This event moves posts older than 365 days to an archive table.

DELIMITER //

CREATE EVENT archive_old_posts
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    INSERT INTO archived_posts
    SELECT * FROM post
    WHERE created_at < NOW() - INTERVAL 365 DAY;

    DELETE FROM post
    WHERE created_at < NOW() - INTERVAL 365 DAY;
END;

//

DELIMITER ;

use socialmedia;
/* procedure that geta all usernames */

DROP PROCEDURE IF EXISTS GetAllUsernames;

DELIMITER //

CREATE PROCEDURE GetAllUsernames()
BEGIN
    SELECT username
    FROM users;
END //

DELIMITER ;
 
 -- call
 CALL GetAllUsernames();


/* get username given mail and pw*/

DROP PROCEDURE IF EXISTS GetUserByUsernameAndPassword;

DELIMITER //

CREATE PROCEDURE GetUserByUsernameAndPassword(
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255)
)
BEGIN
    DECLARE user_name VARCHAR(255);

    -- Retrieve the username based on the provided email and password
    SELECT u.username INTO user_name
    FROM login l
    JOIN users u ON l.login_id = u.login_id
    WHERE l.email = p_email AND l.user_password = p_password;

    -- Return the result
    SELECT user_name AS 'Username';
END //

DELIMITER ;

-- call
CALL GetUserByUsernameAndPassword('olivia.green@example.com', 'securePass123');



-- Procedure to get all posts by a specific user
DROP PROCEDURE IF EXISTS GetPostsByUsername;

DELIMITER //
CREATE PROCEDURE GetPostsByUsername(
    IN p_username VARCHAR(255)
)
BEGIN
    -- Select all posts created by the specified user
    SELECT *
    FROM post
    WHERE username = p_username;
END //
DELIMITER ;

CALL GetPostsByUsername('john_doe');


/* get all posts */

DROP PROCEDURE IF EXISTS  GetAllPosts;
DELIMITER //
CREATE PROCEDURE GetAllPosts()
BEGIN
    SELECT *
    FROM post;
END //
DELIMITER ;

-- CALL
CALL GetAllPosts();


/* Procedure to get all posts liked by a user given username*/
DROP PROCEDURE IF EXISTS GetLikedPostsByUsername;

DELIMITER //

CREATE PROCEDURE GetLikedPostsByUsername(
    IN p_username VARCHAR(255)
)
BEGIN
    -- Temporary table to store liked posts
    CREATE TEMPORARY TABLE temp_liked_posts (
        post_id INT,
        username VARCHAR(255),
        photo_url VARCHAR(255),
        video_url VARCHAR(255),
        caption VARCHAR(200),
        location VARCHAR(50),
        size FLOAT,
        created_at TIMESTAMP
    );

    -- Insert liked posts into the temporary table
    INSERT INTO temp_liked_posts
    SELECT DISTINCT
        p.post_id,
        p.username,
        p.photo_url,
        p.video_url,
        p.caption,
        p.location,
        p.size,
        p.created_at
    FROM
        post_likes pl
    JOIN
        post p ON pl.post_id = p.post_id AND pl.username = p.username
    WHERE
        pl.user_likes = p_username;

    -- Select the liked posts from the temporary table
    SELECT
        post_id,
        username,
        photo_url,
        video_url,
        caption,
        location,
        size,
        created_at
    FROM
        temp_liked_posts;

    -- Drop the temporary table
    DROP TEMPORARY TABLE IF EXISTS temp_liked_posts;
END //

DELIMITER ;

-- call
-- Call the procedure to get liked posts for a user
CALL GetLikedPostsByUsername('john_doe');

/* procedure to get all comments by a particular user */

-- Procedure to get all comments by a specific user

DROP PROCEDURE IF EXISTS GetCommentsByUsername;

DELIMITER //
CREATE PROCEDURE GetCommentsByUsername(
    IN p_username VARCHAR(255)
)
BEGIN
    -- Select comments based on the provided username
    SELECT *
    FROM comments
    WHERE username = p_username;
END //
DELIMITER ;

-- Call the procedure with a specific username
CALL GetCommentsByUsername('john_doe');


