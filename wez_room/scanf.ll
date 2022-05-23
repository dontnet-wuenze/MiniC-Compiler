; ModuleID = 'main'
source_filename = "main"

@_Const_String_ = private constant [6 x i8] c"%d %d\00"
@_Const_String_.1 = private constant [7 x i8] c"%d %d\0A\00"

declare i32 @printf(i8*, ...)

declare i32 @scanf(...)

define i32 @main() {
entry:
  %b = alloca i32
  %a = alloca [10 x i32]
  %LoadInst = load [10 x i32], [10 x i32]* %a
  %scanf = call i32 (...) @scanf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @_Const_String_, i32 0, i32 0), [10 x i32] %LoadInst, i32* %b)
  %tmparray = getelementptr inbounds [10 x i32], [10 x i32]* %a, i32 0, i32 0
  %tmpvar = load i32, i32* %tmparray
  %LoadInst1 = load i32, i32* %b
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @_Const_String_.1, i32 0, i32 0), i32 %tmpvar, i32 %LoadInst1)
  ret i32 0
}