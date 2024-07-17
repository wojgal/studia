import RPi.GPIO as GPIO
import time

def play_buzzer_thread(buzzer):   #Funkcja dla watku, do grania muzyki
    while True:
        buzzer.run()
        time.sleep(0.1)

class Buzzer:

    def __init__(self, pin):
        self.pin = pin
        self.speed = 1
        self.tones = {'c6':1047,
                        'b5':988,
                        'a5':880,
                        'g5':784,
                        'f5':698,
                        'e5':659,
                        'eb5':622,
                        'd5':587,
                        'c5':523,
                        'b4':494,
                        'a4':440,
                        'ab4':415,
                        'g4':392,
                        'f4':349,
                        'e4':330,
                        'd4':294,
                        'c4':262}
        self.song = [['e5', 16], ['eb5', 16], ['e5', 16], ['c4', 16], ['f4', 16], ['p', 16]]
        GPIO.setmode(GPIO.BOARD)
        GPIO.setup(self.pin, GPIO.OUT,initial=GPIO.LOW)
        self.p = GPIO.PWM(self.pin, 0.1)


    def play_tone(self, tone):
        duration = (1./(tone[1] * 0.25 * self.speed))

        if tone[0] == 'p':   #pauza
            time.sleep(duration)

        else:
            frequency = self.tones[tone[0]]
            self.p.ChangeFrequency(frequency)
            self.p.start(0.5)
            time.sleep(duration)
            self.p.stop()

    def run(self):
        self.p.start(0.5)


        for tone in self.song:
            self.play_tone(tone)



    def stop(self):
        GPIO.output(self.pin, GPIO.LOW)
        GPIO.cleanup(13)











