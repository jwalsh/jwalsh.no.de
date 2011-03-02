#!/bin/sh 
# Purpose: Publish into the test pages.svn
# echo Publishing Test to staging and production 

DEBUG=true

. ~/.facebookrc

if [ $DEBUG ] 
then 
    echo APP_ID: $APP_ID
    echo APP_SECRET: $APP_SECRET
    echo SITE_URL: $SITE_URL
fi 

if [ -z "$APP_ID" -o -z "$APP_SECRET" -o -z "$SITE_URL" ] ; 
then 
    echo APP_ID, APP_SECRET, and SITE_URL  are required in ~/.facebookrc
    exit 1
else 
    # Access token 
    TOKEN=$(curl -s -F type=client_cred  -F client_id=$APP_ID  -F client_secret=$APP_SECRET  https://graph.facebook.com/oauth/access_token)

    # Just publish a trivial message to the main SITE_URL for the application 
    URL=$SITE_URL
    MESSAGE=$(uptime)

    if [ $DEBUG ] 
    then 
        echo URL: $URL
        echo MESSAGE: $MESSAGE
    fi 

    # If errors are seen recheck the URL at http://developers.facebook.com/tools/lint/
    curl -s \
        -F "$TOKEN" \
        -F "id=$URL" \
        -F "message=$MESSAGE" \
        https://graph.facebook.com/feed

fi
