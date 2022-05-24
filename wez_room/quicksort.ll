; ModuleID = 'main'
source_filename = "main"

@A = private global [200000 x i32] zeroinitializer
@_Const_String_ = private constant [3 x i8] c"%d\00"
@_Const_String_.1 = private constant [3 x i8] c"%d\00"
@_Const_String_.2 = private constant [4 x i8] c"%d \00"

declare i32 @printf(i8*, ...)

declare i32 @scanf(...)

define void @quicksort(i32 %left1, i32 %right2) {
entry:
  %left = alloca i32
  store i32 %left1, i32* %left
  %right = alloca i32
  store i32 %right2, i32* %right
  %i = alloca i32
  %j = alloca i32
  %x = alloca i32
  %y = alloca i32
  %LoadInst = load i32, i32* %left
  store i32 %LoadInst, i32* %i
  %LoadInst3 = load i32, i32* %right
  store i32 %LoadInst3, i32* %j
  %LoadInst4 = load i32, i32* %left
  %LoadInst5 = load i32, i32* %right
  %0 = add i32 %LoadInst4, %LoadInst5
  %1 = sdiv i32 %0, 2
  %tmparray = getelementptr inbounds [200000 x i32], [200000 x i32]* @A, i32 0, i32 %1
  %tmpvar = load i32, i32* %tmparray
  store i32 %tmpvar, i32* %x
  br label %cond

return:                                           ; preds = %afterifonly53
  ret void

cond:                                             ; preds = %afterifonly, %entry
  %LoadInst6 = load i32, i32* %i
  %LoadInst7 = load i32, i32* %j
  %icmptmp = icmp sle i32 %LoadInst6, %LoadInst7
  %whileCond = icmp ne i1 %icmptmp, false
  br i1 %whileCond, label %loop, label %afterLoop

loop:                                             ; preds = %cond
  br label %cond8

afterLoop:                                        ; preds = %cond
  %LoadInst46 = load i32, i32* %left
  %LoadInst47 = load i32, i32* %j
  %icmptmp48 = icmp slt i32 %LoadInst46, %LoadInst47
  %ifCond49 = icmp ne i1 %icmptmp48, false
  br i1 %ifCond49, label %if44, label %afterifonly45

cond8:                                            ; preds = %loop9, %loop
  %LoadInst11 = load i32, i32* %i
  %tmparray12 = getelementptr inbounds [200000 x i32], [200000 x i32]* @A, i32 0, i32 %LoadInst11
  %tmpvar13 = load i32, i32* %tmparray12
  %LoadInst14 = load i32, i32* %x
  %icmptmp15 = icmp slt i32 %tmpvar13, %LoadInst14
  %whileCond16 = icmp ne i1 %icmptmp15, false
  br i1 %whileCond16, label %loop9, label %afterLoop10

loop9:                                            ; preds = %cond8
  %LoadInst17 = load i32, i32* %i
  %2 = add i32 %LoadInst17, 1
  store i32 %2, i32* %i
  br label %cond8

afterLoop10:                                      ; preds = %cond8
  br label %cond18

cond18:                                           ; preds = %loop19, %afterLoop10
  %LoadInst21 = load i32, i32* %x
  %LoadInst22 = load i32, i32* %j
  %tmparray23 = getelementptr inbounds [200000 x i32], [200000 x i32]* @A, i32 0, i32 %LoadInst22
  %tmpvar24 = load i32, i32* %tmparray23
  %icmptmp25 = icmp slt i32 %LoadInst21, %tmpvar24
  %whileCond26 = icmp ne i1 %icmptmp25, false
  br i1 %whileCond26, label %loop19, label %afterLoop20

loop19:                                           ; preds = %cond18
  %LoadInst27 = load i32, i32* %j
  %3 = sub i32 %LoadInst27, 1
  store i32 %3, i32* %j
  br label %cond18

afterLoop20:                                      ; preds = %cond18
  %LoadInst28 = load i32, i32* %i
  %LoadInst29 = load i32, i32* %j
  %icmptmp30 = icmp sle i32 %LoadInst28, %LoadInst29
  %ifCond = icmp ne i1 %icmptmp30, false
  br i1 %ifCond, label %if, label %afterifonly

if:                                               ; preds = %afterLoop20
  %LoadInst31 = load i32, i32* %i
  %tmparray32 = getelementptr inbounds [200000 x i32], [200000 x i32]* @A, i32 0, i32 %LoadInst31
  %tmpvar33 = load i32, i32* %tmparray32
  store i32 %tmpvar33, i32* %y
  %LoadInst34 = load i32, i32* %i
  %tmpvar35 = getelementptr inbounds [200000 x i32], [200000 x i32]* @A, i32 0, i32 %LoadInst34
  %LoadInst36 = load i32, i32* %j
  %tmparray37 = getelementptr inbounds [200000 x i32], [200000 x i32]* @A, i32 0, i32 %LoadInst36
  %tmpvar38 = load i32, i32* %tmparray37
  store i32 %tmpvar38, i32* %tmpvar35
  %LoadInst39 = load i32, i32* %j
  %tmpvar40 = getelementptr inbounds [200000 x i32], [200000 x i32]* @A, i32 0, i32 %LoadInst39
  %LoadInst41 = load i32, i32* %y
  store i32 %LoadInst41, i32* %tmpvar40
  %LoadInst42 = load i32, i32* %i
  %4 = add i32 %LoadInst42, 1
  store i32 %4, i32* %i
  %LoadInst43 = load i32, i32* %j
  %5 = sub i32 %LoadInst43, 1
  store i32 %5, i32* %j
  br label %afterifonly

afterifonly:                                      ; preds = %if, %afterLoop20
  br label %cond

if44:                                             ; preds = %afterLoop
  %LoadInst50 = load i32, i32* %left
  %LoadInst51 = load i32, i32* %j
  call void @quicksort(i32 %LoadInst50, i32 %LoadInst51)
  br label %afterifonly45

afterifonly45:                                    ; preds = %if44, %afterLoop
  %LoadInst54 = load i32, i32* %i
  %LoadInst55 = load i32, i32* %right
  %icmptmp56 = icmp slt i32 %LoadInst54, %LoadInst55
  %ifCond57 = icmp ne i1 %icmptmp56, false
  br i1 %ifCond57, label %if52, label %afterifonly53

if52:                                             ; preds = %afterifonly45
  %LoadInst58 = load i32, i32* %i
  %LoadInst59 = load i32, i32* %right
  call void @quicksort(i32 %LoadInst58, i32 %LoadInst59)
  br label %afterifonly53

afterifonly53:                                    ; preds = %if52, %afterifonly45
  br label %return
}

