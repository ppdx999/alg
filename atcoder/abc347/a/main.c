#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int n, k;
  scanf("%d %d", &n, &k);

  int *a = (int *)malloc(sizeof(int) * n);
  for (int i = 0; i < n; i++) {
    scanf("%d", &a[i]);
  }
  
  for (int i = 0; i < n; i++) {
    if (a[i] % k == 0) {
      printf("%d ", a[i] / k);
    }
  }
};
