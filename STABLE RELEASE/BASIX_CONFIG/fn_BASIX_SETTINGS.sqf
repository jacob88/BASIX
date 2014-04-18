//MAIN SETTINGS BASIX

//Addon Blacklist
_Setting1 = true; //Scan player PBO files ("true" is on, "false" is off, set to true by default)
_Setting2 = ["devcon.pbo","DevCon.pbo","DEV_PostA3.pbo","DEV_CO_Dummy.pbo"]; //Addons you don't wan't on your server (e.g. "devcon.pbo")

//Variable Blacklist
_Setting3 = true; //Detect player using Banned variable names ("true" is on, "false" is off, set to true by default)
_Setting4 = ["mainnext1","visualeffects1","iBeFlying","nonapsi_ef","ChangingBullets_xx",
"change_terrain_Metallica","HaxSmokeOn","DEV_CurrentDisplayIdd","DEV_ConsoleActive","DEV_DebugConsoleInputFields",
"DEV_UnitMapMarkersShown","DEV_UnitMapMarkerID","DEV_RemoteCodeLogic","scroll_m_init_star","xtags_star_xx",
"Monky_hax_dbclick","infammoON","raiinswalker"]; //Banned variable names (e.g. an array called: HaxSmokeOn)

//Classname Blacklist
_Setting16 = true; //Detect player using Banned classnames ("true" is on, "false" is off, set to true by default)
_Setting17 = ["DevCon","DEV_Background","DEV_Abort","GlobalExecuteButton_06","DEV_MiniMap","DevCon_Fired","DEV_MapReplacement"]; //Banned classnames list

//Server Speed Limit
_Setting5 = false; //Detect player speed hacking ("true" is on, "false" is off, set to false by default)
_Setting6 = 600; //Non-unit vehicle max speed on your server (Variable for detecting speed-hacking, set to 600 by default)

//Weapon Blacklist
_Setting7 = false; //Detect player using Banned weapon ("true" is on, "false" is off, set to false by default)
_Setting8 = [""]; //Weapons you can't obtain legitimately in your mission

//Vehicle Blacklist
_Setting9 = false; //Detect player using Banned vehicle ("true" is on, "false" is off, set to false by default)
_Setting10 = [""]; //Vehicles you can't obtain legitimately in your mission

//Anti-Teleport
_Setting11 = true; //Detect player teleport ("true" is on, "false" is off, set to true by default)

//Player Exemptions
_Setting12 = false; //Allow declared players to be exempt from Anti-Hack ("true" is on, "false" is off, set to false by default)
_Setting13 = [""]; //List of player UID's exempt from Anti-Hack

//Admin Menu
_Setting14 = false; //Enable BASIX admin menu system ("true" is on, "false" is off, set to false by default)
_Setting15 = [["",""]]; //List of admin UID's and level, structure [UID,LEVEL] e.g. ["123456","SuperAdmin"] (options: "SuperAdmin", "Admin", "Moderator")

//Permanent BASIX Bans
_Setting18 = true; //Enable BASIX permanent ban system, be warned possible security risk if enabled ("true" is on, "false" is off, set to true by default)




//End Of Settings ** Do Not Edit Below This Point **
BASIX_SETTINGS = compileFinal (format ["_return = [%1,%2,%3,%4,%5,%6,%7,%8,%9,%10,%11,%12,%13,%14,%15,%16,%17,%18]; _return",_Setting1,_Setting2,_Setting3,_Setting4,_Setting5,_Setting6,_Setting7,_Setting8,_Setting9,_Setting10,_Setting11,_Setting12,_Setting13,_Setting14,_Setting15,_Setting16,_Setting17,_Setting18]);
publicVariable "BASIX_SETTINGS";
