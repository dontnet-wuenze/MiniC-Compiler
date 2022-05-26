; ModuleID = 'main'
source_filename = "main"

@course_info = private global [1000000 x i8] zeroinitializer
@pre_course = private global [1000000 x i8] zeroinitializer
@pass_course = private global [11100 x i32] zeroinitializer
@_Const_String_ = private constant [3 x i8] c"%s\00"
@_Const_String_.1 = private constant [4 x i8] c"%s\0A\00"
@_Const_String_.2 = private constant [4 x i8] c"%s\0A\00"
@_Const_String_.3 = private constant [11 x i8] c"GPA: %.1f\0A\00"
@_Const_String_.4 = private constant [21 x i8] c"Hours Attempted: %d\0A\00"
@_Const_String_.5 = private constant [21 x i8] c"Hours Completed: %d\0A\00"

declare i32 @printf(i8*, ...)

declare i32 @scanf(...)

define i32 @main() {
entry:
  %0 = alloca i32
  %total_credit = alloca i32
  store i32 0, i32* %total_credit
  %total_gpa = alloca float
  store float 0.000000e+00, float* %total_gpa
  %pass_credit = alloca i32
  store i32 0, i32* %pass_credit
  %try_credit = alloca i32
  store i32 0, i32* %try_credit
  %course_num = alloca i32
  store i32 0, i32* %course_num
  br label %cond

return:                                           ; preds = %afterLoop5
  %1 = load i32, i32* %0
  ret i32 %1

cond:                                             ; preds = %afterifonly, %entry
  br i1 true, label %loop, label %afterLoop

loop:                                             ; preds = %cond
  %LoadInst = load i32, i32* %course_num
  %2 = mul i32 %LoadInst, 1000
  %elePtr = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @course_info, i32 0, i32 %2
  %scanf = call i32 (...) @scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @_Const_String_, i32 0, i32 0), i8* %elePtr)
  %LoadInst1 = load i32, i32* %course_num
  %3 = mul i32 %LoadInst1, 1000
  %tmparray = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @course_info, i32 0, i32 %3
  %tmpvar = load i8, i8* %tmparray
  %icmptmp = icmp eq i8 %tmpvar, 101
  %ifCond = icmp ne i1 %icmptmp, false
  br i1 %ifCond, label %if, label %afterifonly

afterLoop:                                        ; preds = %if, %cond
  %course = alloca i32
  store i32 0, i32* %course
  br label %cond3

if:                                               ; preds = %loop
  br label %afterLoop

afterifonly:                                      ; preds = %loop
  %LoadInst2 = load i32, i32* %course_num
  %4 = add i32 %LoadInst2, 1
  store i32 %4, i32* %course_num
  br label %cond

cond3:                                            ; preds = %afterifonly110, %afterLoop
  %LoadInst6 = load i32, i32* %course
  %LoadInst7 = load i32, i32* %course_num
  %icmptmp8 = icmp slt i32 %LoadInst6, %LoadInst7
  %whileCond = icmp ne i1 %icmptmp8, false
  br i1 %whileCond, label %loop4, label %afterLoop5

loop4:                                            ; preds = %cond3
  %LoadInst9 = load i32, i32* %course
  %5 = mul i32 %LoadInst9, 1000
  %elePtr10 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @course_info, i32 0, i32 %5
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_Const_String_.1, i32 0, i32 0), i8* %elePtr10)
  %idx = alloca i32
  %LoadInst11 = load i32, i32* %course
  %6 = mul i32 %LoadInst11, 1000
  store i32 %6, i32* %idx
  %preidx = alloca i32
  %LoadInst12 = load i32, i32* %course
  %7 = mul i32 %LoadInst12, 1000
  store i32 %7, i32* %preidx
  br label %cond13

afterLoop5:                                       ; preds = %cond3
  %LoadInst117 = load float, float* %total_gpa
  %LoadInst118 = load i32, i32* %try_credit
  %tmptypecast119 = sitofp i32 %LoadInst118 to float
  %8 = fdiv float %LoadInst117, %tmptypecast119
  %tmpdouble = fpext float %8 to double
  %printf120 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @_Const_String_.3, i32 0, i32 0), double %tmpdouble)
  %LoadInst121 = load i32, i32* %try_credit
  %printf122 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @_Const_String_.4, i32 0, i32 0), i32 %LoadInst121)
  %LoadInst123 = load i32, i32* %pass_credit
  %printf124 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @_Const_String_.5, i32 0, i32 0), i32 %LoadInst123)
  store i32 0, i32* %0
  br label %return

cond13:                                           ; preds = %loop14, %loop4
  %LoadInst16 = load i32, i32* %idx
  %tmparray17 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @course_info, i32 0, i32 %LoadInst16
  %tmpvar18 = load i8, i8* %tmparray17
  %icmptmp19 = icmp ne i8 %tmpvar18, 124
  %whileCond20 = icmp ne i1 %icmptmp19, false
  br i1 %whileCond20, label %loop14, label %afterLoop15

