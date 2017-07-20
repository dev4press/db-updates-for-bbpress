CREATE TABLE `wp_bbp_subscribed_forums` (
  `user_id` BIGINT UNSIGNED NOT NULL COMMENT 'Connects to ID in the wp_users table.',
  `forum_id` BIGINT UNSIGNED NOT NULL COMMENT 'Connects to ID in the wp_posts table for the post_type = \'forum\'.',
  INDEX `user_id` (`user_id`),
  INDEX `forum_id` (`forum_id`),
  UNIQUE INDEX `user_forum` (`user_id`, `forum_id`))
ENGINE = InnoDB;
