#include <stdio.h>
#include <stdlib.h>

long long INF = 9223372036854775807;

long long min(long long a, long long b)
{
  if (a < b) return a;
  else return b;
}

int cmp(const void *a, const void *b)
{
  return *(long long *)a - *(long long *)b;
}

int lower_bound(int n, long long a[], long long x)
{
  int l = -1, r = n;
  while (r - l > 1) {
    int m = (l + r) / 2;
    if (a[m] >= x) r = m;
    else l = m;
  }
  return r;
}

int main(int argc, char *argv[])
{
  int n; scanf("%d", &n);
  long long a[300000]; for (int i = 0; i < n; i++) scanf("%lld", &a[i]);
  qsort(a, n, sizeof(long long), cmp);

  int q; scanf("%d", &q);
  for (int i = 0; i < q; i++) {
    long long x; scanf("%lld", &x);

    int j = lower_bound(n, a, x);
    long long answer = INF;
    if(j > 0) answer = min(answer, llabs(a[j - 1] - x));
    if(j < n) answer = min(answer, llabs(a[j] - x));

    printf("%lld\n", answer);
  }
}
