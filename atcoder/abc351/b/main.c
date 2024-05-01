#include<stdio.h>
#include<stdlib.h>

int main(int argc, char *argv[]) {
  int n, i, j;
  char *a, *b;
  scanf("%d", &n);
  a = (char *)malloc((n+1) * (n+1) * sizeof(char));
  b = (char *)malloc((n+1) * (n+1) * sizeof(char));

  for(i = 1; i <= n; i++)
    scanf("%s", a + i*(n+1) + 1);
  
  for(i = 1; i <= n; i++)
    scanf("%s", b + i*(n+1) + 1);

  for(i = 1; i <= n; i++)
    for(j = 1; j <= n; j++)
      if(a[i*(n+1) + j] != b[i*(n+1) + j])
        printf("%d %d\n", i, j);

  return 0;
}
