/* Updated subforums counts */
UPDATE wp_bbp_forums o LEFT JOIN (
    SELECT f.forum_id, count(p.ID) AS subforums
    FROM wp_bbp_forums f INNER JOIN wp_posts p ON f.forum_id = p.post_parent AND p.post_type = 'forum'
    WHERE p.post_status IN ('publish', 'private', 'hidden')
    GROUP BY f.forum_id) r ON o.forum_id = r.forum_id
SET o.subforum_count = r.subforums;

/* Update last_topic_id, topic_count */
UPDATE wp_bbp_forums f INNER JOIN (
    SELECT t.forum_id, MAX(t.topic_id) AS topic_id, COUNT(t.topic_id) AS topic_count
    FROM wp_bbp_topics t
    INNER JOIN wp_bbp_forums f ON f.forum_id = t.forum_id AND f.forum_type = 'forum'
    INNER JOIN wp_posts p ON p.ID = t.topic_id AND p.post_status IN ('publish', 'closed')
    GROUP BY t.forum_id) t ON t.forum_id = f.forum_id
SET f.last_topic_id = t.topic_id, f.topic_count = t.topic_count;

/* Update last_reply_id, reply_count */
UPDATE wp_bbp_forums f INNER JOIN (
    SELECT t.forum_id, MAX(t.reply_id) AS reply_id, COUNT(t.reply_id) AS reply_count
    FROM wp_bbp_replies t
    INNER JOIN wp_bbp_forums f ON f.forum_id = t.forum_id AND f.forum_type = 'forum'
    INNER JOIN wp_posts p ON p.ID = t.reply_id AND p.post_status IN ('publish')
    GROUP BY t.forum_id) r ON r.forum_id = f.forum_id
SET f.last_reply_id = r.reply_id, f.reply_count = r.reply_count;

/* Update topic_count_hidden */
UPDATE wp_bbp_forums f INNER JOIN (
    SELECT t.forum_id, COUNT(t.topic_id) AS topic_count_hidden
    FROM wp_bbp_topics t
    INNER JOIN wp_bbp_forums f ON f.forum_id = t.forum_id AND f.forum_type = 'forum'
    INNER JOIN wp_posts p ON p.ID = t.topic_id AND p.post_status IN ('pending', 'trash', 'spam')
    GROUP BY t.forum_id) t ON t.forum_id = f.forum_id
SET f.topic_count_hidden = t.topic_count_hidden;
    
/* Update reply_count_hidden */
UPDATE wp_bbp_forums f INNER JOIN (
    SELECT t.forum_id, COUNT(t.reply_id) AS reply_count_hidden
    FROM wp_bbp_replies t
    INNER JOIN wp_bbp_forums f ON f.forum_id = t.forum_id AND f.forum_type = 'forum'
    INNER JOIN wp_posts p ON p.ID = t.reply_id AND p.post_status IN ('pending', 'trash', 'spam')
    GROUP BY t.forum_id) r ON r.forum_id = f.forum_id
SET f.reply_count_hidden = r.reply_count_hidden;
