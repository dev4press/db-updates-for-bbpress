INSERT INTO wp_bbp_subscribed_topics
SELECT 
   CAST(pm.meta_value AS UNSIGNED) AS user_id, 
   pm.post_id AS topic_id
FROM wp_postmeta pm
INNER JOIN wp_posts p ON p.ID = pm.post_id AND p.post_type = 'topic'
WHERE pm.meta_key = '_bbp_subscription'
