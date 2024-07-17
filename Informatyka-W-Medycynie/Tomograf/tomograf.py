import math
import numpy



def Bresenham(x1, y1, x2, y2):
    points = []

    dx = abs(x2 - x1)
    dy = -abs(y2 - y1)
    
    if x2 > x1:
        x_sign = 1
    else:
        x_sign = -1

    if y2 > y1:
        y_sign = 1
    else:
        y_sign = -1

    error = dx + dy

    while True:
        points.append([x1, y1])
        if x1 == x2 and y1 == y2:
            break

        e2 = 2 * error

        if e2 >= dy:
            if x1 == x2:
                break

            error += dy
            x1 += x_sign

        if e2 <= dx:
            if y1 == y2:
                break

            error += dx
            y1 += y_sign

    return points



def cords_on_photo(x, y ,photo_size):
    new_x = int(x + photo_size/2)
    new_y = int(y + photo_size/2)

    return new_x, new_y



def avg_pixel(x1, y1, x2, y2, image):
    new_x1, new_y1 = cords_on_photo(x1, y1, image.shape[0])
    new_x2, new_y2 = cords_on_photo(x2, y2, image.shape[0])

    points = Bresenham(new_x1, new_y1, new_x2, new_y2)

    all_sum = 0
    average = 0 
    counter = 0

    for x, y in points:
        try:
            all_sum += image[x, y]
            counter += 1
        except:
            continue

    if counter != 0:
        average = all_sum / counter

    return average, points



def generate_detector_positions(radius, step, system_range, number_of_detectors):
    detector_positions = []

    for x in range(number_of_detectors):
        angle = step + 180 - system_range / 2 + x * (system_range / (number_of_detectors - 1))
        angle = math.radians(angle)
        
        x = radius * math.cos(angle)
        y = radius * math.sin(angle)

        detector_positions.append([x, y])

    return detector_positions



def generate_emiter_and_detectors(radius, delta_alfa, system_range, number_of_detectors):
    step = math.radians(delta_alfa)

    x = radius * numpy.cos(step)
    y = radius * numpy.sin(step)

    emiter = [x, y]
    detectors_positions = generate_detector_positions(radius, delta_alfa, system_range, number_of_detectors)

    return emiter, detectors_positions



def normalize_image(image):
    max_value = numpy.amax(image)

    new_image = image / max_value
            
    return new_image



def transform_to_square_image(image):
    img_height = image.shape[0]
    img_width = image.shape[1]

    square_length = max(img_height, img_width)
    square_image = numpy.zeros((square_length, square_length))
    
    x0 = (square_length - img_width) // 2
    y0 = (square_length - img_height) // 2

    square_image[y0:img_height + y0, x0:x0 + img_width] = image

    return square_image


