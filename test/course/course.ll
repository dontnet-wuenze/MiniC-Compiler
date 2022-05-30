; ModuleID = 'main'
source_filename = "main"

@course_info = private global [1000000 x i8] zeroinitializer
@pre_course = private global [1000000 x i8] zeroinitializer
@pass_course = private global [11100 x i32] zeroinitializer
@course_id = private global [11100 x i32] zeroinitializer
@_Const_String_ = private constant [11 x i8] c"GPA: %.1f\0A\00"
@_Const_String_.1 = private constant [21 x i8] c"Hours Attempted: %d\0A\00"
@_Const_String_.2 = private constant [21 x i8] c"Hours Completed: %d\0A\00"
@_Const_String_.3 = private constant [23 x i8] c"Credits Remaining: %d\0A\00"
@_Const_String_.4 = private constant [2 x i8] c"\0A\00"
@_Const_String_.5 = private constant [31 x i8] c"Possible Courses to Take Next\0A\00"
@_Const_String_.6 = private constant [27 x i8] c"  None - Congratulations!\0A\00"
@_Const_String_.7 = private constant [3 x i8] c"  \00"
@_Const_String_.8 = private constant [3 x i8] c"%c\00"
@_Const_String_.9 = private constant [2 x i8] c"\0A\00"

declare i32 @printf(i8*, ...)

declare i32 @scanf(...)

declare i32 @gets(...)

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

return:                                           ; preds = %afterLoop163, %if155
  %1 = load i32, i32* %0
  ret i32 %1

cond:                                             ; preds = %afterifonly, %entry
  br i1 true, label %loop, label %afterLoop

loop:                                             ; preds = %cond
  %LoadInst = load i32, i32* %course_num
  %2 = mul i32 %LoadInst, 1000
  %elePtr = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @course_info, i32 0, i32 %2
  %gets = call i32 (...) @gets(i8* %elePtr)
  %LoadInst1 = load i32, i32* %course_num
  %3 = mul i32 %LoadInst1, 1000
  %tmparray = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @course_info, i32 0, i32 %3
  %tmpvar = load i8, i8* %tmparray
  %icmptmp = icmp eq i8 %tmpvar, 0
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
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @_Const_String_, i32 0, i32 0), double %tmpdouble)
  %LoadInst145 = load i32, i32* %try_credit
  %printf146 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @_Const_String_.1, i32 0, i32 0), i32 %LoadInst145)
  %LoadInst147 = load i32, i32* %pass_credit
  %printf148 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @_Const_String_.2, i32 0, i32 0), i32 %LoadInst147)
  %course_remain = alloca i32
  %LoadInst149 = load i32, i32* %total_credit
  %LoadInst150 = load i32, i32* %pass_credit
  %37 = sub i32 %LoadInst149, %LoadInst150
  store i32 %37, i32* %course_remain
  %LoadInst151 = load i32, i32* %course_remain
  %printf152 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @_Const_String_.3, i32 0, i32 0), i32 %LoadInst151)
  %printf153 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @_Const_String_.4, i32 0, i32 0))
  %printf154 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @_Const_String_.5, i32 0, i32 0))
  %LoadInst157 = load i32, i32* %course_remain
  %icmptmp158 = icmp eq i32 %LoadInst157, 0
  %ifCond159 = icmp ne i1 %icmptmp158, false
  br i1 %ifCond159, label %if155, label %afterifonly156

if155:                                            ; preds = %afterifonly137
  %printf160 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @_Const_String_.6, i32 0, i32 0))
  store i32 0, i32* %0
  br label %return

afterifonly156:                                   ; preds = %afterifonly137
  store i32 0, i32* %course
  br label %cond161

cond161:                                          ; preds = %afterifonly169, %afterifonly156
  %LoadInst164 = load i32, i32* %course
  %LoadInst165 = load i32, i32* %course_num
  %icmptmp166 = icmp slt i32 %LoadInst164, %LoadInst165
  %whileCond167 = icmp ne i1 %icmptmp166, false
  br i1 %whileCond167, label %loop162, label %afterLoop163

loop162:                                          ; preds = %cond161
  %LoadInst170 = load i32, i32* %course
  %tmparray171 = getelementptr inbounds [11100 x i32], [11100 x i32]* @course_id, i32 0, i32 %LoadInst170
  %tmpvar172 = load i32, i32* %tmparray171
  %tmparray173 = getelementptr inbounds [11100 x i32], [11100 x i32]* @pass_course, i32 0, i32 %tmpvar172
  %tmpvar174 = load i32, i32* %tmparray173
  %icmptmp175 = icmp eq i32 %tmpvar174, 0
  %ifCond176 = icmp ne i1 %icmptmp175, false
  br i1 %ifCond176, label %if168, label %afterifonly169

