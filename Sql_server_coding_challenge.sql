-- 1. Provide a SQL script that initializes the database for the Job Board scenario “CareerHub”.  
CREATE DATABASE CareerHub

USE CareerHub

--2. Create tables for Companies, Jobs, Applicants and Applications.  
--3. Define appropriate primary keys, foreign keys, and constraints.  
--4. Ensure the script handles potential errors, such as if the database or tables already exist. 

-- Create the Companies table
CREATE TABLE Companies (
    CompanyID INT PRIMARY KEY IDENTITY(1,1),
    CompanyName VARCHAR(255) NOT NULL,
    Location VARCHAR(255)
)

-- Create the Jobs table
CREATE TABLE Jobs (
    JobID INT PRIMARY KEY IDENTITY(1,1),
    CompanyID INT FOREIGN KEY REFERENCES Companies(CompanyID),
    JobTitle VARCHAR(255) NOT NULL,
    JobDescription TEXT,
    JobLocation VARCHAR(255),
    Salary DECIMAL(18,2),
    JobType VARCHAR(50),
    PostedDate DATETIME DEFAULT GETDATE()
)

-- Create the Applicants table
CREATE TABLE Applicants (
    ApplicantID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Phone VARCHAR(20),
    Resume TEXT
)

-- Create the Applications table
CREATE TABLE Applications (
    ApplicationID INT PRIMARY KEY IDENTITY(1,1),
    JobID INT FOREIGN KEY REFERENCES Jobs(JobID),
    ApplicantID INT FOREIGN KEY REFERENCES Applicants(ApplicantID),
    ApplicationDate DATETIME DEFAULT GETDATE(),
    CoverLetter TEXT
)

-- Inserting data into the table
-- Insert sample data into Companies table
INSERT INTO Companies (CompanyName, Location)
VALUES
('Tata Consultancy Services', 'Mumbai'),
('Infosys', 'Bengaluru'),
('Wipro', 'Bengaluru'),
('HCL Technologies', 'Noida'),
('Tech Mahindra', 'Pune'),
('Reliance Industries', 'Mumbai'),
('Larsen & Toubro', 'Mumbai'),
('Bharti Airtel', 'New Delhi'),
('HDFC Bank', 'Mumbai'),
('ICICI Bank', 'Mumbai')

select * from Companies

-- Insert sample data into Jobs table
INSERT INTO Jobs (CompanyID, JobTitle, JobDescription, JobLocation, Salary, JobType, PostedDate)
VALUES
(1, 'Software Developer', 'Develop and maintain software applications.', 'Mumbai', 800000, 'Full-time', '2024-09-01'),
(1, 'Data Analyst', 'Analyze large datasets to extract actionable insights.', 'Mumbai', 700000, 'Full-time', '2024-09-10'),
(2, 'System Engineer', 'Work on the development and support of IT systems.', 'Bengaluru', 600000, 'Full-time', '2024-09-12'),
(3, 'Project Manager', 'Oversee IT projects from start to finish.', 'Bengaluru', 1200000, 'Full-time', '2024-09-15'),
(4, 'Network Engineer', 'Maintain and optimize network infrastructure.', 'Noida', 900000, 'Full-time', '2024-09-20'),
(5, 'Cloud Architect', 'Design and manage cloud infrastructure.', 'Pune', 1500000, 'Full-time', '2024-09-22'),
(6, 'Marketing Manager', 'Lead the marketing team and strategies.', 'Mumbai', 1100000, 'Full-time', '2024-09-25'),
(7, 'Civil Engineer', 'Plan and oversee construction projects.', 'Mumbai', 850000, 'Full-time', '2024-09-28'),
(8, 'Sales Executive', 'Handle sales and client relationships.', 'New Delhi', 500000, 'Full-time', '2024-09-30'),
(9, 'Banking Analyst', 'Analyze financial transactions and trends.', 'Mumbai', 950000, 'Full-time', '2024-09-05')

