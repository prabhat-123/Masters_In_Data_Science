DROP DATABASE ECA_ACADEMY;



CREATE DATABASE ECA_ACADEMY;

USE ECA_ACADEMY;

CREATE TABLE IF NOT EXISTS User (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    User_Role VARCHAR(100) NOT NULL,
    EnrollmentDate DATETIME DEFAULT CURRENT_TIMESTAMP
);


-- Create Category Table
CREATE TABLE IF NOT EXISTS Category (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Description TEXT
);


-- Create Course Table

CREATE TABLE IF NOT EXISTS Course (
    CourseID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(1000) NOT NULL,
    Description TEXT,
    CategoryID INT,
    Difficulty VARCHAR(100) NOT NULL,
    TeacherID INT,
    Price DECIMAL(10, 2), -- For paid courses
    FOREIGN KEY (TeacherID) REFERENCES User(UserID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);


-- Create Enrollment Table
CREATE TABLE IF NOT EXISTS Enrollment (
    UserID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    CompletionDate DATETIME,
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);





-- Create Payment Table (For Paid Courses)
CREATE TABLE IF NOT EXISTS Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    CourseID INT NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status ENUM('Pending', 'Completed'),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);



-- Ratings & Reviews
CREATE TABLE IF NOT EXISTS Rating (
    UserID INT NOT NULL,
    CourseID INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Review TEXT,
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);




-- Insert 10 rows into Category table (need to create another subcategory_id as a foreign key)
INSERT INTO Category (Name, Description) VALUES
('Music', 'Course on Classical Music'),
('Music', 'Course on Western Music'),
('Music', 'Course on Flutes & Guitar'),
('Music', 'Course on Rock Music'),
('Singing', 'Course on classical singing'),
('Singing', 'Course on Vocal Training'),
('Singing', 'Course on Pop Singing'),
('Dancing', 'Course on Hip Hop Dancing'),
('Dancing', 'Course on Classical Dancing'),
('Dancing', 'Course on Contemporary Dancing');



-- Insert 10 rows into User table
INSERT INTO User (FirstName, LastName, Email, User_Role) VALUES
('Prabhat', 'Ale', 'prabhat@gmail.com', 'Teacher'),
('Gaurav', 'Bhattarai', 'gauravh@gmail.com', 'Student'),
('Niraj', 'Kharel', 'niraj@gmail.com', 'Student'),
('Anish', 'Thapaliya', 'anish@gmail.com', 'Teacher'),
('Sunil', 'Ghimire', 'sunil@gmail.com', 'Admin'),
('Ashmita', 'Bhata', 'ashmita@gmail.com', 'Student'),
('Suman', 'Paudel', 'suman@gmail.com', 'Teacher'),
('Gita', 'Gaire', 'gita@gmail.com', 'Student'),
('Alisha', 'Thapa', 'alisha@gmail.com', 'Student'),
('Kshitiz', 'Regmi', 'kshitiz@gmail.com', 'Teacher');




-- Insert 10 rows into Course table
INSERT INTO Course (Title, Description, CategoryID, Difficulty, TeacherID, Price) VALUES
('Introduction to Classical Music', 'Basics of Classical Music', 1, 'Beginner', 1, 10000),
('Western Music Fundamentals', 'Learn the basics of Western Music', 2, 'Beginner', 4, 15000),
('Guitar for Beginners', 'Learn to play the guitar', 3, 'Beginner', 7, 8000),
('Rock Music Techniques', 'Advanced rock music techniques', 4, 'Advanced', 10, 7500),
('Classical Singing Basics', 'Introduction to classical singing techniques', 5, 'Beginner', 1, 12500),
('Vocal Training for Singers', 'Improve your vocal skills', 6, 'Intermediate', 4, 15000),
('Pop Singing Masterclass', 'Advanced techniques in pop singing', 7, 'Advanced', 7, 11000),
('Hip Hop Dance Moves', 'Learn the basics of Hip Hop Dancing', 8, 'Beginner', 10, 18000),
('Classical Dance Fundamentals', 'Basics of Classical Dancing', 9, 'Beginner', 1, 20000),
('Contemporary Dance Techniques', 'Advanced contemporary dance techniques', 10, 'Advanced', 4, 25000);


