// my1st.cpp : Defines the exported functions for the DLL application.
//

#pragma comment(lib,"Ws2_32.lib")
#include "stdafx.h"
#include <iostream>
#include <WinSock2.h>
#include <cstdlib>
#include <string>
#include <stdlib.h>
#include <winsock.h>

using namespace std;

#define BUFFERSIZE 1024

extern "C"
{
	__declspec (dllexport) void __stdcall RVExtension(char *output, int outputSize, const char *function);
}

void __stdcall RVExtension(char *output, int outputSize, const char *function)
{
	string Func;
	Func = function;

	if (Func == "Version")
	{
		string request;
		int resp_leng;

		char buffer[BUFFERSIZE];
		struct sockaddr_in serveraddr;
		int sock;

		WSADATA wsaData;
		char *ipaddress = "199.19.115.144";
		int port = 80;

		request += "GET /antihack/version.txt HTTP/1.0\r\n";
		request += "Host: www.basix-antihack.com\r\n";
		request += "\r\n";

		if (WSAStartup(MAKEWORD(2, 0), &wsaData) != 0)
		{
			strncpy_s(output, outputSize, "HTTP ERROR!", _TRUNCATE);
		}

		if ((sock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0)
		{
			strncpy_s(output, outputSize, "HTTP ERROR!", _TRUNCATE);
		}

		memset(&serveraddr, 0, sizeof(serveraddr));
		serveraddr.sin_family = AF_INET;
		serveraddr.sin_addr.s_addr = inet_addr(ipaddress);
		serveraddr.sin_port = htons((unsigned short)port);
		if (connect(sock, (struct sockaddr *) &serveraddr, sizeof(serveraddr)) < 0)
		{
			strncpy_s(output, outputSize, "HTTP ERROR!", _TRUNCATE);
		}

		if (send(sock, request.c_str(), request.length(), 0) != request.length())
		{
			strncpy_s(output, outputSize, "HTTP ERROR!", _TRUNCATE);
		}

		resp_leng = BUFFERSIZE;
		resp_leng = recv(sock, (char*)&buffer, BUFFERSIZE, 0);

		if (resp_leng > 0)
		{
			strncpy_s(output, outputSize, buffer, _TRUNCATE);
		}

		closesocket(sock);

		WSACleanup();
	}
}