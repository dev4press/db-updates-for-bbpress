/* Update last_active_id */
UPDATE wp_bbp_forums f 
SET f.last_active_id = GREATEST(last_topic_id, last_reply_id);

/* Update last_active_time */
UPDATE wp_bbp_forums f
INNER JOIN wp_posts p ON p.ID = f.last_active_id
SET f.last_active_time = p.post_date;
