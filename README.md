BASIX
=====

BASIX is a serverside addon developed to aid in the defence
against hackers ans script-kiddies, BASIX achieves this by
remotely sending code to each client that joins the server
which runs in the background until illegitimate activity is found.

Features:

- Runs completely serverside, this means no yellow question mark in the serverbrowser
- Highly configurable, BASIX comes with a configuration file to changes scan options
- Whitelist to prevent admins and VIP's being falsely detected as hacking
- When a player is detected as hacking they are kicked to the lobby and players alerted
- Players that get kicked by BASIX will not be able to reconnect until the server restarts



BASIX Options:
- Blacklisted addon files (PBO Files)
- Blacklisted variable names (Comes with some common Hack-Variables already configured)
- Blacklisted classnames, useful due to hackers being able to hide addon files (Comes with some common Hack-Classnames already configured)
- User defined speed limit (e.g. if someone goes 3000 kmh they are probably hacking)
- Blacklisted weapons (Useful for Life servers, e.g. you probably don't want people walking around with some missile launchers)
- Blacklisted vehicles (Same as the vehicle Blacklist except vehicles, e.g. Blacklist tanks, etc...)
- Anti-Teleport detection
- Small limited admin menu system

Installation Instructions:
1. Install C++ runtime from the link below
http://www.microsoft.com/en-nz/downl....aspx?id=40784
2. Extract the .zip folder contents into your ArmA 3 server directory
3. When prompted to merge the "Addons" folder click yes
4. Edit the settings in "BASIX_CONFIG\fn_BASIX_SETTINGS.sqf"
5. Start your server as normal, BASIX has been installed!
