; ModuleID = 'main'
source_filename = "main"

@course_info = private global [1000000 x i8] zeroinitializer
@pre_course = private global [1000000 x i8] zeroinitializer
@pass_course = private global [11100 x i32] zeroinitializer
@course_id = private global [11100 x i32] zeroinitializer
@_Const_String_ = private constant [3 x i8] c"%s\00"
@_Const_String_.1 = private constant [11 x i8] c"GPA: %.1f\0A\00"
@_Const_String_.2 = private constant [21 x i8] c"Hours Attempted: %d\0A\00"
@_Const_String_.3 = private constant [21 x i8] c"Hours Completed: %d\0A\00"
@_Const_String_.4 = private constant [23 x i8] c"Credits Remaining: %d\0A\00"
@_Const_String_.5 = private constant [31 x i8] c"Possible Courses to Take Next\0A\00"
@_Const_String_.6 = private constant [27 x i8] c"  None - Congratulations!\0A\00"
@_Const_String_.7 = private constant [3 x i8] c"  \00"
@_Const_String_.8 = private constant [3 x i8] c"%c\00"
@_Const_String_.9 = private constant [2 x i8] c"\0A\00"

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

return:                                           ; preds = %afterLoop162, %if154
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

cond3:                                            ; preds = %afterifonly129, %afterLoop
  %LoadInst6 = load i32, i32* %course
  %LoadInst7 = load i32, i32* %course_num
  %icmptmp8 = icmp slt i32 %LoadInst6, %LoadInst7
  %whileCond = icmp ne i1 %icmptmp8, false
  br i1 %whileCond, label %loop4, label %afterLoop5

loop4:                                            ; preds = %cond3
  %idx = alloca i32
  %LoadInst9 = load i32, i32* %course
  %5 = mul i32 %LoadInst9, 1000
  store i32 %5, i32* %idx
  %preidx = alloca i32
  %LoadInst10 = load i32, i32* %course
  %6 = mul i32 %LoadInst10, 1000
  store i32 %6, i32* %preidx
  br label %cond11

afterLoop5:                                       ; preds = %cond3
  %LoadInst138 = load i32, i32* %try_credit
  %icmptmp139 = icmp ne i32 %LoadInst138, 0
  %ifCond140 = icmp ne i1 %icmptmp139, false
  br i1 %ifCond140, label %if136, label %afterifonly137

cond11:                                           ; preds = %afterifonly20, %loop4
  %LoadInst14 = load i32, i32* %idx
  %tmparray15 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @course_info, i32 0, i32 %LoadInst14
  %tmpvar16 = load i8, i8* %tmparray15
  %icmptmp17 = icmp ne i8 %tmpvar16, 124
  %whileCond18 = icmp ne i1 %icmptmp17, false
  br i1 %whileCond18, label %loop12, label %afterLoop13

loop12:                                           ; preds = %cond11
  %LoadInst21 = load i32, i32* %idx
  %tmparray22 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @course_info, i32 0, i32 %LoadInst21
  %tmpvar23 = load i8, i8* %tmparray22
  %icmptmp24 = icmp ne i8 %tmpvar23, 99
  %ifCond25 = icmp ne i1 %icmptmp24, false
  br i1 %ifCond25, label %if19, label %afterifonly20

afterLoop13:                                      ; preds = %cond11
  %LoadInst35 = load i32, i32* %idx
  %7 = add i32 %LoadInst35, 1
  store i32 %7, i32* %idx
  %credit = alloca i32
  %LoadInst36 = load i32, i32* %idx
  %tmparray37 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @course_info, i32 0, i32 %LoadInst36
  %tmpvar38 = load i8, i8* %tmparray37
  %8 = sub i8 %tmpvar38, 48
  %tmptypecast39 = zext i8 %8 to i32
  store i32 %tmptypecast39, i32* %credit
  %LoadInst40 = load i32, i32* %total_credit
  %LoadInst41 = load i32, i32* %credit
  %9 = add i32 %LoadInst40, %LoadInst41
  store i32 %9, i32* %total_credit
  %LoadInst42 = load i32, i32* %idx
  %10 = add i32 %LoadInst42, 1
  store i32 %10, i32* %idx
  %LoadInst43 = load i32, i32* %idx
  %11 = add i32 %LoadInst43, 1
  store i32 %11, i32* %idx
  br label %cond44

