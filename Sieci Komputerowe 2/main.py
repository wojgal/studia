import tkinter as tk
from tkinter import ttk
import tkinter.messagebox
from tkinter.filedialog import askopenfilenames
import subprocess

C_CLIENT = 'a.exe'
server_ip = 0
server_port = 0
files_paths = False
files_names = []
settings_window_open = False



def add_file():
    add_button_text.set('Ładowanie plików ...')

    global files_paths, files_names

    files_names.clear()
    files_paths = askopenfilenames()
    
    for f_path in files_paths:
        f_name = f_path.split('/')[len(f_path.split('/')) - 1]
        files_names.append(f_name)

    files_table = ttk.Treeview(root)

    files_table.column('#0', width=600, minwidth=25)
    files_table.heading('#0', text='Dodane pliki', anchor='center')

    for idx, name in enumerate(files_names):
        files_table.insert(parent='', index='end', iid=idx, text=name)

    files_table
    files_table.grid(column=1, row=2)


    if files_paths:
        show_info('Pomyślnie dodano pliki.')
        
    add_button_text.set('Dodaj pliki')



def compress_file():
    global files_paths, files_names

    if not files_paths:
        show_warning('Nie dodano żadnego pliku!')
        return

    if not server_ip:
        show_warning('Nie dodano adresu ip!')
        return

    if not server_port:
        show_warning('Nie dodano portu!')
        return

    f_amount = str(len(files_paths))

    command = C_CLIENT + ' ' + server_ip + ' ' + server_port + ' ' + f_amount

    for f_path, f_name in zip(files_paths, files_names):
        if f_path.find(f_name) == -1:
            show_error('Źle odczytana kolejność plików!')
            return
        
        command += ' "' + f_name + '" "' + f_path + '"'

    subproc = subprocess.run(command, capture_output=True, text=True)
    process_return = int(subproc.returncode)

    if process_return:
        error = subproc.stdout
        show_error('Nie udało się skompresować plików!\n\n' + error)
    else:
        show_info('Pliki zostały pomyślnie skompresowany.')
        add_button_text.set('Dodaj pliki')




def settings():
    global server_ip, server_port, settings_window_open

    if settings_window_open:
        return
    
    settings_window_open = True

    def close_by_X():
        global settings_window_open
        settings_window_open = False
        window.destroy()

    def close():
        global server_ip, server_port, settings_window_open

        if not check_ip_correctnes(ip_entry.get()):
            show_warning('Niepoprawne ip!')
            return

        if not check_port_correctnes(port_entry.get()):
            show_warning('Niepoprawny port!')
            return

        server_ip = ip_entry.get()
        server_port = port_entry.get()
        save_properties()
        settings_window_open = False
        window.destroy()

    window = tk.Toplevel()
    window.title('Opcje')
    window.protocol('WM_DELETE_WINDOW', close_by_X)

    cnvs = tk.Canvas(window, width=384, height=240, bg='#ECFCFF')
    cnvs.grid(columnspan=3, rowspan=5)

    ip_label = tk.Label(window, text='IP serwera', font='sans 12 bold', bg='#ECFCFF')
    ip_label.grid(column=1, row=0)
    ip_entry = tk.Entry(window, width=30, bg='#D4E3E6')
    ip_entry.grid(column=1, row=1)
    if server_ip:
        ip_entry.insert(0, server_ip[0:16])


    port_label = tk.Label(window, text='Port serwera', font='sans 12 bold', bg='#ECFCFF')
    port_label.grid(column=1, row=2)
    port_entry = tk.Entry(window, width=30, bg='#D4E3E6')
    port_entry.grid(column=1, row=3)
    if server_port:
        port_entry.insert(0, server_port)

    set_button = tk.Button(window, text='Zastosuj', command=close, font='sans 10 bold', bg='#7EEAFF')
    set_button.grid(column=1, row=4)



def check_ip_correctnes(ip):
    if not len(ip):
        return False

    if ip[0] == '.':
        return False

    if ip[-1] == '.':
        return False

    last_char = False

    for char in ip:
        if last_char == '.' and char == '.':
            return False
        last_char = char

    if ip.count('.') != 3:
        return False 

    for number in ip.split('.'):
        if not number.isdigit():
            return False

        if not 0 <= int(number) <= 255:
            return False

        if str(int(number)) != number:
            return False

    return True

        

def check_port_correctnes(port):
    if not len(port):
        return True

    if not port.isdigit():
        return False

    if port[0] == '0' and len(port) > 1:
        return False

    return True



def load_properties():
    global server_ip, server_port

    properties = open('properties.txt', 'r+')
    lines = properties.readlines()

    for line in lines:
        line.replace('\n', '')
        name, value = line.split('=')

        if name == 'ip':
            server_ip = value[:-1]

        if name == 'port':
            server_port = value[:-1]

    properties.close()



def save_properties():
    global server_ip, server_port

    properties = open('properties.txt', 'w')
    properties.truncate(0)

    properties.write('ip=' + server_ip + '\n')
    properties.write('port=' + server_port + '\n')

    properties.close()



def show_info(text):
    tkinter.messagebox.showinfo('Informacja', text)



def show_warning(text):
    tkinter.messagebox.showwarning('Ostrzeżenie', text)



def show_error(text):
    tkinter.messagebox.showerror('Błąd', text)



if __name__ == '__main__':

    load_properties()

    root = tk.Tk()
    root.title('Kompresja plikow')
    canvas = tk.Canvas(root, width=768, height=480, bg='#ECFCFF')
    canvas.grid(columnspan=3, rowspan=5)

    insutrctions = tk.Label(root, text='Wybierz pliki do kompresji', font='sans 14 bold', bg='#ECFCFF')
    insutrctions.grid(columnspan=3, column=0, row=0)

    add_button_text = tk.StringVar()
    add_button_text.set('Dodaj pliki')

    add_button = tk.Button(root, textvariable=add_button_text, command=add_file, font='sans 10 bold', bg='#7EEAFF')
    add_button.grid(column=1, row=1)

    start_button = tk.Button(root, text='Kompresuj', command=compress_file, font='sans 10 bold', bg='#7EEAFF')
    start_button.grid(column=1, row=3)

    options_button = tk.Button(root, text='Opcje', command=settings, font='sans 10 bold', bg='#7EEAFF')
    options_button.grid(column=2, row=4)

    root.mainloop()
