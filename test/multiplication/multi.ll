; ModuleID = 'main'
source_filename = "main"

@A = private global [200000 x i32] zeroinitializer
@B = private global [200000 x i32] zeroinitializer
@C = private global [200000 x i32] zeroinitializer
@input = private global [100000 x i8] zeroinitializer
@_Const_String_ = private constant [7 x i8] c"%d %d\0A\00"
@_Const_String_.1 = private constant [3 x i8] c"%d\00"
@_Const_String_.2 = private constant [6 x i8] c"%d %d\00"
@_Const_String_.3 = private constant [3 x i8] c"%d\00"
@_Const_String_.4 = private constant [25 x i8] c"Incompatible Dimensions\0A\00"
@_Const_String_.5 = private constant [5 x i8] c"%10d\00"
@_Const_String_.6 = private constant [2 x i8] c"\0A\00"

declare i32 @printf(i8*, ...)

declare i32 @scanf(...)

declare i32 @gets(...)

define i32 @main() {
entry:
  %0 = alloca i32
  %A_M = alloca i32
  %A_N = alloca i32
  %B_M = alloca i32
  %B_N = alloca i32
  %scanf = call i32 (...) @scanf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @_Const_String_, i32 0, i32 0), i32* %A_M, i32* %A_N)
  %i = alloca i32
  store i32 0, i32* %i
  %j = alloca i32
  store i32 0, i32* %j
  br label %cond

return:                                           ; preds = %afterLoop87, %if
  %1 = load i32, i32* %0
  ret i32 %1

cond:                                             ; preds = %afterLoop4, %entry
  %LoadInst = load i32, i32* %i
  %LoadInst1 = load i32, i32* %A_M
  %icmptmp = icmp slt i32 %LoadInst, %LoadInst1
  %whileCond = icmp ne i1 %icmptmp, false
  br i1 %whileCond, label %loop, label %afterLoop

loop:                                             ; preds = %cond
  store i32 0, i32* %j
  br label %cond2

afterLoop:                                        ; preds = %cond
  %scanf15 = call i32 (...) @scanf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @_Const_String_.2, i32 0, i32 0), i32* %B_M, i32* %B_N)
  store i32 0, i32* %i
  store i32 0, i32* %j
  br label %cond16

cond2:                                            ; preds = %loop3, %loop
  %LoadInst5 = load i32, i32* %j
  %LoadInst6 = load i32, i32* %A_N
  %icmptmp7 = icmp slt i32 %LoadInst5, %LoadInst6
  %whileCond8 = icmp ne i1 %icmptmp7, false
  br i1 %whileCond8, label %loop3, label %afterLoop4

loop3:                                            ; preds = %cond2
  %LoadInst9 = load i32, i32* %i
  %LoadInst10 = load i32, i32* %A_N
  %2 = mul i32 %LoadInst9, %LoadInst10
  %LoadInst11 = load i32, i32* %j
  %3 = add i32 %2, %LoadInst11
  %elePtr = getelementptr inbounds [200000 x i32], [200000 x i32]* @A, i32 0, i32 %3
  %scanf12 = call i32 (...) @scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @_Const_String_.1, i32 0, i32 0), i32* %elePtr)
  %LoadInst13 = load i32, i32* %j
  %4 = add i32 %LoadInst13, 1
  store i32 %4, i32* %j
  br label %cond2

afterLoop4:                                       ; preds = %cond2
  %LoadInst14 = load i32, i32* %i
  %5 = add i32 %LoadInst14, 1
  store i32 %5, i32* %i
  br label %cond

cond16:                                           ; preds = %afterLoop25, %afterLoop
  %LoadInst19 = load i32, i32* %i
  %LoadInst20 = load i32, i32* %B_M
  %icmptmp21 = icmp slt i32 %LoadInst19, %LoadInst20
  %whileCond22 = icmp ne i1 %icmptmp21, false
  br i1 %whileCond22, label %loop17, label %afterLoop18

loop17:                                           ; preds = %cond16
  store i32 0, i32* %j
  br label %cond23

