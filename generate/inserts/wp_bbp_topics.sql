/* Update last_reply_id, last_active_id */
UPDATE wp_bbp_topics t
LEFT JOIN (
    SELECT t.topic_id, MAX(p.ID) AS last_reply_id
    FROM wp_bbp_topics t
    INNER JOIN wp_posts p ON p.post_parent = t.topic_id AND p.post_type = 'reply'
    WHERE p.post_status IN ('publish')
    GROUP BY t.topic_id) r ON t.topic_id = r.topic_id 
SET t.last_reply_id = r.last_reply_id, t.last_active_id = r.last_reply_id;

/* Update last_active_id if it is 0 */
UPDATE wp_bbp_topics t
SET t.last_active_id = t.topic_id
WHERE t.last_active_id = 0;

/* Update last_active_time */
UPDATE wp_bbp_topics t
INNER JOIN wp_posts p ON p.ID = t.last_active_id
SET t.last_active_time = p.post_date;

/* Update reply_count */
UPDATE wp_bbp_topics o INNER JOIN (
    SELECT t.topic_id, COUNT(r.reply_id) AS reply_count FROM wp_bbp_topics t
    INNER JOIN wp_bbp_replies r ON t.topic_id = r.topic_id
    INNER JOIN wp_posts p ON p.ID = r.reply_id
    WHERE p.post_status IN ('publish')
    GROUP BY t.topic_id) r ON r.topic_id = o.topic_id
SET o.reply_count = r.reply_count;

/* Update reply_count_hidden */
UPDATE wp_bbp_topics o INNER JOIN (
    SELECT t.topic_id, COUNT(r.reply_id) AS reply_count_hidden FROM wp_bbp_topics t
    INNER JOIN wp_bbp_replies r ON t.topic_id = r.topic_id
    INNER JOIN wp_posts p ON p.ID = r.reply_id
    WHERE p.post_status IN ('trash', 'spam', 'pedning')
    GROUP BY t.topic_id) r ON r.topic_id = o.topic_id
SET o.reply_count_hidden = r.reply_count_hidden;

/* Update voices. Engagement table must be populated before this query */
UPDATE wp_bbp_topics t INNER JOIN (
    SELECT topic_id, COUNT(user_id) AS voices 
    FROM wp_bbp_engaged_topics
    GROUP BY topic_id) e ON e.topic_id = t.topic_id
SET t.voice_count = e.voices;
