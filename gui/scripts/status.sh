#!/bin/bash


# NEW: The order has been created but not yet executed.
# PARTIALLY_FILLED: The order has been partially filled.
# FILLED: The order has been completely filled.
# CANCELED: The order was canceled.
# PENDING_CANCEL: The order is being canceled.
# REJECTED: The order was rejected.
# EXPIRED: The order has expired.
# Your Binance API key and secret key

API_KEY="rtkDibROAhuUQM3vVKvVa36QzdROahMi2ycOSCLYpjbutb7jCqf8t18VhNvlV0yX"
SECRET_KEY="5Xv5xYSTRa08E9xK2A6ZaKXwtYQZq2qV19Hr8rrTsM0lpVXc52VBKFofJIkkWNpL"

# Parameters
SYMBOL="$1"
ORDER_ID="$2"  # Replace with your actual order ID

SERVER_TIME=$(curl -s "https://testnet.binance.vision/api/v3/time" | jq -r '.serverTime')
TIMESTAMP=$SERVER_TIME

# Create Query String
QUERY_STRING="symbol=$SYMBOL&orderId=$ORDER_ID&timestamp=$TIMESTAMP"

# Generate Signature
SIGNATURE=$(echo -n "$QUERY_STRING" | openssl dgst -sha256 -hmac "$SECRET_KEY" | sed 's/^.* //')

# Send Request and store response in RESPONSE variable
RESPONSE=$(curl -s -H "X-MBX-APIKEY: $API_KEY" \
"https://testnet.binance.vision/api/v3/order?$QUERY_STRING&signature=$SIGNATURE")

# Echo status from response
echo $RESPONSE | jq -r ".status"
echo "$RESPONSE" | jq -r ".side"
echo "$RESPONSE" | jq -r ".type"
