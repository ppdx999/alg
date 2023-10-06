#include <stdio.h>

void print_answer(int bit, int n) {
  for(int i = n-1; i>=0; i--){
    if(bit & (1<<i)) printf("%c", ')');
    else printf("%c", '(');
  }
  printf("\n");
}

int is_valid(int n, int bit) {
  int nest_openness = 0;
  for(int i = n-1; i>=0; i--){
    if(bit & (1<<i)) nest_openness--;
    else nest_openness++;

    if(nest_openness < 0) return 0;
  }
  return nest_openness == 0;
}

int main(int argc, char *argv[]) {
    int n; scanf("%d", &n);

    for (int bit = 0; bit < (1 << n); bit++) {
      if(is_valid(n, bit)) print_answer(bit, n);
    }
}
