INSERT INTO wp_bbp_topics
SELECT 
   p.ID AS topic_id,
   p.post_parent AS forum_id,
   '' AS sticky,
   IF (ma.meta_value IS NULL, 0, CAST(ma.meta_value AS UNSIGNED)) AS last_reply_id,
   IF (mb.meta_value IS NULL, 0, CAST(mb.meta_value AS UNSIGNED)) AS last_active_id,
   IF (mc.meta_value IS NULL, '0000-00-00 00:00:00', mc.meta_value) AS last_active_time,
   IF (md.meta_value IS NULL, 0, CAST(md.meta_value AS UNSIGNED)) AS reply_count,
   IF (me.meta_value IS NULL, 0, CAST(me.meta_value AS UNSIGNED)) AS reply_count_hidden,
   IF (mg.meta_value IS NULL, 0, CAST(mg.meta_value AS UNSIGNED)) AS voice_count
FROM wp_posts p
LEFT JOIN wp_postmeta ma ON ma.post_id = p.ID AND ma.meta_key = '_bbp_last_reply_id'
LEFT JOIN wp_postmeta mb ON mb.post_id = p.ID AND mb.meta_key = '_bbp_last_active_id'
LEFT JOIN wp_postmeta mc ON mc.post_id = p.ID AND mc.meta_key = '_bbp_last_active_time'
LEFT JOIN wp_postmeta md ON md.post_id = p.ID AND md.meta_key = '_bbp_reply_count'
LEFT JOIN wp_postmeta me ON me.post_id = p.ID AND me.meta_key = '_bbp_reply_count_hidden'
LEFT JOIN wp_postmeta mg ON mg.post_id = p.ID AND mg.meta_key = '_bbp_voice_count'
WHERE p.post_type = 'topic'
ORDER BY p.ID ASC