-- Insert sample data into Applicants table
INSERT INTO Applicants (FirstName, LastName, Email, Phone, Resume)
VALUES
('Amit', 'Sharma', 'amit.sharma@gmail.com', '9876543210', 'Experienced software developer.'),
('Priya', 'Verma', 'priya.verma@gmail.com', '9823456710', 'Expert in data analysis and visualization.'),
('Rohit', 'Singh', 'rohit.singh@gmail.com', '9912345678', 'Certified network engineer with 5 years of experience.'),
('Nisha', 'Patel', 'nisha.patel@gmail.com', '9123456789', 'Civil engineer with expertise in infrastructure development.'),
('Vikas', 'Kumar', 'vikas.kumar@gmail.com', '9874561230', 'Marketing manager with a track record of successful campaigns.'),
('Anjali', 'Mehta', 'anjali.mehta@gmail.com', '9987456123', 'Cloud architect with 7 years of experience in AWS.'),
('Rahul', 'Joshi', 'rahul.joshi@gmail.com', '9876523410', 'Banking analyst with expertise in risk management.'),
('Sonia', 'Kapoor', 'sonia.kapoor@gmail.com', '9987563412', 'Experienced project manager in IT services.'),
('Manoj', 'Bajpai', 'manoj.bajpai@gmail.com', '9872341234', 'Sales executive with strong communication skills.'),
('Meera', 'Gupta', 'meera.gupta@gmail.com', '9812341234', 'System engineer with expertise in IT systems.')

-- Insert sample data into Applications table
INSERT INTO Applications (JobID, ApplicantID, ApplicationDate, CoverLetter)
VALUES
(1, 1, '2024-09-02', 'I am an experienced software developer looking to join your team.'),
(2, 2, '2024-09-12', 'I have expertise in data analysis and am excited about this role.'),
(4, 3, '2024-09-15', 'I have 5 years of experience in network management.'),
(8, 9, '2024-09-30', 'I have strong sales experience and am eager to contribute.'),
(5, 6, '2024-09-25', 'As a cloud architect, I have managed large-scale cloud projects.'),
(9, 7, '2024-09-05', 'I have deep experience in financial analysis and banking trends.'),
(3, 8, '2024-09-16', 'With 10 years of experience in IT project management, I am well-suited for this role.'),
(6, 5, '2024-09-26', 'I have a proven record of leading successful marketing strategies.'),
(7, 4, '2024-09-28', 'My civil engineering skills will be beneficial to your projects.'),
(2, 10, '2024-09-13', 'I have extensive experience in systems engineering and support.')

-- 5. Write an SQL query to count the number of applications received for each job listing in the 
--"Jobs" table. Display the job title and the corresponding application count. Ensure that it lists all 
--jobs, even if they have no applications. 


SELECT j.JobTitle, COUNT(a.ApplicationID) AS ApplicationCount
FROM Jobs j LEFT JOIN Applications a ON j.JobID = a.JobID
GROUP BY j.JobTitle


--6. Develop an SQL query that retrieves job listings from the "Jobs" table within a specified salary 
--range. Allow parameters for the minimum and maximum salary values. Display the job title, 
--company name, location, and salary for each matching job. 

SELECT j.JobTitle, c.CompanyName, j.JobLocation, j.Salary
FROM Jobs j JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE j.Salary BETWEEN 500000 AND 1000000

-- 7. Write an SQL query that retrieves the job application history for a specific applicant. Allow a 
-- parameter for the ApplicantID, and return a result set with the job titles, company names, and 
-- application dates for all the jobs the applicant has applied to. 

SELECT j.JobTitle, c.CompanyName, a.ApplicationDate
FROM Applications a JOIN Jobs j ON a.JobID = j.JobID JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE a.ApplicantID = 5
ORDER BY a.ApplicationDate DESC

--8. Create an SQL query that calculates and displays the average salary offered by all companies for 
-- job listings in the "Jobs" table. Ensure that the query filters out jobs with a salary of zero. 

SELECT AVG(Salary) AS AverageSalary
FROM Jobs WHERE Salary > 0

--9. Write an SQL query to identify the company that has posted the most job listings. Display the 
--company name along with the count of job listings they have posted. Handle ties if multiple 
--companies have the same maximum count.

SELECT c.CompanyName, COUNT(j.JobID) AS JobCount
FROM Companies c JOIN Jobs j ON c.CompanyID = j.CompanyID
GROUP BY c.CompanyName
HAVING COUNT(j.JobID) = (
    SELECT MAX(JobCount)
    FROM (
        SELECT COUNT(j.JobID) AS JobCount
        FROM Jobs j
        GROUP BY j.CompanyID
    ) AS MaxJobCounts
)


--10. Find the applicants who have applied for positions in companies located in 'CityX' and have at 
--least 3 years of experience. 

