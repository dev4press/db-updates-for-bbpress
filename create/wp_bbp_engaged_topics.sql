INSERT INTO wp_bbp_engaged_topics
SELECT 
   DISTINCT 
   posts.post_author AS user_id, 
   CAST(postmeta.meta_value AS UNSIGNED) AS topic_ic
FROM wp_posts AS posts
INNER JOIN wp_postmeta AS postmeta ON posts.ID = postmeta.post_id AND postmeta.meta_key = '_bbp_topic_id'
WHERE 
   posts.post_type IN ('topic', 'reply') AND 
   posts.post_status IN ('publish', 'closed')
ORDER BY CAST(postmeta.meta_value AS UNSIGNED) ASC
