# hw7-ddl.sql

## DO NOT RENAME OR OTHERWISE CHANGE THE SECTION TITLES OR ORDER.
## The autograder will look for specific code sections. If it can't find them, you'll get a "0"

# Code specifications.
# 0. Where there a conflict between the problem statement in the google doc and this file, this file wins.
# 1. Complete all sections below.
# 2. Table names must MATCH EXACTLY to schemas provided.
# 3. Define primary keys in each table as appropriate.
# 4. Define foreign keys connecting tables as appropriate.
# 5. Assign ID to skills, people, roles manually (you must pick the ID number!)
# 6. Assign ID in the peopleskills and peopleroles automatically (use auto_increment)
# 7. Data types: ONLY use "int", "varchar(255)", "varchar(4096)" or "date" as appropriate.

# Section 1
# Drops all tables.  This section should be amended as new tables are added.

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS peopleskills;
DROP TABLE IF EXISTS peopleroles;
DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS roles;
# ... 
SET FOREIGN_KEY_CHECKS=1;

# Section 2
# Create skills( id,name, description, tag, url, time_commitment)
# ID, name, description and tag cannot be NULL. Other fields can default to NULL.
# tag is a skill category grouping.  You can assign it based on your skill descriptions.
# time committment offers some sense of how much time was required (or will be required) to gain the skill.
# You can assign the skill descriptions.  Please be creative!

CREATE TABLE skills(
    skills_id int not null,
    skills_name varchar(255) not null,
    skills_description varchar(255) not null,
    skills_tag varchar(255) not null,
    skills_url varchar(255),
    skills_time_commitment int,
    PRIMARY KEY (skills_id)
);

# Section 3
# Populate skills
# Populates the skills table with eight skills, their tag fields must exactly contain “Skill 1”, “Skill 2”, etc.
# You can assign skill names.  Please be creative!

insert into skills(skills_id, skills_name, skills_description, skills_tag) values
(1,'Googling','Incredible googler!','Skill 1'),
(2,'Python coding','Can write in python well','Skill 2'),
(3,'Java coding','I love writing public static void main string args','Skill 3'),
(4,'C++ coding','Enjoys segfaults','Skill 4'),
(5,'C# coding','Good at making games','Skill 5'),
(6,'Javascript coding','Javascript supremacy','Skill 6'),
(7,'HTML enthusiast','Loves <div>s','Skill 7'),
(8,'CSS enjoyer','Incredible with CSS for some reason','Skill 8');

# Section 4
# Create people( id,first_name, last_name, email, linkedin_url, headshot_url, discord_handle, brief_bio, date_joined)
# ID cannot be null, Last name cannot be null, date joined cannot be NULL.
# All other fields can default to NULL.

CREATE TABLE people (
    people_id int not null,
    people_first_name varchar(256),
    people_email varchar(256),
    people_linkedin_url varchar(256),
    people_headshot_url varchar(256),
    people_discord_handle varchar(256),
    people_brief_bio varchar(4096),
    people_date_joined date not null,
    people_last_name varchar(256) NOT NULL,
    PRIMARY KEY (people_id)
);

# Section 5
# Populate people with six people.
# Their last names must exactly be “Person 1”, “Person 2”, etc.
# Other fields are for you to assign.

insert into people (people_id,people_first_name,people_last_name,people_date_joined, people_email) values 
(1,'Austin','Person 1','2021-09-01','Austin@gmail.com'),
(2,'John','Person 2','2021-09-01','John@gmail.com'),
(3,'James','Person 3','2021-09-01','James@gmail.com'),
(4,'Noah','Person 4','2021-09-01','Noah@gmail.com'),
(5,'Joe','Person 5','2021-09-01','Joe@gmail.com'),
(6,'Chad','Person 6','2021-09-01','Chad@gmail.com'),
(7,'Mike','Person 7','2021-09-01','Mike@gmail.com'),
(8,'Larry','Person 8','2021-09-01','Larry@gmail.com'),
(9,'Patrick','Person 9','2021-09-01','Patrick@gmail.com'),
(10,'Eugeine','Person 10','2021-09-01','Eugeine@gmail.com');

select * from people;

# Section 6
# Create peopleskills( id, skills_id, people_id, date_acquired )
# None of the fields can ba NULL. ID can be auto_increment.

CREATE TABLE peopleskills(
    id int  auto_increment,
    skills_id int,
    people_id int,
    date_acquired date not null default (current_date),
    PRIMARY KEY (id),
    FOREIGN KEY (skills_id) REFERENCES skills(skills_id) on delete cascade,
    FOREIGN KEY (people_id) REFERENCES people(people_id) on delete cascade,
    unique (skills_id, people_id)
);

