INSERT INTO wp_bbp_users
SELECT
   ID AS user_id, 
   IF (ua.meta_value IS NULL, '0000-00-00 00:00:00', FROM_UNIXTIME(ua.meta_value, '%Y-%d-%m %H:%i:%s')) AS last_posted, 
   IF (ub.meta_value IS NULL, '0000-00-00 00:00:00', FROM_UNIXTIME(ub.meta_value, '%Y-%d-%m %H:%i:%s')) AS last_active, 
   IF (uc.meta_value IS NULL, 0, CAST(uc.meta_value AS UNSIGNED)) AS topic_count, 
   IF (ud.meta_value IS NULL, 0, CAST(ud.meta_value AS UNSIGNED)) AS reply_count
FROM wp_users u
LEFT JOIN wp_usermeta ua ON ua.user_id = u.ID AND ua.meta_key = 'wp__bbp_last_posted'
LEFT JOIN wp_usermeta ub ON ub.user_id = u.ID AND ub.meta_key = 'wp_bbp_last_activity'
LEFT JOIN wp_usermeta uc ON uc.user_id = u.ID AND uc.meta_key = 'wp__bbp_topic_count'
LEFT JOIN wp_usermeta ud ON ud.user_id = u.ID AND ud.meta_key = 'wp__bbp_reply_count'
ORDER BY user_id ASC
