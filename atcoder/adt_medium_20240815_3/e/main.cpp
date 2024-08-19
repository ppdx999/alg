#include <bits/stdc++.h>
using namespace std;
#define rep(i, n) for (int i = 0; i < (n); i++)

int main() {
  int q;
  cin >> q;
  multiset<int> s;

  rep(i,q) {
    int type;
    cin >> type;
    if (type == 1) {
      int x;
      cin >> x;
      s.insert(x);
    } else if (type == 2) {
      int x,c;
      cin >> x >> c;
      rep(i,c) {
        auto it = s.find(x);
        if(it == s.end()) break;
        s.erase(it);
      }
    } else {
      int ans = *s.rbegin() - *s.begin();
      cout << ans << endl;
    }
  }
}
