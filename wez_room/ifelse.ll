; ModuleID = 'main'
source_filename = "main"

@_Const_String_ = private constant [7 x i8] c"i: %d\0A\00"
@_Const_String_.1 = private constant [12 x i8] c"if: j : %d\0A\00"
@_Const_String_.2 = private constant [14 x i8] c"else: j : %d\0A\00"
@_Const_String_.3 = private constant [7 x i8] c"i: %d\0A\00"

declare i32 @printf(i8*, ...)

declare i32 @scanf(...)

define i32 @main() {
entry:
  %i = alloca i32
  store i32 10, i32* %i
  %LoadInst = load i32, i32* %i
  %icmptmp = icmp sgt i32 %LoadInst, 9
  %ifCond = icmp ne i1 %icmptmp, false
  br i1 %ifCond, label %if, label %else

if:                                               ; preds = %entry
  %LoadInst1 = load i32, i32* %i
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @_Const_String_, i32 0, i32 0), i32 %LoadInst1)
  br label %afterifelse

else:                                             ; preds = %entry
  br label %afterifelse

afterifelse:                                      ; preds = %else, %if
  %LoadInst5 = load i32, i32* %i
  %icmptmp6 = icmp slt i32 %LoadInst5, 8
  %ifCond7 = icmp ne i1 %icmptmp6, false
  br i1 %ifCond7, label %if2, label %else3

if2:                                              ; preds = %afterifelse
  %j = alloca i32
  store i32 10, i32* %j
  %LoadInst8 = load i32, i32* %j
  %printf9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @_Const_String_.1, i32 0, i32 0), i32 %LoadInst8)
  br label %afterifelse4

else3:                                            ; preds = %afterifelse
  %j10 = alloca i32
  store i32 12, i32* %j10
  %LoadInst11 = load i32, i32* %j10
  %printf12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @_Const_String_.2, i32 0, i32 0), i32 %LoadInst11)
  br label %afterifelse4

afterifelse4:                                     ; preds = %else3, %if2
  %LoadInst16 = load i32, i32* %i
  %icmptmp17 = icmp slt i32 %LoadInst16, 20
  %ifCond18 = icmp ne i1 %icmptmp17, false
  br i1 %ifCond18, label %if13, label %else14

if13:                                             ; preds = %afterifelse4
  %LoadInst19 = load i32, i32* %i
  %printf20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @_Const_String_.3, i32 0, i32 0), i32 %LoadInst19)
  br label %afterifelse15

else14:                                           ; preds = %afterifelse4
  br label %afterifelse15

afterifelse15:                                    ; preds = %else14, %if13
  ret i32 0
}