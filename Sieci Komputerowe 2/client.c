#include <stdlib.h>
#include <stdio.h>
#include <winsock2.h>
#include <string.h>
 
 //Main zwraca 1, gdy cos sie nie powiodlo, blad jest na standardowym wyjsciu
int main(int argc, char *argv[])
{
    SOCKET socket_fd = 0;
    int bytes_received = 0;
    char receive_buff[1024];
    memset(receive_buff, '0', sizeof(receive_buff));
    struct sockaddr_in serv_addr;
    WSADATA WData;
    WSAStartup(MAKEWORD(2, 0), &WData);

    //Tworzenie socketu
    if((socket_fd = socket(AF_INET, SOCK_STREAM, 0)) == INVALID_SOCKET){
        printf("Blad: nie udalo sie stworzyc socketu!");
        return 1;
        }

    //Inicjalizacja sockaddr_in w strukturze 
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_port = htons(atoi(argv[2])); // port

    //Zapis adresu ip
    char ip[50];
    strcpy(ip, argv[1]);
    serv_addr.sin_addr.s_addr = inet_addr(ip);

    //Zapis ilosci przesylanych plikow
    char files_amount_str[10];
    strcpy(files_amount_str, argv[3]);
    int files_amount = atoi(files_amount_str);


    //Nawiazywanie polaczenia
    if(connect(socket_fd, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0){
        printf("Blad: Nie udalo sie stworzyc polaczenia!");
        return 1;
        }

    char file_name[255];
    char file_path[10000];
    long long int file_size;

    send(socket_fd, files_amount_str, 10, 0);
    
    FILE* file;

    for(int f_idx = 4; f_idx < files_amount * 2 + 4; f_idx+=2){
        strcpy(file_name, argv[f_idx]);
        //strcat(file_name, "\n");
        send(socket_fd, file_name, 255, 0);

        strcpy(file_path, argv[f_idx + 1]);

        file = fopen(file_path, "rb");

        if(file == NULL){
            printf("Blad: Nie udalo sie otworzyc pliku do wyslania!");
            return 1;
        }

        
        //Sprawdzanie wielkosci pliku
        fseek(file, 0L, SEEK_END);
        file_size = ftell(file);
        fseek(file, 0L, SEEK_SET);
        char file_size_str[20];
        lltoa(file_size, file_size_str, 10);
        
        send(socket_fd, file_size_str, 20, 0);

        int bytes_send = 0;

        while(bytes_send < file_size){
            int bytes_to_read = 1024;

            if(file_size - bytes_send < 1024){
                bytes_to_read = file_size - bytes_send;
            }

            /*unsigned*/char buff[1024] = {0};
            int n_bytes_read = fread(buff, 1, bytes_to_read, file);
            bytes_send += n_bytes_read;

            if(n_bytes_read > 0){
                int send_result = send(socket_fd, buff, n_bytes_read, 0);

                if(send_result == SOCKET_ERROR){
                printf("Blad %d: Niepowodzenie w przesylaniu pliku!", WSAGetLastError());
                closesocket(socket_fd);
                WSACleanup();
                return 1;
                }
            }   
        }

        fclose(file);
    }


    //Zamkniecie przesylania dla socketu i zamkniecie przesylanego pliku
    shutdown(socket_fd, 1);

	strcpy(file_name, "");
	recv(socket_fd, file_name, 255, 0);

   	file = fopen(file_name, "ab"); 
    if(file == NULL){
        printf("Blad: Nie udalo sie utworzyc przeslanego pliku!");
        return 1;
    }

    while((bytes_received = recv(socket_fd, receive_buff, 1024, 0)) > 0){
        fwrite(receive_buff, 1, bytes_received, file);
    }

    if(bytes_received < 0 ){
        printf("Blad: Nie udalo sie poprawnie zapisac otrzymanego pliku!");
        return 1;
    }

    fclose(file);
    closesocket(socket_fd);
    return 0;
}
