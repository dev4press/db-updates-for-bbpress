/* bbp_users_roles
   this table connects users to specific forum roles
*/

CREATE TABLE `wp_bbp_users_roles` (
  `user_id` BIGINT UNSIGNED NOT NULL COMMENT 'Connects to ID in the wp_users table.',
  `role` VARCHAR(128) NOT NULL DEFAULT '',
  UNIQUE INDEX `user_id` (`user_id`),
  INDEX `role` (`role`)
)
ENGINE = InnoDB;