define i32 @main() {
entry:
  %0 = alloca i32
  %N = alloca i32
  %scanf = call i32 (...) @scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @_Const_String_, i32 0, i32 0), i32* %N)
  %i = alloca i32
  store i32 0, i32* %i
  br label %cond

return:                                           ; preds = %afterLoop10
  %1 = load i32, i32* %0
  ret i32 %1

cond:                                             ; preds = %loop, %entry
  %LoadInst = load i32, i32* %i
  %LoadInst1 = load i32, i32* %N
  %icmptmp = icmp slt i32 %LoadInst, %LoadInst1
  %whileCond = icmp ne i1 %icmptmp, false
  br i1 %whileCond, label %loop, label %afterLoop

loop:                                             ; preds = %cond
  %LoadInst2 = load i32, i32* %i
  %elePtr = getelementptr inbounds [200000 x i32], [200000 x i32]* @A, i32 0, i32 %LoadInst2
  %scanf3 = call i32 (...) @scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @_Const_String_.1, i32 0, i32 0), i32* %elePtr)
  %LoadInst4 = load i32, i32* %i
  %2 = add i32 %LoadInst4, 1
  store i32 %2, i32* %i
  br label %cond

afterLoop:                                        ; preds = %cond
  %left = alloca i32
  store i32 0, i32* %left
  %right = alloca i32
  %LoadInst5 = load i32, i32* %N
  %3 = sub i32 %LoadInst5, 1
  store i32 %3, i32* %right
  %LoadInst6 = load i32, i32* %left
  %LoadInst7 = load i32, i32* %right
  call void @quicksort(i32 %LoadInst6, i32 %LoadInst7)
  store i32 0, i32* %i
  br label %cond8

cond8:                                            ; preds = %loop9, %afterLoop
  %LoadInst11 = load i32, i32* %i
  %LoadInst12 = load i32, i32* %N
  %icmptmp13 = icmp slt i32 %LoadInst11, %LoadInst12
  %whileCond14 = icmp ne i1 %icmptmp13, false
  br i1 %whileCond14, label %loop9, label %afterLoop10

loop9:                                            ; preds = %cond8
  %LoadInst15 = load i32, i32* %i
  %tmparray = getelementptr inbounds [200000 x i32], [200000 x i32]* @A, i32 0, i32 %LoadInst15
  %tmpvar = load i32, i32* %tmparray
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_Const_String_.2, i32 0, i32 0), i32 %tmpvar)
  %LoadInst16 = load i32, i32* %i
  %4 = add i32 %LoadInst16, 1
  store i32 %4, i32* %i
  br label %cond8

afterLoop10:                                      ; preds = %cond8
  store i32 0, i32* %0
  br label %return
}