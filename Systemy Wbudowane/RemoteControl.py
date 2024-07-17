import RPi.GPIO as GPIO
from datetime import datetime
from time import sleep


def find_first_command(command_list):   #Funckja znajdujaca pierwsza komenda w liscie
    for command in command_list:
        if command is not None:
            command_list.clear()
            return command



def read_remote_control_thread(command_list, remote_control):   #Funkcja dla watku, sprawdzajaca caly czas dzialanie pilota
    while True:
        command_list.append(remote_control.read_remote_control())
        sleep(0.1)

class RemoteControl:    #Klasa pilota

    def __init__(self, pin):
        self.pin = pin
        self. buttons = {'0x300ff18e7': 'up',
                        '0x300ff10ef': 'left',
                        '0x300ff5aa5': 'right',
                        '0x300ff4ab5': 'down',
                        '0x300ff38c7': 'ok'}

        GPIO.setmode(GPIO.BOARD)
        GPIO.setwarnings(False)
        GPIO.setup(self.pin, GPIO.IN)


    def get_binary(self):   #Funkcja konwertujaca sygnal z pilota, na reprezentacje binarna, w celu pozniejszego odczytania
                            #rodzaju wcisnietego guzika na pilocie
        amount_of_ones = 0
        binary = 1
        command = []
        previouse_value = 0

        value = GPIO.input(self.pin)


        while value:
            sleep(0.001)
            value = GPIO.input(self.pin)

        start_time = datetime.now()

        while True:
            if previouse_value != value:
                now = datetime.now()
                pulse_time = now - start_time
                start_time = now
                command.append((previouse_value, pulse_time.microseconds))

            if value:
                amount_of_ones += 1
            else:
                amount_of_ones = 0


            if amount_of_ones > 10_000:
                break

            previouse_value = value
            value = GPIO.input(self.pin)

        for (typ, time) in command:
            if typ == 1:
                if time > 1000:
                    binary = binary * 10 + 1
                else:
                    binary *= 10

        if len(str(binary)) > 34:
            binary = int(str(binary)[:34])
        return binary



    def convert_to_hex(self, binary_value):
        return hex(int(str(binary_value), 2))



    def read_remote_control(self):
        incoming_data = self.convert_to_hex(self.get_binary())
        return self.buttons.get(incoming_data)