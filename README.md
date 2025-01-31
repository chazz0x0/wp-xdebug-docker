# Debug your WordPress Docker instance with XDebug

What does this repository offer?

- A fully debuggable WordPress docker instance
- Limit of upload_max_filesize increased to upload plugins with high filesize

# Modifications from Upstream

This repository provides a number of QoL changes from upstream.

- Builds Xdebug-enabled WP images for current WordPress (TBD: Add support for automatic WP5 setup)
- Allows for automatic integration of custom CA certificates (e.g., for proxying WordPress itself through Burp Suite)
- Automatically logs sent mail via Sendria (MailTrap)
- Provides easy visual access to MySQL via Adminer
- Automatically manages TLS setup via Caddy
- Automatic MySQL import of a default WordPress installation with users for each role:
    - admin:admin (Administrator)
    - editor:editor (Editor)
    - author:author (Author)
    - con:con (Contributor)
    - sub:sub (Subscriber)

## Steps to Installation

0. **Optional** Install [`just`](https://github.com/casey/just?tab=readme-ov-file#packages) for convenience. 
1. `git clone https://github.com/chazz0x0/wp-xdebug-docker`
2. `cd wp-xdebug-docker`
3. `cp .env.example .env`
4. Configure .env (See notes)
5. Update domain in MySQL dump (`just set-domain <your domain>` or manually run `sed` call in `justfile:set-domain`)
6. `docker-compose up -d`
7. Navigate to https://wp.<your domain> and get started.

XDebug is listening on port 9000. Use your preferred IDE to attach to the listener.

### Attaching with VSCode:

1. Install Dev Container & PHP Debug VSCode plugin
2. Use the Connect to option and Attach to running container
3. Select the WordPress container
4. Create a launch.json file and attach to 9000 port

Example launch.json file:
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for Xdebug",
            "type": "php",
            "request": "launch",
            "port": 9000
        }
        
    ]
}
   ```

For more info: https://code.visualstudio.com/docs/devcontainers/attach-container

This repo makes use of a modified version of the https://github.com/Automattic/wordpress-xdebug image
