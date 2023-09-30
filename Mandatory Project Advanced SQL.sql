-- Mandatory project assignment
-- 1.How many times does the average user post?
select avg(user_id) from photos;

-- 2.Find the top 5 most used hashtags.
SELECT tag_id,COUNT(tag_id) as MostUsedTags FROM Photo_tags 
GROUP BY tag_id order by MostUsedTags DESC LIMIT 5;

-- 3.Find users who have liked every single photo on the site.
select username,photos.image_url,photo_id,count(*)
 from likes 
 join photos on photos.id=likes.photo_id 
 join users on users.id=likes.user_id
 group by photo_id,username,photos.image_url order by count(*) 

-- 4.Retrieve a list of users along with their usernames and the rank of their account creation, ordered by the creation date in ascending order.
select username, Rank() over (order by created_at ASC) as creation_date from users

-- 5.List the comments made on photos with their comment texts, photo URLs, and usernames of users who posted the comments. Include the comment count for each photo

SELECT users.username,comment_text,image_url,count(*)
FROM users
JOIN photos ON users.id = photos.user_id
join comments on photos.user_id=comments.user_id
GROUP BY users.id,comments.comment_text,photos.image_url order by count(*);

-- 6.For each tag, show the tag name and the number of photos associated with that tag. Rank the tags by the number of photos in descending order.
select tags.tag_name,count(*) 
from tags
join photo_tags ON tags.id = photo_tags.tag_id
group by tags.id
order by count(*) desc

-- 7.List the usernames of users who have posted photos along with the count of photos they have posted. Rank them by the number of photos in descending order.
SELECT users.username,COUNT(photos.image_url)
FROM users
JOIN photos ON users.id = photos.user_id
GROUP BY users.id
order by count(photos.image_url) desc;

-- 8.Display the username of each user along with the creation date of their first posted photo and the creation date of their next posted photo.

select username,photos.created_at, lead(photos.created_at) over (partition by username) as creation_date
 from users join photos on users.id=photos.user_id 

-- 9.For each comment, show the comment text, the username of the commenter, and the comment text of the previous comment made on the same photo.

SELECT users.username,comment_text,image_url,
LAG(comment_text) over (partition by username) as previous_comment
FROM users
JOIN photos ON users.id = photos.user_id
join comments on photos.user_id=comments.user_id;

-- 10.Show the username of each user along with the number of photos they have posted and the number of photos posted by the user before them and after them, based on the creation date.

 select username,count(image_url) ,photos.created_at,lag(count(image_url)) over (partition by created_at) as after
 from users join photos on users.id=photos.user_id group by username,photos.created_at