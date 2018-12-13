/*
 * Authored by Bennett Liu on October 22nd, 2018
 * configMaker builds the config.clp file using the data provided in Animals.csv
 */
#include <iostream>
#include <cstdio>
#include <vector>
using namespace std;

int main()
{
   //Create and initialize all needed variables
   int n, q;
   cout << "How many questions do you want? ";
   cin >> q;
   cout << "How many animals do you have? ";
   cin >> n;
   
   string inputString, tmp;
   vector<string> characteristics = vector<string>();
   vector<string> questions = vector<string>();
   vector<string> animal[n];
   fill(animal, animal + n, vector<string>());
   
   //Begin reading the CSV
   freopen("Animals.csv","r",stdin);
   
   //Read all characteristic names into characteristics
   getline(cin,inputString);
   for (int i = 1; i < inputString.length() - 1; i++)
   {
      if (inputString[i] == ',')
      {
         characteristics.push_back(tmp);
         tmp = "";
      }
      else tmp += inputString[i];
   }
   characteristics.push_back(tmp);
   
   //Read all characteristic questions into questions
   tmp = "";
   getline(cin,inputString);
   for (int i = 1; i < inputString.length() - 1; i++)
   {
      if (inputString[i] == ',')
      {
         questions.push_back(tmp);
         tmp = "";
      }
      else tmp += inputString[i];
   }
   questions.push_back(tmp);
   
   //Read all animals and their qualities into animal
   for (int i = 0; i < n; i++)
   {
      getline(cin,inputString);
      int j = 1;
      animal[i].push_back("");
      if ('a' <= inputString[0]) animal[i][0] += char(inputString[0] + 'A' - 'a');
      else animal[i][0] += inputString[0];
      for (; j < inputString.length() - 1 && inputString[j] != ','; j++)
      {
         animal[i][0] += inputString[j];
      }
      j++;
      for (int k = 0; k < characteristics.size(); k++, j+=2)
      {
         if (j < inputString.length() && (inputString[j] == 'Y' || inputString[j] == 'N' || inputString[j] == '?'))
         {
            animal[i].push_back(inputString.substr(j,1));
         }
         else
         {
            cout << "Error at " << animal[i][0] << ": " << characteristics[k] << endl;
         }
      }
   }
   
   //Begin writing the config file
   freopen("config.clp","w",stdout);
   
   //Write header comment
   cout << "/*" << endl << " Automatically generated config file using configMaker.cpp" << endl<<" */" << endl << endl;
   
   //Define templates and instantiate globals
   cout << "(deftemplate animal (slot name) (slot round)";
   for (int i = 0; i < characteristics.size(); i++) cout << " (slot " << characteristics[i] << ")";
   cout << ")" << endl;
   
   cout << "(deftemplate finished)" << endl;
   
   cout << "(defglobal ?*CHARACTERISTICS* = (create$";
   for (int i = 0; i < characteristics.size(); i++) cout << " " << characteristics[i];
   cout << "))" << endl;
   
   cout << "(defglobal ?*QUESTIONS* = (create$";
   for (int i = 0; i < questions.size(); i++) cout << " \"" << questions[i] << "\"";
   cout << "))" << endl;
   
   cout << "(defglobal ?*POSSIBILITIES* = " << n << ")" << endl;
   cout << "(defglobal ?*QUESTION* = 1)" << endl;
   cout << "(defglobal ?*QUESTIONCAP* = " << q << ")" << endl;
   
   cout << "(defglobal ?*ASKED* = (create$ ";
   for (int i = 0; i < characteristics.size(); i++) cout << " FALSE";
   cout << "))" << endl;
   
   cout << "(defglobal ?*YES* = (create$";
   for (int i = 0; i < characteristics.size(); i++) cout << " 0";
   cout << "))" << endl;
   
   cout << "(defglobal ?*NO* = (create$";
   for (int i = 0; i < characteristics.size(); i++) cout << " 0";
   cout << "))" << endl << endl;
   
   //Defines function makeAnimal to simplify round 1 animal definitions
   cout << "(deffunction makeAnimal (?name";
   for (int i = 0; i < characteristics.size(); i++) cout << " ?" << characteristics[i];
   cout << ")" << endl;
   cout << "\t(assert (animal (name ?name) (round 1)";
   for (int i = 0;i < characteristics.size(); i++)
      cout << " (" << characteristics[i] << " ?" << characteristics[i] << ")";
   cout << "))" << endl << ")" << endl << endl;
   
   //Uses makeAnimal to assert each animal as a round 1 animal
   for (int i = 0; i < n; i++) {
      cout << "(makeAnimal \"";
      cout << animal[i][0];
      cout << "\"";
      for (int j = 1; j <= characteristics.size(); j++) cout << " \"" << animal[i][j] << "\"";
      cout << ")" << endl;
   }
   
   return 0;
}
