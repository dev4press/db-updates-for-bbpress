/* convert favorited meta to own table */
INSERT INTO wp_bbp_favorited_topics
SELECT 
    CAST(meta_value AS UNSIGNED) AS user_id, 
    post_id AS topic_id
FROM wp_postmeta
WHERE meta_key = '_bbp_favorite'
