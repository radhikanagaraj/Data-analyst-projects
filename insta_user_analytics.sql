#loyal user reward(top 5 oldest users )
select * from users
order by created_at
limit 5

#inactive user engagement(users who have not posted single photo)
select username from users u 
left join photos p 
on u.id = p.user_id
where p.id is null

#user with most no of likes on a single photo
select * from photos
join (select photo_id, count(likes.created_at) a from likes
group by 1
order by 2 desc) sub
on photos.id = sub.photo_id
order by sub.a desc

#most frequently used hashtag
select count(tag_name) a, tag_name from tags t
join photo_tags p on t.id=p.tag_id
group by t.tag_name
order by a desc
limit 5

#weekely user registration
select dayname(created_at) d, count(id) from users
group by d
order by count(id) desc

#average no of posts per user on instagram using inner join
select avg(s.averageposts) averagepostsperuser from
(select count(p.id) as averageposts,u.id from photos p
join users u
on p.user_id = u.id
group by u.id) s

#average no of posts per user on instagram using right join
select avg(s.averageposts) averagepostsperuser from
(select count(p.id) as averageposts,u.id from photos p
right join users u
on p.user_id = u.id 
group by u.id) s

#total number of photos on Instagram divided by the total number of users
select (select count(*) from photos)/(select count(*) from users) as avg

#bots and fake account
select u.username, count(*) as n_likes
from users u
join likes l on u.id=l.user_id
group by u.id
having n_likes = (select count(*) from photos)

#fake accounts by joining the above query and (
#inactive user engagement(users who have not posted single photo))
select a.username,b.username
from(select u.username, count(*) as n_likes
from users u
join likes l on u.id=l.user_id
group by u.id
having n_likes=(select count(*) from photos)) a,
(select username from users u 
left join photos p 
on u.id = p.user_id
where p.id is null) b 
where a.username = b.username

#no of users registered over the years
select year(created_at) y, count(id) c from users
group by y
order by y

#top 5 users with highest followers
select username, count(follower_id), followee_id from follows
join users on follows.followee_id=users.id
group by followee_id
order by 2 desc
limit 5

#users with photos having most comments
select username, photos.id, count(comments.comment_text) from photos
join users on photos.user_id=users.id
join comments on photos.id=comments.photo_id
group by photos.id
order by 3 desc

#users who have posted highest no of photos
select u.username, count(p.id) c
from users u
join photos p
on u.id=p.user_id
group by u.id
order by c desc
limit 5

/*to see if the users with highest photo uploads had highest follower count as well 
 by joining queries “top five users who have posted most photos” and “top users with 
 highest followers”*/
select b.username, b.fc, b.followee_id, a.username,a.c,a.id
from (select username, count(follower_id) fc, followee_id from follows
join users on follows.followee_id=users.id
group by followee_id
order by 2) b
inner join (select u.username,u.id,count(p.id) c
from users u
join photos p
on u.id=p.user_id
group by u.id
order by c desc) a 
on b.username=a.username
order by a.c desc



