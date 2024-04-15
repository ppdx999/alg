#include<stdio.h>
int main(int argc, char *argv[]) {
  int n, k, cnt, x,y,z;
  scanf("%d %d", &n, &k);

  cnt = 0;
  for (x = 1; x <= n; x++) {
    for (y = 1; y <= n; y++) {
      z = k - x - y;
      if (z >= 1 && z <= n) {
        cnt++;
      }
    }
  }
  printf("%d\n", cnt);
}
