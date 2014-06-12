#include "stdafx.h"
#include <iostream>
#include <cstdlib>
#include <fstream>
#include <string>
#include <ctime>

using namespace std;

extern "C"
{
	__declspec (dllexport) void __stdcall RVExtension(char *output, int outputSize, const char *function);
}

void __stdcall RVExtension(char *output, int outputSize, const char *function)
{
	string INPUT_UID = function;
	unsigned UID_POS1 = INPUT_UID.find(", ");
	string OUTPUT_UID = INPUT_UID.substr(0, UID_POS1);

	time_t now = time(0);
	tm *ltm = localtime(&now);

	ifstream file1("BASIX_CONFIG/Ban_Whitelist.txt");
	string str1;
	string file_contents1;
	while (getline(file1, str1))
	{
		file_contents1 += str1;
		file_contents1.push_back('\n');
	}

	if (file_contents1.find(OUTPUT_UID) == string::npos)
	{
		ifstream file2("ban.txt");
		string str2;
		string file_contents2;
		while (getline(file2, str2))
		{
			file_contents2 += str2;
			file_contents2.push_back('\n');
		}

		if (file_contents2.find(OUTPUT_UID) == string::npos)
		{
			fstream file3("ban.txt", ios_base::app | ios_base::out);
			file3 << OUTPUT_UID << endl;
			file3.close();

			fstream file4("BASIX_LOGS/Ban_Log.txt", ios_base::app | ios_base::out);
			file4 << "[[" << ltm->tm_mday << "/" << 1 + ltm->tm_mon << "/" << ltm->tm_year - 100 << "] " << ltm->tm_hour << ":" << ltm->tm_min << ":" << ltm->tm_sec << "]:" << " " << INPUT_UID << endl;
			file4.close();
		}
	}
}