#include <stdio.h>
#define ALPHABET_SIZE 26

int main() {
  int n, k;
  scanf("%d%d", &n, &k);
  char s[n + 1];
  scanf("%s", s);

  int nxt_size = (n + 1) * ALPHABET_SIZE;
  int nxt[nxt_size];
  for (int i = 0; i < nxt_size; i++) nxt[i] = n;

  for (int i = n - 1; i >= 0; i--) {
    for (int j = 0; j < ALPHABET_SIZE; j++) 
      nxt[i * ALPHABET_SIZE + j] = nxt[(i + 1) * ALPHABET_SIZE + j];

    nxt[i * ALPHABET_SIZE + s[i] - 'a'] = i;
  }

  char res[k + 1];
  int j = -1;
  for (int i = 0; i < k; i++){
    for (int l = 0; l < ALPHABET_SIZE; l++) {
      int val = nxt[(j + 1) * ALPHABET_SIZE + l];

      if (n - val >= k - i) {
        res[i] = 'a' + l;
        j = val;
        break;
      }
    }
  }

  res[k] = '\0';
  printf("%s\n", res);
}
