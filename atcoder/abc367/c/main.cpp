#include <bits/stdc++.h>
using namespace std;
#define rep(i, n) for (int i = 0; i < (n); i++)

int n,k;
int r[8];
int seq[8];

void f(int lv) {
  if(lv == n) {
    int sum = 0;
    rep(i, n) sum += seq[i];
    if(sum%k == 0) {
      rep(i, n-1) cout << seq[i] << " ";
      cout << seq[n-1] << endl;
    }
  } else {
    for(int i = 1; i <= r[lv]; ++i) {
      seq[lv] = i;
      f(lv + 1);
    }
  }
}

int main() {
  cin >> n >> k;
  rep(i, n) cin >> r[i];
  f(0);
}
