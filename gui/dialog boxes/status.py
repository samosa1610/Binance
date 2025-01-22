import tkinter as tk 
from tkinter import messagebox
import sys


status = sys.argv[1]  
side = sys.argv[2]
TYPE = sys.argv[3]
# for i in range(2, len(sys.argv)):
#     error += " " + sys.argv[i]      


main = tk.Tk()
main.withdraw()
messagebox.showinfo("STATUS" , f"Status: {status}\nSide: {side}\nType: {TYPE}" )
main.destroy()
