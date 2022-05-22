; ModuleID = 'main'
source_filename = "main"

@_Const_String_ = private constant [3 x i8] c"%d\00"
@_Const_String_.1 = private constant [4 x i8] c"%d\0A\00"
@_Const_String_.2 = private constant [3 x i8] c"%d\00"
@_Const_String_.3 = private constant [4 x i8] c"%d\0A\00"

declare i32 @printf(i8*, ...)

declare i32 @scanf(...)

define i32 @main() {
entry:
  %a = alloca i32
  %scanf = call i32 (...) @scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @_Const_String_, i32 0, i32 0), i32* %a)
  %LoadInst = load i32, i32* %a
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_Const_String_.1, i32 0, i32 0), i32 %LoadInst)
  %c = alloca [10 x i32]
  %tmparray = getelementptr inbounds [10 x i32], [10 x i32]* %c, i32 0, i32 5
  %scanf1 = call i32 (...) @scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @_Const_String_.2, i32 0, i32 0), i32* %tmparray)
  %tmparray2 = getelementptr inbounds [10 x i32], [10 x i32]* %c, i32 0, i32 5
  %tmpvar = load i32, i32* %tmparray2
  %printf3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_Const_String_.3, i32 0, i32 0), i32 %tmpvar)
  %LoadInst4 = load i32, i32* %a
  ret i32 %LoadInst4
}