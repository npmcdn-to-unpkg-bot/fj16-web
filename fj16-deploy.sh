#!/bin/sh

DATE=$(date)
echo "DEPLOY STARTED AT $DATE"
git log -1
echo

echo "Running update hooks..."
/var/lib/nginx/drush/drush updatedb -y
echo "Reverting features..."
/var/lib/nginx/drush/drush features-revert-all -y
echo "Clearing caches..."
/var/lib/nginx/drush/drush cc all #clear caches

hostname=$(hostname)
flowname="web-sivut"
email=$flowname"@finnjamboree2016.flowdock.com"
commit=$(git log -1)
sendmail $email -f noreply@roihu2016.fi <<< "Subject: Deployed on "$hostname"
From: noreply@roihu2016.fi

"$commit

DATE=$(date)
echo "DEPLOY COMPLETED AT $DATE"
echo
