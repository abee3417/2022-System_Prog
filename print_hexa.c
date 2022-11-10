#include <stdio.h>

int main(){
    for (int i = 0; i < 256; i++){
        printf("0x%x = ", i);
        for (int j = 7; j >= 0; j--) {
            printf("%d", i >> j & 1);
        }
        printf("\n");
    }
    return 0;
}