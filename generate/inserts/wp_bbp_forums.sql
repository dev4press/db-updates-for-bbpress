/* Insert initial forum ID's */
INSERT INTO wp_bbp_forums (`forum_id`, `forum_status`, `forum_type`) ( 
SELECT
    f.ID AS forum_id,
    IF (ms.meta_value IS NULL OR ms.meta_value = 'open', 'open', 'closed') AS forum_status,
    IF (mt.meta_value IS NULL OR mt.meta_value = 'forum', 'forum', 'category') AS forum_type
FROM wp_posts f 
LEFT JOIN wp_postmeta ms ON ms.post_id = f.ID AND ms.meta_key = '_bbp_status'
LEFT JOIN wp_postmeta mt ON mt.post_id = f.ID AND mt.meta_key = '_bbp_forum_type'
WHERE f.post_type = 'forum' AND f.post_status IN ('publish', 'private', 'hidden'));