if19:                                             ; preds = %loop12
  %LoadInst26 = load i32, i32* %course
  %tmpvar27 = getelementptr inbounds [11100 x i32], [11100 x i32]* @course_id, i32 0, i32 %LoadInst26
  %LoadInst28 = load i32, i32* %course
  %tmparray29 = getelementptr inbounds [11100 x i32], [11100 x i32]* @course_id, i32 0, i32 %LoadInst28
  %tmpvar30 = load i32, i32* %tmparray29
  %12 = mul i32 %tmpvar30, 10
  %LoadInst31 = load i32, i32* %idx
  %tmparray32 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @course_info, i32 0, i32 %LoadInst31
  %tmpvar33 = load i8, i8* %tmparray32
  %tmptypecast = zext i8 %tmpvar33 to i32
  %13 = add i32 %12, %tmptypecast
  %14 = sub i32 %13, 48
  store i32 %14, i32* %tmpvar27
  br label %afterifonly20

afterifonly20:                                    ; preds = %if19, %loop12
  %LoadInst34 = load i32, i32* %idx
  %15 = add i32 %LoadInst34, 1
  store i32 %15, i32* %idx
  br label %cond11

cond44:                                           ; preds = %loop45, %afterLoop13
  %LoadInst47 = load i32, i32* %idx
  %tmparray48 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @course_info, i32 0, i32 %LoadInst47
  %tmpvar49 = load i8, i8* %tmparray48
  %icmptmp50 = icmp ne i8 %tmpvar49, 124
  %whileCond51 = icmp ne i1 %icmptmp50, false
  br i1 %whileCond51, label %loop45, label %afterLoop46

loop45:                                           ; preds = %cond44
  %LoadInst52 = load i32, i32* %preidx
  %tmpvar53 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @pre_course, i32 0, i32 %LoadInst52
  %LoadInst54 = load i32, i32* %idx
  %tmparray55 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @course_info, i32 0, i32 %LoadInst54
  %tmpvar56 = load i8, i8* %tmparray55
  store i8 %tmpvar56, i8* %tmpvar53
  %LoadInst57 = load i32, i32* %preidx
  %16 = add i32 %LoadInst57, 1
  store i32 %16, i32* %preidx
  %LoadInst58 = load i32, i32* %idx
  %17 = add i32 %LoadInst58, 1
  store i32 %17, i32* %idx
  br label %cond44

afterLoop46:                                      ; preds = %cond44
  %LoadInst59 = load i32, i32* %preidx
  %tmpvar60 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @pre_course, i32 0, i32 %LoadInst59
  store i8 0, i8* %tmpvar60
  %grade = alloca i8
  %LoadInst61 = load i32, i32* %idx
  %18 = add i32 %LoadInst61, 1
  %tmparray62 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @course_info, i32 0, i32 %18
  %tmpvar63 = load i8, i8* %tmparray62
  store i8 %tmpvar63, i8* %grade
  %LoadInst66 = load i8, i8* %grade
  %icmptmp67 = icmp eq i8 %LoadInst66, 65
  %ifCond68 = icmp ne i1 %icmptmp67, false
  br i1 %ifCond68, label %if64, label %afterifonly65

if64:                                             ; preds = %afterLoop46
  %LoadInst69 = load float, float* %total_gpa
  %LoadInst70 = load i32, i32* %credit
  %19 = mul i32 %LoadInst70, 4
  %tmptypecast71 = sitofp i32 %19 to float
  %20 = fadd float %LoadInst69, %tmptypecast71
  store float %20, float* %total_gpa
  %LoadInst72 = load i32, i32* %try_credit
  %LoadInst73 = load i32, i32* %credit
  %21 = add i32 %LoadInst72, %LoadInst73
  store i32 %21, i32* %try_credit
  %LoadInst74 = load i32, i32* %pass_credit
  %LoadInst75 = load i32, i32* %credit
  %22 = add i32 %LoadInst74, %LoadInst75
  store i32 %22, i32* %pass_credit
  %LoadInst76 = load i32, i32* %course
  %tmparray77 = getelementptr inbounds [11100 x i32], [11100 x i32]* @course_id, i32 0, i32 %LoadInst76
  %tmpvar78 = load i32, i32* %tmparray77
  %tmpvar79 = getelementptr inbounds [11100 x i32], [11100 x i32]* @pass_course, i32 0, i32 %tmpvar78
  store i32 1, i32* %tmpvar79
  br label %afterifonly65

afterifonly65:                                    ; preds = %if64, %afterLoop46
  %LoadInst82 = load i8, i8* %grade
  %icmptmp83 = icmp eq i8 %LoadInst82, 66
  %ifCond84 = icmp ne i1 %icmptmp83, false
  br i1 %ifCond84, label %if80, label %afterifonly81

