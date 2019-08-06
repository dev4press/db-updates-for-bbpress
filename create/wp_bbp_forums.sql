INSERT INTO wp_bbp_forums
SELECT 
   p.ID AS forum_id,
   IF (ma.meta_value IS NULL, 'forum', ma.meta_value) AS forum_type,
   IF (mb.meta_value IS NULL, 'open', mb.meta_value) AS forum_status,
   IF (mc.meta_value IS NULL, 0, CAST(mc.meta_value AS UNSIGNED)) AS last_topic_id,
   IF (md.meta_value IS NULL, 0, CAST(md.meta_value AS UNSIGNED)) AS last_reply_id,
   IF (me.meta_value IS NULL, 0, CAST(me.meta_value AS UNSIGNED)) AS last_active_id,
   IF (mf.meta_value IS NULL, '0000-00-00 00:00:00', mf.meta_value) AS last_active_time,
   IF (mg.meta_value IS NULL, 0, CAST(mg.meta_value AS UNSIGNED)) AS subforum_count,
   IF (mh.meta_value IS NULL, 0, CAST(mh.meta_value AS UNSIGNED)) AS topic_count,
   IF (mi.meta_value IS NULL, 0, CAST(mi.meta_value AS UNSIGNED)) AS topic_count_hidden,
   IF (mj.meta_value IS NULL, 0, CAST(mj.meta_value AS UNSIGNED)) AS total_topic_count,
   IF (mk.meta_value IS NULL, 0, CAST(mk.meta_value AS UNSIGNED)) AS reply_count,
   IF (ml.meta_value IS NULL, 0, CAST(ml.meta_value AS UNSIGNED)) AS reply_count_hidden,
   IF (mm.meta_value IS NULL, 0, CAST(mm.meta_value AS UNSIGNED)) AS total_reply_count
FROM wp_posts p
LEFT JOIN wp_postmeta ma ON ma.post_id = p.ID AND ma.meta_key = '_bbp_forum_type'
LEFT JOIN wp_postmeta mb ON mb.post_id = p.ID AND mb.meta_key = '_bbp_status'
LEFT JOIN wp_postmeta mc ON mc.post_id = p.ID AND mc.meta_key = '_bbp_last_topic_id'
LEFT JOIN wp_postmeta md ON md.post_id = p.ID AND md.meta_key = '_bbp_last_reply_id'
LEFT JOIN wp_postmeta me ON me.post_id = p.ID AND me.meta_key = '_bbp_last_active_id'
LEFT JOIN wp_postmeta mf ON mf.post_id = p.ID AND mf.meta_key = '_bbp_last_active_time'
LEFT JOIN wp_postmeta mg ON mg.post_id = p.ID AND mg.meta_key = '_bbp_forum_subforum_count'
LEFT JOIN wp_postmeta mh ON mh.post_id = p.ID AND mh.meta_key = '_bbp_topic_count'
LEFT JOIN wp_postmeta mi ON mi.post_id = p.ID AND mi.meta_key = '_bbp_topic_count_hidden'
LEFT JOIN wp_postmeta mj ON mj.post_id = p.ID AND mj.meta_key = '_bbp_total_topic_count'
LEFT JOIN wp_postmeta mk ON mk.post_id = p.ID AND mk.meta_key = '_bbp_reply_count'
LEFT JOIN wp_postmeta ml ON ml.post_id = p.ID AND ml.meta_key = '_bbp_reply_count_hidden'
LEFT JOIN wp_postmeta mm ON mm.post_id = p.ID AND mm.meta_key = '_bbp_total_reply_count'
WHERE p.post_type = 'forum'
ORDER BY p.ID ASC   
