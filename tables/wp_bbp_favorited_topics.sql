/* bbp_favorited_topics
   this table connects user to the topic. Unique index placed on the user/topic combination.
*/

CREATE TABLE `wp_bbp_favorited_topics` (
  `user_id` BIGINT UNSIGNED NOT NULL COMMENT 'Connects to ID in the wp_users table.',
  `topic_id` BIGINT UNSIGNED NOT NULL COMMENT 'Connects to ID in the wp_posts table for the post_type = \'topic\'.',
  `favorited` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `user_id` (`user_id`),
  INDEX `topic_id` (`topic_id`),
  INDEX `favorited` (`favorited`),
  UNIQUE INDEX `user_topic` (`user_id`, `topic_id`))
ENGINE = InnoDB;