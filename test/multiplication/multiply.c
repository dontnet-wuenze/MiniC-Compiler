#include <stdio.h>

int A[200000];
int B[200000];

int main() {
    int A_M;
    int A_N;
    int B_M;
    int B_N;
    scanf("%d %d", &A_M, &A_N);
    int i = 0;
    int j = 0;
    while(i < A_M) {
        j = 0;
        while(j < A_N) {
            scanf("%d", &A[i * A_N + j]);
            j++;
        }
        i++;
    }

    scanf("%d %d", &B_M, &B_N);
    i = 0;
    j = 0;
    while(i < B_M) {
        j = 0;
        while(j < B_N) {
            scanf("%d", &B[i * B_N + j]);
            j++;
        }
        i++;
    }

    if(A_N != B_M) {
        printf("Incompatible Dimensions\n");
        return 0;
    }

    int C[200000];
    i = 0;
    j = 0;
    while(i < A_M) {
        j = 0;
        while(j < B_N) {
            C[i * B_N + j] = 0;
            int k = 0;
            while(k < A_N) {
                C[i * B_N + j] += A[i * A_N + k] * B[k * B_N + j];
                k++;
            }
            j++;
        }
        i++;
    }

    i = 0;
    while(i < A_M) {
        j = 0;
        while(j < B_N) {
            printf("%d ", C[i * B_N + j]);
            j++;
        }
        printf("\n");
        i++;
    }
    return 0;
}