/*
    File: fn_lantern_onPlayerKilled.sqf
    Author: PiG13BR - https://github.com/PiG13BR
    Date: 19/10/2026
    Last Update: 23/10/2026
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Remove flashlight items if the player is killed

    Parameter(s):
        _player - player killed [OBJECT, defaults to player]

    Returns:
        -
*/
params["_player", ["_handler", -1, [0]]];

{deleteVehicle _x}forEach (_player getVariable ["PIG_latern_lightObjects", []]);
deleteVehicle (_player getVariable ["PIG_lantern_flashLightObject", objNull]);
_player setVariable ["PIG_lanternOn", nil];
_player setVariable ["PIG_latern_lightObjects", nil];
_player setVariable ["PIG_lantern_killedEH", nil];
_player removeEventHandler ["Killed", _handler];