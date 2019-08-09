/* Insert initial forum ID's */
INSERT INTO wp_bbp_forums (`forum_id`) ( 
SELECT
    f.ID AS forum_id
FROM wp_posts f 
WHERE f.post_type = 'forum' AND f.post_status IN ('publish', 'private', 'hidden'));

