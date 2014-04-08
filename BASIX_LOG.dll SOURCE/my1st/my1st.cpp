// my1st.cpp : Defines the exported functions for the DLL application.
//

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
	string LogSTR;
	LogSTR = function;

	time_t now = time(0);
	tm *ltm = localtime(&now);

	fstream file("BASIX_LOGS/Server_Log.txt", ios_base::app | ios_base::out);
	file << "[[" << ltm->tm_mday << "/" << 1 + ltm->tm_mon << "/" << ltm->tm_year - 100 << "] " << 1 + ltm->tm_hour << ":" << 1 + ltm->tm_min << ":" << 1 + ltm->tm_sec << "]:" << " " << LogSTR << endl;
	file.close();
}