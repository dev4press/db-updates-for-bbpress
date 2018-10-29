/* Here is the SQL query that counts replies that belong to a single forums using regular bbPress setup with wp_postmeta for storage */

SELECT COUNT(*) FROM wp_posts p
INNER JOIN wp_postmeta m 
	ON p.ID = m.post_id
	AND m.meta_key = '_bbp_forum_id'
WHERE p.post_type = 'reply' 
	AND m.meta_value = 16745;
  
/* This query returns result of 2723 with total query time 0.203 seconds. */

/* Here is the SQL query that does the same using dedicated replies table. */

SELECT count(*) FROM wp_bbp_replies r
WHERE r.forum_id = 16745;
  
/* This query returns 2856 rows with total query time 0.0005 seconds. */
/* This query is roughly 400 times faster! */