if80:                                             ; preds = %afterifonly65
  %LoadInst85 = load float, float* %total_gpa
  %LoadInst86 = load i32, i32* %credit
  %23 = mul i32 %LoadInst86, 3
  %tmptypecast87 = sitofp i32 %23 to float
  %24 = fadd float %LoadInst85, %tmptypecast87
  store float %24, float* %total_gpa
  %LoadInst88 = load i32, i32* %try_credit
  %LoadInst89 = load i32, i32* %credit
  %25 = add i32 %LoadInst88, %LoadInst89
  store i32 %25, i32* %try_credit
  %LoadInst90 = load i32, i32* %pass_credit
  %LoadInst91 = load i32, i32* %credit
  %26 = add i32 %LoadInst90, %LoadInst91
  store i32 %26, i32* %pass_credit
  %LoadInst92 = load i32, i32* %course
  %tmparray93 = getelementptr inbounds [11100 x i32], [11100 x i32]* @course_id, i32 0, i32 %LoadInst92
  %tmpvar94 = load i32, i32* %tmparray93
  %tmpvar95 = getelementptr inbounds [11100 x i32], [11100 x i32]* @pass_course, i32 0, i32 %tmpvar94
  store i32 1, i32* %tmpvar95
  br label %afterifonly81

afterifonly81:                                    ; preds = %if80, %afterifonly65
  %LoadInst98 = load i8, i8* %grade
  %icmptmp99 = icmp eq i8 %LoadInst98, 67
  %ifCond100 = icmp ne i1 %icmptmp99, false
  br i1 %ifCond100, label %if96, label %afterifonly97

if96:                                             ; preds = %afterifonly81
  %LoadInst101 = load float, float* %total_gpa
  %LoadInst102 = load i32, i32* %credit
  %27 = mul i32 %LoadInst102, 2
  %tmptypecast103 = sitofp i32 %27 to float
  %28 = fadd float %LoadInst101, %tmptypecast103
  store float %28, float* %total_gpa
  %LoadInst104 = load i32, i32* %try_credit
  %LoadInst105 = load i32, i32* %credit
  %29 = add i32 %LoadInst104, %LoadInst105
  store i32 %29, i32* %try_credit
  %LoadInst106 = load i32, i32* %pass_credit
  %LoadInst107 = load i32, i32* %credit
  %30 = add i32 %LoadInst106, %LoadInst107
  store i32 %30, i32* %pass_credit
  %LoadInst108 = load i32, i32* %course
  %tmparray109 = getelementptr inbounds [11100 x i32], [11100 x i32]* @course_id, i32 0, i32 %LoadInst108
  %tmpvar110 = load i32, i32* %tmparray109
  %tmpvar111 = getelementptr inbounds [11100 x i32], [11100 x i32]* @pass_course, i32 0, i32 %tmpvar110
  store i32 1, i32* %tmpvar111
  br label %afterifonly97

afterifonly97:                                    ; preds = %if96, %afterifonly81
  %LoadInst114 = load i8, i8* %grade
  %icmptmp115 = icmp eq i8 %LoadInst114, 68
  %ifCond116 = icmp ne i1 %icmptmp115, false
  br i1 %ifCond116, label %if112, label %afterifonly113

if112:                                            ; preds = %afterifonly97
  %LoadInst117 = load float, float* %total_gpa
  %LoadInst118 = load i32, i32* %credit
  %tmptypecast119 = sitofp i32 %LoadInst118 to float
  %31 = fadd float %LoadInst117, %tmptypecast119
  store float %31, float* %total_gpa
  %LoadInst120 = load i32, i32* %try_credit
  %LoadInst121 = load i32, i32* %credit
  %32 = add i32 %LoadInst120, %LoadInst121
  store i32 %32, i32* %try_credit
  %LoadInst122 = load i32, i32* %pass_credit
  %LoadInst123 = load i32, i32* %credit
  %33 = add i32 %LoadInst122, %LoadInst123
  store i32 %33, i32* %pass_credit
  %LoadInst124 = load i32, i32* %course
  %tmparray125 = getelementptr inbounds [11100 x i32], [11100 x i32]* @course_id, i32 0, i32 %LoadInst124
  %tmpvar126 = load i32, i32* %tmparray125
  %tmpvar127 = getelementptr inbounds [11100 x i32], [11100 x i32]* @pass_course, i32 0, i32 %tmpvar126
  store i32 1, i32* %tmpvar127
  br label %afterifonly113

