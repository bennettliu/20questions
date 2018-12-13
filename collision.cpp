/*
 * Authored by Bennett Liu on October 22nd, 2018
 * collisions.cpp checks for animals with the same characteristics in the data provided in Animals.csv
 */
#include <iostream>
#include <cstdio>
#include <vector>
#include <algorithm>
using namespace std;

int main()
{
   //Create and initialize all needed variables
   int n, curDiff, diff;
   cout << "How many animals are there? ";
   cin >> n;
   cout << "How many differences are you looking for? ";
   cin >> diff;
   
   string inputString, tmp;
   vector<string> characteristics = vector<string>();
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
   getline(cin,inputString);
   
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
      for (int k = 0; k < characteristics.size(); k++, j+=2) {
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
   
   //Count differences for each pair and output pair if cur<=diff
   for (int i = 0; i < n; i++)
   {
      for (int j = i + 1; j < n; j++)
      {
         curDiff = 0;
         for (int k = 1; k < characteristics.size(); k++)
         {
            if ((animal[i][k] == "Y" && animal[j][k] == "N") || (animal[i][k] == "N" && animal[j][k] == "Y")) curDiff++;
         }
         if (curDiff <= diff)
         {
            cout << curDiff << " Differences between " << animal[i][0] << " and " << animal[j][0] << endl;
         }
      }
   }
   return 0;
}
