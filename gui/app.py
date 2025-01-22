import tkinter as tk 
import subprocess  #for running cpp with this

#----------------------------------------------------------main window --------------------------------------------------------------------------
main = tk.Tk()  
main.title("BinanceAPI Client")
main.geometry("1080x720")  
main.configure(bg="#079992")
#-------------------------------------------------------------------------------------------------------------------------------------

def PlaceOrder():
    symbol = symbol_entry.get().upper()
    order = order_type.get()
    side = side_type.get()
    quantity = quantity_entry.get()
    price = price_entry.get()
    print("Order placing ......")
    print("\n")

    
    output = subprocess.run( ['./build/place', symbol, side, order, quantity, price],
        capture_output=True, text=True)
    
    print(output.stdout)
    if output.stderr :
        print(output.stderr)

def checkStatus():
    symbol = symbol_status_entry.get().upper()
    orderID = orderID_status_entry.get().upper()

    print("Checking status ....")
    print("\n")

    output = subprocess.run( ['./scripts/status.sh', symbol, orderID],
        capture_output=True, text=True)
    
    print(output.stdout)
    if output.stderr :
        print(output.stderr)

def cancelOrder():
    symbol = symbol_cancel_entry.get().upper()
    orderID = orderID_cancel_entry.get().upper()

    print("Cancelling ....")
    print("\n")

    output = subprocess.run( ['./build/cancel', symbol, orderID],
        capture_output=True, text=True)
    
    print(output.stdout)
    if output.stderr :
        print(output.stderr)


# ----------------------------------------------------------order---------------------------------------------------------------------------------
#frame for place order section
place_order_frame = tk.Frame(main , bg = "#218c74")
place_order_frame.pack(pady = 100 , padx = 5 ) 

# orderbutton  , calls PlaceOrder fxn
Orderbutton = tk.Button(place_order_frame , text = "Place Order" , command = PlaceOrder ).grid(row = 0 , column = 0 , pady = 5 ) 

# symbol selection
tk.Label(place_order_frame, text = "Enter symbol : ").grid(row = 1 , column = 0 , padx = 5 , pady = 5)
symbol_entry = tk.Entry(place_order_frame )
symbol_entry.grid(row = 2 , column = 0 , padx = 5 , pady = 5)

#order type selection
tk.Label(place_order_frame,text = "Select Order Type : ").grid(row = 1 , column = 1 , padx = 5 , pady = 5 )
order_type = tk.StringVar(value = "LIMIT") #default val
order_drpdwn_options = ["LIMIT" , "MARKET"]
tk.OptionMenu(place_order_frame, order_type , *order_drpdwn_options).grid(row = 2 , column = 1 , padx= 5 , pady = 5)

# side selection
tk.Label(place_order_frame,text = "Select Side : ").grid(row = 1 , column = 2 , padx = 5 , pady = 5 )
side_type = tk.StringVar(value = "BUY")
side_type_options = ["BUY" , "SELL"]
tk.OptionMenu(place_order_frame , side_type , *side_type_options ).grid(row = 2 , column = 2 , padx = 5 , pady = 5)

#quantity selection
tk.Label(place_order_frame, text = "Quantity : ").grid(row = 1 , column = 3 , padx = 5 , pady = 5)
quantity_entry = tk.Entry(place_order_frame )
quantity_entry.grid(row = 2 , column = 3 , padx = 5 , pady = 5)

#price selection
tk.Label(place_order_frame, text = "Price : ").grid(row = 1 , column = 4 , padx = 5 , pady = 5)
price_entry = tk.Entry(place_order_frame )
price_entry.grid(row = 2 , column = 4 , padx = 5 , pady = 5)
price_entry.insert(0,"(leave in case of market)")
# -------------------------------------------------------------------------------------------------------------------------------------------------

#-------------------------------------------------------status-------------------------------------------------------------------------------------
#frame for status
status_frame = tk.Frame(main , bg = "#218c74")
status_frame.pack(pady = 100 , padx = 5)

#check status button
check_status_button = tk.Button(status_frame , text = "check status" , command = checkStatus).grid(row = 0 , column = 1 )

# symbol entry
tk.Label(status_frame , text = "Symbol : ").grid(row = 1 , column = 0 )
symbol_status_entry = tk.Entry(status_frame )
symbol_status_entry.grid(row = 1 , column = 1 , padx = 5 , pady = 5)

# order Id entry
tk.Label(status_frame, text = "Order ID : ").grid(row = 1 , column = 2 , padx = 5 , pady = 5)
orderID_status_entry = tk.Entry(status_frame )
orderID_status_entry.grid(row = 1 , column = 3 , padx = 5 , pady = 5)


#-------------------------------------------------------------------------------------------------------------------------------------------------

#------------------------------------------------------------------CANCEL-------------------------------------------------------------------------
cancel_frame = tk.Frame(main , bg = "#218c74")
cancel_frame.pack(pady = 100 , padx = 5)

#cancel button
cancel_button = tk.Button(cancel_frame , text = "cancel order" , command = cancelOrder).grid(row = 0 , column = 1 )

# symbol entry
tk.Label(cancel_frame , text = "Symbol : ").grid(row = 1 , column = 0 )
symbol_cancel_entry = tk.Entry(cancel_frame )
symbol_cancel_entry.grid(row = 1 , column = 1 , padx = 5 , pady = 5)

# order Id entry
tk.Label(cancel_frame, text = "Order ID : ").grid(row = 1 , column = 2 , padx = 5 , pady = 5)
orderID_cancel_entry = tk.Entry(cancel_frame )
orderID_cancel_entry.grid(row = 1 , column = 3 , padx = 5 , pady = 5)

#---------------------------------------------------------------------------------------------------------------------------------------------------
# event loop
main.mainloop()