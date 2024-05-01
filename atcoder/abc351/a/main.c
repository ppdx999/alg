#include<stdio.h>

int main(int argc, char *argv[]) {
  int buf, i, ans;
  ans=1;
  for(i=0;i<9;i++) {
    scanf("%d", &buf);
    ans += buf;
  }
  for(i=0;i<8;i++){
    scanf("%d", &buf);
    ans -= buf;
  }
  printf("%d\n", ans);
}
