from matplotlib import pyplot as plt
import matplotlib.patheffects as path_effects
from skimage import filters
import numpy as np
import cv2
import math



def convert_to_white_black(image, value):
    WHITE = 1
    BLACK = 0

    for x, row in enumerate(image):
        for y, pixel in enumerate(row):
            if pixel > value:
                image[x][y] = WHITE
            else:
                image[x][y] = BLACK



def detect_eye_vessels(image_path):
    image_original = cv2.imread(image_path)
    image_original = cv2.cvtColor(image_original, cv2.COLOR_BGR2RGB)

    image_gray = cv2.cvtColor(image_original, cv2.COLOR_BGR2GRAY)

    image_vessels = filters.unsharp_mask(image_gray)
    image_vessels = filters.sato(image_vessels)
    convert_to_white_black(image_vessels, 0.01)

    return image_original, image_gray, image_vessels



def add_mask_to_image(image_vessels, mask_path):
    BLACK = 0

    mask = cv2.imread(mask_path)
    mask = cv2.cvtColor(mask, cv2.COLOR_BGR2GRAY)
    convert_to_white_black(mask, 100)

    shape = mask.shape
    width, height = shape[0], shape[1]

    for x in range(width):
        for y in range(height):
            if mask[x][y] == BLACK:
                image_vessels[x][y] = BLACK

    return image_vessels



def draw_images(image1, image2, image3, image4, accuracy, sensitivity, specificity, precision, g_mean, f_measure):
    _, axes = plt.subplots(nrows=2, ncols=3, figsize=(15, 15))

    ax = axes.ravel()

    ax[0].imshow(image1)
    ax[0].set_title('Original Image')
    
    ax[1].imshow(image2, cmap='gray')
    ax[1].set_title('Gray Image')
    
    ax[2].imshow(image3, cmap='gray')
    ax[2].set_title('Vessels Detected Image')

    ax[3].imshow(image4)
    ax[3].set_title('Confusion Image')

    string = 'True Positive - Green\nFalse Positive - Red\nFalse Negative - Blue\nTrue Negative - White\n\n'
    string += f'Accuracy: {accuracy}\nSensitivity: {sensitivity}\nSpecificity: {specificity}\nPrecision: {precision}\nG-Mean: {g_mean}\nF-measure: {f_measure} '

    text = ax[4].text(0.5, 0.5, string, ha='center', va='center', size=10)
    text.set_path_effects([path_effects.Normal()])

    plt.show()



def confusion_matrix(image, model_path):
    WHITE_1 = 1
    BLACK_1 = 0
    WHITE_3 = (255, 255, 255)
    BLACK_3 = (0, 0, 0)
    BLUE_3 = (0, 0, 255)
    RED_3 = (255, 0, 0)
    GREEN_3 = (0, 255, 0)

    conf_matrix = []

    true_positive = false_positive = false_negative = true_negative = 0

    shape = image.shape
    width, height = shape[0], shape[1]

    model = cv2.imread(model_path)
    model = cv2.cvtColor(model, cv2.COLOR_BGR2GRAY)
    convert_to_white_black(model, 10)

    for x in range(width):
        row = []

        for y in range(height):

            if image[x][y] == WHITE_1 and model[x][y] == WHITE_1:
                row.append(GREEN_3)
                true_positive += 1

            elif image[x][y] == WHITE_1 and model[x][y] == BLACK_1:
                row.append(RED_3)
                false_positive += 1

            elif image[x][y] == BLACK_1 and model[x][y] == WHITE_1:
                row.append(BLUE_3)
                false_negative += 1
            
            elif image[x][y] == BLACK_1 and model[x][y] == BLACK_1:
                row.append(WHITE_3)
                true_negative += 1
            else:
                row.append(BLACK_3)

        conf_matrix.append(row)

    return conf_matrix, true_positive, false_positive, false_negative, true_negative



def effectiveness_measures(true_positive, false_positive, false_negative, true_negative):
    accuracy = round((true_positive + true_negative) / (true_positive + false_positive + false_negative + true_negative), 4)
    sensitivity = round(true_positive / (true_positive + false_negative + 1), 4)
    specificity = round(true_negative / (false_positive + true_negative + 1), 4)
    precision = round(true_positive / (true_positive + false_positive + 1), 4)
    g_mean = round(math.sqrt(sensitivity * specificity), 4)
    f_measure = round((2 * precision * sensitivity) / (precision + sensitivity + 1), 4)

    return accuracy, sensitivity, specificity, precision, g_mean, f_measure
