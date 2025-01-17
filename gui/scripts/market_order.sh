#!/bin/bash

API_KEY="rtkDibROAhuUQM3vVKvVa36QzdROahMi2ycOSCLYpjbutb7jCqf8t18VhNvlV0yX"
SECRET_KEY="5Xv5xYSTRa08E9xK2A6ZaKXwtYQZq2qV19Hr8rrTsM0lpVXc52VBKFofJIkkWNpL"

# The server time
SERVER_TIME=$(curl -s "https://testnet.binance.vision/api/v3/time" | jq -r '.serverTime')

# Parameters for the market order
SYMBOL="$1"
SIDE="$2"
QUANTITY="$3"
TIMESTAMP=$SERVER_TIME

# SYMBOL="BTCUSDT"
# SIDE = "BUY"
# QUANTITY="0.001"
# TIMESTAMP=$SERVER_TIME

# Prepare query string
QUERY_STRING="symbol=$SYMBOL&side=$SIDE&type=MARKET&quantity=$QUANTITY&timestamp=$TIMESTAMP"

# Generate the signature
SIGNATURE=$(echo -n "$QUERY_STRING" | openssl dgst -sha256 -hmac "$SECRET_KEY" | sed 's/^.* //')

# Send the request to place the market order
RESPONSE=$(curl -X POST "https://testnet.binance.vision/api/v3/order" \
-H "X-MBX-APIKEY: $API_KEY" \
-d "$QUERY_STRING&signature=$SIGNATURE")

# Output the response from Binance
echo "Response: $RESPONSE"


