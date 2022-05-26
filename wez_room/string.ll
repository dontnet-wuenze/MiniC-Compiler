; ModuleID = 'main'
source_filename = "main"

@_Const_String_ = private constant [3 x i8] c"%s\00"
@_Const_String_.1 = private constant [4 x i8] c"%s\0A\00"
@_Const_String_.2 = private constant [9 x i8] c"success\0A\00"

declare i32 @printf(i8*, ...)

declare i32 @scanf(...)

define i32 @main() {
entry:
  %0 = alloca i32
  %c = alloca i8
  store i8 99, i8* %c
  %d = alloca i8
  store i8 68, i8* %d
  %b = alloca [10 x i8]
  br label %cond

return:                                           ; preds = %afterLoop
  %1 = load i32, i32* %0
  ret i32 %1

cond:                                             ; preds = %afterifonly, %entry
  br i1 true, label %loop, label %afterLoop

loop:                                             ; preds = %cond
  %arrayPtr = getelementptr inbounds [10 x i8], [10 x i8]* %b, i32 0, i32 0
  %scanf = call i32 (...) @scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @_Const_String_, i32 0, i32 0), i8* %arrayPtr)
  %arrayPtr1 = getelementptr inbounds [10 x i8], [10 x i8]* %b, i32 0, i32 0
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_Const_String_.1, i32 0, i32 0), i8* %arrayPtr1)
  %tmparray = getelementptr inbounds [10 x i8], [10 x i8]* %b, i32 0, i32 0
  %tmpvar = load i8, i8* %tmparray
  %icmptmp = icmp eq i8 %tmpvar, 92
  %ifCond = icmp ne i1 %icmptmp, false
  br i1 %ifCond, label %if, label %afterifonly

afterLoop:                                        ; preds = %if, %cond
  %printf2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @_Const_String_.2, i32 0, i32 0))
  store i32 0, i32* %0
  br label %return

if:                                               ; preds = %loop
  br label %afterLoop

afterifonly:                                      ; preds = %loop
  br label %cond
}