#include<stdio.h>
#include<stdlib.h>

int main(int argc, char *argv[]) {
  int d,n,l,r,i;
  int* a;
  scanf("%d %d", &d, &n);
  a = (int*)malloc((d+1)*sizeof(int));
  for(i=1; i<=n; i++) {
    scanf("%d %d", &l, &r);
    for(l; l<=r; l++) {
      a[l] += 1;
    }
  }

  for(i=1; i<=d; i++) {
    printf("%d\n", a[i]);
  }
}
