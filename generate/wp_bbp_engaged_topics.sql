INSERT INTO wp_bbp_engaged_topics
        SELECT p.post_author, t.topic_id 
        FROM wp_bbp_topics t 
        INNER JOIN wp_posts p ON p.ID = t.topic_id AND p.post_status IN ('publish', 'closed')
    UNION
        SELECT p.post_author, r.topic_id 
        FROM wp_bbp_replies r 
        INNER JOIN wp_posts p ON p.ID = r.reply_id AND p.post_status IN ('publish');
