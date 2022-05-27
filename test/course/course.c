#include <stdio.h>

char course_info[1000000];
char pre_course[1000000];
int pass_course[11100];
int course_id[11100];

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
        int idx = course * 1000;
        int preidx = course * 1000;
        while(course_info[idx] != '|') {
            if(course_info[idx] != 'c') {
                course_id[course] = course_id[course] * 10 + course_info[idx] - '0';
            }
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
        char grade = course_info[idx + 1];
        if(grade == 'A') {
            total_gpa = total_gpa + credit * 4;
            try_credit = try_credit + credit;
            pass_credit = pass_credit + credit;
            pass_course[course_id[course]] = 1;
        }
        if(grade == 'B') {
            total_gpa = total_gpa + credit * 3;
            try_credit = try_credit + credit;
            pass_credit = pass_credit + credit;
            pass_course[course_id[course]] = 1;
        }
        if(grade == 'C') {
            total_gpa = total_gpa + credit * 2;
            try_credit = try_credit + credit;
            pass_credit = pass_credit + credit;
            pass_course[course_id[course]] = 1;
        }
        if(grade == 'D') {
            total_gpa = total_gpa + credit;
            try_credit = try_credit + credit;
            pass_credit = pass_credit + credit;
            pass_course[course_id[course]] = 1;
        }
        if(grade == 'F') {
            try_credit = try_credit + credit;
        }
        course = course + 1;
    }

    if(try_credit != 0) {
        total_gpa = total_gpa / try_credit;
    }

    printf("GPA: %.1f\n", total_gpa);
    printf("Hours Attempted: %d\n", try_credit);
    printf("Hours Completed: %d\n", pass_credit);

    int course_remain = total_credit - pass_credit;
    printf("Credits Remaining: %d\n", course_remain);

    printf("Possible Courses to Take Next\n");
    if(course_remain == 0) {
        printf("  None - Congratulations!\n");
        return 0;
    }
    course = 0;
    while(course < course_num) {
        if(pass_course[course_id[course]] == 0) {
            int can = 0;
            if(pre_course[course * 1000] == '\0') {
                can = 1;
            } else {
                int cid = 0;
                int flag = 1;
                int preidx = course * 1000;
                while(1) {
                    if(pre_course[preidx] == '\0') {
                        if(pass_course[cid] == 0) {
                            flag = 0;
                        }
                        if(flag == 1) {
                            can = 1;
                        }
                        break;
                    }
                    if(pre_course[preidx] == ';') {
                        if(pass_course[cid] == 0) {
                            flag = 0;
                        }
                        if(flag == 1) {
                            can = 1;
                        }
                        cid = 0;
                        flag = 1;
                        preidx = preidx + 1;
                    }
                    if(pre_course[preidx] == ',') {
                        if(pass_course[cid] == 0) {
                            flag = 0;
                        }
                        cid = 0;
                        preidx = preidx + 1;
                    }
                    if(pre_course[preidx] != 'c') {
                        cid = cid * 10 + pre_course[preidx] - '0';
                    }
                    preidx = preidx + 1;
                }
            }
            if(can == 1) {
                printf("  ");
                int course_idx = course * 1000;
                while(course_info[course_idx] != '|') {
                    printf("%c", course_info[course_idx]);
                    course_idx = course_idx + 1;
                }
                printf("\n");
            }
        }
        course = course + 1;
    }
    return 0;
}