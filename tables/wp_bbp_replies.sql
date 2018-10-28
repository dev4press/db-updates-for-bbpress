/* bbp_replies
   this table connects replies to topics and forums. Unique index placed on the reply/topic/forum combination.
*/

CREATE TABLE `wp_bbp_replies` (
  `reply_id` BIGINT UNSIGNED NOT NULL COMMENT 'Connects to ID in the wp_posts table for the post_type = \'reply\'.',
  `topic_id` BIGINT UNSIGNED NOT NULL COMMENT 'Connects to ID in the wp_posts table for the post_type = \'topic\'.',
  `forum_id` BIGINT UNSIGNED NOT NULL COMMENT 'Connects to ID in the wp_posts table for the post_type = \'forum\'.',
  UNIQUE INDEX `reply_topic_forum` (`reply_id`, `topic_id`, `forum_id`),
  INDEX `reply_id` (`reply_id`),
  INDEX `topic_id` (`topic_id`),
  INDEX `forum_id` (`forum_id`))
ENGINE = InnoDB;
