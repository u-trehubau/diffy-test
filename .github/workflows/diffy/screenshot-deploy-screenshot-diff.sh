#!/bin/bash

# Installation a diffy.phar.
wget https://github.com/DiffyWebsite/diffy-cli/releases/latest/download/diffy.phar
chmod a+x diffy.phar
cp diffy.phar /usr/local/bin/diffy

# Authorisation.
diffy auth:login $DIFFY_API_KEY

# Get API token.
DIFFY_API_TOKEN=$(curl -X POST "$MAIN_API_URL/auth/key" -H "accept: application/json" -d '{"key":"'$DIFFY_API_KEY'"}')
DIFFY_API_TOKEN=$(echo $DIFFY_API_TOKEN | jq -r '.token')

#----------- NOT NEEDED -----------
# First set of screenshots.
#echo "Starting taking pre-deployment screenshots..."
#SCREENSHOT_ID1=`diffy screenshot:create $DIFFY_PROJECT_ID production --wait`
#echo "Screenshots created $SCREENSHOT_ID1"

# Deployment.
#echo "Deployment started"
#sleep 10
#echo "Deployment finished"

#SCREENSHOT_ID2=`diffy screenshot:create $DIFFY_PROJECT_ID production`

# We can run diff while screenshots are not yet ready. We do not wait for the diff to be completed.
# Will receive a notification with results by email / slack.
#DIFF_ID=`diffy diff:create $DIFFY_PROJECT_ID $SCREENSHOT_ID1 $SCREENSHOT_ID2`
#echo "Diff started $DIFF_ID"
#----------- /NOT NEEDED -----------

# Compare two environments.
DIFFY_DIFF_ID=`diffy project:compare $DIFFY_PROJECT_ID $DIFFY_ENV1 $DIFFY_ENV2`
echo "Diff started $DIFFY_DIFF_ID"

# Get link to diff.
DIFFY_DIFF_LINK=$(curl -X GET "https://app.diffy.website/api/diffs/$DIFFY_DIFF_ID" -H "accept: application/json" -H "Authorization: Bearer $DIFFY_API_TOKEN")
DIFFY_DIFF_LINK=$(echo $DIFFY_DIFF_LINK | jq -r '.diffSharedUrl')

# Set ENV variables.
echo "DIFFY_DIFF_ID=$DIFFY_DIFF_ID" >> $GITHUB_ENV
echo "DIFFY_DIFF_LINK=$DIFFY_DIFF_LINK" >> $GITHUB_ENV
