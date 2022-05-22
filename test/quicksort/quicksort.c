#include <stdio.h>

int A[200000];

int quicksort(int left, int right) {
    int i;
    int j;
    int x;
    int y;
    i = left;
    j = right;
    x = A[(left + right) / 2];
    while(i <= j) {
        while (A[i] < x) { 
            i = i + 1;
        }
        while (x < A[j]) {
            j = j - 1;
        }
        if (i <= j) {
            y = A[i];
            A[i] = A[j];
            A[j] = y;
            i = i + 1;
            j = j - 1;
        } else {}
    }
    if (left < j) {
        quicksort(left, j);
    } else{

    }
    if (i < right) {
        quicksort(i, right);
    } 
    else {

    }
    return 0;
}

int main()
{
    int N;
    scanf("%d", N);
    int i = 0;
    while(i < N) {
        scanf("%d", A[i]);
        i = i + 1;
    }
    int left = 0;
    int right = N - 1;
    quicksort(left, right);
    i = 0;
    while(i < N) {
        printf("%d ", A[i]);
        i = i + 1;
    }
    
    return 0;
}