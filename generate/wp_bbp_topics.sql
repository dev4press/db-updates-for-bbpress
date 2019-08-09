/* Insert initial topic/forum combinations */
INSERT INTO wp_bbp_topics (`topic_id`, `forum_id`) ( 
SELECT
    t.ID AS topic_id,
    f.ID AS forum_id
FROM wp_posts t 
INNER JOIN wp_posts f ON f.ID = t.post_parent AND f.post_type = 'forum'
WHERE t.post_type = 'topic');

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