loop14:                                           ; preds = %cond13
  %LoadInst21 = load i32, i32* %idx
  %9 = add i32 %LoadInst21, 1
  store i32 %9, i32* %idx
  br label %cond13

afterLoop15:                                      ; preds = %cond13
  %LoadInst22 = load i32, i32* %idx
  %10 = add i32 %LoadInst22, 1
  store i32 %10, i32* %idx
  %credit = alloca i32
  %LoadInst23 = load i32, i32* %idx
  %tmparray24 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @course_info, i32 0, i32 %LoadInst23
  %tmpvar25 = load i8, i8* %tmparray24
  %11 = sub i8 %tmpvar25, 48
  %tmptypecast = zext i8 %11 to i32
  store i32 %tmptypecast, i32* %credit
  %LoadInst26 = load i32, i32* %total_credit
  %LoadInst27 = load i32, i32* %credit
  %12 = add i32 %LoadInst26, %LoadInst27
  store i32 %12, i32* %total_credit
  %LoadInst28 = load i32, i32* %idx
  %13 = add i32 %LoadInst28, 1
  store i32 %13, i32* %idx
  %LoadInst29 = load i32, i32* %idx
  %14 = add i32 %LoadInst29, 1
  store i32 %14, i32* %idx
  br label %cond30

cond30:                                           ; preds = %loop31, %afterLoop15
  %LoadInst33 = load i32, i32* %idx
  %tmparray34 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @course_info, i32 0, i32 %LoadInst33
  %tmpvar35 = load i8, i8* %tmparray34
  %icmptmp36 = icmp ne i8 %tmpvar35, 124
  %whileCond37 = icmp ne i1 %icmptmp36, false
  br i1 %whileCond37, label %loop31, label %afterLoop32

loop31:                                           ; preds = %cond30
  %LoadInst38 = load i32, i32* %preidx
  %tmpvar39 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @pre_course, i32 0, i32 %LoadInst38
  %LoadInst40 = load i32, i32* %idx
  %tmparray41 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @course_info, i32 0, i32 %LoadInst40
  %tmpvar42 = load i8, i8* %tmparray41
  store i8 %tmpvar42, i8* %tmpvar39
  %LoadInst43 = load i32, i32* %preidx
  %15 = add i32 %LoadInst43, 1
  store i32 %15, i32* %preidx
  %LoadInst44 = load i32, i32* %idx
  %16 = add i32 %LoadInst44, 1
  store i32 %16, i32* %idx
  br label %cond30

afterLoop32:                                      ; preds = %cond30
  %LoadInst45 = load i32, i32* %preidx
  %tmpvar46 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @pre_course, i32 0, i32 %LoadInst45
  store i8 0, i8* %tmpvar46
  %LoadInst47 = load i32, i32* %course
  %17 = mul i32 %LoadInst47, 1000
  %elePtr48 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @pre_course, i32 0, i32 %17
  %printf49 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_Const_String_.2, i32 0, i32 0), i8* %elePtr48)
  %grade = alloca i8
  %LoadInst50 = load i32, i32* %idx
  %18 = add i32 %LoadInst50, 1
  %tmparray51 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @course_info, i32 0, i32 %18
  %tmpvar52 = load i8, i8* %tmparray51
  store i8 %tmpvar52, i8* %grade
  %LoadInst55 = load i8, i8* %grade
  %icmptmp56 = icmp eq i8 %LoadInst55, 65
  %ifCond57 = icmp ne i1 %icmptmp56, false
  br i1 %ifCond57, label %if53, label %afterifonly54

if53:                                             ; preds = %afterLoop32
  %LoadInst58 = load float, float* %total_gpa
  %LoadInst59 = load i32, i32* %credit
  %19 = mul i32 %LoadInst59, 4
  %tmptypecast60 = sitofp i32 %19 to float
  %20 = fadd float %LoadInst58, %tmptypecast60
  store float %20, float* %total_gpa
  %LoadInst61 = load i32, i32* %try_credit
  %LoadInst62 = load i32, i32* %credit
  %21 = add i32 %LoadInst61, %LoadInst62
  store i32 %21, i32* %try_credit
  %LoadInst63 = load i32, i32* %pass_credit
  %LoadInst64 = load i32, i32* %credit
  %22 = add i32 %LoadInst63, %LoadInst64
  store i32 %22, i32* %pass_credit
  %LoadInst65 = load i32, i32* %course
  %tmpvar66 = getelementptr inbounds [11100 x i32], [11100 x i32]* @pass_course, i32 0, i32 %LoadInst65
  store i32 1, i32* %tmpvar66
  br label %afterifonly54

