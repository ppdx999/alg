#include<stdio.h>
#include<stdlib.h>

int main(int argc, char *argv[]) {
  int n, q, l, r, i;
  int* as;

  scanf("%d %d", &n, &q);
  as = (int*)malloc(sizeof(int)* (n+1));
  as[0] = 0;
  i=1;
  while(i<=n){
    scanf("%d", &as[i]);
    as[i] += as[i-1];
    ++i;
  }

  i=0;
  while(i<q){
    scanf("%d %d", &l, &r);
    printf("%d\n", as[r] - as[l-1]);
    ++i;
  }
}
