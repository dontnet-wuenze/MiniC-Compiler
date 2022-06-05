; ModuleID = 'main'
source_filename = "main"

@str = private global [10 x i8] zeroinitializer
@_Const_String_ = private constant [4 x i8] c"%s\0A\00"

declare i32 @printf(i8*, ...)

declare i32 @scanf(...)

declare i32 @gets(...)

define i32 @main() {
entry:
  %0 = alloca i32
  %gets = call i32 (...) @gets(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @str, i32 0, i32 0))
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_Const_String_, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @str, i32 0, i32 0))
  store i32 0, i32* %0
  br label %return

return:                                           ; preds = %entry
  %1 = load i32, i32* %0
  ret i32 %1
}