/* Insert initial data */
INSERT INTO wp_bbp_replies 
SELECT
    r.ID AS reply_id,
    t.ID AS topic_id,
    f.ID AS forum_id,
    0 AS parent_id
FROM wp_posts r 
INNER JOIN wp_posts t ON t.ID = r.post_parent AND t.post_type = 'topic'
INNER JOIN wp_posts f ON f.ID = t.post_parent AND f.post_type = 'forum'
WHERE r.post_type = 'reply' AND r.post_status IN ('publish', 'spam', 'trash', 'pending');

/* Update parent ID's */
UPDATE wp_bbp_replies r 
INNER JOIN wp_posts p ON p.ID = r.reply_id AND p.post_type = 'reply'
INNER JOIN wp_postmeta m ON p.ID = m.post_id AND m.meta_key = '_bbp_reply_to'
SET r.parent_id = CAST(m.meta_value AS UNSIGNED)
WHERE r.topic_id != CAST(m.meta_value AS UNSIGNED) AND CAST(m.meta_value AS UNSIGNED) > 0;
