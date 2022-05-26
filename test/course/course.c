#include <stdio.h>

char course_info[1000000];
char pre_course[1000000];
int pass_course[11100];

int main() {
    int total_credit = 0;
    float total_gpa = 0;
    int pass_credit = 0;
    int try_credit = 0;
    int course_num = 0;
    while(1) {
        scanf("%s", &course_info[course_num * 1000]);
        // 输入 end 表示输入结束
        if(course_info[course_num * 1000] == 'e') {
            break;
        }
        course_num = course_num + 1;
    }

    int course = 0;
    while(course < course_num) {
        printf("%s\n", &course_info[course * 1000]);
        int idx = course * 1000;
        int preidx = course * 1000;
        while(course_info[idx] != '|') {
            idx = idx + 1;
        }
        idx = idx + 1;
        int credit = course_info[idx] - '0';
        total_credit = total_credit + credit;
        idx = idx + 1;
        idx = idx + 1;
        while(course_info[idx] != '|') {
            pre_course[preidx] = course_info[idx];
            preidx = preidx + 1;
            idx = idx + 1;
        }
        pre_course[preidx] = '\0';
        printf("%s\n", &pre_course[course * 1000]);
        char grade = course_info[idx + 1];
        if(grade == 'A') {
            total_gpa = total_gpa + credit * 4;
            try_credit = try_credit + credit;
            pass_credit = pass_credit + credit;
            pass_course[course] = 1;
        }
        if(grade == 'B') {
            total_gpa = total_gpa + credit * 3;
            try_credit = try_credit + credit;
            pass_credit = pass_credit + credit;
            pass_course[course] = 1;
        }
        if(grade == 'C') {
            total_gpa = total_gpa + credit * 2;
            try_credit = try_credit + credit;
            pass_credit = pass_credit + credit;
            pass_course[course] = 1;
        }
        if(grade == 'D') {
            total_gpa = total_gpa + credit;
            try_credit = try_credit + credit;
            pass_credit = pass_credit + credit;
            pass_course[course] = 1;
        }
        if(grade == 'F') {
            try_credit = try_credit + credit;
        }
        course = course + 1;
    }

    printf("GPA: %.1f\n", total_gpa / try_credit);
    printf("Hours Attempted: %d\n", try_credit);
    printf("Hours Completed: %d\n", pass_credit);

    return 0;
}