#include "tree.h"
using namespace std;
void TreeNode::addChild(TreeNode* child) {
    if(this->child == nullptr){
        this->child = child;
    }else{
        this->child->addSibling(child);
    }
	
}

void TreeNode::addSibling(TreeNode* sibling){
    TreeNode *cursor=this;
    while(cursor->sibling != nullptr){
        cursor = cursor->sibling;
    }
	cursor->sibling = sibling;
}

TreeNode::TreeNode(int lineno, NodeType type) {
	this->lineno = lineno;
	this->nodeType = type;
}

void TreeNode::genNodeId() {
	TreeNode *cursor = this;
    int nodeid = 1;
    queue<TreeNode *> Q;
    Q.push(cursor);
    while(!Q.empty()){
        TreeNode *temp = Q.front();
        Q.pop();
        temp->nodeID = nodeid++;
        if(temp->child != nullptr){
            cursor = temp->child;
            Q.push(cursor);
            cursor = cursor->sibling;
            while(cursor != nullptr){
                Q.push(cursor);
                cursor = cursor->sibling;
            }
        }
    }
}

void TreeNode::printNodeInfo() {
    switch(this->nodeType){
        case NODE_CONST:{
            
        }
            break;
        case NODE_VAR:{

        }
            break;
        case NODE_EXPR:{

        }
            break;
        case NODE_STMT:{

        }
            break;
        case NODE_TYPE:{

        }
            break;
        default:
            break;
    }
}

void TreeNode::printChildrenId() {

}

void TreeNode::printAST() {

}


// You can output more info...
void TreeNode::printSpecialInfo() {
    switch(this->nodeType){
        case NODE_CONST:
            break;
        case NODE_VAR:
            break;
        case NODE_EXPR:
            break;
        case NODE_STMT:
            break;
        case NODE_TYPE:
            break;
        default:
            break;
    }
}

string TreeNode::sType2String(StmtType type) {
    return "?";
}


string TreeNode::nodeType2String (NodeType type){
    return "<>";
}
