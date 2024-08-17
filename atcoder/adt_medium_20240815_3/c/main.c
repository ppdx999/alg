#include<stdio.h>

int overlap(int l1, int r1, int l2, int r2)
{
  if(l1 >= r2 || l2 >= r1)
    return 0;
  return 1;
}

int main()
{
  int hitting = 0;
  int a,b,c,d,e,f,g,h,i,j,k,l;
  scanf("%d %d %d %d %d %d",&a,&b,&c,&d,&e,&f);
  scanf("%d %d %d %d %d %d",&g,&h,&i,&j,&k,&l);

  hitting += overlap(a,d,g,j) + overlap(b,e,h,k) + overlap(c,f,i,l);

  if(hitting == 3) printf("Yes\n");
  else printf("No\n");
}
