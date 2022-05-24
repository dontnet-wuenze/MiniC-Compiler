void f(int a[10]) {
printf("%d\n", a[2]);
a[4] = 6;
return;
}

int main() {
int b[10];
b[2] = 3;
f(b);
printf("b: %d\n", b[4]);
return 0;
}