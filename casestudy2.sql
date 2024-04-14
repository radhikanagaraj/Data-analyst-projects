use project3
#weekely user engagement
select count( distinct events.user_id) weekelyuserengagement , week(events.temp_occured_at) w from events
join users on events.user_id=users.user_id
where events.event_type='engagement'
group by 2
order by 1

#user growth over time
select num_active_users,y,w,sum(num_active_users) over (order by y,w) cc from 
(select count(distinct user_id) num_active_users, year(temp_activated_at) y, 
week(temp_activated_at) w from users
group by 2,3
order by 2,3) sub

#weekely user retention
select c.sw, sum(case when c.rw=1 then 1 else 0 end)  week1retention,
sum(case when c.rw=2 then 1 else 0 end) week2retention,
sum(case when c.rw=3 then 1 else 0 end) week3retention,
sum(case when c.rw=4 then 1 else 0 end) week4retention,
sum(case when c.rw=5 then 1 else 0 end) week5retention,
sum(case when c.rw=6 then 1 else 0 end) week6retention,
sum(case when c.rw=7 then 1 else 0 end) week7retention,
sum(case when c.rw=8 then 1 else 0 end) week8retention
from
(select  a.user_id, a.sw, b.ew, b.ew-a.sw rw from
((select user_id, min(week(temp_occured_at)) sw from events
where event_type='signup_flow' and event_name='complete_signup' group by 1
order by 2) a
join (select user_id, week(temp_occured_at) ew from events
where event_type='engagement' group by 1,2
order by 2) b
on a.user_id=b.user_id)) c
group by c.sw
order by c.sw

#weekely user engagement per device
select count(distinct events.user_id) countofusers,
extract(week from temp_occured_at) week, device from events
where events.event_type='engagement'
group by 3,2
order by 1 desc

 #email engagement oprn rate
 select ((select count(*) from email_events where action='email_open')/
 (select count(*) from email_events where action='sent_weekly_digest'))*100 as emailopenrate

#email engagement CTR
 select ((select count(*) from email_events where action='email_clickthrough')/
 (select count(*) from email_events where action='sent_weekly_digest'))*100 as clickthroughrate

#email engagement rengagement rate
 select ((select count(*) from email_events where action='sent_reengagement_email')/
 (select count(*) from email_events where action='sent_weekly_digest'))*100 as reengagementrate





