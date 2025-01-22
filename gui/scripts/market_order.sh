#!/bin/bash
#----------------------------------------------------------------------------------------------------------------------------------
API_KEY="rtkDibROAhuUQM3vVKvVa36QzdROahMi2ycOSCLYpjbutb7jCqf8t18VhNvlV0yX"
SECRET_KEY="5Xv5xYSTRa08E9xK2A6ZaKXwtYQZq2qV19Hr8rrTsM0lpVXc52VBKFofJIkkWNpL"
SERVER_TIME=$(curl -s "https://testnet.binance.vision/api/v3/time" | jq -r '.serverTime')
#----------------------------------------------------------------------------------------------------------------------------------

SYMBOL="$1"
SIDE="$2"
QUANTITY="$3"
TIMESTAMP=$SERVER_TIME
TYPE="MARKET"
PRICE=""

# query string
QUERY_STRING="symbol=$SYMBOL&side=$SIDE&type=MARKET&quantity=$QUANTITY&timestamp=$TIMESTAMP"

# # HMAC SHA256 signature
SIGNATURE=$(echo -n "$QUERY_STRING" | openssl dgst -sha256 -hmac "$SECRET_KEY" | sed 's/^.* //')

# API request
RESPONSE=$(curl -X POST "https://testnet.binance.vision/api/v3/order" \
-H "X-MBX-APIKEY: $API_KEY" \
-d "$QUERY_STRING&signature=$SIGNATURE")

# response
echo "Response: $RESPONSE"

#storing response
LOG_FILE="./outputs/market_responses.json"

# Check if the log file exists
if [ ! -f "$LOG_FILE" ]; then
    # If the file doesn't exist
    echo "[" > "$LOG_FILE"
else
    # If the file exists
    sed -i '$ s/.$//' "$LOG_FILE"
    echo "," >> "$LOG_FILE" 
fi

echo "$RESPONSE" >> "$LOG_FILE"
echo "]" >> "$LOG_FILE"
echo "Response stored in $LOG_FILE"


#erro handling
ORDER_STATUS=$(echo "$RESPONSE" | jq -r '.status')

if [ "$ORDER_STATUS" == "NEW" ] || [ "$ORDER_STATUS" == "FILLED" ]; then
    ORDER_ID=$(echo "$RESPONSE" | jq -r ".orderId")
    python3 "./dialog boxes/order_placed.py" "$SYMBOL" "$SIDE" "$TYPE" "$ORDER_ID" "$PRICE"
else
    ERROR=$(echo "$RESPONSE" | jq -r '.msg')
    python3 "./dialog boxes/failed_order.py" "$ERROR"
fi


