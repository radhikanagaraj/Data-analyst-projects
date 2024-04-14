#create table design 
create table job_data(
ds	Date,
job_id int,
actor_id int,
event varchar(100),
language varchar(100),
time_spent int,
org varchar(100))

#add values into the table
insert into job_data(ds,job_id,actor_id,event,language,time_spent,org)
values(
'2020-11-30',21,1001,'skip','English',15,'A'),
('2020-11-30',22,1006,'transfer','Arabic',25,'B'),
('2020-11-29',23,1003,'decision','Persian',20,'C'),
('2020-11-28',23,1005,'transfer','Persian',22,'D'),
('2020-11-28',25,1002,'decision','Hindi',11,'B'),
('2020-11-27',11,1007,'decision','French',104,'D'),
('2020-11-26',23,1004,'skip','Persian',56,'A'),
('2020-11-25',20,1003,'transfer','Italian',45,'C')

select * from job_data

#jobs reviewed over time
select count(job_id)/24 jobsperhour, ds
from job_data
group by 2

#Throughput Analysis
select ds, eventspersecond, 
avg(eventspersecond) over(order by ds rows between 6 preceding and current row) 7dayrolling_average from
(select  count(event)/sum(time_spent) eventspersecond, ds
from job_data
group by 2
order by 2) a

#percentage wise language share
select language, count(language)/(select count(*) a from job_data)*100 p 
from job_data group by language

#to dind duplicate rows
SELECT *
FROM job_data
WHERE (ds, job_id, actor_id, event, language, time_spent, org) IN (
    SELECT ds, job_id, actor_id, event, language, time_spent, org
    FROM job_data
    GROUP BY ds, job_id, actor_id, event, language, time_spent, org
    HAVING COUNT(*) > 1)





