-- =============================================================
				#Online Mentionship Platform
-- =============================================================

-- create `Database` 
create database if not exists Online_Mentorship; 
use Online_Mentorship; 
  

-- create `Users Table`  
create table if not exists User ( 
    user_id int auto_increment primary key, 
    email varchar(255) not null unique, 
    password varchar(255) not null, 
    role enum('Mentor', 'Student', 'Admin') not null, 
    created_at datetime default current_timestamp, 
    update_at datetime default current_timestamp on update current_timestamp 
);
 

-- insert data into `User table`
insert into User (email, password, role) values
('chat.anik@gmail.com', 'Anik@12345', 'mentor'),
('contact.tarek@gmail.com', 'Tarek@abc321', 'student'),
('work.shimul@gmail.com', 'Shimul#2024', 'mentor'),
('chat.moni@gmail.com', 'Moni!$987', 'student'),
('contact.fahim@gmail.com', 'Fahim$Pass2023', 'mentor'),
('work.shahida@gmail.com', 'Shahida@4567', 'student'),
('chat.riaz@gmail.com', 'Riaz123#Pass', 'mentor'),
('contact.samina@gmail.com', 'Samina@7860', 'student'),
('work.nabil@gmail.com', 'Nabil&2024#', 'mentor'),
('chat.nisha@gmail.com', 'Nisha1234#$', 'student');

insert into User (email, password, role) values
('cont.ayaan@gmail.com', 'ayaan#$12', 'admin'),
('work.rajmi@gmail.com', 'rajmi#$025', 'admin');

 

 

-- create `Profiles Table` 
create table if not exists Profile ( 
    profile_id int auto_increment primary key, 
    first_name varchar(100) not null, 
    last_name varchar(100) not null, 
    bio text, 
    id_verified boolean default false,
    user_id int not null,
    created_at datetime default current_timestamp, 
    update_at datetime default current_timestamp on update current_timestamp, 
    foreign key (user_id) references User(user_id) 
);
  

-- insert data into `Profile table`
insert into profile (first_name, last_name, bio, id_verified, user_id) values
('Anik', 'Hossain', 'Experienced in mentoring software development and programming skills.', true, 1),
('Tarek', 'Islam', 'Aspiring software engineer and looking for mentorship.', false, 2),
('Shimul', 'Rahman', 'Passionate about teaching and mentoring students in AI and Machine Learning.', true, 3),
('Moni', 'Ahmed', 'Student with a keen interest in web development.', false, 4),
('Fahim', 'Khan', 'Senior developer and mentor specializing in backend systems.', true, 5),
('Shahida', 'Chowdhury', 'Student looking for mentorship in full-stack web development.', false, 6),
('Riaz', 'Siddique', 'Experienced mentor focusing on mobile app development.', true, 7),
('Samina', 'Sultana', 'Student interested in data science and artificial intelligence.', false, 8),
('Nabil', 'Hossain', 'Mentor with experience in entrepreneurship and startup mentoring.', true, 9),
('Nisha', 'Begum', 'Student pursuing a degree in computer science.', false, 10);
 
 
-- create `Skill Table`
create table if not exists Skill (
    skill_id int auto_increment primary key,
    expertise varchar(100) not null
);
 
 
-- insert data into `Skill table`
insert into skill (expertise) values
('Java'),
('Python'),
('Machine Learning'),
('Web Development'),
('Data Science'),
('Mobile App Development'),
('AI'),
('Backend Development'),
('Full-stack Development'),
('Entrepreneurship');

-- create `User_Skill Table` to map users to skills
create table if not exists User_Skill (
	skill_id int not null,
    user_id int not null, 
    primary key(user_id, skill_id),
    foreign key (user_id) references User(user_id),
    foreign key (skill_id) references Skill(skill_id)
);


-- insert data into `User_Skill table`
insert into user_skill (user_id, skill_id) values
(1, 1), 	-- Anik is a mentor in Java
(2, 4), 	-- Tarek is a student learning Web Development
(3, 3), 	-- Shimul is a mentor in Machine Learning
(4, 4), 	-- Moni is a student learning Web Development
(5, 1), 	-- Fahim is a mentor in Java
(6, 4), 	-- Shahida is a student learning Web Development
(7, 6), 	-- Riaz is a mentor in Mobile App Development
(8, 5), 	-- Samina is a student learning Data Science
(9, 9), 	-- Nabil is a mentor in Full-stack Development
(10, 5); 	-- Nisha is a student learning Data Science

  


