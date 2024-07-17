import tkinter as tk
import tkinter.messagebox
from tkinter.filedialog import askopenfilename
import matplotlib.pyplot as plt
import numpy
from skimage import io
import pydicom
from pydicom import data
import tomograf



def show_info(text):
    tkinter.messagebox.showinfo('Informacja', text)



def show_error(text):
    tkinter.messagebox.showerror('Błąd', text)



def add_file():
    add_button_text.set('Ładowanie zdjecia ...')

    global file_path, file_name

    file_path = askopenfilename()
    file_name = file_path.split('/')[len(file_path.split('/')) - 1]
    picture_name_text.set(file_name)

    if file_path:
        show_info('Pomyślnie dodano pliki.')
    else:
        show_error('nie zaladowano pliku!')
        
    add_button_text.set('Dodaj zdjecie')



def check_if_int(value):
    try:
        int(value)

    except:
        return False
    
    else:
        return True
    


def check_delta_alpha():
    delta_alpha_value = delta_alpha_entry.get()
    correct = True

    if not check_if_int(delta_alpha_value):
        correct = False

    delta_alpha_value = int(delta_alpha_value)

    if delta_alpha_value <= 0:
        correct = False

    if correct:
        return delta_alpha_value
    
    show_error('Niepoprawna wartosc w Delta Alpha!')
    return False



def check_detector_amount():
    detector_amount_value = detector_amount_entry.get()
    correct = True

    if not check_if_int(detector_amount_value):
        correct = False

    detector_amount_value = int(detector_amount_value)

    if detector_amount_value <= 0:
        correct = False

    if correct:
        return detector_amount_value
    
    show_error('Niepoprawna wartosc w liczbie detektorow!')
    return False



def check_system_range():
    system_range_value = system_range_entry.get()
    correct = True

    if not check_if_int(system_range_value):
        correct = False

    system_range_value = int(system_range_value)

    if system_range_value <= 0:
        correct = False

    if correct:
        return system_range_value
    
    show_error('Niepoprawna wartosc w rozpietosci ukladu!')
    return False



def load_image(file_path):
    extension = file_path[-4:]

    if extension == '.dcm':
        image = pydicom.dcmread(file_path).pixel_array
        return image
    
    image = io.imread(file_path, as_gray=True).astype('float64')
    image = numpy.asarray(image)

    return image



def save_as_dicom(image, name, address, id_, birth_date, more_information):
    file_name = data.get_testdata_files('CT_small.dcm')[0]
    file = pydicom.dcmread(file_name)

    image = numpy.asarray(image, dtype=numpy.uint16)

    file.Rows = image.shape[1]
    file.Columns = image.shape[0]
    file.PixelData = image.tobytes()

    file.PatientName = name
    file.PatientAddress = address
    file.PatientID = id_
    file.PatientBirthDate = birth_date
    file.StudyDescription = more_information

    global file_path 
    f_name = file_path.split('/')[len(file_path.split('/')) - 1]
    file.save_as(f'{f_name}-dcm.dcm')


def draw_plots(img1, img2, img3):
    plt.ion()
    
    fig, (ax1, ax2, ax3) = plt.subplots(1, 3)
    axim1 = ax1.imshow(img1, cmap='gray')
    axim2 = ax2.imshow(img2, cmap='gray')
    axim3 = ax3.imshow(img3, cmap='gray')

    plt.show()

    return fig, axim1, axim2, axim3



def update_plots(fig, axim1, axim2, axim3, img1, img2, img3):
    axim1.set_data(img1)
    axim2.set_data(img2)
    axim3.set_data(img3)

    fig.canvas.flush_events()



