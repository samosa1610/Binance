#include <iostream>
#include <string>
#include <cstdlib> // for command line comands

int main(int argc, char *argv[]) {

    std::string symbol = argv[1];
    std::string orderID = argv[2];
    

    std::string command = "./scripts/cancel_order.sh " + symbol + " " + orderID  ;

        // Execute the command
        int result = system(command.c_str());

        if (result != 0) {
            std::cerr << "Error executing the shell script.\n";
            return 1;
        }

        std::cout << "Shell script executed successfully.\n";
      
}