-- create `Mentorship Sessions Table`
create table if not exists Mentorship_Session ( 
    session_id int auto_increment primary key, 
	scheduled_time datetime not null,
    duration int not null,
    status enum('pending', 'completed', 'cancelled') default 'pending', 
    user_id int not null, 
    created_at datetime default current_timestamp, 
    foreign key (user_id) references User(user_id)
      
);

 
-- insert data into `Mentorship_Session table`
insert into mentorship_session (scheduled_time, duration, status, user_id) values
('2024-12-10 10:00:00', 60, 'pending', 1),
('2024-12-11 11:00:00', 90, 'completed', 2),
('2024-12-12 14:00:00', 120, 'cancelled', 3),
('2024-12-13 09:00:00', 60, 'pending', 4),
('2024-12-14 15:00:00', 75, 'completed', 5),
('2024-12-15 16:00:00', 90, 'pending', 6),
('2024-12-16 10:30:00', 60, 'completed', 7),
('2024-12-17 13:00:00', 120, 'pending', 8),
('2024-12-18 14:30:00', 90, 'completed', 9),
('2024-12-19 11:30:00', 60, 'cancelled', 10);

  
-- create `Payment Table` 
create table if not exists Payment (
	payment_id int auto_increment primary key,
    amount decimal(10, 2) not null,
    payment_date datetime default current_timestamp,  
    payment_status enum('paid', 'pending') default 'paid',
    transaction_type enum('Bkash', 'Nagad', 'Bank') default 'Bkash',
    user_id int not null,
    session_id int not null,
    foreign key (user_id) references User(user_id),
    foreign key (session_id) references Mentorship_Session(session_id)
);

-- insert data into `Payment table`
insert into payment (amount, payment_status, user_id, session_id, transaction_type) values
(500.00, 'paid', 2, 1, 'Bkash'),
(1000.00, 'pending', 4, 2, 'Nagad'),
(750.00, 'paid', 6, 3, 'Bank'),
(1200.00, 'paid', 8, 4, 'Bkash'),
(1500.00, 'pending', 10, 5, 'Nagad'),
(2000.00, 'paid', 3, 6, 'Bank'),
(2500.00, 'pending', 5, 7, 'Bkash'),
(3000.00, 'paid', 7, 8, 'Nagad'),
(3500.00, 'pending', 9, 9, 'Bank'),
(4000.00, 'paid', 1, 10, 'Bkash');
 

-- create `Messages Table`
create table if not exists Message ( 
    message_id int auto_increment primary key, 
    content text not null, 
    created_at datetime default current_timestamp, 
	user_id int not null, 
    foreign key (user_id) references User(user_id) 
);

