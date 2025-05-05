#include <stdio.h>
#include <pthread.h>

int contador = 0; // Variable global compartida
pthread_mutex_t mutex; // Declaración del mutex para exclusión mutua

void* incrementar(void* arg) {
    for (int i = 0; i < 100000; i++) {
        pthread_mutex_lock(&mutex); // Bloqueo de la sección crítica
        contador++;
        pthread_mutex_unlock(&mutex); // Liberación de la sección crítica
    }
    return NULL;
}

int main() {
    pthread_t h1, h2;
    pthread_mutex_init(&mutex, NULL);
    
    pthread_create(&h1, NULL, incrementar, NULL);
    pthread_create(&h2, NULL, incrementar, NULL);
    
    pthread_join(h1, NULL);
    pthread_join(h2, NULL);
    
    pthread_mutex_destroy(&mutex);
    printf("Valor final del contador: %d\n", contador);
    
    return 0;
}