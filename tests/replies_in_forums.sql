/* Here is the SQL query that can get replies that belong in the specified forums using regular bbPress setup with wp_postmeta for storage */

SELECT * FROM wp_posts p
INNER JOIN wp_postmeta m 
	ON p.ID = m.post_id
	AND m.meta_key = '_bbp_forum_id'
WHERE p.post_type = 'reply' 
	AND CAST(m.meta_value AS UNSIGNED) IN (7138, 7169, 7201, 7217, 59979, 16745);
  
/* This query returns 2856 rows with total query time 0.218 seconds. */

/* Here is the SQL query that can get replies that belong in the specified forums using dedicated replies table. */

SELECT * FROM wp_posts p 
INNER JOIN wp_bbp_replies r 
  ON r.reply_id = p.ID
WHERE r.forum_id IN (7138, 7169, 7201, 7217, 59979, 16745);
  
/* This query returns 2856 rows with total query time 0.005 seconds. */
/* This query is roughly 43 times faster! */
