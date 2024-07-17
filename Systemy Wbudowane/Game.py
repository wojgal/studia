from Item import *
from random import randint
from luma.core.interface.serial import spi, noop
from luma.core.render import canvas
from luma.led_matrix.device import max7219
from time import sleep

ZERO_LED = [[0, 0], [1, 0], [2, 0], [3, 0], [4, 0],
         [0, 1], [4, 1],
         [0, 2], [1, 2], [2, 2], [3, 2], [4, 2]]

ONE_LED = [[0, 2], [1, 2], [2, 2], [3, 2], [4, 2]]

TWO_LED = [[0, 0], [1, 0], [2, 0], [4, 0],
         [0, 1], [2, 1], [4, 1],
         [0, 2], [2, 2], [3, 2], [4, 2]]

THREE_LED = [[0, 0], [2, 0], [4, 0],
         [0, 1], [2, 1], [4, 1],
         [0, 2], [1, 2], [2, 2], [3, 2], [4, 2]]

FOUR_LED = [[2, 0], [3, 0], [4, 0],
         [2, 1],
         [0, 2], [1, 2], [2, 2], [3, 2], [4, 2]]

FIVE_LED = [[0, 0], [2, 0], [3, 0], [4, 0],
         [0, 1], [2, 1], [4, 1],
         [0, 2], [1, 2], [2, 2], [4, 2]]

SIX_LED = [[0, 0], [1, 0], [2, 0], [3, 0], [4, 0],
         [0, 1], [2, 1], [4, 1],
         [0, 2], [1, 2], [2, 2], [4, 2]]

SEVEN_LED = [[4, 0],
         [4, 1],
         [0, 2], [1, 2], [2, 2], [3, 2], [4, 2]]

EIGHT_LED = [[0, 0], [1, 0], [2, 0], [3, 0], [4, 0],
         [0, 1], [2, 1], [4, 1],
         [0, 2], [1, 2], [2, 2], [3, 2], [4, 2]]

NINE_LED = [[0, 0], [2, 0], [3, 0], [4, 0],
         [0, 1], [2, 1], [4, 1],
         [0, 2], [1, 2], [2, 2], [3, 2], [4, 2]]

NUMBERS_LED = {'0': ZERO_LED,
               '1': ONE_LED,
               '2': TWO_LED,
               '3': THREE_LED,
               '4': FOUR_LED,
               '5': FIVE_LED,
               '6': SIX_LED,
               '7': SEVEN_LED,
               '8': EIGHT_LED,
               '9': NINE_LED}


