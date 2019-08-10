/* Insert all users data */
INSERT INTO wp_bbp_users
SELECT 
    p.post_author AS user_id,
    IF (r.first_reply_date IS NULL || t.first_topic_date <= r.last_reply_date, t.first_topic_date, r.first_reply_date) AS first_posted,
    IF (r.last_reply_date IS NULL || t.last_topic_date >= r.last_reply_date, t.last_topic_date, r.last_reply_date) AS last_posted,
    IF (u.last_active IS NULL, '0000-00-00 00:00:00', FROM_UNIXTIME(u.last_active, '%Y-%d-%m %H:%i:%s')) AS last_active,
    IF (t.topic_count IS NULL, 0, t.topic_count) AS topic_count,
    IF (r.reply_count IS NULL, 0, r.reply_count) AS reply_count
FROM (SELECT DISTINCT post_author 
    FROM wp_posts 
    WHERE post_type IN ('topic', 'reply') AND post_status IN ('publish', 'closed')) p
LEFT JOIN (SELECT post_author AS user_id, COUNT(ID) AS topic_count, MAX(post_date) AS last_topic_date, MIN(post_date) AS first_topic_date
    FROM wp_posts
    WHERE post_type = 'topic' AND post_status IN ('publish', 'closed')
    GROUP BY post_author) t ON t.user_id = p.post_author
LEFT JOIN (SELECT post_author AS user_id, COUNT(ID) AS reply_count, MAX(post_date) AS last_reply_date, MIN(post_date) AS first_reply_date
    FROM wp_posts
    WHERE post_type = 'reply' AND post_status IN ('publish')
    GROUP BY post_author) r ON r.user_id = p.post_author
LEFT JOIN (SELECT user_id, MAX(meta_value) AS last_active
    FROM wp_usermeta WHERE meta_key = 'wp_bbp_last_activity'
    GROUP BY user_id) u ON u.user_id = p.post_author
