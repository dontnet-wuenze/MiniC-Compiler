; ModuleID = 'main'
source_filename = "main"

@j = private global i32 0
@_Const_String_ = private constant [7 x i8] c"j: %d\0A\00"

declare i32 @printf(i8*, ...)

declare i32 @scanf(...)

define i32 @main() {
entry:
  %j = alloca i32
  store i32 3, i32* %j
  %i = alloca i32
  store i32 2, i32* %i
  %LoadInst = load i32, i32* %i
  %icmptmp = icmp slt i32 %LoadInst, 4
  %ifCond = icmp ne i1 %icmptmp, false
  br i1 %ifCond, label %if, label %else

if:                                               ; preds = %entry
  %j1 = alloca i32
  store i32 4, i32* %j1
  br label %afterifelse

else:                                             ; preds = %entry
  store i32 5, i32* %j
  br label %afterifelse

afterifelse:                                      ; preds = %else, %if
  %LoadInst2 = load i32, i32* %j
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @_Const_String_, i32 0, i32 0), i32 %LoadInst2)
  ret i32 0
}