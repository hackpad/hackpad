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

* If you want emoji support go to https://github.com/github/gemoji/tree/master/images/emoji/unicode
  and copy the images into etherpad/src/static/img/emoji/unicode/
  
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
    * Facebook login should be functioning properly now


