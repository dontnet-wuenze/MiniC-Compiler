; ModuleID = 'main'
source_filename = "main"

@_Const_String_ = private constant [4 x i8] c"%d\0A\00"
@_Const_String_.1 = private constant [4 x i8] c"%d\0A\00"

declare i32 @printf(i8*, ...)

declare i32 @scanf(...)

define void @f(i32* %a1, i32 %b2) {
entry:
  %a = alloca i32*
  store i32* %a1, i32** %a
  %b = alloca i32
  store i32 %b2, i32* %b
  %0 = load i32*, i32** %a
  %tmparray = getelementptr inbounds i32, i32* %0, i32 4
  %tmpvar = load i32, i32* %tmparray
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_Const_String_, i32 0, i32 0), i32 %tmpvar)
  %1 = load i32*, i32** %a
  %tmpvar3 = getelementptr inbounds i32, i32* %1, i32 2
  store i32 2, i32* %tmpvar3
  br label %return

return:                                           ; preds = %entry
  ret void
}

define i32 @main() {
entry:
  %0 = alloca i32
  %b = alloca [10 x i32]
  %tmpvar = getelementptr inbounds [10 x i32], [10 x i32]* %b, i32 0, i32 4
  store i32 4, i32* %tmpvar
  %c = alloca i32
  store i32 2, i32* %c
  %arrayPtr = getelementptr inbounds [10 x i32], [10 x i32]* %b, i32 0, i32 0
  %LoadInst = load i32, i32* %c
  call void @f(i32* %arrayPtr, i32 %LoadInst)
  %tmparray = getelementptr inbounds [10 x i32], [10 x i32]* %b, i32 0, i32 2
  %tmpvar1 = load i32, i32* %tmparray
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_Const_String_.1, i32 0, i32 0), i32 %tmpvar1)
  store i32 0, i32* %0
  br label %return

return:                                           ; preds = %entry
  %1 = load i32, i32* %0
  ret i32 %1
}