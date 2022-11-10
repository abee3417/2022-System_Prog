#include <stdio.h>
#include <stdlib.h>

/*
64비트 int인 unsigned __int64를 이용하고, 하나를 36비트만 사용. 64 + 36 = 100
front : 0000:000n:nnnn:nnnn
back : nnnn:nnnn:nnnn:nnnn
front과 2를 붙인다는 느낌으로 -> 0x0000:000n:nnnn:nnnn:nnnn:nnnn:nnnn:nnnn
앞의 0 7개는 사용하지 않는 비트.
*/

typedef struct __int100{ 
   unsigned __int64 front : 36;
   unsigned __int64 back;
}int100;

void set_bit(char* data, int100* ptr){
   unsigned __int64* num_ptr = (unsigned __int64*)ptr;
   *num_ptr = 0;
   for(int i = 0; i < 25; i++){
      if(i == 9){
        num_ptr++; // 9번째 부터는 front에서 back으로 이동
      }
      //
      if ('a' <= data[i] && data[i] <= 'f'){
         *num_ptr = *num_ptr * 16 + data[i] - 'a' + 10;
      }          
      else if ('0' <= data[i] && data[i] <= '9'){
         *num_ptr = *num_ptr * 16 + data[i] - '0'; 
      }
   }              
}

int100* Long_integer_add(int100* n1, int100* n2){
   int100* result = malloc(sizeof(int100));
   result->back = n1->back + n2->back;
   result->front = n1->front + n2->front;
   if (result->back < n1->back || result->back < n2->back){
      // 뒤의 64비트에서 오버플로우가 발생했을 경우 앞의 36비트로 넘겨준다. (오버플로우 발생 시 수가 작아지는것을 활용)
        result->front++; // 1증가
   }
   result->front = result->front & 0x0000000fffffffff; // front은 앞의 28비트를 안쓰기 때문에 앞의 7자리를 0으로 만들어준다.
   return result;
}

int main() {
   int100 n1, n2;
   char* s1 = "fffffffffffffffffffffffff";
   char* s2 = "0000000000000000000000001";
   set_bit(s1, &n1);
   set_bit(s2, &n2);
   int100* result = Long_integer_add(&n1, &n2);
   printf("0x%s + 0x%s\n= 0x%09llx%016llx", s1, s2, result->front, result->back);
   return 0;
}