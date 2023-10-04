#include <stdio.h>

int check(int *a, int n, int x, int len, int k) {
  int num = 0;
  int pre = 0;

  for (int i=0; i<n; i++) {
    if(a[i] - pre >= x) {
      num++;
      pre = a[i];
    }
  }

  if(len - pre >= x) num++;
  
  return num >= k + 1;
}

int bsearch(int *a, int n, int len, int k, int left, int right) {
  if(right - left == 1) return left;

  int mid = (left + right) / 2;

  if(check(a, n, mid, len, k)) return bsearch(a, n, len, k, mid, right);
  else return bsearch(a, n, len, k, left, mid);
}

int main(int argc, char *argv[]) {
    int n, len, k;
    int a[100001];

    scanf("%d %d %d", &n, &len, &k);

    for (int i = 0; i < n; ++i) {
        scanf("%d", &a[i]);
    }

    int left = bsearch(a, n, len, k, -1, len + 1);

    printf("%d\n", left);
}
