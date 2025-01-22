#!/bin/bash

# NEW: The order has been created but not yet executed.
# PARTIALLY_FILLED: The order has been partially filled.
# FILLED: The order has been completely filled.
# CANCELED: The order was canceled.
# PENDING_CANCEL: The order is being canceled.
# REJECTED: The order was rejected.
# EXPIRED: The order has expired.

#----------------------------------------------------------------------------------------------------------------------------------
API_KEY="rtkDibROAhuUQM3vVKvVa36QzdROahMi2ycOSCLYpjbutb7jCqf8t18VhNvlV0yX"
SECRET_KEY="5Xv5xYSTRa08E9xK2A6ZaKXwtYQZq2qV19Hr8rrTsM0lpVXc52VBKFofJIkkWNpL"
SERVER_TIME=$(curl -s "https://testnet.binance.vision/api/v3/time" | jq -r '.serverTime')
#----------------------------------------------------------------------------------------------------------------------------------

SYMBOL="$1"
ORDER_ID="$2"  
TIMESTAMP=$SERVER_TIME

# Query String
QUERY_STRING="symbol=$SYMBOL&orderId=$ORDER_ID&timestamp=$TIMESTAMP"

# HMAC SHA256 signature
SIGNATURE=$(echo -n "$QUERY_STRING" | openssl dgst -sha256 -hmac "$SECRET_KEY" | sed 's/^.* //')

# API request
RESPONSE=$(curl -s -H "X-MBX-APIKEY: $API_KEY" \
"https://testnet.binance.vision/api/v3/order?$QUERY_STRING&signature=$SIGNATURE")

# error handling
ERROR=$(echo "$RESPONSE" | jq -r ".code")

if [ "$ERROR" == "-2013" ]; then
    python3 "./dialog boxes/failed_order.py" "Order does not exist."
else
    STATUS=$(echo $RESPONSE | jq -r ".status")
    SIDE=$(echo "$RESPONSE" | jq -r ".side")
    TYPE=$(echo "$RESPONSE" | jq -r ".type")

    python3 "./dialog boxes/status.py" "$STATUS" "$SIDE" "$TYPE"

fi

echo "$RESPONSE"



