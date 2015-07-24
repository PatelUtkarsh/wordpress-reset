# wordpress-reset
Reset wordpress to default state


#How to use this ? 

1. Clone this using `git clone https://github.com/PatelUtkarsh/wordpress-reset.git`

2. Open `take_backup.sh` and `SITE_WEBROOT` change your wordpress site folder.

3. Do that same in `reset_wordpress.sh`.

4. Run `bash take_backup.sh`

5. Add file to crontab using `crontab -e`
Example:  `10 1 * * * bash /wordpress-reset/reset_wordpress.sh`

This will reset your database and upload folder every day at 1.10 AM.