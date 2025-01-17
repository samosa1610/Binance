import tkinter as tk 
from tkinter import messagebox

main = tk.Tk()
main.withdraw()
messagebox.showinfo("Order Confirmation", "✅ Your order has been placed successfully!")
main.destroy()
