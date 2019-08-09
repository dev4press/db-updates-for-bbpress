/* bbp_topics
   this table includes columns based on the meta_keys saved for each forum into the wp_postmeta,
   and it has indexes on each ID based column.
*/

CREATE TABLE `wp_bbp_topics` (
  `topic_id` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Connects to ID in the wp_posts table for the post_type = \'topic\'.',
  `forum_id` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Connects to ID in the wp_posts table for the post_type = \'forum\'.',
  `sticky` VARCHAR(16) NOT NULL DEFAULT '' COMMENT 'Values can be: empty, sticky or front.',
  `last_reply_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `last_active_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `last_active_time` DATETIME NULL DEFAULT '0000-00-00 00:00:00',
  `reply_count` INT UNSIGNED NOT NULL DEFAULT 0,
  `reply_count_hidden` INT UNSIGNED NOT NULL DEFAULT 0,
  `voice_count` INT UNSIGNED NOT NULL DEFAULT 1,
  UNIQUE INDEX `topic_forum_id` (`topic_id`, `forum_id`),
  INDEX `sticky` (`sticky`),
  INDEX `topic_id` (`topic_id`),
  INDEX `forum_id` (`forum_id`),
  INDEX `last_reply_id` (`last_reply_id`),
  INDEX `last_active_id` (`last_active_id`),
  INDEX `last_active_time` (`last_active_time`))
ENGINE = InnoDB;
