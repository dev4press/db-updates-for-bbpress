/* Insert all users roles, bbPress allows single role per user */
INSERT INTO wp_bbp_users_roles
SELECT DISTINCT user_id, 
(CASE
    WHEN LOCATE('bbp_keymaster', meta_value) > 0 THEN 'bbp_keymaster'
    WHEN LOCATE('bbp_moderator', meta_value) > 0 THEN 'bbp_moderator'
    WHEN LOCATE('bbp_participant', meta_value) > 0 THEN 'bbp_participant'
    WHEN LOCATE('bbp_spectator', meta_value) > 0 THEN 'bbp_spectator'
    WHEN LOCATE('bbp_blocked', meta_value) > 0 THEN 'bbp_blocked'
    WHEN LOCATE('bbp_spammer', meta_value) > 0 THEN 'bbp_spammer'
    ELSE 'bbp_spectator'
END) AS role 
FROM wp_usermeta WHERE meta_key = 'wp_capabilities'
