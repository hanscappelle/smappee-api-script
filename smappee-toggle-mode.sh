#!/bin/bash

# simple script to toggle smappee ev wall home charger mode using smappee api
# required input flags:
# -i = client_id
# -s = client_secret
# -u = username
# -p = password
# -m = mode to toggle to
# -d = device serial
# -c = connector (typically 1 or 2)

# TODO print info on flags when flags are missing


# get flags
while getopts i:s:u:p:m:d:c: flag
do
    case "${flag}" in
	i) clientId=${OPTARG};;
	s) clientSecret=${OPTARG};;
        u) username=${OPTARG};;
        p) password=${OPTARG};;
        m) mode=${OPTARG};;
	d) serial=${OPTARG};;
	c) connector=${OPTARG};;
    esac
done

echo "Username: $username" >&2
echo "Mode to toggle to: $mode" >&2

# step 1 - retrieve a valid token for API

echo "retrieving token" >&2

response=$(curl -s --location 'https://app1pub.smappee.net/dev/v1/oauth2/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'grant_type=password' \
--data-urlencode 'client_id='$clientId \
--data-urlencode 'client_secret='$clientSecret \
--data-urlencode 'username='$username \
--data-urlencode 'password='$password)

echo "token received response $response" >&2
token=$(jq -r '.access_token' <<<"$response")
echo "token response was: $token"

# step 2 - trigger update

echo "triggering with new mode: $mode on device $serial on connector $connector" >&2

response=$(curl -s --location --request PUT 'https://app1pub.smappee.net/dev/v3/chargingstations/'$serial'/connectors/'$connector'/mode' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer '$token \
--data '{
    "mode": "'$mode'"
}')

echo "update mode response was: $response" >&2



