#include<stdio.h>

#define SIZE 10

int main(int argc, char *argv[]) {
  int n, i;
  scanf("%d", &n);

  for (i=SIZE-1; i>=0; i--) {
    printf("%d", (n>>i)&1);
  }
}
