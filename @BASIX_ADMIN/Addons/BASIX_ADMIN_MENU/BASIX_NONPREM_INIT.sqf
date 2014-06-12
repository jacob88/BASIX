if (isNil "BASIX_ISADMIN") exitWith {hint "BASIX_ERROR!";};
if ((call BASIX_ISADMIN) == "NotAdmin") exitWith
{
_reason = "Attempted Admin Access";
_reason spawn BASIX_KICK_ADD;
sleep 0.1;
endMission "LOSER";
};
if ((call BASIX_ISADMIN) == "SuperAdmin") then
{
_this execVM "\BASIX_ADMIN_MENU\BASIX_ADMIN_LEVELS\SuperAdmin.sqf";
};
if ((call BASIX_ISADMIN) == "Admin") then
{
_this execVM "\BASIX_ADMIN_MENU\BASIX_ADMIN_LEVELS\Admin.sqf";
};
if ((call BASIX_ISADMIN) == "Moderator") then
{
_this execVM "\BASIX_ADMIN_MENU\BASIX_ADMIN_LEVELS\Moderator.sqf";
};