; ModuleID = 'main'
source_filename = "main"

@sum = private global i32 0
@_Const_String_ = private constant [28 x i8] c"sum : %d, i : %d, cnt : %d\0A\00"

declare i32 @printf(i8*, ...)

declare i32 @scanf(...)

define i32 @main() {
entry:
  %i = alloca i32
  store i32 2, i32* %i
  %cnt = alloca i32
  store i32 0, i32* %cnt
  br label %cond

cond:                                             ; preds = %loop, %entry
  %LoadInst = load i32, i32* %cnt
  %icmptmp = icmp slt i32 %LoadInst, 3
  %whileCond = icmp ne i1 %icmptmp, false
  br i1 %whileCond, label %loop, label %afterLoop

loop:                                             ; preds = %cond
  %LoadInst1 = load i32, i32* %cnt
  %0 = add i32 %LoadInst1, 1
  store i32 %0, i32* %cnt
  %LoadInst2 = load i32, i32* %i
  %1 = add i32 %LoadInst2, 1
  store i32 %1, i32* %i
  br label %cond

afterLoop:                                        ; preds = %cond
  %LoadInst3 = load i32, i32* %i
  %LoadInst4 = load i32, i32* @sum
  %2 = add i32 %LoadInst3, %LoadInst4
  store i32 %2, i32* @sum
  %LoadInst5 = load i32, i32* @sum
  %LoadInst6 = load i32, i32* %i
  %LoadInst7 = load i32, i32* %cnt
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @_Const_String_, i32 0, i32 0), i32 %LoadInst5, i32 %LoadInst6, i32 %LoadInst7)
  ret i32 0
}