#!/bin/bash

set -e

cd "$( dirname "${BASH_SOURCE[0]}" )"

function escapeChars(){
    printf '%q\n' "$1" | sed 's/\//\\\//g'
}

ADMIN_EMAILS=$(escapeChars ${ADMIN_EMAILS:-admin@example.com})
DB_HOST=$(escapeChars ${DB_HOST:-mysql})
DB_REQUIRE_SSL=$(escapeChars ${DB_REQUIRE_SSL:-false})
DB_PORT=$(escapeChars ${DB_PORT:-3306})
DB_NAME=$(escapeChars ${DB_NAME:-hackpad})
DB_USERNAME=$(escapeChars ${DB_USERNAME:-hackpad})
DB_PASSWORD=$(escapeChars ${DB_PASSWORD:-password})
CANONICAL_DOMAIN=$(escapeChars ${CANONICAL_DOMAIN:-localhost})
TOP_DOMAINS=$(escapeChars ${TOP_DOMAINS:-localhost,localbox.info})
USE_HTTPS_URLS=$(escapeChars ${USE_HTTPS_URLS:-false})
ACCOUNT_ENCRYPTION_KEY=$(escapeChars ${ACCOUNT_ENCRYPTION_KEY:-0123456789abcdef})
DEFAULT_ENCRYPTION_KEY=$(escapeChars ${DEFAULT_ENCRYPTION_KEY:-0123456789abcdef})
COLLECTION_ENCRYPTION_KEY=$(escapeChars ${COLLECTION_ENCRYPTION_KEY:-0123456789abcdef})
FB_SECRET=$(escapeChars ${FB_SECRET:-no_facebookClientSecret})
FB_ID=$(escapeChars ${FB_ID:-no_facebookClientId})
GOOGLE_SECRET=$(escapeChars ${GOOGLE_SECRET:-no_googleClientSecret})
GOOGLE_ID=$(escapeChars ${GOOGLE_ID:-no_googleClientId})
CUSTOM_EMAIL_ADDRESS=$(escapeChars ${CUSTOM_EMAIL_ADDRESS:-__custom_email_address__})
SMTP_SERVER=$(escapeChars ${SMTP_SERVER:-__smtp_server__})
SMTP_USER=$(escapeChars ${SMTP_USER:-__smtp_user__})
SMTP_PASS=$(escapeChars ${SMTP_PASS:-__smtp_password__})
AWS_KEY_ID=$(escapeChars ${AWS_KEY_ID:-__aws_key_id__})
AWS_SECRET=$(escapeChars ${AWS_SECRET:-__aws_secret__})
S3_BUCKET=$(escapeChars ${S3_BUCKET:-__aws_attachments_bucket__})
S3_REGION=$(escapeChars ${S3_REGION:-__aws_region__})
ENABLE_FB_LOGIN=$(escapeChars ${ENABLE_FB_LOGIN:-true})
ENABLE_GOOGLE_LOGIN=$(escapeChars ${ENABLE_GOOGLE_LOGIN:-true})
ENABLE_FORM_LOGIN=$(escapeChars ${ENABLE_FORM_LOGIN:-true})
CUSTOM_CLIENT_LOGIN=$(escapeChars ${CUSTOM_CLIENT_LOGIN:-false})
CUSTOM_OAUTH_BASE_URL=$(escapeChars ${CUSTOM_OAUTH_BASE_URL:-__custom_client_api_base__})
OAUTH_CLIENT_SECRET=$(escapeChars ${OAUTH_CLIENT_SECRET:-__oauth_service_secret__})
OAUTH_CLIENT_ID=$(escapeChars ${OAUTH_CLIENT_ID:-__oauth_service_id__})
CUSTOM_OAUTH_CLIENT_NAME=$(escapeChars ${CUSTOM_OAUTH_CLIENT_NAME:-__custom_oauth_client_name__})
CUSTOM_OAUTH_CLIENT_IMAGE=$(escapeChars ${CUSTOM_OAUTH_CLIENT_IMAGE:-__custom_oauth_client_image__})
GOOGLE_ANALYTICS_ID=$(escapeChars ${GOOGLE_ANALYTICS_ID:-__google_analytics_account__})
DROPBOX_KEY=$(escapeChars ${DROPBOX_KEY:-__dropbox_app_key__})
DROPBOX_SECRET=$(escapeChars ${DROPBOX_SECRET:-__dropbox_app_secret__})
DISABLE_DROPBOX_SYNC=$(escapeChars ${DISABLE_DROPBOX_SYNC:-false})
DISABLE_WORKSPACE_CREATION=$(escapeChars ${DISABLE_WORKSPACE_CREATION:-__disable_creating_workspaces__})
IS_PRODUCTION=$(escapeChars ${IS_PRODUCTION:-true})
DEV_MODE=$(escapeChars ${DEV_MODE:-false})
cp hackpad/etherpad/etc/etherpad.local.properties.tmpl hackpad/etherpad/etc/etherpad.local.properties

