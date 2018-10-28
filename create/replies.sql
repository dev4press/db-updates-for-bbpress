INSERT INTO wp_bbp_replies (`reply_id`, `topic_id`, `forum_id`) (
	SELECT 
	  p.ID, 
	  CAST(t.meta_value AS UNSIGNED), 
	  CAST(f.meta_value AS UNSIGNED)
  FROM wp_3_posts p
  INNER JOIN wp_3_postmeta t 
	  ON p.ID = t.post_id 
	  AND t.meta_key = '_bbp_topic_id'
  INNER JOIN wp_3_postmeta f 
	  ON p.ID = f.post_id 
	  AND f.meta_key = '_bbp_forum_id'
  WHERE 
	  p.post_type = 'reply'
);
