import tkinter as tk
from tkinter import messagebox
import sys


SYMBOL = sys.argv[1]  
SIDE = sys.argv[2]    
TYPE = sys.argv[3]   
ORDER_ID = sys.argv[4]   
PRICE = sys.argv[5]

message = (
    f"Order Details:\n"
    f"Symbol: {SYMBOL}\n"
    f"Side: {SIDE}\n"
    f"Type: {TYPE}\n"
    f"Price: {PRICE}\n"
    f"Order ID: {ORDER_ID}\n\n"
    "Your order has been placed successfully!"
)

main = tk.Tk()
main.withdraw()  
messagebox.showinfo("Order Confirmation", message)
main.destroy()
