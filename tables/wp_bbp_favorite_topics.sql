CREATE TABLE `wp_bbp_favorite_topics` (
  `user_id` BIGINT UNSIGNED NOT NULL COMMENT 'Connects to ID in the wp_users table.',
  `topic_id` BIGINT UNSIGNED NOT NULL COMMENT 'Connects to ID in the wp_posts table for the post_type = \'topic\'.',
  INDEX `user_id` (`user_id` ASC),
  INDEX `topic_id` (`topic_id` ASC),
  UNIQUE INDEX `user_topic` (`user_id` ASC, `topic_id` ASC))
ENGINE = InnoDB;
