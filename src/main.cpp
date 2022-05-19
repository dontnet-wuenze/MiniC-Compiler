#include "Emit.h"
#include "treenode.h"
#include <llvm-10/llvm/Support/TargetSelect.h>

extern int yyparse(void);
extern BlockNode* programBlock;

int main(){
    yyparse();
    //BlockNode* Root;
    EmitContext* generator = new EmitContext();

    llvm::InitializeNativeTarget();
    llvm::InitializeNativeTargetAsmParser();
    llvm::InitializeNativeTargetAsmPrinter();

    cout<<"program begin"<<endl;
    generator->Run(programBlock);

    return 0;

}