import tkinter as tk 
from tkinter import messagebox

main = tk.Tk()
main.withdraw()
messagebox.showinfo("CANCEL", "Your order has been cancelled successfully!")
main.destroy()
