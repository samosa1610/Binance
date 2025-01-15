#include <iostream>
#include <string>
#include <curl/curl.h>
#include <json/json.h>  // Include jsoncpp header

// Write callback function for handling response
size_t WriteCallback(void *contents, size_t size, size_t nmemb, std::string *output) {
    size_t total_size = size * nmemb;
    output->append((char*)contents, total_size);
    return total_size;
}

// Function to make GET request to Binance API
void getBinanceAPIData(const std::string &endpoint) {
    CURL *curl;
    CURLcode res;
    std::string response_string;
    
    // Base URL
    std::string base_url = "https://testnet.binance.vision/api";
    
    // Construct full URL
    std::string url = base_url + endpoint;
    
    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();
    
    if(curl) {
        curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallback);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &response_string);

        res = curl_easy_perform(curl);

        if(res != CURLE_OK) {
            std::cerr << "CURL Error: " << curl_easy_strerror(res) << std::endl;
        } else {
            // Parse JSON response using jsoncpp
            Json::CharReaderBuilder reader;
            Json::Value json_response;
            std::string errs;

            std::istringstream s(response_string);
            if (Json::parseFromStream(reader, s, &json_response, &errs)) {
                // Print pretty JSON output
                std::cout << json_response.toStyledString() << std::endl;
            } else {
                std::cerr << "Error parsing JSON: " << errs << std::endl;
            }
        }

        curl_easy_cleanup(curl);
    }

    curl_global_cleanup();
}

int main() {
    // Example endpoint to ping the Binance Spot Testnet API
    std::string endpoint = "/v3/exchangeInfo";
    getBinanceAPIData(endpoint);


    // You can use other endpoints by changing the `endpoint` string
    // Example: "/v3/account" to get account info (needs authentication)

    return 0;
}
