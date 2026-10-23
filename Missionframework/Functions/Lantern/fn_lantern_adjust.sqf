/*
    File: fn_lantern_adjust.sqf
    Author: PiG13BR - https://github.com/PiG13BR
    Date: 19/10/2026
    Last Update: 23/10/2026
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Adjust lantern vector dir and up

    Parameter(s):
        _object - Object for cargo clearing [OBJECT, defaults to objNull]

    Returns:
        Function reached the end [BOOL]
*/
params ["_lamp","_pitch", "_yam"];

private _dirUp = [
    [[0,1,0],[0,0,cos _pitch]],
    0,
    _pitch,
    0
] call BIS_fnc_transformVectorDirAndUp;

// Yam correction
_dirUp = [
    _dirUp,
    _yam,
    0,
    0
] call BIS_fnc_transformVectorDirAndUp;

_lamp setVectorDirAndUp _dirUp;