afterLoop163:                                     ; preds = %cond161
  store i32 0, i32* %0
  br label %return

if168:                                            ; preds = %loop162
  %can = alloca i32
  store i32 0, i32* %can
  %LoadInst178 = load i32, i32* %course
  %38 = mul i32 %LoadInst178, 1000
  %tmparray179 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @pre_course, i32 0, i32 %38
  %tmpvar180 = load i8, i8* %tmparray179
  %icmptmp181 = icmp eq i8 %tmpvar180, 0
  %ifCond182 = icmp ne i1 %icmptmp181, false
  br i1 %ifCond182, label %if177, label %else

afterifonly169:                                   ; preds = %afterifonly256, %loop162
  %LoadInst276 = load i32, i32* %course
  %39 = add i32 %LoadInst276, 1
  store i32 %39, i32* %course
  br label %cond161

if177:                                            ; preds = %if168
  store i32 1, i32* %can
  br label %afterifelse

else:                                             ; preds = %if168
  %cid = alloca i32
  store i32 0, i32* %cid
  %flag = alloca i32
  store i32 1, i32* %flag
  %preidx183 = alloca i32
  %LoadInst184 = load i32, i32* %course
  %40 = mul i32 %LoadInst184, 1000
  store i32 %40, i32* %preidx183
  br label %cond185

afterifelse:                                      ; preds = %afterLoop187, %if177
  %LoadInst257 = load i32, i32* %can
  %icmptmp258 = icmp eq i32 %LoadInst257, 1
  %ifCond259 = icmp ne i1 %icmptmp258, false
  br i1 %ifCond259, label %if255, label %afterifonly256

cond185:                                          ; preds = %afterifonly243, %else
  br i1 true, label %loop186, label %afterLoop187

loop186:                                          ; preds = %cond185
  %LoadInst190 = load i32, i32* %preidx183
  %tmparray191 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @pre_course, i32 0, i32 %LoadInst190
  %tmpvar192 = load i8, i8* %tmparray191
  %icmptmp193 = icmp eq i8 %tmpvar192, 0
  %ifCond194 = icmp ne i1 %icmptmp193, false
  br i1 %ifCond194, label %if188, label %afterifonly189

afterLoop187:                                     ; preds = %afterifonly203, %cond185
  br label %afterifelse

if188:                                            ; preds = %loop186
  %LoadInst197 = load i32, i32* %cid
  %tmparray198 = getelementptr inbounds [11100 x i32], [11100 x i32]* @pass_course, i32 0, i32 %LoadInst197
  %tmpvar199 = load i32, i32* %tmparray198
  %icmptmp200 = icmp eq i32 %tmpvar199, 0
  %ifCond201 = icmp ne i1 %icmptmp200, false
  br i1 %ifCond201, label %if195, label %afterifonly196

afterifonly189:                                   ; preds = %loop186
  %LoadInst209 = load i32, i32* %preidx183
  %tmparray210 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @pre_course, i32 0, i32 %LoadInst209
  %tmpvar211 = load i8, i8* %tmparray210
  %icmptmp212 = icmp eq i8 %tmpvar211, 59
  %ifCond213 = icmp ne i1 %icmptmp212, false
  br i1 %ifCond213, label %if207, label %afterifonly208

if195:                                            ; preds = %if188
  store i32 0, i32* %flag
  br label %afterifonly196

afterifonly196:                                   ; preds = %if195, %if188
  %LoadInst204 = load i32, i32* %flag
  %icmptmp205 = icmp eq i32 %LoadInst204, 1
  %ifCond206 = icmp ne i1 %icmptmp205, false
  br i1 %ifCond206, label %if202, label %afterifonly203

if202:                                            ; preds = %afterifonly196
  store i32 1, i32* %can
  br label %afterifonly203

afterifonly203:                                   ; preds = %if202, %afterifonly196
  br label %afterLoop187

if207:                                            ; preds = %afterifonly189
  %LoadInst216 = load i32, i32* %cid
  %tmparray217 = getelementptr inbounds [11100 x i32], [11100 x i32]* @pass_course, i32 0, i32 %LoadInst216
  %tmpvar218 = load i32, i32* %tmparray217
  %icmptmp219 = icmp eq i32 %tmpvar218, 0
  %ifCond220 = icmp ne i1 %icmptmp219, false
  br i1 %ifCond220, label %if214, label %afterifonly215

afterifonly208:                                   ; preds = %afterifonly222, %afterifonly189
  %LoadInst229 = load i32, i32* %preidx183
  %tmparray230 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @pre_course, i32 0, i32 %LoadInst229
  %tmpvar231 = load i8, i8* %tmparray230
  %icmptmp232 = icmp eq i8 %tmpvar231, 44
  %ifCond233 = icmp ne i1 %icmptmp232, false
  br i1 %ifCond233, label %if227, label %afterifonly228