afterifonly113:                                   ; preds = %if112, %afterifonly97
  %LoadInst130 = load i8, i8* %grade
  %icmptmp131 = icmp eq i8 %LoadInst130, 70
  %ifCond132 = icmp ne i1 %icmptmp131, false
  br i1 %ifCond132, label %if128, label %afterifonly129

if128:                                            ; preds = %afterifonly113
  %LoadInst133 = load i32, i32* %try_credit
  %LoadInst134 = load i32, i32* %credit
  %34 = add i32 %LoadInst133, %LoadInst134
  store i32 %34, i32* %try_credit
  br label %afterifonly129

afterifonly129:                                   ; preds = %if128, %afterifonly113
  %LoadInst135 = load i32, i32* %course
  %35 = add i32 %LoadInst135, 1
  store i32 %35, i32* %course
  br label %cond3

if136:                                            ; preds = %afterLoop5
  %LoadInst141 = load float, float* %total_gpa
  %LoadInst142 = load i32, i32* %try_credit
  %tmptypecast143 = sitofp i32 %LoadInst142 to float
  %36 = fdiv float %LoadInst141, %tmptypecast143
  store float %36, float* %total_gpa
  br label %afterifonly137

afterifonly137:                                   ; preds = %if136, %afterLoop5
  %LoadInst144 = load float, float* %total_gpa
  %tmpdouble = fpext float %LoadInst144 to double
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @_Const_String_.1, i32 0, i32 0), double %tmpdouble)
  %LoadInst145 = load i32, i32* %try_credit
  %printf146 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @_Const_String_.2, i32 0, i32 0), i32 %LoadInst145)
  %LoadInst147 = load i32, i32* %pass_credit
  %printf148 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @_Const_String_.3, i32 0, i32 0), i32 %LoadInst147)
  %course_remain = alloca i32
  %LoadInst149 = load i32, i32* %total_credit
  %LoadInst150 = load i32, i32* %pass_credit
  %37 = sub i32 %LoadInst149, %LoadInst150
  store i32 %37, i32* %course_remain
  %LoadInst151 = load i32, i32* %course_remain
  %printf152 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @_Const_String_.4, i32 0, i32 0), i32 %LoadInst151)
  %printf153 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @_Const_String_.5, i32 0, i32 0))
  %LoadInst156 = load i32, i32* %course_remain
  %icmptmp157 = icmp eq i32 %LoadInst156, 0
  %ifCond158 = icmp ne i1 %icmptmp157, false
  br i1 %ifCond158, label %if154, label %afterifonly155

if154:                                            ; preds = %afterifonly137
  %printf159 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @_Const_String_.6, i32 0, i32 0))
  store i32 0, i32* %0
  br label %return

afterifonly155:                                   ; preds = %afterifonly137
  store i32 0, i32* %course
  br label %cond160

cond160:                                          ; preds = %afterifonly168, %afterifonly155
  %LoadInst163 = load i32, i32* %course
  %LoadInst164 = load i32, i32* %course_num
  %icmptmp165 = icmp slt i32 %LoadInst163, %LoadInst164
  %whileCond166 = icmp ne i1 %icmptmp165, false
  br i1 %whileCond166, label %loop161, label %afterLoop162

loop161:                                          ; preds = %cond160
  %LoadInst169 = load i32, i32* %course
  %tmparray170 = getelementptr inbounds [11100 x i32], [11100 x i32]* @course_id, i32 0, i32 %LoadInst169
  %tmpvar171 = load i32, i32* %tmparray170
  %tmparray172 = getelementptr inbounds [11100 x i32], [11100 x i32]* @pass_course, i32 0, i32 %tmpvar171
  %tmpvar173 = load i32, i32* %tmparray172
  %icmptmp174 = icmp eq i32 %tmpvar173, 0
  %ifCond175 = icmp ne i1 %icmptmp174, false
  br i1 %ifCond175, label %if167, label %afterifonly168

afterLoop162:                                     ; preds = %cond160
  store i32 0, i32* %0
  br label %return

if167:                                            ; preds = %loop161
  %can = alloca i32
  store i32 0, i32* %can
  %LoadInst177 = load i32, i32* %course
  %38 = mul i32 %LoadInst177, 1000
  %tmparray178 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @pre_course, i32 0, i32 %38
  %tmpvar179 = load i8, i8* %tmparray178
  %icmptmp180 = icmp eq i8 %tmpvar179, 0
  %ifCond181 = icmp ne i1 %icmptmp180, false
  br i1 %ifCond181, label %if176, label %else