def start():
    #Wczytanie i sprawdzanie poprawnosci wprowadzonych parametrow
    delta_alpha_value = check_delta_alpha()

    if not delta_alpha_value:
        return 
    
    detector_amount_value = check_detector_amount()

    if not detector_amount_value:
        return
    
    system_range_value = check_system_range()

    if not system_range_value:
        return
    
    show_steps = show_steps_value.get()

    number_of_scans = 360 // delta_alpha_value

    #Zaladowanie oryginalnego obrazu
    global file_path
    image_original = load_image(file_path)

    sinogram = []
    image_reconstruction = numpy.zeros(image_original.shape)

    fig = False

    for degree in numpy.linspace(0, 359, number_of_scans):
        sinogram_row = []
        points_list = []

        emiter, detector_list = tomograf.generate_emiter_and_detectors(image_original.shape[0] // 2 - 1, degree, system_range_value, detector_amount_value)
        step_tmp = numpy.zeros(image_original.shape)
        
        for det_x, det_y in detector_list:
            average_pixel, points = tomograf.avg_pixel(emiter[0], emiter[1], det_x, det_y, image_original)

            sinogram_row.append(average_pixel)
            points_list.append(points)

        sinogram.append(sinogram_row)

        for idx, pts in enumerate(points_list):
            for x, y in pts:
                    try:
                        step_tmp[x][y] += sinogram_row[idx]
                    except:
                        continue

        image_reconstruction += step_tmp

        step_sinogram = tomograf.transform_to_square_image(numpy.asarray(sinogram))
        step_sinogram = tomograf.normalize_image(step_sinogram)

        step_image_reconstruction = tomograf.normalize_image(image_reconstruction)

        if show_steps:
            if not fig:
                fig, ax1, ax2, ax3 = draw_plots(image_original, step_sinogram, step_image_reconstruction)
            else:
                update_plots(fig, ax1, ax2, ax3, image_original, step_sinogram, step_image_reconstruction)

    name_value = name_entry.get()
    address_value = address_entry.get()
    id_value = id_entry.get()
    birth_value = birth_entry.get()
    information_value = information_entry.get()

    image_reconstruction = tomograf.normalize_image(image_reconstruction)

    save_as_dicom(image_reconstruction, name_value, address_value, id_value, birth_value, information_value)




file_path = False
file_names = False
sinogram_file = False



if __name__ == '__main__':

    root = tk.Tk()
    root.title('Tomograf')
    canvas = tk.Canvas(root, width=1500, height=600, bg='#ECFCFF')
    canvas.grid(columnspan=4, rowspan=7)

    insutrctions = tk.Label(root, text='Ustawienia tomografu', font='sans 18 bold', bg='#ECFCFF')
    insutrctions.grid(columnspan=3, column=0, row=0)

    add_button_text = tk.StringVar()
    add_button_text.set('Dodaj zdjecie')
    add_button = tk.Button(root, textvariable=add_button_text, command=add_file, font='sans 10 bold', bg='#7EEAFF')
    add_button.grid(column=0, row=1)

    picture_name_text = tk.StringVar()
    picture_name_text.set('---')
    picture_name = tk.Label(root, textvariable=picture_name_text, font='sans 10 bold', bg='#7EEAFF')
    picture_name.grid(column=1, row=1)

    delta_alpha = tk.Label(root, text='Delta Alpha', font='sans 10 bold', bg='#7EEAFF')
    delta_alpha.grid(column=0, row=2)
    delta_alpha_entry = tk.Entry(root, width=15, bg='#7EEAFF')
    delta_alpha_entry.grid(column=1, row=2)

    detector_amount = tk.Label(root, text='Liczba detektorow', font='sans 10 bold', bg='#7EEAFF')
    detector_amount.grid(column=0, row=3)
    detector_amount_entry = tk.Entry(root, width=15, bg='#7EEAFF')
    detector_amount_entry.grid(column=1, row=3)

    system_range = tk.Label(root, text='Rozpietosc ukladu', font='sans 10 bold', bg='#7EEAFF')
    system_range.grid(column=0, row=4)
    system_range_entry = tk.Entry(root, width=15, bg='#7EEAFF')
    system_range_entry.grid(column=1, row=4)

    show_steps_value = tk.IntVar()
    show_steps_checkbox = tk.Checkbutton(root, text='Pokaz kroki', variable=show_steps_value, onvalue=1, offvalue=0, font='sans 10 bold', bg='#7EEAFF')
    show_steps_checkbox.grid(column=0, row=5)

    start_button = tk.Button(root, text='Start', command=start, font='sans 10 bold', bg='#7EEAFF')
    start_button.grid(column=0, row=6)

    name = tk.Label(root, text='Imie', font='sans 10 bold', bg='#7EEAFF')
    name.grid(column=2, row=1)
    name_entry = tk.Entry(root, width=15, bg='#7EEAFF')
    name_entry.grid(column=3, row=1)

    address = tk.Label(root, text='Adres', font='sans 10 bold', bg='#7EEAFF')
    address.grid(column=2, row=2)
    address_entry = tk.Entry(root, width=15, bg='#7EEAFF')
    address_entry.grid(column=3, row=2)

    id_ = tk.Label(root, text='Pesel', font='sans 10 bold', bg='#7EEAFF')
    id_.grid(column=2, row=3)
    id_entry = tk.Entry(root, width=15, bg='#7EEAFF')
    id_entry.grid(column=3, row=3)

    birth = tk.Label(root, text='Data urodzenia', font='sans 10 bold', bg='#7EEAFF')
    birth.grid(column=2, row=4)
    birth_entry = tk.Entry(root, width=15, bg='#7EEAFF')
    birth_entry.grid(column=3, row=4)

    information = tk.Label(root, text='Dodatkowe informacje', font='sans 10 bold', bg='#7EEAFF')
    information.grid(column=2, row=5)
    information_entry = tk.Entry(root, width=15, bg='#7EEAFF')
    information_entry.grid(column=3, row=5)

    root.mainloop()