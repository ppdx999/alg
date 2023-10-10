#include <stdio.h>

int main(int argc, char *argv[])
{
    int h,w;
    scanf("%d %d",&h,&w);

    int a[h][w];
    for(int i=0;i<h;i++){
        for(int j=0;j<w;j++){
          scanf("%d",&a[i][j]);
        }
    }

    int row[h];
    int col[w];
    for(int i=0;i<h;i++) row[i] = 0;
    for(int i=0;i<w;i++) col[i] = 0;

    for(int i=0;i<h;i++){
        for(int j=0;j<w;j++){
            row[i] += a[i][j];
            col[j] += a[i][j];
        }
    }

    for(int i=0;i<h;i++){
        for(int j=0;j<w;j++){
          printf("%d ", row[i] + col[j] - a[i][j]);
        }
        printf("\n");
    }
}
