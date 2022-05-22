; ModuleID = 'main'
source_filename = "main"

@_Const_String_ = private constant [7 x i8] c"%d %d\0A\00"

declare i32 @printf(i8*, ...)

declare i32 @scanf(...)

define i32 @main() {
entry:
  %a = alloca [10 x i32]
  %tmpvar = getelementptr inbounds [10 x i32], [10 x i32]* %a, i32 0, i32 0
  store i32 1, i32* %tmpvar
  %tmpvar1 = getelementptr inbounds [10 x i32], [10 x i32]* %a, i32 0, i32 4
  store i32 5, i32* %tmpvar1
  %tmpvar2 = getelementptr inbounds [10 x i32], [10 x i32]* %a, i32 0, i32 0
  %tmpvar3 = getelementptr inbounds [10 x i32], [10 x i32]* %a, i32 0, i32 4
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @_Const_String_, i32 0, i32 0), i32* %tmpvar2, i32* %tmpvar3)
  ret i32 0
}