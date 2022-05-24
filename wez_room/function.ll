; ModuleID = 'main'
source_filename = "main"

declare i32 @printf(i8*, ...)

declare i32 @scanf(...)

define i32 @main() {
entry:
  %0 = alloca i32
  store i32 0, i32* %0
  %i = alloca i32
  store i32 2, i32* %i
  %LoadInst = load i32, i32* %i
  %icmptmp = icmp sgt i32 %LoadInst, 1
  %ifCond = icmp ne i1 %icmptmp, false
  br i1 %ifCond, label %if, label %afterifonly

return:                                           ; preds = %afterifonly, %if
  %1 = load i32, i32* %0
  ret i32 %1

if:                                               ; preds = %entry
  store i32 0, i32* %0
  br label %return
  br label %afterifonly

afterifonly:                                      ; preds = %if, %entry
  store i32 0, i32* %0
  br label %return
}