-- insert data into `Message table`
insert into message (content, user_id) values
('Hello, I am looking for some guidance on Java development.', 2),
('Can you help me with Machine Learning concepts?', 4),
('I need assistance with my mobile app project.', 6),
('Let's schedule a session for web development mentorship.', 8),
('Looking forward to your feedback on my progress.', 10),
('Can you suggest resources for learning Python?', 1),
('How can I improve my skills in data science?', 3),
('I want to learn more about backend development.', 5),
('What are the best practices in mobile app development?', 7),
('Can you guide me in building a full-stack project?', 9);


-- create `Feedback Table`
create table if not exists Feedback ( 
    feedback_id int auto_increment primary key, 
    rating int check(rating >= 1 and rating <= 5), 
    comments text not null, 
    created_at datetime default current_timestamp,
	session_id int not null, 
    foreign key (session_id) references Mentorship_Session(session_id)
);
 
 
 -- insert data into `Feedback table`
 insert into feedback (rating, comments, session_id) values
(5, 'Very helpful session, got all my queries answered.', 1),
(4, 'Great advice, but need more time for the session.', 2),
(5, 'Excellent session, learned a lot about ML.', 3),
(3, 'Good session, but I expected more guidance.', 4),
(5, 'Amazing mentor, helped me clear all doubts.', 5),
(4, 'The session was good, but I would like more practical examples.', 6),
(5, 'Great session, I got a lot of insights into mobile app development.', 7),
(3, 'Good session, but I needed more details on AI implementation.', 8),
(4, 'Helpful session, but more resources would be great.', 9),
(5, 'Loved the session, learned a lot about full-stack development.', 10);


-- create `Availability Table` for mentor availability slots
create table if not exists Availability (
    availability_id int auto_increment primary key,
    user_id int not null,
    day_of_week enum ('Saturday', 'Monday') not null,
    start_time time not null ,
    end_time time not null, 
    updated_at datetime default current_timestamp on update current_timestamp, 
    foreign key (user_id) references User(user_id)  
);

 
-- insert data into `Availability table`
insert into availability (user_id, day_of_week, start_time, end_time) values
(1, 'monday', '10:00:00', '12:00:00'),
(2, 'saturday', '09:00:00', '11:00:00'),
(3, 'monday', '14:00:00', '16:00:00'),
(4, 'saturday', '13:00:00', '15:00:00'),
(5, 'monday', '09:00:00', '11:00:00'),
(6, 'saturday', '10:00:00', '12:00:00'),
(7, 'monday', '12:00:00', '14:00:00'),
(8, 'saturday', '11:00:00', '13:00:00'),
(9, 'monday', '14:00:00', '16:00:00'),
(10, 'saturday', '15:00:00', '17:00:00');

-- create `Project Table`
create table if not exists Project (
    project_id int auto_increment primary key,
    project_title varchar(255) not null,
    description text not null,
    progress_status enum('not started', 'in progress', 'completed') default 'not started' not null,
    start_date date not null,
    end_date date not null
);

-- insert data into `Project table`
insert into project (project_title, description, progress_status, start_date, end_date) values
('AI-based Chatbot', 'Developing an AI-based chatbot for customer service.', 'in progress', '2024-12-01', '2025-06-01'),
('Mobile App Development', 'Creating a mobile app for e-commerce.', 'not started', '2024-12-01', '2025-06-01'),
('Web Portal for Students', 'Building an online portal for students to access resources.', 'not started', '2024-12-01', '2025-06-01'),
('Data Science Project', 'Analyzing data for improving business processes.', 'in progress', '2024-12-01', '2025-06-01'),
('E-Commerce Website', 'Building an e-commerce website for online shopping.', 'not started', '2024-12-01', '2025-06-01'),
('Social Media App', 'Developing a social media platform.', 'completed', '2024-12-01', '2024-12-31'),
('Online Learning Platform', 'Creating an online platform for learning and mentorship.', 'in progress', '2024-12-01', '2025-06-01'),
('Fitness Tracker App', 'Building an app to track fitness goals and progress.', 'not started', '2024-12-01', '2025-06-01'),
('Smart Home Automation', 'Developing an app to control smart home devices.', 'in progress', '2024-12-01', '2025-06-01'),
('Portfolio Website', 'Creating a personal portfolio website.', 'completed', '2024-12-01', '2024-12-31');


-- create `Project_Collaboration table` 
create table if not exists Project_Collaboration( 
	project_id int not null, 
    user_id int not null, 
    primary key(project_id, user_id), 
    foreign key (project_id) references Project(project_id), 
    foreign key (user_id) references User(user_id)
); 



-- insert data into `Project_Collaboration table`
insert into project_collaboration (project_id, user_id) values
(1, 1),		 -- Anik is collaborating on the AI-based Chatbot
(2, 2), 	-- Tarek is collaborating on the Mobile App Development
(3, 3), 	-- Shimul is collaborating on the Web Portal for Students
(4, 4),		 -- Moni is collaborating on the Data Science Project
(5, 5), 	-- Fahim is collaborating on the E-Commerce Website
(6, 6), 	-- Shahida is collaborating on the Social Media App
(7, 7), 	-- Riya is collaborating on the Online Learning Platform
(8, 8), 	-- Samina is collaborating on the Fitness Tracker App
(9, 9), 	-- Nabil is collaborating on the Smart Home Automation
(10, 10); 	-- Nisha is collaborating on the Portfolio Website


-- create `Resources Table` for shared materials
create table if not exists Resource (
    resource_id int auto_increment primary key,
    resource_type enum('document', 'link', 'video', 'other') not null,
	resource_link varchar(255) not null,
    uploaded_by int not null,
    session_id int,
    project_id int, 
    created_at datetime default current_timestamp,
    foreign key (session_id) references Mentorship_Session(session_id),
    foreign key (project_id) references Project(project_id),
    foreign key (uploaded_by) references User(user_id)
); 

 
 
-- insert data into `Resource table`
insert into resource (resource_type, resource_link, uploaded_by, session_id, project_id) values
('document', 'https://www.geeksforgeeks.org/python-programming-language/', 1, 1, 1),
('link', 'https://www.w3schools.com/python/', 2, 2, 2),
('video', 'https://www.youtube.com/watch?v=rfscVS0vtbw', 3, 3, 3),
('document', 'https://www.geeksforgeeks.org/introduction-to-javascript/', 4, 4, 4),
('link', 'https://www.w3schools.com/js/', 5, 5, 5),
('video', 'https://www.youtube.com/watch?v=8bDh8ZG8r-k', 6, 6, 6),
('document', 'https://www.geeksforgeeks.org/learn-java-tutorial/', 7, 7, 7),
('link', 'https://www.w3schools.com/java/', 8, 8, 8),
('video', 'https://www.youtube.com/watch?v=grEKMHGY6Jw', 9, 9, 9),
('document', 'https://www.geeksforgeeks.org/html-tutorial/', 10, 10, 10);



-- =================================================================== 
							-- Query
-- =================================================================== 

select *from User; 
select *from profile;  
select *from feedback;  
select *from mentorship_session; 
select *from message;
select *from payment;
select *from profile;
select *from project;
select *from project_collaboration;
select *from resource;
select *from skill;
select *from user_skill;
select *from Availability; 



-- ========================================================== 
					 
-- ========================================================== 
-- 1.find the first name ends with 'A' 
select *from profile where first_name like '%A'; 

-- 2.Find How many users(Student&Mentor) are there for each role in the
select role, count(*) as Number_of_user from user 
group by role; 
 
-- 3. find the first name and last name of user whose id is not verified 
select p.first_name, p.last_name from Profile p where p.id_verified = 'False';   

-- 4.fine the user email who are expert in 'Java'  
select u.email from User u 
join User_skill us on u.user_id = us.user_id 
join skill s on s.skill_id = us.skill_id where s.expertise = 'Java';

-- 5. sort the first name of user by decending order 
select p.first_name from Profile p order by p.first_name desc;
  