class Game:
    def __init__(self, item_types):
        self.board_width = 8
        self.board_height = 16
        self.board = [[0 for x in range(self.board_width)] for y in range(self.board_height)]
        self.points = 0
        self.item_types = item_types
        self.item = False
        self.serial = spi(port=0,device=0,gpio=noop(), block_orientation=90)
        self.device = max7219(self.serial,cascaded=2)



    def print_led_board(self):  #Rysowanie aktualnego stanu planszy
        with canvas(self.device) as draw:

            for y in range(self.board_height):
                for x in range(self.board_width):
                    if self.board[y][x] == 1:
                        if y > 7:
                            draw.point((y, self.board_width -x - 1), fill='red')
                        else:
                            draw.point((x, y), fill='red')



    def print_led_T(self):  #Rysowanie litery T
        with canvas(self.device) as draw:

            for led in range(1,7):
                draw.point((led, 2), fill='red')
                draw.point((led, 3), fill='red')

            for led_x in range(4, 8):
                for led_y in range(3, 5):
                    draw.point((led_y, led_x), fill='red')

            for led_x in range(8, 14):
                for led_y in range(3, 5):
                    draw.point((led_x, led_y), fill='red')



    def print_led_score(self):  #Rysowanie zdobytego wyniku po przegranej grze
        score_str = str(self.points)

        for _ in range(4 - len(score_str)):
            score_str = '0' + score_str

        with canvas(self.device) as draw:
            for slot, letter in enumerate(score_str):
                curr_led = NUMBERS_LED[letter]

                for led in curr_led:
                    x = led[0]
                    y = led[1]

                    if slot == 0:
                        draw.point((x + 1, y + 1), fill='red')

                    if slot == 1:
                        draw.point((x + 1, y + 5), fill='red')

                    if slot == 2:
                        draw.point((y + 9, 6 - x), fill='red')

                    if slot == 3:
                        draw.point((y + 13, 6 - x), fill='red')



    def check_game_lost(self):  #Sprawdzenie czy przegralismy
        first_row = self.board[0]

        if first_row.count(1) > 0:
            return True

        return False



    def restart_game(self): #Gra od nowa
        self.board = [[0 for x in range(self.board_width)] for y in range(self.board_height)]
        self.points = 0



    def check_if_ok(self, remote_control_command):
        if remote_control_command == 'ok':
            return True

        return False



    def check_full_lines(self):  #Sprawdza czy jakas linia jest zapelniona i czy mozna ja zamienic na punkty
        rows_completed = 0
        idx_list = []

        for idx, row in enumerate(self.board):
            if row.count(1) == self.board_width:
                rows_completed += 1
                idx_list.append(idx)

        for idx in idx_list:
            self.board.insert(0, [0 for x in range(self.board_width)])
            self.board.pop(idx+1)


        if rows_completed == 1:
            self.points += 50
            return

        if rows_completed == 2:
            self.points += 150
            return

        if rows_completed == 3:
            self.points += 300
            return

        if rows_completed == 4:
            self.points += 600
            return

        return



    def generate_item(self):    #Generowanie nowego itemu do planszy
        i_type = self.item_types[randint(0, len(self.item_types) - 1)]
        rotation = randint(0, len(i_type) - 1)

        self.item = Item(i_type, (self.board_width - len(i_type[rotation][0]))//2, 0, rotation)

        cord_x, cord_y = self.item.get_cords()
        curr_state = self.item.get_current_state()

        for y, row in enumerate(curr_state):
            for x, brick in enumerate(row):
                if brick == 1:
                    self.board[y + cord_y][x + cord_x] = 1

        return



    def check_item_destroy(self):   #Sprawdzamy czy nasz uzywany klocek ma stycznosc z ktorakolwiek budowla
        if self.item is False:
            return

        colliding_bricks_cords = self.item.get_colliding_bricks_down_level()    #Pobieramy cordy dolnych poziomych cegielek

        for collide_cords in colliding_bricks_cords:  # Sprawdzenie czy pod kolizyjnymi cegielkami znajduje sie budowla badz koniec mapy
            x = collide_cords[0]
            y = collide_cords[1]

            if y == self.board_height - 1:  #Klocek doszedl do konca mapy, zwracamy True
                return True

            if self.board[y+1][x] == 1:   #Budowla znajduje sie pod naszym klockiem, zwracamy True
                return True

        return False    #Nic nie koliduje z klockiem, zwracamy False



    def item_destroyed(self):
        cord_x, cord_y = self.item.get_cords()
        curr_state = self.item.get_current_state()

        #Dodawanie zniszczonego klocka do planszy
        for y, row in enumerate(curr_state):
            for x, brick in enumerate(row):
                if brick == 1:
                    self.board[y + cord_y][x + cord_x] = 1

        #Sprawdzenie czy item niszczy sie na spodzie planszy
        if cord_y + len(curr_state) == self.board_height:
            self.points += 5

        #Dodanie punktow za ilosc przebytych wierszy przez figure
        self.points += cord_y + len(curr_state)

        self.check_full_lines()

        if self.check_game_lost():
            return 'lost'
        else:
            self.generate_item()

        return


    def move_item(self, remote_control_command):    #Funkcja kontrolujaca poruszaniem sie klocka
        if self.check_item_destroy():
            if self.item_destroyed() == 'lost':
                return 'lost'
            return

        move_x = 0
        move_y = 1

        if remote_control_command == 'left':    #Funkcja odpowiadajaca za poruszanie sie w lewo
            colliding_bricks_cords = self.item.get_colliding_bricks_left()

            for collide_cords in colliding_bricks_cords:
                x = collide_cords[0]
                y = collide_cords[1]

                if x == 0:
                    break

                if self.board[y][x-1] == 1 and [x-1, y] not in colliding_bricks_cords:
                    break
            else:
                move_x = -1

        if remote_control_command == 'right':   #Funkcja odpowiadajaca za poruszanie sie w prawo
            colliding_bricks_cords = self.item.get_colliding_bricks_right()

            for collide_cords in colliding_bricks_cords:
                x = collide_cords[0]
                y = collide_cords[1]

                if x == self.board_width - 1:
                    break

                if self.board[y][x+1] == 1 and [x+1, y] not in colliding_bricks_cords:
                    break
            else:
                move_x = 1



        if remote_control_command == 'down':    #Funkcja odpowiadajaca za szybkiego spadanie w dol klocka
            colliding_bricks_cords = self.item.get_colliding_bricks_down_level()

            cord_x, cord_y = self.item.get_cords()
            curr_state = self.item.get_current_state()

            highest_points = []
            lowest_cords = []

            for collide_cords in colliding_bricks_cords:
                x = collide_cords[0]
                y = collide_cords[1]

                for board_row in range(y + 1, self.board_height):
                    if self.board[board_row][x] == 1:
                        highest_points.append(board_row)
                        lowest_cords.append(y)
                        break
                else:
                    highest_points.append(16)
                    lowest_cords.append(len(curr_state) + cord_y - 1)

            min_hp = min(highest_points)
            idx = highest_points.index(min_hp)
            min_lc = lowest_cords[idx]

            move_y = min_hp - min_lc - 1

            if move_y <= 0:
                move_y = 1



        #Szybak prowizorka
        if remote_control_command == 'ok':  #Funkcja odpowiadajaca za poruszanie mozliwe rotacje klocka
            can_rotate = True

            next_state = self.item.get_next_state()

            cord_x, cord_y = self.item.get_cords()
            curr_state = self.item.get_current_state()


            for y, row in enumerate(curr_state):
                for x, brick in enumerate(row):
                    if brick == 1:
                        self.board[y + cord_y][x + cord_x] = 0

            for y, row in enumerate(next_state):
                for x, brick in enumerate(row):
                    if brick == 1:
                        if self.board[y + cord_y + move_y][x + cord_x + move_x] == 1:
                            can_rotate = False

            if can_rotate:
                self.item.rotate()


        #Nastepuje usuwanie starej pozycji klocka i wstawienie go w nowa, po wczesniejszych analizach funkcji (oprocz down)
        cord_x, cord_y = self.item.get_cords()
        curr_state = self.item.get_current_state()

        for y, row in enumerate(curr_state):
            for x, brick in enumerate(row):
                if brick == 1:
                    self.board[y + cord_y][x + cord_x] = 0

        for y, row in enumerate(curr_state):
            for x, brick in enumerate(row):
                if brick == 1:
                    self.board[y + cord_y + move_y][x + cord_x + move_x] = 1

        self.item.set_cords(cord_x + move_x, cord_y + move_y)
        return