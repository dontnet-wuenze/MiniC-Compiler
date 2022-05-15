#include "Emit.h"
#include "treenode.h"
#include <llvm-10/llvm/Support/TargetSelect.h>

extern int yyparse(void);

int main(){
    yyparse();
    TreeNode* Root;//待定 暂不知如何得到root
    EmitContext* generator = new EmitContext();

    llvm::InitializeNativeTarget();
    llvm::InitializeNativeTargetAsmParser();
    llvm::InitializeNativeTargetAsmPrinter();

    generator->Run(Root);

    return 0;

}