import mysql.connector
from tkinter import *
from tkinter import ttk, messagebox

# Connect to MySQL
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="16233333Abd@",        # replace with your actual password
    database="PBL"    # replace with your schema name
)
cursor = conn.cursor()

# GUI setup
root = Tk()
root.title("Student Database Manager")
root.geometry("650x450")
root.configure(bg="#e8f0fe")

title = Label(root, text="Student Database CRUD App", font=("Arial", 18, "bold"), bg="#e8f0fe", fg="#202124")
title.pack(pady=10)

# Frame for inputs
frame = Frame(root, bg="#e8f0fe")
frame.pack(pady=10)

Label(frame, text="ID:", bg="#e8f0fe").grid(row=0, column=0, padx=5, pady=5)
entry_id = Entry(frame)
entry_id.grid(row=0, column=1, padx=5, pady=5)

Label(frame, text="Name:", bg="#e8f0fe").grid(row=1, column=0, padx=5, pady=5)
entry_name = Entry(frame)
entry_name.grid(row=1, column=1, padx=5, pady=5)

Label(frame, text="CGPA:", bg="#e8f0fe").grid(row=2, column=0, padx=5, pady=5)
entry_cgpa = Entry(frame)
entry_cgpa.grid(row=2, column=1, padx=5, pady=5)

# CRUD Functions
def add_student():
    try:
        sid = entry_id.get()
        name = entry_name.get()
        cgpa = entry_cgpa.get()
        cursor.execute("INSERT INTO Student (StudentID, Name, CGPA) VALUES (%s, %s, %s)", (sid, name, cgpa))
        conn.commit()
        messagebox.showinfo("Success", "Student added successfully!")
        show_students()
    except Exception as e:
        messagebox.showerror("Error", str(e))

def show_students():
    cursor.execute("SELECT StudentID, Name, CGPA FROM Student")
    rows = cursor.fetchall()
    for row in tree.get_children():
        tree.delete(row)
    for r in rows:
        tree.insert("", "end", values=r)

def update_student():
    try:
        sid = entry_id.get()
        name = entry_name.get()
        cgpa = entry_cgpa.get()
        cursor.execute("UPDATE Student SET Name=%s, CGPA=%s WHERE StudentID=%s", (name, cgpa, sid))
        conn.commit()
        messagebox.showinfo("Updated", "Student updated successfully!")
        show_students()
    except Exception as e:
        messagebox.showerror("Error", str(e))

def delete_student():
    try:
        sid = entry_id.get()
        cursor.execute("DELETE FROM Student WHERE StudentID=%s", (sid,))
        conn.commit()
        messagebox.showinfo("Deleted", "Student deleted successfully!")
        show_students()
    except Exception as e:
        messagebox.showerror("Error", str(e))

# Buttons
btn_frame = Frame(root, bg="#e8f0fe")
btn_frame.pack(pady=10)

Button(btn_frame, text="Add", width=12, bg="#34a853", fg="white", command=add_student).grid(row=0, column=0, padx=5)
Button(btn_frame, text="Show", width=12, bg="#4285f4", fg="white", command=show_students).grid(row=0, column=1, padx=5)
Button(btn_frame, text="Update", width=12, bg="#fbbc05", fg="black", command=update_student).grid(row=0, column=2, padx=5)
Button(btn_frame, text="Delete", width=12, bg="#ea4335", fg="white", command=delete_student).grid(row=0, column=3, padx=5)

# Table to display students
tree = ttk.Treeview(root, columns=("ID", "Name", "CGPA"), show="headings")
tree.heading("ID", text="ID")
tree.heading("Name", text="Name")
tree.heading("CGPA", text="CGPA")
tree.pack(pady=20, fill="x")

# Auto-load students on startup
show_students()

root.mainloop()
