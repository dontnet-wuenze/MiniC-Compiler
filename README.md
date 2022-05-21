# MiniC-Compiler
ZJU编译原理大作业

参考文献：
https://gnuu.org/2009/09/18/writing-your-own-toy-compiler/

编译流程
```
llvm-as-10 easy.ll
llc-10 easy.bc
clang-10 -c easy.s 
clang-10 easy.o -o easy
./easy
```

``` c
float fuck (int wez, float sb) {
int wezsb = 3;
while (wez < wezsb) {
wez = wez + 1;
}
return 1.0;
}
int main(){
fuck(1, 2.0);
return 0;
}
```

``` c
int j;
int main() {
	j = 10;
	while(j < 10) {
		int j;
		while(j < 20) {
			int j;
			j = 10;
		}
		j = 20;
	}
	return 0;
}
```

