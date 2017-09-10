#include <iostream>
#include <string>
#include <deque>
#include <map>
#include <direct.h>
#include <windows.h>
#include <fstream>
#include <sstream>
#include <ctype.h>

using namespace std;

bool is_balanced(string str) {
	map<char, char>open;
	map<char, char>closed;

	if (str[0] == ')' || str[0] == '}' || str[0] == ']') return false;
	int n = str.size();
	if (str[n - 1] == '(' || str[n - 1] == '{' || str[n - 1] == '[') return false;
	if (n % 2 != 0) return false;

	open['('] = ')';
	open['['] = ']';
	open['{'] = '}';
	closed[')'] = '(';
	closed[']'] = '[';
	closed['}'] = '{';

	
	deque<char>buff;

	for (int i = 0; i < str.size(); i++) {
		buff.push_back(str[i]);
		if (closed.find(str[i]) != closed.end()) {
			if (buff.size() > 1) {
				char second = buff.back(); buff.pop_back();
				char first = buff.back(); buff.pop_back();
				if (open[first] != second) return false;
			}
		}
	}
	return true;
}


bool is_number(string str) { //check if string is a number

	for (int i = 0; i < str.size(); i++) {
		if (isdigit(str[i])) return true;
		else continue;
	}
	return false;
}

bool is_file_exist(string fileName)
{
	std::ifstream infile(fileName);
	return infile.good();
}



int main(int argc, char *argv[]) {

	if (argc > 3) {
		cout << "Too many arguments! Terminating...\n";
		system("pause");
		return 0;
	}
	else if (argc < 3) {
		cout << "Too few arguments! Terminating...\n";
		system("pause");
		return 0;
	}
	
	string inputFile = argv[1];//extract current input test case file.
	string outputFile = argv[2];//extract current expected output file.
	
	string dir = _getcwd(NULL, 0);//get current working directory.
	string _resultsFilePath = dir + "\\output.txt"; //path for desired output text file.
	
	ofstream out; //create new output file stream.
	
	if (!is_file_exist (_resultsFilePath)) {//if output file does not exist.
		out.open(_resultsFilePath); //create new output file for writing.
	}
	else {
		out.open(_resultsFilePath, fstream::app | fstream::out); // append to existing file.
	}
			
		ifstream infile(inputFile); //read in current input file using file stream.
		ifstream outfile(outputFile); //read in current output file using file stream.

		string input;
		while (getline(infile, input)) { //read current line in file.
			if (!is_number(input)) {
				string result;
				getline(outfile, result);
				string answer = is_balanced(input) ? "YES" : "NO";
				if (result == "")
					getline(outfile, result);
				string testResult = (answer == result) ? "Pass" : "Fail";
				
				out << input << " " + answer + " " << result + " " << testResult << endl;
			}
		}
	out.close();

	cout << "BalancedBrackets executed sucessfully!\n";
    return 0;
}
