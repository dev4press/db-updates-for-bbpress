INSERT INTO wp_bbp_replies
SELECT 
	p.ID AS topic_id,
	IF (ma.meta_value IS NULL, 0, CAST(ma.meta_value AS UNSIGNED)) AS topic_id,
	IF (mb.meta_value IS NULL, 0, CAST(mb.meta_value AS UNSIGNED)) AS forum_id,
	if (ma.meta_value IS NOT NULL AND CAST(ma.meta_value AS UNSIGNED) = p.post_parent, 0, p.post_parent) AS parent_id
FROM wp_posts p
LEFT JOIN wp_postmeta ma ON ma.post_id = p.ID AND ma.meta_key = '_bbp_topic_id'
LEFT JOIN wp_postmeta mb ON mb.post_id = p.ID AND mb.meta_key = '_bbp_forum_id'
WHERE p.post_type = 'reply'
ORDER BY p.ID ASC
