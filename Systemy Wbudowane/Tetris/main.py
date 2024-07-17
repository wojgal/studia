from Game import *
from RemoteControl import *
import time
from  threading import Thread, Event
from Buzzer import *



def main():
    run = True
    state = 'start'

    game = Game(ALL_BLOCKS)
    remote_control = RemoteControl(11)
    buzzer = Buzzer(13)

    command_list = []
    current_command = None

    t_remote = Thread(target=read_remote_control_thread, args=(command_list, remote_control,), daemon=True)
    t_remote.start()

    t_buzzer = Thread(target=play_buzzer_thread, args=(buzzer,), daemon=True)
    t_buzzer.start()


    while(run):
        while state == 'start': #Stan startowy
            sleep(0.1)
            game.print_led_T()

            current_command = find_first_command(command_list)

            if game.check_if_ok(current_command):
                state = 'play'
                game.generate_item()

        while state == 'play':  #Stan rozgrywki
            game.print_led_board()
            time.sleep(0.85)

            current_command = find_first_command(command_list)

            if game.move_item(current_command) == 'lost':
                state = 'lost'

        while state == 'lost':  #Stan ekranu koncowego
            time.sleep(0.1)
            game.print_led_score()

            current_command = find_first_command(command_list)

            if game.check_if_ok(current_command):
                game.restart_game()
                state = 'start'

if __name__ == '__main__':
    main()