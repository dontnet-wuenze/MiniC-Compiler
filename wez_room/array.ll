; ModuleID = 'main'
source_filename = "main"

@_Const_String_ = private constant [10 x i8] c"%d %d %d\0A\00"

declare i32 @printf(i8*, ...)

declare i32 @scanf(...)

define i32 @main() {
entry:
  %a = alloca [10 x i32]
  %tmpvar = getelementptr inbounds [10 x i32], [10 x i32]* %a, i32 0, i32 0
  store i32 1, i32* %tmpvar
  %tmpvar1 = getelementptr inbounds [10 x i32], [10 x i32]* %a, i32 0, i32 4
  store i32 5, i32* %tmpvar1
  %t = alloca i32
  store i32 10, i32* %t
  %i = alloca i32
  %LoadInst = load i32, i32* %t
  store i32 %LoadInst, i32* %i
  %tmparray = getelementptr inbounds [10 x i32], [10 x i32]* %a, i32 0, i32 4
  %tmpvar2 = load i32, i32* %tmparray
  store i32 %tmpvar2, i32* %t
  %tmparray3 = getelementptr inbounds [10 x i32], [10 x i32]* %a, i32 0, i32 0
  %tmpvar4 = load i32, i32* %tmparray3
  %tmparray5 = getelementptr inbounds [10 x i32], [10 x i32]* %a, i32 0, i32 4
  %tmpvar6 = load i32, i32* %tmparray5
  %LoadInst7 = load i32, i32* %t
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @_Const_String_, i32 0, i32 0), i32 %tmpvar4, i32 %tmpvar6, i32 %LoadInst7)
  ret i32 0
}