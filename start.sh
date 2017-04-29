#!/bin/bash

set -e

cd "$( dirname "${BASH_SOURCE[0]}" )"

ADMIN_EMAILS=${ADMIN_EMAILS:-admin@example.com}
DB_HOST=${DB_HOST:-mysql}
DB_PORT=${DB_PORT:-3306}
DB_NAME=${DB_NAME:-hackpad}
DB_USERNAME=${DB_USERNAME:-hackpad}
DB_PASSWORD=${DB_PASSWORD:-password}
TOP_DOMAINS=${TOP_DOMAINS:-localhost,localbox.info}
USE_HTTPS_URLS=${USE_HTTPS_URLS:-false}
ACCOUNT_ENCRYPTION_KEY=${ACCOUNT_ENCRYPTION_KEY:-0123456789abcdef}
FB_SECRET=${FB_SECRET:-no_facebookClientSecret}
FB_ID=${FB_ID:-no_facebookClientId}
GOOGLE_SECRET=${GOOGLE_SECRET:-no_googleClientSecret}
GOOGLE_ID=${GOOGLE_ID:-no_googleClientId}
CUSTOM_EMAIL_ADDRESS=${CUSTOM_EMAIL_ADDRESS:-__custom_email_address__}
SMTP_SERVER=${SMTP_SERVER:-__smtp_server__}
SMTP_USER=${SMTP_USER:-__smtp_user__}
SMTP_PASS=${SMTP_PASS:-__smtp_password__}

cp hackpad/etherpad/etc/etherpad.local.properties.tmpl hackpad/etherpad/etc/etherpad.local.properties

sed -i.bak s/__email_addresses_with_admin_access__/$ADMIN_EMAILS/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__dbc_dbserver__/$DB_HOST/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__dbc_dbport__/$DB_PORT/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__dbc_dbname__/$DB_NAME/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__dbc_dbuser__/$DB_USERNAME/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__dbc_dbpass__/$DB_PASSWORD/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__account_id_encryption_key__/$ACCOUNT_ENCRYPTION_KEY/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__default_id_encryption_key__/$ACCOUNT_ENCRYPTION_KEY/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__fb_id__/$FB_ID/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__fb_secret__/$FB_SECRET/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__google_client_secret__/$GOOGLE_SECRET/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__google_client_id__/$GOOGLE_ID/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__custom_email_address__/$CUSTOM_EMAIL_ADDRESS/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__smtp_server__/$SMTP_SERVER/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__smtp_user__/$SMTP_USER/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__smtp_password__/$SMTP_PASS/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak "s/^\(topdomains = \).*$/\1$TOP_DOMAINS/g" hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak "s/^\(useHttpsUrls = \).*$/\1$USE_HTTPS_URLS/g" hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak "s/^\(devMode = \).*$/\1 true/g" hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak "s/^\(etherpad\.isProduction = \).*$/\1false/g" hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak "s/^\(logDir = \).*$/\1.\/data\/logs/g" hackpad/etherpad/etc/etherpad.local.properties
echo 'verbose = true' >> hackpad/etherpad/etc/etherpad.local.properties

exec hackpad/bin/run.sh
