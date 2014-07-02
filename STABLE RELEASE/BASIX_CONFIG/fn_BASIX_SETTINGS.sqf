//MAIN SETTINGS BASIX

//Addon Whitelist
_Setting22 = true; //Scan player PBO files against server PBO files and detect discrepancies ("true" is on, "false" is off, set to true by default)
_Setting23 = [""]; //Additional PBO files to add to the whitelist (e.g. ["CBA_A3.pbo","CBA_CORE.pbo"])

//Classname Whitelist
_Setting24 = true; //Scan player classnames against server classnames and detect discrepancies ("true" is on, "false" is off, set to true by default)
_Setting25 = [""]; //Additional classnames to add to the whitelist (e.g. ["LandVehicle_Duck","Gun_Cowboy"])

//Addon Blacklist
_Setting1 = false; //Scan player PBO files ("true" is on, "false" is off, set to false by default)
_Setting2 = ["devcon.pbo","DevCon.pbo","DEV_PostA3.pbo","DEV_CO_Dummy.pbo"]; //Addons you don't wan't on your server (e.g. "devcon.pbo")

//Variable Blacklist
_Setting3 = true; //Detect player using Banned variable names ("true" is on, "false" is off, set to true by default)
_Setting4 = ["mainnext1","visualeffects1","iBeFlying","nonapsi_ef","ChangingBullets_xx",
"change_terrain_Metallica","HaxSmokeOn","DEV_CurrentDisplayIdd","DEV_ConsoleActive","DEV_DebugConsoleInputFields",
"DEV_UnitMapMarkersShown","DEV_UnitMapMarkerID","DEV_RemoteCodeLogic","scroll_m_init_star","xtags_star_xx",
"Monky_hax_dbclick","infammoON","raiinswalker","E_X_T_A_S_Y_ANTI_ANTI_HAX","E_X_T_A_S_Y_Init_Menu","E_X_T_A_S_Y_Wasteland_VF",
"E_X_T_A_S_Y_SpeedyGonzales","E_X_T_A_S_Y_AdminMenu_404","LYSTIC_MENU_LOADED","init_Fncvwr_menu_star","Monky_funcs_inited",
"airborne_spawn_vehicle_infiSTAR","Metallica_infiSTAR_hax_toggled","LysticsCode","color_list_lystic","LOLTOGGLESHITNIT"]; //Banned variable names (e.g. an array called: HaxSmokeOn)

//Classname Blacklist
_Setting16 = false; //Detect player using Banned classnames ("true" is on, "false" is off, set to false by default)
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
_Setting15 = [["",""],["",""]]; //List of admin UID's and level, structure [UID,LEVEL] e.g. [["123456","SuperAdmin"],["789123","Admin"],["456789","Moderator"]] (options: "SuperAdmin", "Admin", "Moderator")

//Permanent BASIX Bans
_Setting18 = true; //Enable BASIX permanent ban system, be warned possible security risk if enabled ("true" is on, "false" is off, set to true by default)

//BASIX Mission Disable
_Setting19 = false; //Disable BASIX for certain missions defined by ".pbo" name e.g. "SuperBattle_V1.pbo" ("true" is on, "false" is off, set to false by default)
_Setting20 = [""]; //Disabled mission PBO files

//CheatEngine Injector Scans
_Setting21 = true; //Allow BASIX to scan for indications of someone Injecting using CheatEngine ("true" is on, "false" is off, set to true by default)

//Chat-Loging
_Setting26 = true; //Allow BASIX to store chat conversations ("true" is on, "false" is off, set to true by default)
_Setting27 = false; //Enable word and phrase filter ("true" is on, "false" is off, set to false by default)
_Setting28 = [""]; //Filter list, capitals don't matter (e.g. ["fuck","cunt","I will kill your dog"])

//Chat-Commands
_Setting29 = true; //Enable chat based commands, found in "fn_BASIX_COMMANDS.sqf" ("true" is on, "false" is off, set to true by default)

//Version Checker
_Setting30 = true; //Enable version checker ("true" is on, "false" is off, set to true by default)





//End Of Settings ** Do Not Edit Below This Point **
BASIX_SETTINGS = compileFinal (format ['_return = [%1,%2,%3,%4,%5,%6,%7,%8,%9,%10,%11,%12,%13,%14,%15,%16,%17,%18,%19,%20,%21,%22,%23,%24,%25,%26,%27,%28,%29,%30]; _return',_Setting1,_Setting2,_Setting3,_Setting4,_Setting5,_Setting6,_Setting7,_Setting8,_Setting9,_Setting10,_Setting11,_Setting12,_Setting13,_Setting14,_Setting15,_Setting16,_Setting17,_Setting18,_Setting19,_Setting20,_Setting21,_Setting22,_Setting23,_Setting24,_Setting25,_Setting26,_Setting27,_Setting28,_Setting29,_Setting30]);
publicVariable "BASIX_SETTINGS";