# Section 7
# Populate peopleskills such that:
# Person 1 has skills 1,3,6;
# Person 2 has skills 3,4,5;
# Person 3 has skills 1,5;
# Person 4 has no skills;
# Person 5 has skills 3,6;
# Person 6 has skills 2,3,4;
# Person 7 has skills 3,5,6;
# Person 8 has skills 1,3,5,6;
# Person 9 has skills 2,5,6;
# Person 10 has skills 1,4,5;
# Note that no one has yet acquired skills 7 and 8.

insert into peopleskills(people_id, skills_id) values
(1,1),(1,3),(1,6),
(2,3),(2,4),(2,5),
(3,1),(3,5),
(5,3),(5,6),
(6,2),(6,3),(6,4),
(7,3),(7,5),(7,6),
(8,1),(8,3),(8,5),(8,6),
(9,2),(9,5),(9,6),
(10,1),(10,4),(10,5);

# Section 8
# Create roles( id, name, sort_priority )
# sort_priority is an integer and is used to provide an order for sorting roles

CREATE TABLE roles(
    roles_id int not null,
    roles_name varchar(255) not null,
    roles_sort_priority int not null,
    PRIMARY KEY (roles_id)
);

# Section 9
# Populate roles
# Designer, Developer, Recruit, Team Lead, Boss, Mentor
# Sort priority is assigned numerically in the order listed above (Designer=10, Developer=20, Recruit=30, etc.)

insert into roles(roles_id, roles_name, roles_sort_priority) values
(1,'Designer',10),
(2,'Developer',20),
(3,'Recruit',30),
(4,'Team Lead',40),
(5,'Boss',50),
(6,'Mentor',60);

# Section 10
# Create peopleroles( id, people_id, role_id, date_assigned )
# None of the fields can be null.  ID can be auto_increment

CREATE TABLE peopleroles(
    id int auto_increment,
    people_id int not null,
    roles_id int not null,
    date_assigned date not null default (current_date),
    PRIMARY KEY (id),
    FOREIGN KEY (people_id) REFERENCES people(people_id) on delete cascade,
    FOREIGN KEY (roles_id) REFERENCES roles(roles_id) on delete cascade,
    unique (people_id, roles_id)
);

# Section 11
# Populate peopleroles
# Person 1 is Developer 
# Person 2 is Boss, Mentor
# Person 3 is Developer and Team Lead
# Person 4 is Recruit
# person 5 is Recruit
# Person 6 is Developer and Designer
# Person 7 is Designer
# Person 8 is Designer and Team Lead
# Person 9 is Developer
# Person 10 is Developer and Designer

insert into peopleroles(people_id, roles_id) values
(1,2),
(2,5),(2,6),
(3,2),(3,4),
(4,3),
(5,3),
(6,1),(6,2),
(7,1),
(8,1),(8,4),
(9,2),
(10,1),(10,2);

#SAMPLE QUERIES

# List skill names, tags, and descriptions ordered by name

select skills_name, skills_tag, skills_description from skills order by skills_name;

# List people names and email addresses ordered by last_name

select people_first_name, people_last_name, people_email from people order by people_last_name;

# List skill names of Person 1

select skills_name from peopleskills join skills on peopleskills.skills_id = skills.skills_id where people_id = 1;

# List people names with Skill 6

select people_first_name, people_last_name
from 
    peopleskills join people on peopleskills.people_id = people.people_id 
    join skills on peopleskills.skills_id = skills.skills_id 
where
    peopleskills.skills_id = 6;

# List people with a DEVELOPER role

select people_first_name, people_last_name 
from 
    peopleroles join people on peopleroles.people_id = people.people_id 
    join roles on peopleroles.roles_id = roles.roles_id 
where 
    roles_name = 'Developer';

# List names and email addresses of people without skills

select people_first_name, people_last_name, people_email
from 
    people left join peopleskills on people.people_id = peopleskills.people_id 
where 
    peopleskills.people_id is null;

# List names and tags of unused skills

select skills_name, skills_tag
from 
    skills left join peopleskills on skills.skills_id = peopleskills.skills_id 
where 
    peopleskills.skills_id is null;

# List people names and skill names with the BOSS role

select people_first_name, people_last_name, skills_name
from 
    peopleroles join people on peopleroles.people_id = people.people_id 
    join roles on peopleroles.roles_id = roles.roles_id 
    join peopleskills on people.people_id = peopleskills.people_id 
    join skills on peopleskills.skills_id = skills.skills_id 
where 
    roles_name = 'Boss';

# List ids and names of unused roles

select roles.roles_id, roles_name
from 
    roles left join peopleroles on roles.roles_id = peopleroles.roles_id 
where 
    peopleroles.roles_id is null;