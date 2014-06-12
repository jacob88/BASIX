if (isNil "BASIX_ISADMIN") exitWith {hint "BASIX_ERROR!";};
if ((call BASIX_ISADMIN) == "NotAdmin") exitWith
{
_reason = "Attempted Admin Access";
_reason spawn BASIX_KICK_ADD;
sleep 0.1;
endMission "LOSER";
};
if ((call BASIX_ISADMIN) == "Admin") then
{
execVM "BASIX_ADMIN_LEVELS\Admin.sqf";
};
if ((call BASIX_ISADMIN) == "Moderator") then
{
execVM "BASIX_ADMIN_LEVELS\Moderator.sqf";
};

if ((_this select 1) == "KICK") exitWith
{
_PlayerName = (_this select 0);
call compile format ["[{
if !(isServer) then
	{
	if ((name player) == ""%1"") then
		{
		endMission ""LOSER"";
		};
	};
}, ""BIS_fnc_spawn"", true, false] spawn BIS_fnc_MP", _PlayerName];
sleep 0.1;
private["_PlayerUID"];
_PlayerUID = "";
for "_i" from 0 to ((count ([] call BIS_fnc_listplayers)) - 1) do
	{
	_PlayerNamez = (name (([] call BIS_fnc_listplayers) select _i));
	if (_PlayerNamez == _PlayerName) exitWith
		{
		_PlayerUID = (getPlayerUID(([] call BIS_fnc_listplayers) select _i));
		};
	};
call compile format ["
[{hint ""BASIX: %1 (%3) Has Been Kicked By: %2 (%4)"";}, ""BIS_fnc_spawn"", true, false] spawn BIS_fnc_MP;
[{systemChat ""BASIX: %1 (%3) Has Been Kicked By: %2 (%4)"";}, ""BIS_fnc_spawn"", true, false] spawn BIS_fnc_MP;
[{""BASIX_LOG"" callExtension ""BASIX: %1 (%3) Has Been Kicked By: %2 (%4)"";}, ""BIS_fnc_spawn"", false, false] spawn BIS_fnc_MP;
", _PlayerName, (name player), _PlayerUID, (getPlayerUID player)];
};

if ((_this select 1) == "BAN") exitWith
{
_PlayerName = (_this select 0);
call compile format ["[{
if !(isServer) then
	{
	if ((name player) == ""%1"") then
		{
		endMission ""LOSER"";
		};
	};
}, ""BIS_fnc_spawn"", true, false] spawn BIS_fnc_MP", _PlayerName];
sleep 0.1;
private["_PlayerUID"];
_PlayerUID = "";
for "_i" from 0 to ((count ([] call BIS_fnc_listplayers)) - 1) do
	{
	_PlayerNamez = (name (([] call BIS_fnc_listplayers) select _i));
	if (_PlayerNamez == _PlayerName) exitWith
		{
		_PlayerUID = (getPlayerUID(([] call BIS_fnc_listplayers) select _i));
		};
	};
call compile format ["
KICKED%3KICKED = compileFinal ""_return = true; _return"";
publicVariable ""KICKED%3KICKED"";
[{hint ""BASIX: %1 (%3) Has Been Banned By: %2 (%4)"";}, ""BIS_fnc_spawn"", true, false] spawn BIS_fnc_MP;
[{systemChat ""BASIX: %1 (%3) Has Been Banned By: %2 (%4)"";}, ""BIS_fnc_spawn"", true, false] spawn BIS_fnc_MP;
[{""BASIX_LOG"" callExtension ""BASIX: %1 (%3) Has Been Banned By: %2 (%4)"";}, ""BIS_fnc_spawn"", false, false] spawn BIS_fnc_MP;
", _PlayerName, (name player), _PlayerUID, (getPlayerUID player)];
_Settings = call BASIX_SETTINGS;
if (_Settings select 17) then
	{
	call compile format ["[{if (isServer) then {""BASIX_BAN"" callExtension ""%1, (%2)-Admin Ban By %3.%4"";}}, ""BIS_fnc_spawn"", false, false] spawn BIS_fnc_MP;",_PlayerUID,_PlayerName,(name player),(getPlayerUID player)];
	};
};

if ((_this select 1) == "TEMPBAN") exitWith
{
_PlayerName = (_this select 0);
call compile format ["[{
if !(isServer) then
	{
	if ((name player) == ""%1"") then
		{
		endMission ""LOSER"";
		};
	};
}, ""BIS_fnc_spawn"", true, false] spawn BIS_fnc_MP", _PlayerName];
sleep 0.1;
private["_PlayerUID"];
_PlayerUID = "";
for "_i" from 0 to ((count ([] call BIS_fnc_listplayers)) - 1) do
	{
	_PlayerNamez = (name (([] call BIS_fnc_listplayers) select _i));
	if (_PlayerNamez == _PlayerName) exitWith
		{
		_PlayerUID = (getPlayerUID(([] call BIS_fnc_listplayers) select _i));
		};
	};
call compile format ["
KICKED%3KICKED = compileFinal ""_return = true; _return"";
publicVariable ""KICKED%3KICKED"";
[{hint ""BASIX: %1 (%3) Has Been TempBanned By: %2 (%4)"";}, ""BIS_fnc_spawn"", true, false] spawn BIS_fnc_MP;
[{systemChat ""BASIX: %1 (%3) Has Been TempBanned By: %2 (%4)"";}, ""BIS_fnc_spawn"", true, false] spawn BIS_fnc_MP;
[{""BASIX_LOG"" callExtension ""BASIX: %1 (%3) Has Been TempBanned By: %2 (%4)"";}, ""BIS_fnc_spawn"", false, false] spawn BIS_fnc_MP;
", _PlayerName, (name player), _PlayerUID, (getPlayerUID player)];
};