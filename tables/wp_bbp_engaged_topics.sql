/* bbp_engaged_topics
   this table connects user to the topic. Unique index placed on the user/topic combination.
*/

CREATE TABLE `wp_bbp_engaged_topics` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL COMMENT 'Connects to ID in the wp_users table.',
  `topic_id` BIGINT UNSIGNED NOT NULL COMMENT 'Connects to ID in the wp_posts table for the post_type = \'topic\'.',
  `engaged` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id`),
  INDEX `topic_id` (`topic_id`),
  INDEX `engaged` (`engaged`),
  UNIQUE INDEX `user_topic` (`user_id`, `topic_id`))
ENGINE = InnoDB;
