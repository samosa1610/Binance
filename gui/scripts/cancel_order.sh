
#!/bin/bash

# Binance API key and secret key
API_KEY="rtkDibROAhuUQM3vVKvVa36QzdROahMi2ycOSCLYpjbutb7jCqf8t18VhNvlV0yX"
SECRET_KEY="5Xv5xYSTRa08E9xK2A6ZaKXwtYQZq2qV19Hr8rrTsM0lpVXc52VBKFofJIkkWNpL"

# Get the current server time from Binance
SERVER_TIME=$(curl -s "https://testnet.binance.vision/api/v3/time" | jq -r '.serverTime')

# Input parameters
SYMBOL="$1"
ORDER_ID="$2"
TIMESTAMP=$SERVER_TIME

# Prepare the query string with the required parameters
QUERY_STRING="symbol=$SYMBOL&orderId=$ORDER_ID&timestamp=$TIMESTAMP"

# Generate the HMAC SHA256 signature using your secret key
SIGNATURE=$(echo -n "$QUERY_STRING" | openssl dgst -sha256 -hmac "$SECRET_KEY" | sed 's/^.* //')

# Append the signature to the query string
QUERY_STRING="$QUERY_STRING&signature=$SIGNATURE"

# Make the API call to cancel the order
RESPONSE=$(curl -X DELETE "https://testnet.binance.vision/api/v3/order" \
-H "X-MBX-APIKEY: $API_KEY" \
-d "$QUERY_STRING")

# Output the response
echo "Response: $RESPONSE"

