<?php

/**
 * Plugin Name:     Set Mail Server
 * Author:          Chazz W
 * Description:     Configure WordPress' outgoing mail server.
 * Version:         0.1.0
 *
 */

if (!function_exists('phpmailer_smtp_setup')) {
    add_action('phpmailer_init', 'phpmailer_smtp_setup');

    function phpmailer_smtp_setup($phpmailer)
    {
        $phpmailer->isSMTP();
        $phpmailer->Host = defined('SMTP_SERVER') ? SMTP_SERVER : $phpmailer->Host;
        $phpmailer->SMTPAuth = defined('SMTP_AUTH') ? SMTP_AUTH : $phpmailer->SMTPAuth;
        $phpmailer->Port = defined('SMTP_PORT') ? SMTP_PORT : $phpmailer->Port;
        $phpmailer->Username = defined('SMTP_USERNAME') ? SMTP_USERNAME : $phpmailer->Username;
        $phpmailer->Password = defined('SMTP_PASSWORD') ? SMTP_PASSWORD : $phpmailer->Password;
        $phpmailer->SMTPSecure = defined('SMTP_SECURE') ? SMTP_SECURE : $phpmailer->SMTPSecure;
        $phpmailer->From = defined('SMTP_FROM') ? SMTP_FROM : $phpmailer->From;
        $phpmailer->FromName = defined('SMTP_NAME') ? SMTP_NAME : $phpmailer->FromName;
    }
}