-- add a column Experience into the Applicants table

ALTER TABLE Applicants
ADD ExperienceYears INT

-- insert the values into the ExperienceYears Column

SELECT a.FirstName, a.LastName, a.Email, a.Phone, a.ExperienceYears
FROM Applicants a
JOIN Applications ap ON a.ApplicantID = ap.ApplicantID
JOIN Jobs j ON ap.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE c.Location = 'Mumbai'
AND a.ExperienceYears >= 3

-- 11. Retrieve a list of distinct job titles with salaries between 60,0000 INR and 80,0000 INR. 
-- replaced $ with INR

SELECT DISTINCT JobTitle
FROM Jobs WHERE Salary BETWEEN 600000 AND 800000

--12. Find the jobs that have not received any applications. 

SELECT j.JobID, j.JobTitle, j.CompanyID, j.JobLocation, j.Salary
FROM Jobs j LEFT JOIN Applications a ON j.JobID = a.JobID
WHERE a.ApplicationID IS NULL


--13. Retrieve a list of job applicants along with the companies they have applied to and the positions 
--they have applied for. 

SELECT a.FirstName, a.LastName, c.CompanyName, j.JobTitle
FROM Applicants a JOIN Applications ap ON a.ApplicantID = ap.ApplicantID 
JOIN Jobs j ON ap.JobID = j.JobID 
JOIN Companies c ON j.CompanyID = c.CompanyID



-- 14. Retrieve a list of companies along with the count of jobs they have posted, even if they have not 
-- received any applications. 

SELECT c.CompanyName, COUNT(j.JobID) AS JobCount
FROM Companies c LEFT JOIN Jobs j ON c.CompanyID = j.CompanyID
GROUP BY c.CompanyName


-- 15. List all applicants along with the companies and positions they have applied for, including those 
-- who have not applied. 

SELECT a.FirstName, a.LastName, COALESCE(c.CompanyName, 'No Applications') AS CompanyName, COALESCE(j.JobTitle, 'No Applications') AS JobTitle
FROM Applicants a LEFT JOIN Applications ap ON a.ApplicantID = ap.ApplicantID 
LEFT JOIN Jobs j ON ap.JobID = j.JobID 
LEFT JOIN Companies c ON j.CompanyID = c.CompanyID



-- 16. Find companies that have posted jobs with a salary higher than the average salary of all jobs. 

SELECT DISTINCT c.CompanyName
FROM Companies c JOIN Jobs j ON c.CompanyID = j.CompanyID 
WHERE j.Salary > (SELECT AVG(Salary) FROM Jobs)


--17 . Display a list of applicants with their names and a concatenated string of their city and state. 
-- add colums names City and State to the applicants table 

ALTER TABLE Applicants
ADD City VARCHAR(100),
    State VARCHAR(100)

-- add the data to those columns

SELECT a.FirstName, a.LastName, CONCAT(a.City, ', ', a.State) AS Location
FROM Applicants a


-- 18. Retrieve a list of jobs with titles containing either 'Developer' or 'Engineer'. 

SELECT JobID, JobTitle, CompanyID, JobDescription, JobLocation, Salary, JobType, PostedDate
FROM Jobs
WHERE JobTitle LIKE '%Developer%' OR JobTitle LIKE '%Engineer%'


--19. Retrieve a list of applicants and the jobs they have applied for, including those who have not 
-- applied and jobs without applicants. 

SELECT a.ApplicantID, a.FirstName, a.LastName, COALESCE(j.JobTitle, 'No Job Applied') AS JobTitle, COALESCE(c.CompanyName, 'No Company') AS CompanyName
FROM Applicants a LEFT JOIN Applications ap ON a.ApplicantID = ap.ApplicantID 
LEFT JOIN Jobs j ON ap.JobID = j.JobID 
LEFT JOIN Companies c ON j.CompanyID = c.CompanyID
ORDER BY a.ApplicantID



--20 List all combinations of applicants and companies where the company is in a specific city and the 
-- applicant has more than 2 years of experience. For example: city=Chennai

SELECT a.ApplicantID, a.FirstName, a.LastName, c.CompanyName, c.Location
FROM Applicants a JOIN Applications ap ON a.ApplicantID = ap.ApplicantID 
JOIN Jobs j ON ap.JobID = j.JobID 
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE c.Location = 'Mumbai' AND a.ExperienceYears > 2

