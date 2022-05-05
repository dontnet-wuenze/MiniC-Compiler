#ifndef _TREE_H_

#define _TREE_H_

#include <iostream>
#include <cstdio>
#include <cstring>

using namespace std;

class Node {
public:
    string Name;

    Node *Left;
    Node *Right;

    int lineNo;

};

#endif // _TREE_H_