/*
    File: fn_lantern_onOff.sqf
    Author: PiG13BR - https://github.com/PiG13BR
    Date: 19/10/26
    Last Update: 23/10/2026
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Turn lantern on/off
        Some frameworks was taken from Shoulder-mounted Light and MrSanchez' Headlamps

    Parameter(s):
        _player - player that wants to turn on/off the lantern [OBJECT, defaults to player]

    Returns:
        -
*/
params[["_player", player, [objNull]]];

if (_player getVariable ["PIG_lantern_isOn", false]) then {

    // Turn off
    if (_player == player) then {
        playSound "CustomLaternOnOff";
        private _killedEH = player getVariable ["PIG_lantern_killedEH", -1];
        player removeEventHandler ["Killed", _killedEH];
    };
    {deleteVehicle _x}forEach (_player getVariable ["PIG_latern_lightObjects", []]);
    _player setVariable ["PIG_lantern_isOn", false];
    _player setVariable ["PIG_latern_lightObjects", []];
} else {

    // Turn On/Create
    private _flashlight = _player getVariable ["PIG_lantern_flashLightObject", objNull];

    if (isNull _flashlight) exitWith {};

    private _reflector = "#lightreflector" createVehicleLocal [0, 0, 0];
    _reflector attachTo [_flashlight,[0.6, 0.05, -0.62]];
    _reflector setLightColor [0.95,0.91,0.42];
    _reflector setLightAmbient [0.95,0.91,0.42];
    _reflector setLightIntensity 12000;
    _reflector setLightConePars [30, 20, 1];
    _reflector setLightAttenuation [2,4,50,0,0.5,400];
    private _vector3D = [[[0, 1, 0], [0, 0, 1]], -90, -5, 0] call BIS_fnc_transformVectorDirAndUp;
    _reflector setVectorDirAndUp _vector3D;

    private _light = "#lightpoint" createVehicleLocal [0, 0, 0];
    _light attachTo [_flashlight,[0.08, 0.05, -0.62]];
    _light setLightColor [0.95,0.91,0.42];
    _light setLightAmbient [0.95,0.91,0.42];
    _light setLightUseFlare true;
    _light setLightFlareSize 0.6;
    _light setLightFlareMaxDistance 20;
    _light setLightAttenuation [0.8,2,10,0,1,3];
    _light setLightBrightness 20;
    _light setLightIntensity 5;
    
    private _yam = -90;
    addMissionEventHandler ["EachFrame", {
        _thisArgs params ["_player", "_light", "_reflector", "_yam"];

        if (!alive _light || !alive _player) then {removeMissionEventHandler [_thisEvent, _thisEventHandler];};
        //["PIG_lantern_adjust", [_light, _reflector,((getCameraViewDirection _player) # 2) * 90, _yam]] call CBA_fnc_globalEvent;
        [_light, _reflector,((getCameraViewDirection _player) # 2) * 90, _yam] call PIG_fnc_lantern_perFrame;
    }, [_player, _light, _reflector, _yam]];

    if (_player == player) then {
        playSound "CustomLaternOnOff";

        _handler = player addEventHandler ["killed", {
            params["_unit"];
            [_unit, _thisEventHandler] call PIG_fnc_lantern_onPlayerKilled;
        }];
        _player setVariable ["PIG_lantern_killedEH", _handler];
    };
    
    _player setVariable ["PIG_latern_lightObjects", [_reflector, _light]];

    _player setVariable ["PIG_lantern_isOn", true];
};