#include <stdio.h>

int A[200000];

void quicksort(int left, int right) {
    int i, j, x, y;
    i = left;
    j = right;
    x = A[(left + right) / 2];
    while(i <= j) {
        while (A[i] < x) i++;
        while (x < A[j]) j--;
        if (i <= j) {
            y = A[i];
            A[i] = A[j];
            A[j] = y;
            i++;
            j--;
        }
    }
    if (left < j) quicksort(left, j);
    if (i < right) quicksort(i, right);
}

int main()
{
    int N;
    scanf("%d", &N);
    int i = 0;
    while(i < N) {
        scanf("%d", &A[i]);
        i++;
    }
    int left = 0;
    int right = N - 1;
    quicksort(left, right);
    i = 0;
    while(i < N) {
        printf("%d ", A[i]);
        i++;
    }
    return 0;
}