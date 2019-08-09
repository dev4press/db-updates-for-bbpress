/* Update parent ID's */
UPDATE wp_bbp_replies r 
INNER JOIN wp_posts p ON p.ID = r.reply_id AND p.post_type = 'reply'
INNER JOIN wp_postmeta m ON p.ID = m.post_id AND m.meta_key = '_bbp_reply_to'
SET r.parent_id = CAST(m.meta_value AS UNSIGNED)
WHERE r.topic_id != CAST(m.meta_value AS UNSIGNED) AND CAST(m.meta_value AS UNSIGNED) > 0;
