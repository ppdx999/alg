#include <bits/stdc++.h>
using namespace std;

int main() {
	int a, b;
	cin >> a >> b;

	if (a==b) {
		cout << 1 << endl;
		return 0;
	} else if (a > b) {
		// swap
		int temp = a;
		a = b;
		b = temp;
	}

	int diff = b - a;
	int ans = 0;
	for (int i = a-diff; i <= b+diff; i++) {
		if (i - a == b - i) {
			ans++;
		} else if (a - i == b - a) {
			ans++;
		} else if (b - a == i - b) {
			ans++;
		}
	}

	cout << ans << endl;
}
