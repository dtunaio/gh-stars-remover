#!/bin/bash

echo "Your GitHub personal access token --> "; read PERSONAL_ACCESS_TOKEN
curl -f -I -H "Authorization: token ${PERSONAL_ACCESS_TOKEN}" https://api.github.com/user/starred && echo "Succesfully authorized." \
|| echo "Could not authorized, please review your token."

for p in `seq 1 10`; do
    echo "Page $p is extracted."
    curl -f-s -H "Authorization: token ${PERSONAL_ACCESS_TOKEN}" https://api.github.com/user/starred\?page\=$p | jq -r '.[] |.full_name' >> stars.txt
done

while read star; do echo Deleted succesfully $star; curl -f -X DELETE -H "Accept: application/vnd.github+json" -H "Authorization: token ${PERSONAL_ACCESS_TOKEN}" https://api.github.com/user/starred/${star}; done < stars.txt