-- Insert additional enrollment records with student information
INSERT INTO Enrollment (UserID, CourseID, EnrollmentDate, CompletionDate) VALUES
(2, 2, '2023-01-15', DATE_ADD('2023-01-15', INTERVAL 6 MONTH)),  -- Gaurav Bhattarai enrolled in Western Music Fundamentals (6 months)
(3, 3, '2023-02-01', DATE_ADD('2023-02-01', INTERVAL 6 MONTH)),  -- Niraj Kharel enrolled in Guitar for Beginners (6 months)
(6, 4, '2023-03-01', DATE_ADD('2023-03-01', INTERVAL 3 MONTH)),  -- Ashmita Bhata enrolled in Rock Music Techniques (3 months)
(8, 5, '2023-03-15', DATE_ADD('2023-03-15', INTERVAL 6 MONTH)),  -- Gita Gaire enrolled in Classical Singing Basics (6 months)
(9, 6, '2023-04-01', DATE_ADD('2023-04-01', INTERVAL 3 MONTH)),  -- Alisha Thapa enrolled in Vocal Training for Singers (3 months)
(6, 7, '2023-04-15', DATE_ADD('2023-04-15', INTERVAL 6 MONTH)),  -- Ashmita Bhata enrolled in Pop Singing Masterclass (6 months)
(8, 8, '2023-05-01', DATE_ADD('2023-05-01', INTERVAL 3 MONTH)),  -- Gita Gaire enrolled in Hip Hop Dance Moves (3 months)
(3, 9, '2023-05-15', DATE_ADD('2023-05-15', INTERVAL 6 MONTH)),  -- Niraj Kharel enrolled in Classical Dance Fundamentals (6 months)
(2, 10, '2023-06-01', DATE_ADD('2023-06-01', INTERVAL 3 MONTH)), -- Gaurav Bhattarai enrolled in Contemporary Dance Techniques (3 months)
(9, 1, '2023-06-15', DATE_ADD('2023-06-15', INTERVAL 6 MONTH));  -- Alisha Thapa enrolled in Introduction to Classical Music (6 months)



-- Insert 10 rows into Payment table with PaymentDate
INSERT INTO Payment (UserID, CourseID, Amount, Status, PaymentDate) VALUES
(2, 2, 15000, 'Completed', '2023-08-15'),    -- Gaurav Bhattarai paid for Introduction to Classical Music
(3, 3, 8000, 'Completed', '2023-10-15'),    -- Niraj Kharel paid for Western Music Fundamentals
(6, 4, 7500, 'Completed', '2023-07-01'),     -- Ashmita Bhata paid for Guitar for Beginners
(8, 5, 12500, 'Completed', '2023-12-01'),     -- Gita Gaire paid for Rock Music Techniques
(9, 6, 15000, 'Completed', '2023-09-30'),    -- Alisha Thapa paid for Classical Singing Basics
(6, 7, 11000, 'Completed', '2023-12-31'),    -- Ashmita Bhata paid for Vocal Training for Singers
(8, 8, 18000, 'Completed', '2024-01-01'),    -- Gita Gaire paid for Pop Singing Masterclass
(3, 9, 20000, 'Completed', '2023-11-30'),    -- Niraj Kharel paid for Hip Hop Dance Moves
(2, 10, 25000, 'Completed', '2023-08-15'),    -- Gaurav Bhattarai paid for Classical Dance Fundamentals
(9, 1, 10000, 'Completed', '2024-01-15');   -- Alisha Thapa paid for Contemporary Dance Techniques



-- Insert 10 rows into Rating table
INSERT INTO Rating (UserID, CourseID, Rating, Review) VALUES
(2, 2, 5, 'Excellent course!'),
(3, 3, 4, 'Very informative.'),
(6, 4, 3, 'Good for beginners.'),
(8, 5, 5, 'Great introduction to business management.'),
(9, 6, 4, 'Helpful tips on time management.'),
(6, 7, 3, 'Basic but good.'),
(8, 8, 5, 'Fun and easy to follow.'),
(3, 9, 4, 'Learned a lot of new techniques.'),
(2, 10, 5, 'Highly recommend for beginners.'),
(9, 1, 4, 'Comprehensive and well-structured.');













# 1) List all the categories in the Category table.
SELECT * FROM Category c ;















# 2) Retrieve all the users with the role 'Student'.
SELECT * FROM User WHERE User_Role = 'Student';












# 3) Find the title and descriptions of all courses with a difficulty level of 'Beginner'.
SELECT Title, Description FROM Course c  
WHERE Difficulty='Beginner';










