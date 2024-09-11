#include <bits/stdc++.h>
using namespace std;

int main() {
	int ans=0;
	int n;
	cin>>n;
	int lprev=0;
	int rprev=0;
	for(int i=0;i<n;i++){
		int a;
		char s;
		cin>>a>>s;
		if(s=='L'){
			if(lprev==0){
				lprev=a;
			}
			ans+=abs(a-lprev);
			lprev=a;
		}
		else if(s=='R'){
			if(rprev==0){
				rprev=a;
			}
			ans+=abs(a-rprev);
			rprev=a;
		}
	}
	cout<<ans<<endl;
}
