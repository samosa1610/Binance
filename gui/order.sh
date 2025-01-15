#!/bin/bash

# Your Binance API key and secret key
API_KEY="rtkDibROAhuUQM3vVKvVa36QzdROahMi2ycOSCLYpjbutb7jCqf8t18VhNvlV0yX"
SECRET_KEY="5Xv5xYSTRa08E9xK2A6ZaKXwtYQZq2qV19Hr8rrTsM0lpVXc52VBKFofJIkkWNpL"

# Fetch the server time
SERVER_TIME=$(curl -s "https://testnet.binance.vision/api/v3/time" | jq -r '.serverTime')

# Prepare the order parameters
SYMBOL="BTCUSDT"
SIDE="BUY"
TYPE="LIMIT"
TIME_IN_FORCE="GTC"
QUANTITY="0.001"
PRICE="35000"
TIMESTAMP=$SERVER_TIME

# Concatenate the parameters for the signature
QUERY_STRING="symbol=$SYMBOL&side=$SIDE&type=$TYPE&timeInForce=$TIME_IN_FORCE&quantity=$QUANTITY&price=$PRICE&timestamp=$TIMESTAMP"

# Generate the signature using HMAC SHA256
SIGNATURE=$(echo -n "$QUERY_STRING" | openssl dgst -sha256 -hmac "$SECRET_KEY" | sed 's/^.* //')

# Make the API request to place the order
RESPONSE=$(curl -X POST "https://testnet.binance.vision/api/v3/order" \
-H "X-MBX-APIKEY: $API_KEY" \
-d "$QUERY_STRING&signature=$SIGNATURE")

# Output the response
echo "Response: $RESPONSE"
