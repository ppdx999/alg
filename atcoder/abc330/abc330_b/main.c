#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int n,l,r;
  scanf("%d %d %d",&n,&l,&r);
  int *a = (int *)malloc(n*sizeof(int));
  for(int i=0;i<n;i++) scanf("%d",&a[i]);

  for(int i=0;i<n;i++) {
    if(a[i]<=l) printf("%d ",l);
    else if(a[i]>=r) printf("%d ",r);
    else printf("%d ",a[i]);
  }
};
