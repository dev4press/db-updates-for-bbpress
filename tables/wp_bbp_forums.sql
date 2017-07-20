/* bbp_forums
   this table includes columns based on the meta_keys saved for each forum into the wp_postmeta,
   and it has indexes on each ID based column, forum type and status.
*/

CREATE TABLE `wp_bbp_forums` (
  `forum_id` BIGINT UNSIGNED NOT NULL COMMENT 'Connects to ID in the wp_posts table for the post_type = \'forum\'.',
  `forum_type` VARCHAR(32) NOT NULL DEFAULT 'forum' COMMENT 'forum or category',
  `status` VARCHAR(32) NOT NULL DEFAULT 'open' COMMENT 'open or closed',
  `last_topic_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `last_reply_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `last_active_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `last_active_time` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `forum_subforum_count` INT UNSIGNED NOT NULL DEFAULT 0,
  `topic_count` INT UNSIGNED NOT NULL DEFAULT 0,
  `topic_count_hidden` INT UNSIGNED NOT NULL DEFAULT 0,
  `total_topic_count` INT UNSIGNED NOT NULL DEFAULT 0,
  `reply_count` INT UNSIGNED NOT NULL DEFAULT 0,
  `reply_count_hidden` INT UNSIGNED NOT NULL DEFAULT 0,
  `total_reply_count` INT UNSIGNED NOT NULL DEFAULT 0,
  INDEX `forum_id` (`forum_id`),
  INDEX `forum_type` (`forum_type`),
  INDEX `last_topic_id` (`last_topic_id`),
  INDEX `last_reply_id` (`last_reply_id`),
  INDEX `last_active_id` (`last_active_id`),
  INDEX `status` (`status`))
ENGINE = InnoDB;
