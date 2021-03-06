/* bbp_users
   this table includes columns based on the meta_keys saved for each user into the wp_usermet,
   and it has indexes on each ID based column.
*/

CREATE TABLE `wp_bbp_users` (
  `user_id` BIGINT UNSIGNED NOT NULL COMMENT 'Connects to ID in the wp_users table.',
  `last_posted` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_active` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `topic_count` INT UNSIGNED NOT NULL DEFAULT 0,
  `reply_count` INT UNSIGNED NOT NULL DEFAULT 0,
  UNIQUE INDEX `user_id` (`user_id`),
  INDEX `last_posted` (`last_posted`),
  INDEX `last_active` (`last_active`)
)
ENGINE = InnoDB;