afterifonly168:                                   ; preds = %afterifonly255, %loop161
  %LoadInst275 = load i32, i32* %course
  %39 = add i32 %LoadInst275, 1
  store i32 %39, i32* %course
  br label %cond160

if176:                                            ; preds = %if167
  store i32 1, i32* %can
  br label %afterifelse

else:                                             ; preds = %if167
  %cid = alloca i32
  store i32 0, i32* %cid
  %flag = alloca i32
  store i32 1, i32* %flag
  %preidx182 = alloca i32
  %LoadInst183 = load i32, i32* %course
  %40 = mul i32 %LoadInst183, 1000
  store i32 %40, i32* %preidx182
  br label %cond184

afterifelse:                                      ; preds = %afterLoop186, %if176
  %LoadInst256 = load i32, i32* %can
  %icmptmp257 = icmp eq i32 %LoadInst256, 1
  %ifCond258 = icmp ne i1 %icmptmp257, false
  br i1 %ifCond258, label %if254, label %afterifonly255

cond184:                                          ; preds = %afterifonly242, %else
  br i1 true, label %loop185, label %afterLoop186

loop185:                                          ; preds = %cond184
  %LoadInst189 = load i32, i32* %preidx182
  %tmparray190 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @pre_course, i32 0, i32 %LoadInst189
  %tmpvar191 = load i8, i8* %tmparray190
  %icmptmp192 = icmp eq i8 %tmpvar191, 0
  %ifCond193 = icmp ne i1 %icmptmp192, false
  br i1 %ifCond193, label %if187, label %afterifonly188

afterLoop186:                                     ; preds = %afterifonly202, %cond184
  br label %afterifelse

if187:                                            ; preds = %loop185
  %LoadInst196 = load i32, i32* %cid
  %tmparray197 = getelementptr inbounds [11100 x i32], [11100 x i32]* @pass_course, i32 0, i32 %LoadInst196
  %tmpvar198 = load i32, i32* %tmparray197
  %icmptmp199 = icmp eq i32 %tmpvar198, 0
  %ifCond200 = icmp ne i1 %icmptmp199, false
  br i1 %ifCond200, label %if194, label %afterifonly195

afterifonly188:                                   ; preds = %loop185
  %LoadInst208 = load i32, i32* %preidx182
  %tmparray209 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @pre_course, i32 0, i32 %LoadInst208
  %tmpvar210 = load i8, i8* %tmparray209
  %icmptmp211 = icmp eq i8 %tmpvar210, 59
  %ifCond212 = icmp ne i1 %icmptmp211, false
  br i1 %ifCond212, label %if206, label %afterifonly207

if194:                                            ; preds = %if187
  store i32 0, i32* %flag
  br label %afterifonly195

afterifonly195:                                   ; preds = %if194, %if187
  %LoadInst203 = load i32, i32* %flag
  %icmptmp204 = icmp eq i32 %LoadInst203, 1
  %ifCond205 = icmp ne i1 %icmptmp204, false
  br i1 %ifCond205, label %if201, label %afterifonly202

if201:                                            ; preds = %afterifonly195
  store i32 1, i32* %can
  br label %afterifonly202

afterifonly202:                                   ; preds = %if201, %afterifonly195
  br label %afterLoop186

if206:                                            ; preds = %afterifonly188
  %LoadInst215 = load i32, i32* %cid
  %tmparray216 = getelementptr inbounds [11100 x i32], [11100 x i32]* @pass_course, i32 0, i32 %LoadInst215
  %tmpvar217 = load i32, i32* %tmparray216
  %icmptmp218 = icmp eq i32 %tmpvar217, 0
  %ifCond219 = icmp ne i1 %icmptmp218, false
  br i1 %ifCond219, label %if213, label %afterifonly214

afterifonly207:                                   ; preds = %afterifonly221, %afterifonly188
  %LoadInst228 = load i32, i32* %preidx182
  %tmparray229 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @pre_course, i32 0, i32 %LoadInst228
  %tmpvar230 = load i8, i8* %tmparray229
  %icmptmp231 = icmp eq i8 %tmpvar230, 44
  %ifCond232 = icmp ne i1 %icmptmp231, false
  br i1 %ifCond232, label %if226, label %afterifonly227

if213:                                            ; preds = %if206
  store i32 0, i32* %flag
  br label %afterifonly214

