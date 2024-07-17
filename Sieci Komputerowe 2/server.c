#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <pthread.h>


struct sockaddr_in c_addr;


void* RecAndSendToClient(int *arg)
{
    char receive_buff[1024];
    memset(receive_buff, '0', sizeof(receive_buff));

    int connfd=(int)*arg;

    printf("Zaakceptowanie polaczenia o id: %d\n", connfd);
    printf("Polaczono z klientem: %s:%d\n", inet_ntoa(c_addr.sin_addr), ntohs(c_addr.sin_port));

	FILE *file;

    //Tworzenie folderu w celu przechowywania danych dla tego polaczenia
	char mkdir[100] = "mkdir -m a=rwx ";
	char directory_name[100];
	sprintf(directory_name, "%s", inet_ntoa(c_addr.sin_addr));
    strcat(directory_name, "-");
    char port_str[10];
    sprintf(port_str, "%d", ntohs(c_addr.sin_port));
    strcat(directory_name, port_str);
    strcat(mkdir,  directory_name);
    system(mkdir);

	
    // Odczytanie ile plikow jest wysylanych
    char files_amount_str[10];
    read(connfd, files_amount_str, 10);
    int files_amount = atoi(files_amount_str);

    char file_name[255];
    char file_size_str[20];
    long long int all_bytes_received;

    // Caly proces odczytywania wszystkich plikow
    for(int f_idx = 0; f_idx < files_amount; f_idx++){
        read(connfd, file_name, 255);
        read(connfd, file_size_str, 20);
        long long int file_size = atoll(file_size_str);
        all_bytes_received = 0;
        
        printf("Nazwa pliku: %s, wielkosc pliku: %s bajtow\n", file_name, file_size_str);

        file = fopen(file_name, "ab");
        
        if(file == NULL){
            printf("Blad w trakcie otwierania pliku!\n");
            goto kill;
        }
	

        while(all_bytes_received < file_size){
        
            int bytes_to_read = 1024;

            if(file_size - all_bytes_received < 1024){
                    bytes_to_read = file_size - all_bytes_received;
                }
                
            int bytes_received = read(connfd, receive_buff, bytes_to_read);
            all_bytes_received += bytes_received;

            fwrite(receive_buff, 1, bytes_received, file);

            if(bytes_received < 0){
                printf("Blad odczytywania!\n");
                goto kill;
            }
            
        }
	    fclose(file);

        // Przeniesienie odebranego pliku do folderu, ktory bedzie pozniej kompresowany
        char mv[100] = "mv \"";
        strcat(mv, file_name);
        strcat(mv, "\" ");
        strcat(mv, directory_name);
        system(mv);
    }
    
    // Kompresowanie folderu w ktorym sa wszystkie pliki
    char tar[100] = "tar -vczf ";
    strcat(tar, directory_name);
    strcat(tar, "-compressed.tar.gz ");
    strcat(tar, directory_name);
    system(tar);
    
    char new_file_name[255] = "";
    strcat(new_file_name, directory_name);
    strcat(new_file_name, "-compressed.tar.gz");
    
    
    file = fopen(new_file_name, "rb");
    if(file==NULL){
        printf("Blad otwierania pliku!\n");
        goto kill;
    }

    write(connfd, new_file_name, 255);
    
    while(1){
    	unsigned char buff[1024] = {0};
    	int bytes_read = fread(buff, 1, 1024, file);
    	
    	if(bytes_read > 0){
    		if(write(connfd, buff, bytes_read) < 0){
                printf("Blad przesylania pliku!")
                goto kill;
            };
    	}
    	
    	if(bytes_read < 1024){
    		if(ferror(file)){
    			printf("Blad odczytywania!\n");
    		}
    		break;
    	}
    }
 
    goto kill;

    kill:
        //Zamkniecie pliku i deskryptorow
        close(connfd);
        shutdown(connfd,SHUT_WR);
        fclose(file);    
        printf("Zamykanie polaczenia o id: %d\n",connfd);

        //Usuniecie juz wyslanych plikow z serwera
        char rm[100] = "rm ";
        strcat(rm, new_file_name);
        system(rm);
        
        strcpy(rm, "rm -r ");
        strcat(rm, directory_name);
        system(rm);
        
        sleep(1);
        return NULL;
}

int main(int argc, char *argv[])
{
    int connfd = 0,err;
    pthread_t tid;
    struct sockaddr_in serv_addr;
    int listenfd = 0,ret;
    unsigned int clen = 0;

    listenfd = socket(AF_INET, SOCK_STREAM, 0);
    if(listenfd<0){
        printf("Blad podczas tworzenia gniazda!\n");
        exit(2);
    }

    printf("Pomyslne stworzono gniazdo\n");

    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);
    serv_addr.sin_port = htons(5000);

    ret=bind(listenfd, (struct sockaddr*)&serv_addr,sizeof(serv_addr));
    if(ret<0){
        printf("Blad w bindzie!\n");
        exit(2);
    }

    if(listen(listenfd, 10) == -1){
        printf("Blad w nasluchiwaniu!\n");
        return -1;
    }

    while(1){
        clen = sizeof(c_addr);
        printf("Oczekiwanie na polaczenie ...\n");
        connfd = accept(listenfd, (struct sockaddr*)&c_addr,&clen);
        if(connfd<0){
            printf("Blad podczas akceptacji polaczenia!\n");
            continue;
        }

        err = pthread_create(&tid, NULL, (void*)RecAndSendToClient, &connfd);
        if (err != 0)
            printf("\nBlad w trakcie tworzenia watku :[%s]", strerror(err));
    }

    close(connfd);
    return 0;
}
