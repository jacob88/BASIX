//General Command Settings

_PM = true; //Player private messaging enabled ("true" is on, "false" is off, set to true by default)

//End of command Settings
/* Note: Do not edit beyond this point unless you know what you are doing. */





_Command = (_this select 0); //Command issued by player
_Rest = (_this select 1); //Everything after that point


//Private Messaging Command
if (((_Command == "!pm") or (_Command == "!Pm") or (_Command == "!pM") or (_Command == "!PM")) && (_PM)) exitWith
{
private ["_PlayerList"];
_PlayerList = [];
for "_i" from 0 to ((count ([] call BIS_fnc_listplayers)) - 1) do
	{
	_PlayerList = _PlayerList + [(name (([] call BIS_fnc_listplayers) select _i))];
	};
_TargetPlayer = _Rest;
if !(_TargetPlayer in _PlayerList) exitWith
	{
	hint "Please enter a valid players name";
	systemChat "BASIX: Please enter a valid players name";
	};
if !(createDialog "RscDisplayPassword") exitWith {hint "Dialog Error!";};
(findDisplay 64) displayRemoveAllEventHandlers "Load";
(findDisplay 64) displayRemoveAllEventHandlers "Unload";
((findDisplay 64) displayCtrl 1) ctrlRemoveAllEventHandlers "ButtonClick";
((findDisplay 64) displayCtrl 2) ctrlRemoveAllEventHandlers "ButtonClick";
((findDisplay 64) displayCtrl 1000) ctrlSetText "Private Message";
((findDisplay 64) displayCtrl 601) ctrlSetText _TargetPlayer;
((findDisplay 64) displayCtrl 1) ctrlSetText "SEND";
((findDisplay 64) displayCtrl 1002) ctrlSetText "Message:";
((findDisplay 64) displayCtrl 1) ctrlAddEventHandler ["ButtonClick",
	{
	_Message = (ctrlText ((findDisplay 64) displayCtrl 101));
	_TargetPlayer = (ctrlText ((findDisplay 64) displayCtrl 601));
	call compile format ["[{
		if !(isServer) then
			{
			_Message = ""%1"";
			_TargetPlayer = ""%2"";
			_Sender = ""%3"";
			if ((name player) == _TargetPlayer) then
				{
				systemChat (""BASIX PM From, "" + _Sender + "": "" + _Message);
				hint (""BASIX PM From, "" + _Sender + "": "" + _Message);
				};
			}
		}, ""BIS_fnc_spawn"", true, false] spawn BIS_fnc_MP",_Message,_TargetPlayer,(name player)];
	}];
};