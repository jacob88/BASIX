
class CfgPatches {
	class BASIX_config {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[]={};
		version = "1.0";
		versionStr = "1.0";
		versionAr[] = {1,0};
	};
};

class CfgFunctions
{
	class BASIX
	{
		class BASIX_CONFIG
		{
			file = "";
			class BASIX_SETTINGS
			{
				preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 0; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class BASIX_INIT
			{
				preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 0; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
		};
	};
};