INSTALLATION INSTRUCTIONS

INSTALLING ON POSIX COMPATIBLE SYSTEMS

* Install the dependencies:
  * Sun Java JDK 7
  * Scala 2.11: On OS X, it's easiest to install via [Homebrew](http://brew.sh/): `brew install scala`
  * MySQL: Again, easiest to install via Homebrew: `brew install mysql`

* Edit the file bin/exports.sh (and optionally
  * etherpad/bin/etherpad.default) and change the paths to
  match your system.

* Run bin/build.sh
  * Execute the script from the root folder (it is required in order to keep consistency with some relative paths in exports.sh)

* Run contrib/scripts/setup-mysql-db.sh

* Copy etherpad/etc/etherpad.localdev-default.properties to etherpad/etc/etherpad.local.properties
* Edit etherpad/etc/etherpad.local.properties and set
   * etherpad.superUserEmailAddresses
       * Example: etherpad.superUserEmailAddresses = name1@example.com,name2@example.com
   * topdomains
       * Example: topdomains = yourhostname.com,localhost
* Set up the following at etherpad/etc/etherpad.local.properties, to send emails without any problems (activation mails as well)
   * customEmailAddress
       * This needs to be a valid address otherwise the emails send by the server will be rejected
   * smtpServer
       * Example: mail.example.com:555 #Attach the port at the end as well
   * smtpUser
       * Example: myemail@example.com #Your SMTP mail address
   * smtpPass
       * Your SMTP password

* You can now run etherpad via bin/run.sh.  Wait for the HTTP server to start
  listening, then visit http://localhost:9000.

* Create an account in development
  * Go through the sign up flow.  At this point, you will have created an
    account, but it needs to be validated.  If this were production, you would
    go to your email to click a link in a verification email, but since your
    development environment does not send email, we will resort to haxx.
  * Inspect the `email_signup` table in MySQL and find the row with your email
    address.  Note the token.
  * Visit http://localhost:9000/ep/account/validate-email?email=YOUR_EMAIL&token=TOKEN
  * Hurrah, you now have an account!

* If you want emoji support go to https://github.com/github/gemoji/tree/choose-set/images/emoji/unicode
  and copy the images into etherpad/src/static/img/emoji/unicode/
  
IMAGE UPLOAD FUNCTIONALITY

1. Create an AWS IAM user with an Access Key (i.e. a tuple: Access Key ID and Secret Access Key)
2. Create a bucker in S3 (say `hackbuck`)
3. Configure hackpad with the AWS credentials (Adding the region as well)
4. Grant PutObject, GetObject, DeleteObject, PutObjectAcl actions to all entities within the bucket: 
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:PutObjectAcl",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws:s3:::hackbuck/*"
            ]
        }
    ]
}
  
INSTRUCTIONS ON HOW TO SETUP SOCIAL LOGINS

* FACEBOOK
    * Create an app at https://developers.facebook.com/
    * At the app Products menu, click "Add Product"
        * Select "Facebook Login"
        * Choose platform: Web
        * Add your Site URL
        * Click 'Next' to the rest of the steps (up to step 5)
    * Click on App->Settings and grab the:
        * Application ID
        * App secret
    * Add the values from the previous step to your settings file (etherpad/etc/etherpad.local.properties)
        * facebookClientId
        * facebookClientSecret
    * Restart hackpad with bin/run.sh
    * Facebook login should be functional now
    
* GOOGLE
    * Go to the Google API console: https://console.developers.google.com
    * Click "Create credentials" and choose:
        * OAuth client ID
    * At the next screen select:
        * Application type: "Web Application"
        * Name: Something to your liking
        * Restrictions: 
            * Authorized JavaScript origins: No need to add anything
            * Authorized redirect URIs: Add your redirect URL as such: http://<YOUR_DOMAIN_NAME>/ep/account/openid
                * For example if you are trying hackpad locally with the default settings the authorized redirect would be: http://localhost:9000/ep/account/openid
    * Click at "Dashboard" and then at "ENABLE API" 
    * At the resulting screen select "Google+ API"
    * At the next screen click "ENABLE"
    * Now click again at "Credentials" and click on the Name you gave and copy your credentials: 
            * Client ID
            * Client secret
    * Back at our configuration file paste the credentials you copied to the corresponding fields (etherpad/etc/etherpad.local.properties)
        * googleClientId
        * googleClientSecret
    * Restart hackpad with bin/run.sh
    * Google login should be functional now
    
INSTRUCTIONS ON HOW TO SETUP DROPBOX LOGIN (FOR USER PAD SYNCING)

* DROPBOX
    * Go to the Dropbox developers page: https://www.dropbox.com/developers
    * Click "My apps"
    * Click the "Create app" button
    * At the next screen select:
        * Choose an API
            * Dropbox API
        * Choose the type of access
            * App folder or Full dropbox
        * Lastly
            * Give your app a name
    * Click at "Create app" 
    * At your newly created app copy the "App key" & "App secret" values
    * At the "Redirect URIs" field add you domain followed by "/ep/dropbox/auth_callback" and click add
    * Now at our configuration file paste the credentials you copied to the corresponding fields (etherpad/etc/etherpad.local.properties)
        * DROPBOX_KEY
        * DROPBOX_SECRET
    * Restart hackpad with bin/run.sh
    * Dropbox login should be functional now