afterLoop18:                                      ; preds = %cond16
  %LoadInst37 = load i32, i32* %A_N
  %LoadInst38 = load i32, i32* %B_M
  %icmptmp39 = icmp ne i32 %LoadInst37, %LoadInst38
  %ifCond = icmp ne i1 %icmptmp39, false
  br i1 %ifCond, label %if, label %afterifonly

cond23:                                           ; preds = %loop24, %loop17
  %LoadInst26 = load i32, i32* %j
  %LoadInst27 = load i32, i32* %B_N
  %icmptmp28 = icmp slt i32 %LoadInst26, %LoadInst27
  %whileCond29 = icmp ne i1 %icmptmp28, false
  br i1 %whileCond29, label %loop24, label %afterLoop25

loop24:                                           ; preds = %cond23
  %LoadInst30 = load i32, i32* %i
  %LoadInst31 = load i32, i32* %B_N
  %6 = mul i32 %LoadInst30, %LoadInst31
  %LoadInst32 = load i32, i32* %j
  %7 = add i32 %6, %LoadInst32
  %elePtr33 = getelementptr inbounds [200000 x i32], [200000 x i32]* @B, i32 0, i32 %7
  %scanf34 = call i32 (...) @scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @_Const_String_.3, i32 0, i32 0), i32* %elePtr33)
  %LoadInst35 = load i32, i32* %j
  %8 = add i32 %LoadInst35, 1
  store i32 %8, i32* %j
  br label %cond23

afterLoop25:                                      ; preds = %cond23
  %LoadInst36 = load i32, i32* %i
  %9 = add i32 %LoadInst36, 1
  store i32 %9, i32* %i
  br label %cond16

if:                                               ; preds = %afterLoop18
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @_Const_String_.4, i32 0, i32 0))
  store i32 0, i32* %0
  br label %return

afterifonly:                                      ; preds = %afterLoop18
  store i32 0, i32* %i
  store i32 0, i32* %j
  br label %cond40

cond40:                                           ; preds = %afterLoop49, %afterifonly
  %LoadInst43 = load i32, i32* %i
  %LoadInst44 = load i32, i32* %A_M
  %icmptmp45 = icmp slt i32 %LoadInst43, %LoadInst44
  %whileCond46 = icmp ne i1 %icmptmp45, false
  br i1 %whileCond46, label %loop41, label %afterLoop42

loop41:                                           ; preds = %cond40
  store i32 0, i32* %j
  br label %cond47

afterLoop42:                                      ; preds = %cond40
  store i32 0, i32* %i
  br label %cond85

cond47:                                           ; preds = %afterLoop59, %loop41
  %LoadInst50 = load i32, i32* %j
  %LoadInst51 = load i32, i32* %B_N
  %icmptmp52 = icmp slt i32 %LoadInst50, %LoadInst51
  %whileCond53 = icmp ne i1 %icmptmp52, false
  br i1 %whileCond53, label %loop48, label %afterLoop49

loop48:                                           ; preds = %cond47
  %LoadInst54 = load i32, i32* %i
  %LoadInst55 = load i32, i32* %B_N
  %10 = mul i32 %LoadInst54, %LoadInst55
  %LoadInst56 = load i32, i32* %j
  %11 = add i32 %10, %LoadInst56
  %tmpvar = getelementptr inbounds [200000 x i32], [200000 x i32]* @C, i32 0, i32 %11
  store i32 0, i32* %tmpvar
  %k = alloca i32
  store i32 0, i32* %k
  br label %cond57

afterLoop49:                                      ; preds = %cond47
  %LoadInst84 = load i32, i32* %i
  %12 = add i32 %LoadInst84, 1
  store i32 %12, i32* %i
  br label %cond40

cond57:                                           ; preds = %loop58, %loop48
  %LoadInst60 = load i32, i32* %k
  %LoadInst61 = load i32, i32* %A_N
  %icmptmp62 = icmp slt i32 %LoadInst60, %LoadInst61
  %whileCond63 = icmp ne i1 %icmptmp62, false
  br i1 %whileCond63, label %loop58, label %afterLoop59

