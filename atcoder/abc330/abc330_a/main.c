#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
  int n, l;
  scanf("%d %d", &n, &l);
  int *a = (int *)malloc(n * sizeof(int));

  for (int i = 0; i < n; i++)
  {
    scanf("%d", &a[i]);
  }

  int count = 0;
  for (int i = 0; i < n; i++)
    if (a[i] >= l)
      count++;

  printf("%d\n", count);
};
