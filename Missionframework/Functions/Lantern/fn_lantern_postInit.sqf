#include "\a3\editor_f\Data\Scripts\dikCodes.h"
/*
    File: fn_lantern_postInit.sqf
    Author: PiG13BR - https://github.com/PiG13BR
    Date: 19/10/2026
    Last Update: 23/10/2026
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Custom lantern post init

    Parameter(s):
        -

    Returns:
        -
*/
["PIG_lantern_turnedOnOff", {
    if (!(isNull objectParent _this) && !(_this getVariable ["PIG_lantern_isOn", false])) exitWith {};
    _this call PIG_fnc_lantern_onOff
}] call CBA_fnc_addEventHandler;

["PIG_lantern_adjust", {
    _this call PIG_fnc_lantern_perFrame
}] call CBA_fnc_addEventHandler;

if (hasInterface) then {
    spawn {
        waitUntil {!isNull player};

        // addMissionEventHandler ["EachFrame", {[] call PIG_fnc_lantern_perFrame;}];
        //[{[] call PIG_fnc_lantern_perFrame;}] call CBA_fnc_addPerFrameHandler;
        
        private _id = player getVariable ["PIG_keyHandlerID", ""];
        if (_id != "") then {
            _id call CBA_fnc_removeKeyHandler;
        };

        // L (press for 1 secound)
        private _id = [DIK_L, [false, false, false], {["PIG_lantern_turnedOnOff", player] call CBA_fnc_globalEvent}, "keydown", "L_KEY_FLASHLIGHT", false, 1] call CBA_fnc_addKeyHandler;
        player setVariable ["PIG_keyHandlerID", _id];

        // Force turn off flashlights on entering vehicle
        player addEventHandler ["GetInMan", {
            if (player getVariable ["PIG_lantern_isOn", false]) then {
                ["PIG_lantern_turnedOnOff", player] call CBA_fnc_globalEventJIP
            };
        }];
    }
};