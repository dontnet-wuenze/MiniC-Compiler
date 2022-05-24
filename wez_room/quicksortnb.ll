; ModuleID = 'main'
source_filename = "main"

@_Const_String_ = private constant [3 x i8] c"%d\00"
@_Const_String_.1 = private constant [3 x i8] c"%d\00"
@_Const_String_.2 = private constant [4 x i8] c"%d \00"

declare i32 @printf(i8*, ...)

declare i32 @scanf(...)

define void @quicksort(i32* %A1, i32 %left2, i32 %right3) {
entry:
  %A = alloca i32*
  store i32* %A1, i32** %A
  %left = alloca i32
  store i32 %left2, i32* %left
  %right = alloca i32
  store i32 %right3, i32* %right
  %i = alloca i32
  %j = alloca i32
  %x = alloca i32
  %y = alloca i32
  %LoadInst = load i32, i32* %left
  store i32 %LoadInst, i32* %i
  %LoadInst4 = load i32, i32* %right
  store i32 %LoadInst4, i32* %j
  %LoadInst5 = load i32, i32* %left
  %LoadInst6 = load i32, i32* %right
  %0 = add i32 %LoadInst5, %LoadInst6
  %1 = sdiv i32 %0, 2
  %2 = load i32*, i32** %A
  %tmparray = getelementptr inbounds i32, i32* %2, i32 %1
  %tmpvar = load i32, i32* %tmparray
  store i32 %tmpvar, i32* %x
  br label %cond

return:                                           ; preds = %afterifonly55
  ret void

cond:                                             ; preds = %afterifonly, %entry
  %LoadInst7 = load i32, i32* %i
  %LoadInst8 = load i32, i32* %j
  %icmptmp = icmp sle i32 %LoadInst7, %LoadInst8
  %whileCond = icmp ne i1 %icmptmp, false
  br i1 %whileCond, label %loop, label %afterLoop

loop:                                             ; preds = %cond
  br label %cond9

afterLoop:                                        ; preds = %cond
  %LoadInst47 = load i32, i32* %left
  %LoadInst48 = load i32, i32* %j
  %icmptmp49 = icmp slt i32 %LoadInst47, %LoadInst48
  %ifCond50 = icmp ne i1 %icmptmp49, false
  br i1 %ifCond50, label %if45, label %afterifonly46

cond9:                                            ; preds = %loop10, %loop
  %LoadInst12 = load i32, i32* %i
  %3 = load i32*, i32** %A
  %tmparray13 = getelementptr inbounds i32, i32* %3, i32 %LoadInst12
  %tmpvar14 = load i32, i32* %tmparray13
  %LoadInst15 = load i32, i32* %x
  %icmptmp16 = icmp slt i32 %tmpvar14, %LoadInst15
  %whileCond17 = icmp ne i1 %icmptmp16, false
  br i1 %whileCond17, label %loop10, label %afterLoop11

loop10:                                           ; preds = %cond9
  %LoadInst18 = load i32, i32* %i
  %4 = add i32 %LoadInst18, 1
  store i32 %4, i32* %i
  br label %cond9

afterLoop11:                                      ; preds = %cond9
  br label %cond19

cond19:                                           ; preds = %loop20, %afterLoop11
  %LoadInst22 = load i32, i32* %x
  %LoadInst23 = load i32, i32* %j
  %5 = load i32*, i32** %A
  %tmparray24 = getelementptr inbounds i32, i32* %5, i32 %LoadInst23
  %tmpvar25 = load i32, i32* %tmparray24
  %icmptmp26 = icmp slt i32 %LoadInst22, %tmpvar25
  %whileCond27 = icmp ne i1 %icmptmp26, false
  br i1 %whileCond27, label %loop20, label %afterLoop21

loop20:                                           ; preds = %cond19
  %LoadInst28 = load i32, i32* %j
  %6 = sub i32 %LoadInst28, 1
  store i32 %6, i32* %j
  br label %cond19

afterLoop21:                                      ; preds = %cond19
  %LoadInst29 = load i32, i32* %i
  %LoadInst30 = load i32, i32* %j
  %icmptmp31 = icmp sle i32 %LoadInst29, %LoadInst30
  %ifCond = icmp ne i1 %icmptmp31, false
  br i1 %ifCond, label %if, label %afterifonly

if:                                               ; preds = %afterLoop21
  %LoadInst32 = load i32, i32* %i
  %7 = load i32*, i32** %A
  %tmparray33 = getelementptr inbounds i32, i32* %7, i32 %LoadInst32
  %tmpvar34 = load i32, i32* %tmparray33
  store i32 %tmpvar34, i32* %y
  %LoadInst35 = load i32, i32* %i
  %8 = load i32*, i32** %A
  %tmpvar36 = getelementptr inbounds i32, i32* %8, i32 %LoadInst35
  %LoadInst37 = load i32, i32* %j
  %9 = load i32*, i32** %A
  %tmparray38 = getelementptr inbounds i32, i32* %9, i32 %LoadInst37
  %tmpvar39 = load i32, i32* %tmparray38
  store i32 %tmpvar39, i32* %tmpvar36
  %LoadInst40 = load i32, i32* %j
  %10 = load i32*, i32** %A
  %tmpvar41 = getelementptr inbounds i32, i32* %10, i32 %LoadInst40
  %LoadInst42 = load i32, i32* %y
  store i32 %LoadInst42, i32* %tmpvar41
  %LoadInst43 = load i32, i32* %i
  %11 = add i32 %LoadInst43, 1
  store i32 %11, i32* %i
  %LoadInst44 = load i32, i32* %j
  %12 = sub i32 %LoadInst44, 1
  store i32 %12, i32* %j
  br label %afterifonly

afterifonly:                                      ; preds = %if, %afterLoop21
  br label %cond

if45:                                             ; preds = %afterLoop
  %LoadInst51 = load i32*, i32** %A
  %LoadInst52 = load i32, i32* %left
  %LoadInst53 = load i32, i32* %j
  call void @quicksort(i32* %LoadInst51, i32 %LoadInst52, i32 %LoadInst53)
  br label %afterifonly46

afterifonly46:                                    ; preds = %if45, %afterLoop
  %LoadInst56 = load i32, i32* %i
  %LoadInst57 = load i32, i32* %right
  %icmptmp58 = icmp slt i32 %LoadInst56, %LoadInst57
  %ifCond59 = icmp ne i1 %icmptmp58, false
  br i1 %ifCond59, label %if54, label %afterifonly55

if54:                                             ; preds = %afterifonly46
  %LoadInst60 = load i32*, i32** %A
  %LoadInst61 = load i32, i32* %i
  %LoadInst62 = load i32, i32* %right
  call void @quicksort(i32* %LoadInst60, i32 %LoadInst61, i32 %LoadInst62)
  br label %afterifonly55

afterifonly55:                                    ; preds = %if54, %afterifonly46
  br label %return
}

define i32 @main() {
entry:
  %0 = alloca i32
  %B = alloca [10 x i32]
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
  %elePtr = getelementptr inbounds [10 x i32], [10 x i32]* %B, i32 0, i32 %LoadInst2
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
  %arrayPtr = getelementptr inbounds [10 x i32], [10 x i32]* %B, i32 0, i32 0
  %LoadInst6 = load i32, i32* %left
  %LoadInst7 = load i32, i32* %right
  call void @quicksort(i32* %arrayPtr, i32 %LoadInst6, i32 %LoadInst7)
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
  %tmparray = getelementptr inbounds [10 x i32], [10 x i32]* %B, i32 0, i32 %LoadInst15
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