loop58:                                           ; preds = %cond57
  %LoadInst64 = load i32, i32* %i
  %LoadInst65 = load i32, i32* %B_N
  %13 = mul i32 %LoadInst64, %LoadInst65
  %LoadInst66 = load i32, i32* %j
  %14 = add i32 %13, %LoadInst66
  %tmpvar67 = getelementptr inbounds [200000 x i32], [200000 x i32]* @C, i32 0, i32 %14
  %LoadInst68 = load i32, i32* %i
  %LoadInst69 = load i32, i32* %B_N
  %15 = mul i32 %LoadInst68, %LoadInst69
  %LoadInst70 = load i32, i32* %j
  %16 = add i32 %15, %LoadInst70
  %tmparray = getelementptr inbounds [200000 x i32], [200000 x i32]* @C, i32 0, i32 %16
  %tmpvar71 = load i32, i32* %tmparray
  %LoadInst72 = load i32, i32* %i
  %LoadInst73 = load i32, i32* %A_N
  %17 = mul i32 %LoadInst72, %LoadInst73
  %LoadInst74 = load i32, i32* %k
  %18 = add i32 %17, %LoadInst74
  %tmparray75 = getelementptr inbounds [200000 x i32], [200000 x i32]* @A, i32 0, i32 %18
  %tmpvar76 = load i32, i32* %tmparray75
  %LoadInst77 = load i32, i32* %k
  %LoadInst78 = load i32, i32* %B_N
  %19 = mul i32 %LoadInst77, %LoadInst78
  %LoadInst79 = load i32, i32* %j
  %20 = add i32 %19, %LoadInst79
  %tmparray80 = getelementptr inbounds [200000 x i32], [200000 x i32]* @B, i32 0, i32 %20
  %tmpvar81 = load i32, i32* %tmparray80
  %21 = mul i32 %tmpvar76, %tmpvar81
  %22 = add i32 %tmpvar71, %21
  store i32 %22, i32* %tmpvar67
  %LoadInst82 = load i32, i32* %k
  %23 = add i32 %LoadInst82, 1
  store i32 %23, i32* %k
  br label %cond57

afterLoop59:                                      ; preds = %cond57
  %LoadInst83 = load i32, i32* %j
  %24 = add i32 %LoadInst83, 1
  store i32 %24, i32* %j
  br label %cond47

cond85:                                           ; preds = %afterLoop94, %afterLoop42
  %LoadInst88 = load i32, i32* %i
  %LoadInst89 = load i32, i32* %A_M
  %icmptmp90 = icmp slt i32 %LoadInst88, %LoadInst89
  %whileCond91 = icmp ne i1 %icmptmp90, false
  br i1 %whileCond91, label %loop86, label %afterLoop87

loop86:                                           ; preds = %cond85
  store i32 0, i32* %j
  br label %cond92

afterLoop87:                                      ; preds = %cond85
  store i32 0, i32* %0
  br label %return

cond92:                                           ; preds = %loop93, %loop86
  %LoadInst95 = load i32, i32* %j
  %LoadInst96 = load i32, i32* %B_N
  %icmptmp97 = icmp slt i32 %LoadInst95, %LoadInst96
  %whileCond98 = icmp ne i1 %icmptmp97, false
  br i1 %whileCond98, label %loop93, label %afterLoop94

loop93:                                           ; preds = %cond92
  %LoadInst99 = load i32, i32* %i
  %LoadInst100 = load i32, i32* %B_N
  %25 = mul i32 %LoadInst99, %LoadInst100
  %LoadInst101 = load i32, i32* %j
  %26 = add i32 %25, %LoadInst101
  %tmparray102 = getelementptr inbounds [200000 x i32], [200000 x i32]* @C, i32 0, i32 %26
  %tmpvar103 = load i32, i32* %tmparray102
  %printf104 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @_Const_String_.5, i32 0, i32 0), i32 %tmpvar103)
  %LoadInst105 = load i32, i32* %j
  %27 = add i32 %LoadInst105, 1
  store i32 %27, i32* %j
  br label %cond92

afterLoop94:                                      ; preds = %cond92
  %printf106 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @_Const_String_.6, i32 0, i32 0))
  %LoadInst107 = load i32, i32* %i
  %28 = add i32 %LoadInst107, 1
  store i32 %28, i32* %i
  br label %cond85
}