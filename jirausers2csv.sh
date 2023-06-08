#!/bin/bash

group=$1

source .env


if [ -z "$group" ] ; then
        groups=$(curl -s -k --request GET \
                -H "Authorization: Bearer $TOKEN" \
                --header 'Accept: application/json' \
                "$URL/rest/api/2/groups/picker?maxResults=10000&query=" | jq -r .groups)

        echo $groups | jq -r '.[].name|@uri' | while read group ; do
                ./$0 "$group"
        done

elif [ "$group" == "NOGROUP" ] ; then
        members=$(curl -s -k --request GET \
                -H "Authorization: Bearer $TOKEN" \
                --header 'Accept: application/json' \
                "$URL/rest/api/2/user/search?username=.&maxResults=10000&includeInactive=true"  )
	echo $members | jq -r '.[] | [ .emailAddress, .active ] | @csv' 
else
        members=$(curl -s -k --request GET \
                -H "Authorization: Bearer $TOKEN" \
                --header 'Accept: application/json' \
                "$URL/rest/api/2/group/member?maxResults=10000&groupname=$group&includeInactiveUsers=true" | jq -r .values)
	echo $members | jq -r --arg group1 "$group" '.[] | [ $group1, .emailAddress, .active ] | @csv' 
fi


