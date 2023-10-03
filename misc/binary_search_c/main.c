#include <stdio.h>

int binary_search(int *a, int N, int key) {
  int left = 0, right = N - 1;
  while (right >= left) {
    int mid = left + (right - left) / 2;
    if (a[mid] == key)
      return mid;
    else if (a[mid] > key)
      right = mid - 1;
    else
      left = mid + 1;
  }
  return -1;
}

int main(int argc, char *argv[]) {
  int N, key;
  int a[1000];

  scanf("%d %d", &N, &key);

  for (int i = 0; i < N; ++i) {
    scanf("%d", &a[i]);
  }

  int idx = binary_search(a, N, key);

  printf("%d\n", idx);
}
