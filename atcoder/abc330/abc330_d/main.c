#include <stdio.h>
#include <stdlib.h>

static long long S[2000][2000] = {0};
static long long rows[2000] = {0};
static long long cols[2000] = {0};
static char buffer[2000] = {0};

int main(int argc, char *argv[]) {
  int n;
  scanf("%d", &n);

  for (int i = 0; i < n; ++i) {
    scanf("%s", buffer);

    for (int j = 0; j < n; ++j) {
      // 'x' is 0, 'o' is 1, because in ASCII, 'x' = 120, 'o' = 111
      S[i][j] = buffer[j] & 1;

      rows[i] += S[i][j];
      cols[j] += S[i][j];
    }
  }

  long long ans = 0;
  for (int i = 0; i < n; ++i)
    for (int j = 0; j < n; ++j)
      ans += S[i][j] * (rows[i] - 1) * (cols[j] - 1);

  printf("%lld\n", ans);
};
