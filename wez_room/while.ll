; ModuleID = 'main'
source_filename = "main"

@_Const_String_ = private constant [33 x i8] c"localsum : %d, i : %d, cnt : %d\0A\00"

declare i32 @printf(i8*, ...)

declare i32 @scanf(...)

define i32 @main() {
entry:
  %localsum = alloca i32
  store i32 5, i32* %localsum
  %i = alloca i32
  store i32 2, i32* %i
  %cnt = alloca i32
  store i32 0, i32* %cnt
  br label %cond

cond:                                             ; preds = %afterLoop4, %entry
  %LoadInst = load i32, i32* %cnt
  %icmptmp = icmp slt i32 %LoadInst, 3
  %whileCond = icmp ne i1 %icmptmp, false
  br i1 %whileCond, label %loop, label %afterLoop

loop:                                             ; preds = %cond
  %LoadInst1 = load i32, i32* %cnt
  %0 = add i32 %LoadInst1, 1
  store i32 %0, i32* %cnt
  %j = alloca i32
  store i32 0, i32* %j
  br label %cond2

afterLoop:                                        ; preds = %cond
  %LoadInst10 = load i32, i32* %i
  %LoadInst11 = load i32, i32* %localsum
  %1 = add i32 %LoadInst10, %LoadInst11
  %2 = add i32 %1, 10
  store i32 %2, i32* %i
  %LoadInst12 = load i32, i32* %localsum
  %LoadInst13 = load i32, i32* %i
  %LoadInst14 = load i32, i32* %cnt
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @_Const_String_, i32 0, i32 0), i32 %LoadInst12, i32 %LoadInst13, i32 %LoadInst14)
  ret i32 0

cond2:                                            ; preds = %loop3, %loop
  %LoadInst5 = load i32, i32* %j
  %icmptmp6 = icmp slt i32 %LoadInst5, 5
  %whileCond7 = icmp ne i1 %icmptmp6, false
  br i1 %whileCond7, label %loop3, label %afterLoop4

loop3:                                            ; preds = %cond2
  %LoadInst8 = load i32, i32* %localsum
  %3 = add i32 %LoadInst8, 1
  store i32 %3, i32* %localsum
  %LoadInst9 = load i32, i32* %j
  %4 = add i32 %LoadInst9, 1
  store i32 %4, i32* %j
  br label %cond2

afterLoop4:                                       ; preds = %cond2
  br label %cond
}