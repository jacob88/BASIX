"BASIX_LOG" callExtension "BASIX Startup Initiated";
waitUntil{!(isNil "BASIX_SETTINGS")};
_Settings = call BASIX_SETTINGS;

BASIX_KICK = compileFinal "
_kick = (""KICKED"" + (getPlayerUID player) + ""KICKED"");
_return = !(isNil _kick);
_return
";
publicVariable "BASIX_KICK";

BASIX_KICK_ADD = compileFinal '
call compile format ["
[{hint ""BASIX: %1 (%3) Has Been Kicked For: %2"";}, ""BIS_fnc_spawn"", true, false] spawn BIS_fnc_MP;
[{systemChat ""BASIX: %1 (%3) Has Been Kicked For: %2"";}, ""BIS_fnc_spawn"", true, false] spawn BIS_fnc_MP;
[{""BASIX_LOG"" callExtension ""%1 (%3) Has Been Kicked For: %2"";}, ""BIS_fnc_spawn"", false, false] spawn BIS_fnc_MP;
",(name player), _this, (getPlayerUID player)];
';
publicVariable "BASIX_KICK_ADD";

BASIX_BAN_ADD = compileFinal '
call compile format ["
KICKED%3KICKED = compileFinal ""_return = true; _return"";
publicVariable ""KICKED%3KICKED"";
[{if !(isServer) then {hint ""BASIX: %1 (%3) Has Been Banned For: %2"";}}, ""BIS_fnc_spawn"", true, false] spawn BIS_fnc_MP;
[{if !(isServer) then {systemChat ""BASIX: %1 (%3) Has Been Banned For: %2"";}}, ""BIS_fnc_spawn"", true, false] spawn BIS_fnc_MP;
[{if (isServer) then {""BASIX_LOG"" callExtension ""%1 (%3) Has Been Banned For: %2"";}}, ""BIS_fnc_spawn"", false, false] spawn BIS_fnc_MP;
",(name player), _this, (getPlayerUID player)];
_Settings = call BASIX_SETTINGS;
if (_Settings select 17) then
{
call compile format ["[{if (isServer) then {""BASIX_BAN"" callExtension ""%1, (%2)-%3"";}}, ""BIS_fnc_spawn"", false, false] spawn BIS_fnc_MP;",(getPlayerUID player),(name player),_this];
};
';
publicVariable "BASIX_BAN_ADD";

//Greeting
[{
if !(isServer) then
	{
	if (call BASIX_KICK) exitWith {};
	_Settings = call BASIX_SETTINGS;
	CBA_display_ingame_warnings = false;
	sleep 5;
	systemChat "BASIX: This Sever Is Secured By BASIX";
	systemChat format ["BASIX: Welcome %1 (%2)",(name player),(getPlayerUID player)];
	call compile format ["[{""BASIX_LOG"" callExtension ""%1 Has Joined The Server UID:(%2)""}, ""BIS_fnc_spawn"", false, false] spawn BIS_fnc_MP", (name player), (getPlayerUID player)];
	player addMPEventHandler ["MPKilled", {if (isServer) then {if ((name (_this select 0)) != "Error: No unit") then {"BASIX_LOG" callExtension format ["%1 Was Killed By %2",(name (_this select 0)),(name (_this select 1))];};};}];
	if ((_Settings select 11) && ((getPlayerUID player) in (_Settings select 12))) then
		{
		call compile format ["[{""BASIX_LOG"" callExtension ""%1 Is White Listed UID:(%2)""}, ""BIS_fnc_spawn"", false, false] spawn BIS_fnc_MP", (name player), (getPlayerUID player)];
		systemChat "BASIX: Anti-Hack Disabled, You Are Whitelisted";
		};
	if ((_Settings select 13) && ((call BASIX_ISADMIN) != "NotAdmin")) then
		{
		call compile format ["[{""BASIX_LOG"" callExtension ""%1 Is White Listed UID:(%2)""}, ""BIS_fnc_spawn"", false, false] spawn BIS_fnc_MP", (name player), (getPlayerUID player)];
		systemChat ("BASIX: Admin Privileges Added, Level: " + (call BASIX_ISADMIN));
		};
	}
}, "BIS_fnc_spawn", true, true] spawn BIS_fnc_MP;

//Addon Blacklist
if (_Settings select 0) then
{
	[{
	if !(isServer) then
		{
		_Settings = call BASIX_SETTINGS;
		if ((_Settings select 11) && ((getPlayerUID player) in (_Settings select 12))) exitWith {};
		if ((count activatedAddons) > 348) then
			{
			for "_i" from 0 to ((count activatedAddons) - 1) do
				{
				_pboName = (activatedAddons select _i) + ".pbo";
				if (_pboName in (_Settings select 1)) exitWith
					{
					_reason = format ["Blacklisted Addon (%1)",_pboName];
					_reason spawn BASIX_BAN_ADD;
					sleep 0.1;
					endMission "LOSER";
					};
				};
			};
		}
	}, "BIS_fnc_spawn", true, true] spawn BIS_fnc_MP;
};

//Variable Blacklist
if (_Settings select 2) then
{
	[{
	if !(isServer) then
		{
		_Settings = call BASIX_SETTINGS;
		if ((_Settings select 11) && ((getPlayerUID player) in (_Settings select 12))) exitWith {};
		while {true} do
			{
			for "_i" from 0 to ((count (_Settings select 3)) - 1) do
				{
				_varname = ((_Settings select 3) select _i);
				if !(isnil _varname) exitWith
					{
					_reason = format ["Blacklisted Variable (%1)",_varname];
					_reason spawn BASIX_BAN_ADD;
					sleep 0.1;
					endMission "LOSER";
					};
				};
			sleep 30;
			};
		}
	}, "BIS_fnc_spawn", true, true] spawn BIS_fnc_MP;
};

//Server Speed Limit
if (_Settings select 4) then
{
	[{
	if !(isServer) then
		{
		_Settings = call BASIX_SETTINGS;
		if ((_Settings select 11) && ((getPlayerUID player) in (_Settings select 12))) exitWith {};
		while {true} do
			{
			waitUntil{(((vehicle player) in vehicles) && ((round speed (vehicle player)) > (_Settings select 5)))};
			if (alive player) exitWith
				{
				_reason = format ["Over Server Speed Limit (%1)",(round speed (vehicle player))];
				_reason spawn BASIX_KICK_ADD;
				sleep 0.1;
				endMission "LOSER";
				};
			};
		}
	}, "BIS_fnc_spawn", true, true] spawn BIS_fnc_MP;
};

//Weapon Blacklist
if (_Settings select 6) then
{
	[{
	if !(isServer) then
		{
		_Settings = call BASIX_SETTINGS;
		if ((_Settings select 11) && ((getPlayerUID player) in (_Settings select 12))) exitWith {};
		while {true} do
			{
			waitUntil{((currentWeapon player) in (_Settings select 7))};
			if (alive player) exitWith
				{
				_reason = format ["Blacklisted Weapon (%1)",(currentWeapon player)];
				_reason spawn BASIX_KICK_ADD;
				sleep 0.1;
				endMission "LOSER";
				};
			};
		}
	}, "BIS_fnc_spawn", true, true] spawn BIS_fnc_MP;
};

//Vehicle Blacklist
if (_Settings select 8) then
{
	[{
	if !(isServer) then
		{
		_Settings = call BASIX_SETTINGS;
		if ((_Settings select 11) && ((getPlayerUID player) in (_Settings select 12))) exitWith {};
		while {true} do
			{
			waitUntil{((TypeOf (vehicle player)) in (_Settings select 9))};
			if (alive player) exitWith
				{
				_reason = format ["Blacklisted Vehicle (%1)",(TypeOf (vehicle player))];
				deleteVehicle (vehicle player);
				_reason spawn BASIX_KICK_ADD;
				sleep 0.1;
				endMission "LOSER";
				};
			};
		}
	}, "BIS_fnc_spawn", true, true] spawn BIS_fnc_MP;
};

//Anti-Teleport
if (_Settings select 10) then
{
	[{
	if !(isServer) then
		{
		_Settings = call BASIX_SETTINGS;
		if ((_Settings select 11) && ((getPlayerUID player) in (_Settings select 12))) exitWith {};
		while {true} do
			{
			waitUntil{(alive player)};
			_pos1 = (getPos (vehicle player));
			sleep 1;
			_pos2 = (getPos (vehicle player));
			_tpcheck = _pos1 distance _pos2; 
			if ((vehicle player) in vehicles) then
				{
				if (_tpcheck > 835) exitWith
					{
					_reason = format ["Teleported (%1)",_tpcheck];
					_reason spawn BASIX_BAN_ADD;
					sleep 0.1;
					endMission "LOSER";
					};
				};
			if !((vehicle player) in vehicles) then
				{
				if (_tpcheck > 30) exitWith
					{
					_reason = format ["Teleported (%1)",_tpcheck];
					_reason spawn BASIX_BAN_ADD;
					sleep 0.1;
					endMission "LOSER";
					};
				};
			};
		}
	}, "BIS_fnc_spawn", true, true] spawn BIS_fnc_MP;
};

//Classname Scanner
if (_Settings select 15) then
{
	[{
	if !(isServer) then
		{
		_Settings = call BASIX_SETTINGS;
		if ((_Settings select 11) && ((getPlayerUID player) in (_Settings select 12))) exitWith {};
		for "_i" from 0 to ((count (_Settings select 16)) - 1) do
			{
			_classname = ((_Settings select 16) select _i);
			if (isClass (configFile >> _classname)) exitWith
				{
				_reason = format ["Blacklisted Classname (%1)",_classname];
				_reason spawn BASIX_BAN_ADD;
				sleep 0.1;
				endMission "LOSER";
				};
			};
		}
	}, "BIS_fnc_spawn", true, true] spawn BIS_fnc_MP;
};

//Admin Menu
if (_Settings select 13) then
{
BASIX_ISADMIN = compileFinal "
_Settings = call BASIX_SETTINGS;
if !(_Settings select 13) exitWith {};
_return = ""NotAdmin"";
for ""_i"" from 0 to ((count (_Settings select 14)) - 1) do
{
_UID = (((_Settings select 14) select _i) select 0);
_LEVEL = (((_Settings select 14) select _i) select 1);
if ((getPlayerUID player) == _UID) then {_return = _LEVEL;};
};
_return
";
publicVariable "BASIX_ISADMIN";

BASIX_INVISIBLE = compileFinal '
_var = (format ["INVIS%1INVIS",(getPlayerUID player)]);
if (isNil _var) exitWith
{
call compile format ["INVIS%1INVIS = true; publicVariable ""INVIS%1INVIS"";",(getPlayerUID player)];
call compile format ["[{if !(isServer) then {if !(isNil ""INVIS%2INVIS"") then {if (INVIS%2INVIS) then {%1 hideObject true;};};}}, ""BIS_fnc_spawn"", true, true] spawn BIS_fnc_MP;",(vehicle player),(getPlayerUID player)];
};
_vartest = (call compile format ["_return = INVIS%1INVIS; _return",(getPlayerUID player)]);
if (_vartest) exitWith
{
call compile format ["INVIS%1INVIS = false; publicVariable ""INVIS%1INVIS"";",(getPlayerUID player)];
call compile format ["[{if !(isServer) then {if !(isNil ""INVIS%2INVIS"") then {if !(INVIS%2INVIS) then {%1 hideObject false;};};}}, ""BIS_fnc_spawn"", true, false] spawn BIS_fnc_MP;",(vehicle player),(getPlayerUID player)];
};
if !(_vartest) exitWith
{
call compile format ["INVIS%1INVIS = true; publicVariable ""INVIS%1INVIS"";",(getPlayerUID player)];
call compile format ["[{if !(isServer) then {if !(isNil ""INVIS%2INVIS"") then {if (INVIS%2INVIS) then {%1 hideObject true;};};}}, ""BIS_fnc_spawn"", true, false] spawn BIS_fnc_MP;",(vehicle player),(getPlayerUID player)];
};
';
publicVariable "BASIX_INVISIBLE";

BASIX_ADMIN_MENU_SUPER_ADMIN = compileFinal '
if ((call BASIX_ISADMIN) == "NotAdmin") exitWith {};
_menu = 
[
	["SuperAdmin",false],
	["Teleport", [2], "", -5, [["expression", "hint ""Click on map to select teleport destination""; onMapSingleClick ""(vehicle player) setPos _pos; hint """"Teleported!"""";"";"]], "1", "1"],
	["Heal Self", [3], "", -5, [["expression", "player setDamage 0;"]], "1", "1"],
	["Heal Target", [4], "", -5, [["expression", "cursorTarget setDamage 0;"]], "1", "1"],
	["Kill Target", [5], "", -5, [["expression", "cursorTarget setDamage 1;"]], "1", "1"],
	["Player Tracker", [6], "", -5, [["expression", "if (isNil ""BASIX_PLAYER_TRACK"") exitWith {BASIX_PLAYER_TRACK = true; [] spawn {while{!(isNil ""BASIX_PLAYER_TRACK"")}do {{createMarkerLocal[(name _x),(getPos _x)];} forEach ([] call BIS_fnc_listplayers); sleep 0.5;};};}; BASIX_PLAYER_TRACK = nil; {deleteMarkerLocal (name _x);} forEach ([] call BIS_fnc_listplayers);"]], "1", "1"],
	["GOD Mode", [7], "", -5, [["expression", "if (isNil ""BASIX_InvincibilityID"") exitWith {BASIX_InvincibilityID = (vehicle player) addEventHandler [""HandleDamage"", {false}];}; (vehicle player) removeEventHandler [""HandleDamage"", BASIX_InvincibilityID]; BASIX_InvincibilityID = nil;"]], "1", "1"],
	["Invisibility", [8], "", -5, [["expression", "call BASIX_INVISIBLE;"]], "1", "1"],
	["Exit", [9], "", -5, [["expression", ""]], "1", "1"]
];
showCommandingMenu "#USER:_menu";
';
publicVariable "BASIX_ADMIN_MENU_SUPER_ADMIN";

BASIX_ADMIN_MENU_ADMIN = compileFinal '
if ((call BASIX_ISADMIN) == "NotAdmin") exitWith {};
_menu = 
[
	["Admin",false],
	["Teleport", [2], "", -5, [["expression", "hint ""Click on map to select teleport destination""; onMapSingleClick ""(vehicle player) setPos _pos; hint """"Teleported!"""";"";"]], "1", "1"],
	["Heal Self", [3], "", -5, [["expression", "player setDamage 0;"]], "1", "1"],
	["Heal Target", [4], "", -5, [["expression", "cursorTarget setDamage 0;"]], "1", "1"],
	["Player Tracker", [5], "", -5, [["expression", "if (isNil ""BASIX_PLAYER_TRACK"") exitWith {BASIX_PLAYER_TRACK = true; [] spawn {while{!(isNil ""BASIX_PLAYER_TRACK"")}do {{createMarkerLocal[(name _x),(getPos _x)];} forEach ([] call BIS_fnc_listplayers); sleep 0.5;};};}; BASIX_PLAYER_TRACK = nil; {deleteMarkerLocal (name _x);} forEach ([] call BIS_fnc_listplayers);"]], "1", "1"],
	["Exit", [6], "", -5, [["expression", ""]], "1", "1"]
];
showCommandingMenu "#USER:_menu";
';
publicVariable "BASIX_ADMIN_MENU_ADMIN";

BASIX_ADMIN_MENU_MODERATOR = compileFinal '
if ((call BASIX_ISADMIN) == "NotAdmin") exitWith {};
_menu = 
[
	["Moderator",false],
	["Heal Target", [2], "", -5, [["expression", "cursorTarget setDamage 0;"]], "1", "1"],
	["Player Tracker", [3], "", -5, [["expression", "if (isNil ""BASIX_PLAYER_TRACK"") exitWith {BASIX_PLAYER_TRACK = true; [] spawn {while{!(isNil ""BASIX_PLAYER_TRACK"")}do {{createMarkerLocal[(name _x),(getPos _x)];} forEach ([] call BIS_fnc_listplayers); sleep 0.5;};};}; BASIX_PLAYER_TRACK = nil; {deleteMarkerLocal (name _x);} forEach ([] call BIS_fnc_listplayers);"]], "1", "1"],
	["Exit", [4], "", -5, [["expression", ""]], "1", "1"]
];
showCommandingMenu "#USER:_menu";
';
publicVariable "BASIX_ADMIN_MENU_MODERATOR";

BASIX_ADMIN_MENU = compileFinal "
_Settings = call BASIX_SETTINGS;
if ((call BASIX_ISADMIN) == ""NotAdmin"") exitWith {};
if ((call BASIX_ISADMIN) == ""SuperAdmin"") exitWith
	{
	call BASIX_ADMIN_MENU_SUPER_ADMIN;
	};
if ((call BASIX_ISADMIN) == ""Admin"") exitWith
	{
	call BASIX_ADMIN_MENU_ADMIN;
	};
if ((call BASIX_ISADMIN) == ""Moderator"") exitWith
	{
	call BASIX_ADMIN_MENU_MODERATOR;
	};
";
publicVariable "BASIX_ADMIN_MENU";

BASIX_KEY_COMBO = compileFinal "
_key = (_this select 1);
_shift = (_this select 2);
_ctrl = (_this select 3);
if ((_key != 15) && !(_ctrl) && !(_shift)) exitWith {};
if ((_key == 15) && (_ctrl) && (_shift)) then
{
call BASIX_ADMIN_MENU;
};
";
publicVariable "BASIX_KEY_COMBO";

BASIX_TELEPORT_PLAYER = compileFinal '
(vehicle player) setPos [(((getPos (([] call BIS_fnc_listplayers) select _this)) select 0) + 2),((getPos (([] call BIS_fnc_listplayers) select _this)) select 1),((getPos (([] call BIS_fnc_listplayers) select _this)) select 2)];
';
publicVariable "BASIX_TELEPORT_PLAYER";

[{
if !(isServer) then
	{
	waitUntil {!(IsNull (findDisplay 46))};
	(findDisplay 46) displayAddEventHandler ["KeyDown", {_this call BASIX_KEY_COMBO;}];
	}
}, "BIS_fnc_spawn", true, true] spawn BIS_fnc_MP;
};
if !(_Settings select 13) then
{
BASIX_ISADMIN = compileFinal "
_return = ""NotAdmin"";
_return
";
publicVariable "BASIX_ISADMIN";
};

//Player Kick-Loop
[{
if !(isServer) then
	{
	_Settings = call BASIX_SETTINGS;
	if ((_Settings select 11) && ((getPlayerUID player) in (_Settings select 12))) exitWith {};
	while{true}do
		{
		if (call BASIX_KICK) then
			{
			endMission "LOSER";
			};
		sleep 1;
		};
	}
}, "BIS_fnc_spawn", true, true] spawn BIS_fnc_MP;
"BASIX_LOG" callExtension "BASIX Startup Finished";