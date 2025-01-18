#include <iostream>
#include <string>
#include <cstdlib> // for command line comands

int main(int argc, char *argv[]) {

    if(std::string(argv[3]) == "LIMIT"){
        for(int i = 0 ; i < 6  ; i ++){
            if (std::string(argv[i]).empty() ) {
                // std::string error = "Use all parameters correctly";
                std::cerr << "Error : Use all parameters correctly\n";
                // std::string command = "python3 \"./dialog boxes/failed_order.py\"" + error;
                // system(command.c_str());
                return 1;
            }   
        }
    }


//-----------------Binance credentials--------------------------------------------------------------
std::string API_KEY="rtkDibROAhuUQM3vVKvVa36QzdROahMi2ycOSCLYpjbutb7jCqf8t18VhNvlV0yX";
std::string SECRET_KEY="5Xv5xYSTRa08E9xK2A6ZaKXwtYQZq2qV19Hr8rrTsM0lpVXc52VBKFofJIkkWNpL";
//-------------------------------------------------------------------------------------------------


// ---------------------------------inputs------------------------------------
    std::string symbol = argv[1];
    std::string side = argv[2];
    std::string order_type = argv[3];
    std::string quantity = argv[4];
    std::string price = argv[5];
//--------------------------------------------------------------------------------

    std::cout << "Order Recived:\n";
    std::cout << "Symbol: " << symbol << "\n";
    std::cout << "Order Type: " << order_type << "\n";
    std::cout << "Side: " << side << "\n";
    std::cout << "Quantity: " << quantity << "\n";
    std::cout << "Price: " << price << "\n";

//----------------------------------------------------------------------------------------
    if(std::string(argv[3]) == "LIMIT" ){
        std::string command = "./scripts/limit_order.sh " + symbol + " " + side + " " + order_type + " "  + quantity + " " + price ;

        //get result
        int result = system(command.c_str());

        if (result != 0) {
            std::cerr << "Error executing the shell script.\n";
            return 1;
        }

        std::cout << "Shell script executed successfully.\n";
    }
    else if( std::string(argv[3]) == "MARKET"){
        std::string command = "./scripts/market_order.sh " + symbol + " " + side + " " + quantity  ;

        // Execute the command
        int result = system(command.c_str());

        if (result != 0) {
            std::cerr << "Error executing the shell script.\n";
            return 1;
        }

        std::cout << "Shell script executed successfully.\n";
    }

    
//---------------------------------------------------------------------------------------------
    return 0;
}