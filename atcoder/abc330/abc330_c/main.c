#include <stdio.h>

// impl min as bit operation
long long minll(long long a, long long b) {
  return b + ((a - b) & ((a - b) >> (sizeof(long long) * 8 - 1)));
}

long long sqrtll(long long n) {
  if (n <= 0) return 0;
  long long min = -1, mid, max = 1;
  while (max * max <= n) 
    max <<= 1;
  while (min + 1 < max) {
    mid = (min + max) >> 1;
    if (mid * mid <= n) min = mid;
    else max = mid;
  }
  return min;
}


int main(int argc, char *argv[]) {
  long long D;
  scanf("%lld", &D);

  long long ans = D;

  for (long long x = 0; x * x <= D; ++x) {
    long long z = D - x * x;
    if (z < 0) ans = minll(ans, -z);
    else {
      long long y = sqrtll(z);
      ans = minll(ans, z - y * y);
      y++;
      ans = minll(ans, y * y - z);
    }
  }

  printf("%lld\n", ans);
};
