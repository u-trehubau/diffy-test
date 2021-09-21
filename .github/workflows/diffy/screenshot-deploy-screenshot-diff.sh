#!/bin/bash

# Installation a diffy.phar.
wget https://github.com/DiffyWebsite/diffy-cli/releases/latest/download/diffy.phar
chmod a+x diffy.phar
cp diffy.phar /usr/local/bin/diffy

# Authorisation.
diffy auth:login $DIFFY_API_KEY

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
DIFF_ID=`diffy project:compare $DIFFY_PROJECT_ID $DIFFY_ENV1 $DIFFY_ENV2`
echo "Diff started $DIFF_ID"

# Set ENV variables.
echo "DIFF_ID=$DIFF_ID" >> $GITHUB_ENV
