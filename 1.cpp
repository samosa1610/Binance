#include <iostream>
#include <curl/curl.h>

// Callback function to write the data received by libcurl
size_t write_callback(void *contents, size_t size, size_t nmemb, std::string *output) {
    size_t total_size = size * nmemb;
    output->append(static_cast<char*>(contents), total_size); // Append the data to the string
    return total_size; // Return the size of the data processed
}

int main() {
    CURL *curl;
    CURLcode res;
    std::string read_buffer;

    // Initialize libcurl
    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    if(curl) {
        // Set the URL to send the GET request to
        curl_easy_setopt(curl, CURLOPT_URL, "http://google.com");

        // Set the callback function to handle the response data
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_callback);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &read_buffer);

        // Perform the HTTP GET request
        res = curl_easy_perform(curl);

        // Check if the request was successful
        if(res != CURLE_OK) {
            std::cerr << "curl_easy_perform() failed: " << curl_easy_strerror(res) << std::endl;
        } else {
            // Print the response data
            std::cout << "Response data: " << std::endl;
            std::cout << read_buffer << std::endl;
        }

        // Cleanup
        curl_easy_cleanup(curl);
    }

    // Cleanup global libcurl environment
    curl_global_cleanup();

    return 0;
}
