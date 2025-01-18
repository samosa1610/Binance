import tkinter as tk 
from tkinter import messagebox
import sys


error = sys.argv[1]  
for i in range(2, len(sys.argv)):
    error += " " + sys.argv[i]      


main = tk.Tk()
main.withdraw()
messagebox.showerror("Order Failed", f"Error: {error}")
main.destroy()
