I_BLOCK = [
    [[1, 1, 1, 1]],

    [[1],
     [1],
     [1],
     [1]]
]

J_BLOCK = [
    [[1, 0, 0],
     [1, 1, 1]],

    [[1, 1],
     [1, 0],
     [1, 0]],

    [[1, 1, 1],
     [0, 0, 1]],

    [[0, 1],
     [0, 1],
     [1, 1]]
]

L_BLOCK = [
    [[0, 0, 1],
     [1, 1, 1]],

    [[1, 0],
     [1, 0],
     [1, 1]],

    [[1, 1, 1],
     [1, 0, 0]],

    [[1, 1],
     [0, 1],
     [0, 1]]
]

O_BLOCK = [
    [[1, 1],
     [1, 1]]
]

S_BLOCK = [
    [[0, 1, 1],
     [1, 1, 0]],

     [[1, 0],
      [1, 1],
      [0, 1]]
]

T_BLOCK = [
    [[0, 1, 0],
     [1, 1, 1]],

    [[1, 0],
     [1, 1],
     [1, 0]],

    [[1, 1, 1],
     [0, 1, 0]],

    [[0, 1],
     [1, 1],
     [0, 1]]
]

Z_BLOCK = [
    [[1, 1, 0],
     [0, 1, 1]],

    [[0, 1],
     [1, 1],
     [1, 0]]
]

ALL_BLOCKS = [I_BLOCK, J_BLOCK, L_BLOCK, O_BLOCK, S_BLOCK, T_BLOCK, Z_BLOCK]

class Item: #Klasa reprezentujaca poruszajace przez nas klocki
    def __init__(self, block, x, y, rotation):
        self.block = block
        self.cord_x = x
        self.cord_y = y
        self.current_state = block[rotation]
        self.rotation = rotation
        self.max_rotation = len(block) - 1

    def get_cords(self):
        return self.cord_x, self.cord_y

    def set_cords(self, new_cord_x, new_cord_y):
        self.cord_x = new_cord_x
        self.cord_y = new_cord_y
        return

    def get_current_state(self):
        return self.current_state

    def get_colliding_bricks_down_level(self):  #Znalezenie kordow czesci klockow odpowiadajacych za kolizje z dolu
        colliding_bricks_cords = []

        for x in range(len(self.current_state[0])):   #Znalezienie wszystkich cegielek klocka, na ktore bedziemy zwracac uwage czy koliduja
            for y in range(len(self.current_state) - 1, -1, -1):
                if self.current_state[y][x] == 1:
                    colliding_bricks_cords.append([x + self.cord_x, y + self.cord_y])
                    break

        return colliding_bricks_cords

    def get_colliding_bricks_left(self):    #Znalezenie kordow czesci klockow odpowiadajacych za kolizje z lewej strony
        colliding_bricks_cords = []

        for y in range(len(self.current_state)):
            for x_left in range(len(self.current_state[y])):     #Szukamy cordow kolizyjnych po lewej stronie klocka
                if self.current_state[y][x_left] == 1:
                    colliding_bricks_cords.append([x_left + self.cord_x, y + self.cord_y])
                    break

        return colliding_bricks_cords



    def get_colliding_bricks_right(self):   #Znalezenie kordow czesci klockow odpowiadajacych za kolizje z prawej strony
        colliding_bricks_cords = []

        for y in range(len(self.current_state)):
            for x_right in range(len(self.current_state[y]) - 1, -1, -1):   ##Szukamy cordow kolizyjnych po prawej stronie klocka
                    if self.current_state[y][x_right] == 1:
                        colliding_bricks_cords.append([x_right + self.cord_x, y + self.cord_y])
                        break

        return colliding_bricks_cords



    def get_next_state(self):   #Sprawdzenie jaki jest nastepny stan (sluzy do rotacji)
        print('aktualna', self.rotation)
        if self.rotation + 1 > self.max_rotation:
            print('nastepna', 0)
            return self.block[0]
        print('nastepna', self.rotation+1)
        return self.block[self.rotation + 1]



    def rotate(self):   #Rotowanie klockiem
        if self.rotation == self.max_rotation:
            self.rotation = 0
            self.current_state = self.block[self.rotation]
            return

        self.rotation += 1
        self.current_state = self.block[self.rotation]
        return
