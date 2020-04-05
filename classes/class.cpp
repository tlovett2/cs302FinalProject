#include <iostream>
#include <list>
#include <string>
#include <sstream>
#include <ctime>

using namespace std;

class Node {
    //possibly add a date to be completed by
  public: 
   string task;
   string time; 
   bool completed;
};

class tasks {
  public:
   tasks();
   ~tasks();
   void add_task(string &);
   void remove_task(string &);
   void edit_task(string &, string &);
   void clear_tasks();
   void print_tasks();
   void help();
  private:
   list <Node *> all_tasks;
};

tasks::tasks()
{
    
}

tasks::~tasks()
{
    clear_tasks();
}

void tasks::add_task(string &s)
{
    //add a to be completed by date would ask for when getting input for task;
  time_t rawtime;
  struct tm * timeinfo;
  time (&rawtime);
  timeinfo = localtime(&rawtime);
  
  Node *n = new Node;

  n->task = s;
  n->time = asctime(timeinfo);
  n->completed = false;
    
  all_tasks.push_back(n);
}

//https://stackoverflow.com/questions/23943728/case-insensitive-standard-string-comparison-in-c
//from stack overflow-------
bool icompare_pred(unsigned char a, unsigned char b)
{
    return tolower(a) == tolower(b);
}

bool icompare(std::string const& a, std::string const& b)
{
    if (a.length()==b.length()) {
        return equal(b.begin(), b.end(),
                           a.begin(), icompare_pred);
    }
    else {
        return false;
    }
}
//-----------

void tasks::remove_task(string &s)
{
    list<Node *>::iterator it;
    bool in_list = false;
    Node *n;
    for(it = all_tasks.begin(); it != all_tasks.end(); it++) {
        
        if (icompare((*it)->task, s)) {
            in_list = true;
            n = *it;
            delete n;
            all_tasks.erase(it);
        }
    }
    if(!in_list) cout << "Task \"" << s << "\" already not in list.\n";
    
}

void tasks::edit_task(string &org_tsk,string &new_tsk)
{
    list<Node *>::iterator it;
    bool in_list = false;
    Node *n;
    for(it = all_tasks.begin(); it != all_tasks.end(); it++) {
        
        if (icompare((*it)->task, org_tsk)) {
            in_list = true;
            n = *it;
            n->task = new_tsk;
        }
    }
    if(!in_list) cout << "Task \"" << org_tsk << "\" not in list.\n";
    
    
}

void tasks::clear_tasks()
{
    list<Node *>::iterator it;
    while(!all_tasks.empty()) {
        delete (*all_tasks.begin());
        all_tasks.pop_front();
    }
    
}

void tasks::print_tasks()
{
    if(all_tasks.empty()) {cout << "All tasks completed.\n"; return;}
    list<Node *>::const_iterator it;
    cout << "Current tasks:\n";
    int i = 1;
    for(it = all_tasks.begin(); it != all_tasks.end(); it++) {
        printf("Task %d: %s\nDate created: %s", i, (*it)->task.c_str(), (*it)->time.c_str());
        i++;
    }
}

void tasks::help()
{
    cout << "Possible commands:\n";
    cout << "Help -- shows possible commands\n";
    cout << "Add -- adds a task -- enter add then prompt will then ask you to input task\n";
    cout << "Delete -- deletes task(case does not matter) -- enter delete then prompt will for task to delete\n";
    cout << "Edit -- edit a currently existing task -- enter edit then prompt will ask for old task and new task\n";
    cout << "Print -- prints all tasks\n";
    cout << "Clear -- clears all tasks\n";
    cout << "Quit -- exits the program\n";
    
    cout << "**Note case for commands does not matter**\n";
}

int main()
{
  string s, str;
  tasks tsk;
    
  while(1) {
      
    cout << "Enter command:\n" << '>';
    cin >> s;
    if("Help" == s || "help" == s || "HELP" == s) {
        tsk.help();
    }
    else if("Add" == s || "add" == s || "ADD" == s) {
      cout << "Enter new task:\n>";
      while(cin >> s){
          getline(cin, str);
          
          s.append(str);
          break;
      }
      tsk.add_task(s);
    }
    else if("Delete" == s || "delete" == s || "DELETE" == s) {
      cout << "Enter task to delete:\n>";
      while(cin >> s){
          getline(cin, str);
          
          s.append(str);
          break;
      }
      tsk.remove_task(s);
    }
    else if("Quit" == s || "quit" == s || "QUIT" == s) {
        return 1;
    }
    else if("Clear" == s || "clear" == s || "CLEAR" == s) {
      tsk.clear_tasks();
    }
    else if("Edit" == s || "edit" == s || "EDIT" == s) {
      string org_tsk,new_tsk;
      cout << "Enter original task:\n>";
      while(cin >> org_tsk){
          getline(cin, str);
          
          org_tsk.append(str);
          break;
      }
        
      cout << "Enter edited task:\n>";
      while(cin >> new_tsk){
          getline(cin, str);
            
          new_tsk.append(str);
          break;
      }
      tsk.edit_task(org_tsk,new_tsk);
    }
    else if("Print" == s || "print" == s || "PRINT" == s) {
      tsk.print_tasks();
    }
    else {
      cerr << "Bad input enter another command\n";
      s.clear();
      continue;
    }

  }
  return 0;
}