afterifonly214:                                   ; preds = %if213, %if206
  %LoadInst222 = load i32, i32* %flag
  %icmptmp223 = icmp eq i32 %LoadInst222, 1
  %ifCond224 = icmp ne i1 %icmptmp223, false
  br i1 %ifCond224, label %if220, label %afterifonly221

if220:                                            ; preds = %afterifonly214
  store i32 1, i32* %can
  br label %afterifonly221

afterifonly221:                                   ; preds = %if220, %afterifonly214
  store i32 0, i32* %cid
  store i32 1, i32* %flag
  %LoadInst225 = load i32, i32* %preidx182
  %41 = add i32 %LoadInst225, 1
  store i32 %41, i32* %preidx182
  br label %afterifonly207

if226:                                            ; preds = %afterifonly207
  %LoadInst235 = load i32, i32* %cid
  %tmparray236 = getelementptr inbounds [11100 x i32], [11100 x i32]* @pass_course, i32 0, i32 %LoadInst235
  %tmpvar237 = load i32, i32* %tmparray236
  %icmptmp238 = icmp eq i32 %tmpvar237, 0
  %ifCond239 = icmp ne i1 %icmptmp238, false
  br i1 %ifCond239, label %if233, label %afterifonly234

afterifonly227:                                   ; preds = %afterifonly234, %afterifonly207
  %LoadInst243 = load i32, i32* %preidx182
  %tmparray244 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @pre_course, i32 0, i32 %LoadInst243
  %tmpvar245 = load i8, i8* %tmparray244
  %icmptmp246 = icmp ne i8 %tmpvar245, 99
  %ifCond247 = icmp ne i1 %icmptmp246, false
  br i1 %ifCond247, label %if241, label %afterifonly242

if233:                                            ; preds = %if226
  store i32 0, i32* %flag
  br label %afterifonly234

afterifonly234:                                   ; preds = %if233, %if226
  store i32 0, i32* %cid
  %LoadInst240 = load i32, i32* %preidx182
  %42 = add i32 %LoadInst240, 1
  store i32 %42, i32* %preidx182
  br label %afterifonly227

if241:                                            ; preds = %afterifonly227
  %LoadInst248 = load i32, i32* %cid
  %43 = mul i32 %LoadInst248, 10
  %LoadInst249 = load i32, i32* %preidx182
  %tmparray250 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @pre_course, i32 0, i32 %LoadInst249
  %tmpvar251 = load i8, i8* %tmparray250
  %tmptypecast252 = zext i8 %tmpvar251 to i32
  %44 = add i32 %43, %tmptypecast252
  %45 = sub i32 %44, 48
  store i32 %45, i32* %cid
  br label %afterifonly242

afterifonly242:                                   ; preds = %if241, %afterifonly227
  %LoadInst253 = load i32, i32* %preidx182
  %46 = add i32 %LoadInst253, 1
  store i32 %46, i32* %preidx182
  br label %cond184

if254:                                            ; preds = %afterifelse
  %printf259 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @_Const_String_.7, i32 0, i32 0))
  %course_idx = alloca i32
  %LoadInst260 = load i32, i32* %course
  %47 = mul i32 %LoadInst260, 1000
  store i32 %47, i32* %course_idx
  br label %cond261

afterifonly255:                                   ; preds = %afterLoop263, %afterifelse
  br label %afterifonly168

cond261:                                          ; preds = %loop262, %if254
  %LoadInst264 = load i32, i32* %course_idx
  %tmparray265 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @course_info, i32 0, i32 %LoadInst264
  %tmpvar266 = load i8, i8* %tmparray265
  %icmptmp267 = icmp ne i8 %tmpvar266, 124
  %whileCond268 = icmp ne i1 %icmptmp267, false
  br i1 %whileCond268, label %loop262, label %afterLoop263

loop262:                                          ; preds = %cond261
  %LoadInst269 = load i32, i32* %course_idx
  %tmparray270 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @course_info, i32 0, i32 %LoadInst269
  %tmpvar271 = load i8, i8* %tmparray270
  %printf272 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @_Const_String_.8, i32 0, i32 0), i8 %tmpvar271)
  %LoadInst273 = load i32, i32* %course_idx
  %48 = add i32 %LoadInst273, 1
  store i32 %48, i32* %course_idx
  br label %cond261

afterLoop263:                                     ; preds = %cond261
  %printf274 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @_Const_String_.9, i32 0, i32 0))
  br label %afterifonly255
}