sed -i.bak s/__email_addresses_with_admin_access__/$ADMIN_EMAILS/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__dbc_dbserver__/$DB_HOST/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__dbc_require_ssl__/$DB_REQUIRE_SSL/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__dbc_dbport__/$DB_PORT/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__dbc_dbname__/$DB_NAME/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__dbc_dbuser__/$DB_USERNAME/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__dbc_dbpass__/$DB_PASSWORD/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__account_id_encryption_key__/$ACCOUNT_ENCRYPTION_KEY/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__default_id_encryption_key__/$DEFAULT_ENCRYPTION_KEY/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__collection_id_encryption_key__/$COLLECTION_ENCRYPTION_KEY/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__enable_facebook_login__/$ENABLE_FB_LOGIN/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__fb_id__/$FB_ID/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__fb_secret__/$FB_SECRET/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__enable_google_login__/$ENABLE_GOOGLE_LOGIN/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__google_client_secret__/$GOOGLE_SECRET/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__google_client_id__/$GOOGLE_ID/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__enable_normal_login__/$ENABLE_FORM_LOGIN/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__enable_custom_client_login__/$CUSTOM_CLIENT_LOGIN/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__custom_client_api_base__/$CUSTOM_OAUTH_BASE_URL/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__oauth_client_secret__/$OAUTH_CLIENT_SECRET/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__oauth_client_id__/$OAUTH_CLIENT_ID/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__custom_oauth_client_name__/$CUSTOM_OAUTH_CLIENT_NAME/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__custom_oauth_client_image__/$CUSTOM_OAUTH_CLIENT_IMAGE/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__custom_email_address__/$CUSTOM_EMAIL_ADDRESS/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__smtp_server__/$SMTP_SERVER/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__smtp_user__/$SMTP_USER/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__smtp_password__/$SMTP_PASS/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__aws_key_id__/$AWS_KEY_ID/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__aws_secret__/$AWS_SECRET/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__aws_attachments_bucket__/$S3_BUCKET/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__aws_region__/$S3_REGION/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__canonical_domain__/$CANONICAL_DOMAIN/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__google_analytics_account__/$GOOGLE_ANALYTICS_ID/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__dropbox_app_key__/$DROPBOX_KEY/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__dropbox_app_secret__/$DROPBOX_SECRET/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__disable_dropbox_sync__/$DISABLE_DROPBOX_SYNC/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__disable_creating_workspaces__/$DISABLE_WORKSPACE_CREATION/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak "s/^\(etherpad\.imgDefaultDomain = \).*$/\1$CANONICAL_DOMAIN/g" hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak "s/^\(topdomains = \).*$/\1$TOP_DOMAINS/g" hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak "s/^\(useHttpsUrls = \).*$/\1$USE_HTTPS_URLS/g" hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak "s/^\(devMode = \).*$/\1$DEV_MODE/g" hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak "s/^\(etherpad\.isProduction = \).*$/\1$IS_PRODUCTION/g" hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak "s/^\(logDir = \).*$/\1.\/data\/logs/g" hackpad/etherpad/etc/etherpad.local.properties
echo 'verbose = true' >> hackpad/etherpad/etc/etherpad.local.properties

exec hackpad/bin/run.sh