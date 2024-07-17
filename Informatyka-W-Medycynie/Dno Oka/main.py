import tkinter as tk
from tkinter.filedialog import askopenfilename
import eye



def add_file(text_var, f_type):
    file_path = askopenfilename()
    file_name = file_path.split('/')[-1]

    text_var.set(file_name)

    if f_type == 'photo':
        global photo_path
        photo_path = 'data/inputs/' + file_name

    elif f_type == 'mask':
        global mask_path
        mask_path = 'data/masks/' + file_name

    elif f_type == 'model':
        global model_path 
        model_path = 'data/models/' + file_name
    


def detect():
    global photo_path, mask_path, model_path

    image_original, image_gray, image_vessels = eye.detect_eye_vessels(photo_path)
    image_vessels = eye.add_mask_to_image(image_vessels, mask_path)
    conf_matrix, true_positive, false_positive, false_negative, true_negative  = eye.confusion_matrix(image_vessels, model_path)
    accuracy, sensitivity, specificity, precision, g_mean, f_measure = eye.effectiveness_measures(true_positive, false_positive, false_negative, true_negative)
    eye.draw_images(image_original, image_gray, image_vessels, conf_matrix, accuracy, sensitivity, specificity, precision, g_mean, f_measure)



def main():
    global photo_path, mask_path, model_path

    root = tk.Tk()
    root.title('Dno Oka')
    canvas = tk.Canvas(root, width=640, height=480)
    canvas.grid(columnspan=3, rowspan=3)

    name = tk.Label(root, text='Wykrywanie naczyn dna siatkowkia oka')
    name.grid(row=0, column=1)

    add_photo_button_var = tk.StringVar()
    add_photo_button_var.set('Dodaj zdjecie oka')
    add_photo_button = tk.Button(root, textvariable=add_photo_button_var, command=lambda: add_file(add_photo_button_var, 'photo'))
    add_photo_button.grid(column=0, row=1)

    add_mask_button_var = tk.StringVar()
    add_mask_button_var.set('Dodaj zdjecie maski')
    add_mask_button = tk.Button(root, textvariable=add_mask_button_var, command=lambda: add_file(add_mask_button_var, 'mask'))
    add_mask_button.grid(column=1, row=1)

    add_model_button_var = tk.StringVar()
    add_model_button_var.set('Dodaj zdjecie ekspercie')
    add_model_button = tk.Button(root, textvariable=add_model_button_var, command=lambda: add_file(add_model_button_var, 'model'))
    add_model_button.grid(column=2, row=1)

    detect_button = tk.Button(root, text='Wykryj naczynia', command=detect)
    detect_button.grid(column=1, row=2)

    root.mainloop()



if __name__ == '__main__':
    main()
