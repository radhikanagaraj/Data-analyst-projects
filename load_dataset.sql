#use the database u want to work with
use project3


 #create table design for users
 create table users( 
 user_id int,
 created_at varchar(100),
 company_id int,
 language varchar(50),
 activated_at varchar(100),
 state varchar(100))
 
#to find the path of dataset file
show variables like 'secure_file_priv'
#C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\
 
 # load the dataset into table
 lOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users.csv"
 INTO TABLE users
 FIELDS TERMINATED BY ','
 ENCLOSED BY '"'
 LINES TERMINATED BY '\n'
 IGNORE 1 ROWS
 
select * from users 

# change datatype of  created_at column into datetime
alter table users add temp_created_at datetime
SET SQL_SAFE_UPDATES = 0;
update users set temp_created_at= STR_TO_DATE(created_at,'%d-%m-%Y %H:%i:%s');
SET SQL_SAFE_UPDATES = 1;

#drop the old column
alter table users drop column created_at

# change datatype of  activated_at column into datetime
alter table users add temp_activated_at datetime
SET SQL_SAFE_UPDATES = 0;
update users set temp_activated_at= STR_TO_DATE(activated_at,'%d-%m-%Y %H:%i:%s');
SET SQL_SAFE_UPDATES = 1;

#drop the old column
alter table users drop column activated_at

#create table design for events
create table events( 
 user_id int,
 occured_at varchar(100),
 event_type varchar(100),
 event_name varchar(100),
 location varchar(50),
 device varchar(100),
 user_type int)
 
 #C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\
 
# load the dataset into table
 lOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/events.csv"
 INTO TABLE events
 FIELDS TERMINATED BY ','
 ENCLOSED BY '"'
 LINES TERMINATED BY '\n'
 IGNORE 1 ROWS;
select * from events


# change datatype of  occurred_at column into datetime
alter table events add temp_occured_at datetime
SET SQL_SAFE_UPDATES = 0;
update events set temp_occured_at= STR_TO_DATE(occured_at,'%d-%m-%Y %H:%i');
SET SQL_SAFE_UPDATES = 1;

#drop the old column
alter table events drop column occured_at

#create table design for email_events
create table email_events( 
 user_id int,
 occured_at varchar(100),
 action varchar(100),
 user_type int)

# load the dataset into table
 lOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/email_events.csv"
 INTO TABLE email_events
 FIELDS TERMINATED BY ','
 ENCLOSED BY '"'
 LINES TERMINATED BY '\n'
 IGNORE 1 ROWS

# change datatype of  occurred_at column into datetime
alter table email_events add temp_occured_at datetime
update email_events set temp_occured_at= STR_TO_DATE(occured_at,'%d-%m-%Y %H:%i')

#drop the old column
alter table email_events drop column occured_at