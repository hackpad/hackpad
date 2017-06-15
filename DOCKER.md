How to develop Hackpad under Docker
===================================

If you'd like to develop Hackpad on Docker, these instructions are for you.

This will let you edit this repository and see your changes reflected in the docker image. 

Getting it running
-------------------

1. Obviously, if you haven't already, you'll need to install [Docker](https://docs.docker.com/installation/).

2. Build the image. From the root of this repo, run:

		docker build -t hackpad .

3. Run the container. Docker doesn't let you automatically mount a directory on your host machine in the container, so you'll need to specify by hand. 

	Replace /path/to/this/repo below with the path to the current repository. Leave the other path alone. 

		docker run -d -p 9000:9000 -v /path/to/this/repo:/etc/hackpad/src hackpad
		
	The available environment variables are:
	
        ADMIN_EMAILS - comma-separated superuser emails (default: admin@example.com)
        DB_HOST - mysql host (default: mysql)
        DB_REQUIRE_SSL - Defaults to false
        DB_PORT - mysql port (default: 3306)
        DB_NAME - mysql database name (default: hackpad)
        DB_USERNAME - mysql user (default: hackpad)
        DB_PASSWORD - mysql user password (default: password)
        TOP_DOMAINS - comma-separated top level domains (default: localhost,localbox.info)
        USE_HTTPS_URLS - should hackpad emit the absolute urls using https as opposed to http (default: false)
        DEFAULT_ENCRYPTION_KEY - Set the default encryption key (It needs to be a HEXadecimal value)
        ACCOUNT_ENCRYPTION_KEY - Set an encryption key for accounts (It needs to be a HEXadecimal value)
        COLLECTION_ENCRYPTION_KEY - Set an encryption key for collections (It needs to be a HEXadecimal value)
        ENABLE_GOOGLE_LOGIN - Enable Google OAuth2 login (true by default)
        GOOGLE_SECRET - Google OAuth secret key
        GOOGLE_ID - Google OAuth app id
        ENABLE_FB_LOGIN - Enable Facebook OAuth2 login (true by default)
        FB_ID - Facebook OAuth id
        FB_SECRET - Facebook OAuth secret key
        CUSTOM_EMAIL_ADDRESS - This needs to be a valid, resolvable, address, ex. noreply@mycompany.com
        SMTP_SERVER - The smtp server host (needs the PORT as well), ex. smtp.my.host:587
        SMTP_USER - SMTP username
        SMTP_PASS - SMTP password
        CUSTOM_CLIENT_LOGIN - Enable Custom client OAuth2 login (false is default)
        CUSTOM_OAUTH_BASE_URL - The Base API URL for the custom client OAuth service
        OAUTH_CLIENT_SECRET - Custom client OAuth secret key
        OAUTH_CLIENT_ID - Custom client OAuth app id
        CUSTOM_OAUTH_CLIENT_NAME - The name of the service with which the user will authenticate
        CUSTOM_OAUTH_CLIENT_IMAGE - The image of the auth service to show in the login popup. This image can be a URL, you can also upload an image to the folder etherpad/src/static/img/ and use this path along with the uploaded image name  (e.g. value "/static/img/company-logo.png")
        GOOGLE_ANALYTICS_ID - Add it to keep track of analytics data
        DROPBOX_KEY - Dropbox app key (to be used for user pad syncing)
        DROPBOX_SECRET - Dropbox app secret (to be used for user pad syncing)
        DISABLE_DROPBOX_SYNC - Weather to disable or not the dropbox sync task (defaults to false, i.e. keep the sync enabled)
        ENABLE_FORM_LOGIN - Enable or disable normal form login/registration
        AWS_KEY_ID - Your AWS Access Key ID
        AWS_SECRET - Your AWS Secret Access Key
        S3_BUCKET - The bucket in which files will be stored
        S3_REGION - Regional endpoint to make your requests
        DISABLE_WORKSPACE_CREATION - Weather or not to disable workspace creations (defaults to false)
        IS_PRODUCTION - Define if the environment you will be building the docker image is production or not (defaults to true)
        DEV_MODE - Enable/Disable devMode (defaults to false)
        MIXPANEL_TOKEN - Mixpanel token
        DB_PARAMETERS - Add extra parameters to the jdbc url
        PROCESS_INBOX - Set to true or false (defaults to false)
        
        
        Note: For EACH environment variable you want to set, add "-e ENV_VAR=VALUE" at the 'docker run' command, e.x. "-e DB_HOST=localhost -e DB_PORT=3306" etc. 

	This will build hackpad, run schema migrations, and then start the server. It may take a few minutes. If you want to see what's going on, do:

		docker logs -f [container name]

4. Fix networking (one time only). If you're on OS X or Windows, you'll need to set up port forwarding to have Hackpad work properly. Linux folk can skip this.

	1. Open VirtualBox

	2. Select the `default` image and click Settings

	3. Go to Network -> Adapter 1 -> Port forwarding

	4. Create a custom rule like so:

		* Host IP: 127.0.0.1
		* Host Port: 9000
		* Guest IP: blank
		* Guest Port: 9000

	You should only have to do this once.

	At this point you should be able to open http://localhost:9000 in a browser and see the Hackpad page.

5. Create a password for the admin account.

	As part of the Docker setup, Hackpad is configured with 'admin@localhost.info' as a admin account, but you'll need to create a password to log in. 

	To do that: 

	1. Open http://localhost:9000 and click Log In

	2. Create an account with 'admin@localhost.info' and any password you like.

	3. From the command line, run:

		1. Find the name of your running container by running `docker ps`. Note the name. 

		2. Run this query and find the token:

				docker exec -it [container name] mysql -D hackpad -e 'select * from email_signup;'

		3. Load this in a browser: http://localhost:9000/ep/account/validate-email?email=admin%40localhost.info&token=TOKEN


You're all set!  You should be able to edit the Hackpad source code and the docker container will track those changes.

