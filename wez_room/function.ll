; ModuleID = 'main'
source_filename = "main"

@_Const_String_ = private constant [4 x i8] c"%d\0A\00"
@_Const_String_.1 = private constant [7 x i8] c"b: %d\0A\00"

declare i32 @printf(i8*, ...)

declare i32 @scanf(...)

define void @f([10 x i32] %a1) {
entry:
  %a = alloca [10 x i32]
  store [10 x i32] %a1, [10 x i32]* %a
  %tmparray = getelementptr inbounds [10 x i32], [10 x i32]* %a, i32 0, i32 2
  %tmpvar = load i32, i32* %tmparray
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_Const_String_, i32 0, i32 0), i32 %tmpvar)
  %tmpvar2 = getelementptr inbounds [10 x i32], [10 x i32]* %a, i32 0, i32 4
  store i32 6, i32* %tmpvar2
  ret void
}

define i32 @main() {
entry:
  %b = alloca [10 x i32]
  %tmpvar = getelementptr inbounds [10 x i32], [10 x i32]* %b, i32 0, i32 2
  store i32 3, i32* %tmpvar
  %LoadInst = load [10 x i32], [10 x i32]* %b
  call void @f([10 x i32] %LoadInst)
  %tmparray = getelementptr inbounds [10 x i32], [10 x i32]* %b, i32 0, i32 4
  %tmpvar1 = load i32, i32* %tmparray
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @_Const_String_.1, i32 0, i32 0), i32 %tmpvar1)
  ret i32 0
}