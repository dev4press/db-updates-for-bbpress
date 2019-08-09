/* Insert initial forum ID's */
INSERT INTO wp_bbp_forums (`forum_id`, `forum_status`, `forum_type`) ( 
SELECT
    f.ID AS forum_id,
    IF (ms.meta_value IS NULL OR ms.meta_value = 'open', 'open', 'closed') AS forum_status,
    IF (mt.meta_value IS NULL OR mt.meta_value = 'forum', 'forum', 'category') AS forum_type
FROM wp_posts f 
LEFT JOIN wp_postmeta ms ON ms.post_id = f.ID AND ms.meta_key = '_bbp_status'
LEFT JOIN wp_postmeta mt ON mt.post_id = f.ID AND mt.meta_key = '_bbp_forum_type'
WHERE f.post_type = 'forum' AND f.post_status IN ('publish', 'private', 'hidden'));

/* Updated subforums counts */
UPDATE wp_bbp_forums o LEFT JOIN (
    SELECT f.forum_id, count(p.ID) AS subforums
    FROM wp_bbp_forums f INNER JOIN wp_posts p ON f.forum_id = p.post_parent AND p.post_type = 'forum'
    WHERE p.post_status IN ('publish', 'private', 'hidden')
    GROUP BY f.forum_id) r ON o.forum_id = r.forum_id
SET o.subforum_count = r.subforums;

/* Update last_topic_id, basic pass */
UPDATE wp_bbp_forums f LEFT JOIN (
    SELECT forum_id, MAX(topic_id) AS topic_id FROM wp_bbp_topics
    GROUP BY forum_id) t ON t.forum_id = f.forum_id
SET f.last_topic_id = t.topic_id;

/* Update last_reply_id, basic pass */
UPDATE wp_bbp_forums f LEFT JOIN (
    SELECT forum_id, MAX(reply_id) AS reply_id FROM wp_bbp_replies
    GROUP BY forum_id) r ON r.forum_id = f.forum_id
SET f.last_reply_id = r.reply_id;
