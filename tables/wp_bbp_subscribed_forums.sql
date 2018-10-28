/* bbp_subscribed_forums
   this table connects user to the forum. Unique index placed on the user/forum combination.
*/

CREATE TABLE `wp_bbp_subscribed_forums` (
  `user_id` BIGINT UNSIGNED NOT NULL COMMENT 'Connects to ID in the wp_users table.',
  `forum_id` BIGINT UNSIGNED NOT NULL COMMENT 'Connects to ID in the wp_posts table for the post_type = \'forum\'.',
  `subscribed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE INDEX `user_forum` (`user_id`, `forum_id`),
  INDEX `user_id` (`user_id`),
  INDEX `forum_id` (`forum_id`),
  INDEX `subscribed` (`subscribed`))
ENGINE = InnoDB;
