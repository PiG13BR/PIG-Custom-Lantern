/*
    File: fn_lantern_perFrame.sqf
    Author: PiG13BR - https://github.com/PiG13BR
    Date: 19/10/2026
    Last Update: 23/10/2026
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Update light source vector

    Parameter(s):
        -

    Returns:
        -
*/
params["_light", "_reflector", "_dir", "_yam"];

[_light, _dir, _yam] call PIG_fnc_lantern_adjust;
[_reflector, _dir, _yam] call PIG_fnc_lantern_adjust;