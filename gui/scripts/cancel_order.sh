
#!/bin/bash
#----------------------------------------------------------------------------------------------------------------------------------
API_KEY="rtkDibROAhuUQM3vVKvVa36QzdROahMi2ycOSCLYpjbutb7jCqf8t18VhNvlV0yX"
SECRET_KEY="5Xv5xYSTRa08E9xK2A6ZaKXwtYQZq2qV19Hr8rrTsM0lpVXc52VBKFofJIkkWNpL"
SERVER_TIME=$(curl -s "https://testnet.binance.vision/api/v3/time" | jq -r '.serverTime')
# -----------------------------------------------------------------------------------------------------------------------------------------------


SYMBOL="$1"
ORDER_ID="$2"
TIMESTAMP=$SERVER_TIME

QUERY_STRING="symbol=$SYMBOL&orderId=$ORDER_ID&timestamp=$TIMESTAMP"

# HMAC SHA256 signature
SIGNATURE=$(echo -n "$QUERY_STRING" | openssl dgst -sha256 -hmac "$SECRET_KEY" | sed 's/^.* //')

# new query
QUERY_STRING="$QUERY_STRING&signature=$SIGNATURE"

# API call
RESPONSE=$(curl -X DELETE "https://testnet.binance.vision/api/v3/order" \
-H "X-MBX-APIKEY: $API_KEY" \
-d "$QUERY_STRING")

#response 
echo "Response: $RESPONSE"

# error handling
ERROR=$(echo "$RESPONSE" | jq -r ".code")

if [ "$ERROR" = "-2011" ]; then 
    python3 "./dialog boxes/failed_order.py" "Order does not exist."
else
    python3 "./dialog boxes/canceled.py" 
fi

