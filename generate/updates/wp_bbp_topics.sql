/* Insert initial topic/forum combinations */
INSERT INTO wp_bbp_topics (`topic_id`, `forum_id`) ( 
SELECT
    t.ID AS topic_id,
    f.ID AS forum_id
FROM wp_posts t 
INNER JOIN wp_posts f ON f.ID = t.post_parent AND f.post_type = 'forum' AND f.post_status IN ('publish', 'private', 'hidden')
WHERE t.post_type = 'topic' AND t.post_status IN ('publish', 'closed', 'pending', 'trash', 'spam'));
