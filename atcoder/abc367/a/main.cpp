#include <bits/stdc++.h>
using namespace std;

int main() {
  int a,b,c;
  cin >> a >> b >> c;
  if (b > c) {
    if(a <= b && a >= c) cout << "Yes" << endl;
    else cout << "No" << endl;
  } else {
    if(a <= b || c <= a) cout << "Yes" << endl;
    else cout << "No" << endl;
  }
}