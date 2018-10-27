/* bbp_subscribed_forums
   this table connects user to the forum. Unique index placed on the user/forum combination.
*/

CREATE TABLE `wp_bbp_subscribed_forums` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL COMMENT 'Connects to ID in the wp_users table.',
  `forum_id` BIGINT UNSIGNED NOT NULL COMMENT 'Connects to ID in the wp_posts table for the post_type = \'forum\'.',
  `subscribed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id`),
  INDEX `forum_id` (`forum_id`),
  INDEX `subscribed` (`subscribed`),
  UNIQUE INDEX `user_forum` (`user_id`, `forum_id`))
ENGINE = InnoDB;
