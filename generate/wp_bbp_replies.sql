INSERT INTO wp_bbp_replies 
SELECT
    r.ID AS reply_id,
    t.ID AS topic_id,
    f.ID AS forum_id,
    if (r.post_parent = t.ID, 0, t.post_parent) AS parent_id
FROM wp_posts r 
INNER JOIN wp_posts t ON t.ID = r.post_parent AND t.post_type = 'topic'
INNER JOIN wp_posts f ON f.ID = t.post_parent AND f.post_type = 'forum'
WHERE r.post_type = 'reply'