if214:                                            ; preds = %if207
  store i32 0, i32* %flag
  br label %afterifonly215

afterifonly215:                                   ; preds = %if214, %if207
  %LoadInst223 = load i32, i32* %flag
  %icmptmp224 = icmp eq i32 %LoadInst223, 1
  %ifCond225 = icmp ne i1 %icmptmp224, false
  br i1 %ifCond225, label %if221, label %afterifonly222

if221:                                            ; preds = %afterifonly215
  store i32 1, i32* %can
  br label %afterifonly222

afterifonly222:                                   ; preds = %if221, %afterifonly215
  store i32 0, i32* %cid
  store i32 1, i32* %flag
  %LoadInst226 = load i32, i32* %preidx183
  %41 = add i32 %LoadInst226, 1
  store i32 %41, i32* %preidx183
  br label %afterifonly208

if227:                                            ; preds = %afterifonly208
  %LoadInst236 = load i32, i32* %cid
  %tmparray237 = getelementptr inbounds [11100 x i32], [11100 x i32]* @pass_course, i32 0, i32 %LoadInst236
  %tmpvar238 = load i32, i32* %tmparray237
  %icmptmp239 = icmp eq i32 %tmpvar238, 0
  %ifCond240 = icmp ne i1 %icmptmp239, false
  br i1 %ifCond240, label %if234, label %afterifonly235

afterifonly228:                                   ; preds = %afterifonly235, %afterifonly208
  %LoadInst244 = load i32, i32* %preidx183
  %tmparray245 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @pre_course, i32 0, i32 %LoadInst244
  %tmpvar246 = load i8, i8* %tmparray245
  %icmptmp247 = icmp ne i8 %tmpvar246, 99
  %ifCond248 = icmp ne i1 %icmptmp247, false
  br i1 %ifCond248, label %if242, label %afterifonly243

if234:                                            ; preds = %if227
  store i32 0, i32* %flag
  br label %afterifonly235

afterifonly235:                                   ; preds = %if234, %if227
  store i32 0, i32* %cid
  %LoadInst241 = load i32, i32* %preidx183
  %42 = add i32 %LoadInst241, 1
  store i32 %42, i32* %preidx183
  br label %afterifonly228

if242:                                            ; preds = %afterifonly228
  %LoadInst249 = load i32, i32* %cid
  %43 = mul i32 %LoadInst249, 10
  %LoadInst250 = load i32, i32* %preidx183
  %tmparray251 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @pre_course, i32 0, i32 %LoadInst250
  %tmpvar252 = load i8, i8* %tmparray251
  %tmptypecast253 = zext i8 %tmpvar252 to i32
  %44 = add i32 %43, %tmptypecast253
  %45 = sub i32 %44, 48
  store i32 %45, i32* %cid
  br label %afterifonly243

afterifonly243:                                   ; preds = %if242, %afterifonly228
  %LoadInst254 = load i32, i32* %preidx183
  %46 = add i32 %LoadInst254, 1
  store i32 %46, i32* %preidx183
  br label %cond185

if255:                                            ; preds = %afterifelse
  %printf260 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @_Const_String_.7, i32 0, i32 0))
  %course_idx = alloca i32
  %LoadInst261 = load i32, i32* %course
  %47 = mul i32 %LoadInst261, 1000
  store i32 %47, i32* %course_idx
  br label %cond262

afterifonly256:                                   ; preds = %afterLoop264, %afterifelse
  br label %afterifonly169

cond262:                                          ; preds = %loop263, %if255
  %LoadInst265 = load i32, i32* %course_idx
  %tmparray266 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @course_info, i32 0, i32 %LoadInst265
  %tmpvar267 = load i8, i8* %tmparray266
  %icmptmp268 = icmp ne i8 %tmpvar267, 124
  %whileCond269 = icmp ne i1 %icmptmp268, false
  br i1 %whileCond269, label %loop263, label %afterLoop264

loop263:                                          ; preds = %cond262
  %LoadInst270 = load i32, i32* %course_idx
  %tmparray271 = getelementptr inbounds [1000000 x i8], [1000000 x i8]* @course_info, i32 0, i32 %LoadInst270
  %tmpvar272 = load i8, i8* %tmparray271
  %printf273 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @_Const_String_.8, i32 0, i32 0), i8 %tmpvar272)
  %LoadInst274 = load i32, i32* %course_idx
  %48 = add i32 %LoadInst274, 1
  store i32 %48, i32* %course_idx
  br label %cond262

afterLoop264:                                     ; preds = %cond262
  %printf275 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @_Const_String_.9, i32 0, i32 0))
  br label %afterifonly256
}