afterifonly54:                                    ; preds = %if53, %afterLoop32
  %LoadInst69 = load i8, i8* %grade
  %icmptmp70 = icmp eq i8 %LoadInst69, 66
  %ifCond71 = icmp ne i1 %icmptmp70, false
  br i1 %ifCond71, label %if67, label %afterifonly68

if67:                                             ; preds = %afterifonly54
  %LoadInst72 = load float, float* %total_gpa
  %LoadInst73 = load i32, i32* %credit
  %23 = mul i32 %LoadInst73, 3
  %tmptypecast74 = sitofp i32 %23 to float
  %24 = fadd float %LoadInst72, %tmptypecast74
  store float %24, float* %total_gpa
  %LoadInst75 = load i32, i32* %try_credit
  %LoadInst76 = load i32, i32* %credit
  %25 = add i32 %LoadInst75, %LoadInst76
  store i32 %25, i32* %try_credit
  %LoadInst77 = load i32, i32* %pass_credit
  %LoadInst78 = load i32, i32* %credit
  %26 = add i32 %LoadInst77, %LoadInst78
  store i32 %26, i32* %pass_credit
  %LoadInst79 = load i32, i32* %course
  %tmpvar80 = getelementptr inbounds [11100 x i32], [11100 x i32]* @pass_course, i32 0, i32 %LoadInst79
  store i32 1, i32* %tmpvar80
  br label %afterifonly68

afterifonly68:                                    ; preds = %if67, %afterifonly54
  %LoadInst83 = load i8, i8* %grade
  %icmptmp84 = icmp eq i8 %LoadInst83, 67
  %ifCond85 = icmp ne i1 %icmptmp84, false
  br i1 %ifCond85, label %if81, label %afterifonly82

if81:                                             ; preds = %afterifonly68
  %LoadInst86 = load float, float* %total_gpa
  %LoadInst87 = load i32, i32* %credit
  %27 = mul i32 %LoadInst87, 2
  %tmptypecast88 = sitofp i32 %27 to float
  %28 = fadd float %LoadInst86, %tmptypecast88
  store float %28, float* %total_gpa
  %LoadInst89 = load i32, i32* %try_credit
  %LoadInst90 = load i32, i32* %credit
  %29 = add i32 %LoadInst89, %LoadInst90
  store i32 %29, i32* %try_credit
  %LoadInst91 = load i32, i32* %pass_credit
  %LoadInst92 = load i32, i32* %credit
  %30 = add i32 %LoadInst91, %LoadInst92
  store i32 %30, i32* %pass_credit
  %LoadInst93 = load i32, i32* %course
  %tmpvar94 = getelementptr inbounds [11100 x i32], [11100 x i32]* @pass_course, i32 0, i32 %LoadInst93
  store i32 1, i32* %tmpvar94
  br label %afterifonly82

afterifonly82:                                    ; preds = %if81, %afterifonly68
  %LoadInst97 = load i8, i8* %grade
  %icmptmp98 = icmp eq i8 %LoadInst97, 68
  %ifCond99 = icmp ne i1 %icmptmp98, false
  br i1 %ifCond99, label %if95, label %afterifonly96

if95:                                             ; preds = %afterifonly82
  %LoadInst100 = load float, float* %total_gpa
  %LoadInst101 = load i32, i32* %credit
  %tmptypecast102 = sitofp i32 %LoadInst101 to float
  %31 = fadd float %LoadInst100, %tmptypecast102
  store float %31, float* %total_gpa
  %LoadInst103 = load i32, i32* %try_credit
  %LoadInst104 = load i32, i32* %credit
  %32 = add i32 %LoadInst103, %LoadInst104
  store i32 %32, i32* %try_credit
  %LoadInst105 = load i32, i32* %pass_credit
  %LoadInst106 = load i32, i32* %credit
  %33 = add i32 %LoadInst105, %LoadInst106
  store i32 %33, i32* %pass_credit
  %LoadInst107 = load i32, i32* %course
  %tmpvar108 = getelementptr inbounds [11100 x i32], [11100 x i32]* @pass_course, i32 0, i32 %LoadInst107
  store i32 1, i32* %tmpvar108
  br label %afterifonly96

afterifonly96:                                    ; preds = %if95, %afterifonly82
  %LoadInst111 = load i8, i8* %grade
  %icmptmp112 = icmp eq i8 %LoadInst111, 70
  %ifCond113 = icmp ne i1 %icmptmp112, false
  br i1 %ifCond113, label %if109, label %afterifonly110

if109:                                            ; preds = %afterifonly96
  %LoadInst114 = load i32, i32* %try_credit
  %LoadInst115 = load i32, i32* %credit
  %34 = add i32 %LoadInst114, %LoadInst115
  store i32 %34, i32* %try_credit
  br label %afterifonly110

afterifonly110:                                   ; preds = %if109, %afterifonly96
  %LoadInst116 = load i32, i32* %course
  %35 = add i32 %LoadInst116, 1
  store i32 %35, i32* %course
  br label %cond3
}