#include <stdio.h>
#include <string.h>

#define rep(i,n) for (int i = 0; i < n; i++)
#define MAX_H 30
#define MAX_W 30

char a[MAX_H][MAX_W];
char b[MAX_H][MAX_W];
char na[MAX_H][MAX_W];

int main() {
  int h, w;
  scanf("%d %d", &h, &w);

  rep(i,h) scanf("%s", a[i]);
  rep(i,h) scanf("%s", b[i]);

  rep(s,h) rep(t,w) {
    rep(i,h)rep(j,w) na[(i+s)%h][(j+t)%w] = a[i][j];
    if (memcmp(na, b, sizeof(b)) == 0) {
      puts("Yes");
      return 0;
    }
  }
  puts("No");
  return 0;
}
