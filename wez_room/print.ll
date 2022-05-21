; ModuleID = 'main'
source_filename = "main"

@_Const_String_ = private constant [8 x i8] c"i : %d\0A\00"

declare i32 @printf(i8*, ...)

declare i32 @scanf(...)

define i32 @main() {
entry:
  %i = alloca i32
  store i32 0, i32* %i
  %LoadInst = load i32, i32* %i
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @_Const_String_, i32 0, i32 0), i32 %LoadInst)
  %LoadInst1 = load i32, i32* %i
  ret i32 %LoadInst1
}