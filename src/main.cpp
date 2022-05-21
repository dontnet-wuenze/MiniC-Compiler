#include "fstream"
#include "Emit.h"
#include "treenode.h"
#include <llvm/Support/TargetSelect.h>

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

    // jsonize AST
    string jsonString("");
    programBlock->generateJson(jsonString);
    ofstream fout;
    fout.open("../visualization/AST.json");
    fout << jsonString;
    fout.close();

    generator->Run(programBlock);

    return 0;

}