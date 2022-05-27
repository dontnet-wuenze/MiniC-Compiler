; ModuleID = 'main'
source_filename = "main"

@_Const_String_ = private constant [7 x i8] c"%c %c\0A\00"

declare i32 @printf(i8*, ...)

declare i32 @scanf(...)

define i32 @main() {
entry:
  %0 = alloca i32
  %c = alloca i8
  store i8 99, i8* %c
  %d = alloca i8
  store i8 68, i8* %d
  %LoadInst = load i8, i8* %c
  %LoadInst1 = load i8, i8* %d
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @_Const_String_, i32 0, i32 0), i8 %LoadInst, i8 %LoadInst1)
  store i32 0, i32* %0
  br label %return

return:                                           ; preds = %entry
  %1 = load i32, i32* %0
  ret i32 %1
}