# 4) Get the full names and email addresses of all teachers.
SELECT CONCAT(FirstName, ' ', LastName), Email 
FROM User WHERE User_Role = 'Teacher';






# 5) Find the total number of courses each teacher is teaching.
SELECT CONCAT(User.FirstName, ' ', User.LastName), COUNT(*) as num_of_courses_taught
FROM User
JOIN Course ON User.UserID = Course.TeacherID
WHERE User.User_Role = 'Teacher'
GROUP BY User.UserID;










# 6) Find the average rating given by each user.
SELECT UserID , AVG(Rating) AS avg_rating FROM Rating GROUP BY UserID;







# 7) List all courses description along with their respective categories.
SELECT Course.Description, Category.Name  FROM Course JOIN Category ON Course.CategoryID  = Category.CategoryID;







# 8) Find the total amount paid by each student.
SELECT CONCAT(User.FirstName, ' ', User.LastName) AS student, SUM(Amount) AS total_amount_paid FROM User JOIN Payment ON User.UserID = Payment.UserID  
WHERE User_Role = 'Student'
GROUP BY Payment.UserID ;




# 9) Get a list of all courses that have the word 'Music' in their title.
SELECT Course.Title 
FROM Category 
JOIN Course ON Category.CategoryID = Course.CategoryID
WHERE Course.Title LIKE '%Music%';




# 10) How can we get a combined list of courses that either have the word 'Music' in their 
# title or belong to a category with 'Music' in its name?

-- Get all courses with 'Music' in the title
SELECT Title
FROM Course
WHERE Title LIKE '%Music%'

UNION

-- Get all courses belonging to categories with 'Music' in the name
SELECT c.Title
FROM Course c
JOIN Category ca ON c.CategoryID = ca.CategoryID
WHERE ca.Name LIKE '%Music%';




# 11) How can we find courses that both have 'Music' in their title and belong to a category with
# 'Music' in its name?

-- Get all courses with 'Music' in the title
SELECT Title
FROM Course
WHERE Title LIKE '%Music%'

INTERSECT

-- Get all courses belonging to categories with 'Music' in the name
SELECT c.Title
FROM Course c
JOIN Category ca ON c.CategoryID = ca.CategoryID
WHERE ca.Name LIKE '%Music%';



## Triggers


-- procedure to get the name of User
DROP PROCEDURE IF EXISTS GetUser;
DELIMITER //
CREATE PROCEDURE GetUser()
BEGIN
     SELECT * FROM User;
END;
//
DELIMITER ;

CALL GetUser();


-- procedure to find out high value student

DELIMITER //
CREATE PROCEDURE HighValueStudent(IN amt DECIMAL(10, 2))
BEGIN
    SELECT u.UserID, u.FirstName, c.CourseID, p.Amount FROM User u 
    JOIN Payment p ON u.UserID = p.UserID
	JOIN Course c ON p.CourseID = c.CourseID
    WHERE p.Amount > amt;
END;
//
DELIMITER ;

call HighValueStudent(18000.00);
-- how many courses

--course count
DELIMITER //
CREATE PROCEDURE GetCourseCount(OUT course_count INT)
BEGIN
     SELECT count(*) AS Total_Course FROM Course;
END;
//
DELIMITER ;

CALL GetCourseCount(@course_count);


DELIMITER //
CREATE PROCEDURE CalculateAverageCourseRating (
    IN p_CourseID INT
)
BEGIN
    SELECT AVG(Rating) AS `Average Rating`
    FROM Rating
    WHERE CourseID = p_CourseID;
END //
DELIMITER ;

CALL CalculateAverageCourseRating(1);

-- before insert

DELIMITER //
CREATE TRIGGER before_insert
BEFORE INSERT ON User
FOR EACH ROW
BEGIN
	SET NEW.UserID = 100;
END

//
DELIMITER ;


SELECT * FROM User;
INSERT INTO User (FirstName, LastName, Email, User_Role) VALUES
('Suman', 'Paudel', 'suman1@gmail.com', 'Teacher');


CREATE TABLE trigger_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER after_delete
AFTER DELETE ON Rating
FOR EACH ROW
BEGIN
SELECT CONCAT('Rating for Course ID: ', OLD.CourseID, ' has been deleted.') INTO @message;
INSERT INTO trigger_log(message) VALUES(@message);
END//
DELIMITER ;

delete from Rating where CourseID = 10;
SELECT * FROM trigger_log;

