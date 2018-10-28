INSERT INTO wp_bbp_engaged_topics (`user_id`, `topic_id`, `engaged`) (
	SELECT 
		posts.post_author, 
		postmeta.meta_value, 
		posts.post_date
	FROM wp_posts AS posts
	INNER JOIN wp_postmeta AS postmeta 
		ON posts.ID = postmeta.post_id 
		AND postmeta.meta_key = '_bbp_topic_id'
	WHERE 
		posts.post_type IN ('topic', 'reply') 
		AND posts.post_status IN ('publish', 'closed')
	GROUP BY postmeta.meta_value, posts.post_author
	ORDER BY posts.post_date ASC
);
