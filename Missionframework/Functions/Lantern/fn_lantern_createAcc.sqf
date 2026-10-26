/*
    File: fn_lantern_onPlayerKilled.sqf
    Author: PiG13BR - https://github.com/PiG13BR
    Date: 19/10/2026
    Last Update: 26/10/2026
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Remove flashlight items if the player is killed

    Parameter(s):
        _player - player killed [OBJECT, defaults to player]

    Returns:
        -
*/
params["_player"];

// Create flashlight on the shoulder
private _flashlight = createVehicle ["item_acc_flashlight", position _player, [], 0, "CAN_COLLIDE"];
_player setVariable ["PIG_lantern_flashLightObject", _flashlight, true];
_flashlight setVariable ["PIG_lantern_playerRefer", _player, true];

_flashlight attachTo [_player, [0.08, 0.03, 0.70], "leftShoulder"];
_flashlight enablesimulation false;

_yPos = -90; // Flashlight yam
_p = 0; _r = 5;
_flashlight setVectorDirAndUp [
    [ sin _yPos * cos _p ,cos _yPos * cos _p, sin _p],
    [ [ sin _r, -sin _p, cos _r * cos _p], -_yPos] call BIS_fnc_rotateVector2D
];

[_flashlight, false] call ace_dragging_fnc_setCarryable;
[_flashlight, false] call ace_dragging_fnc_setDraggable;

_flashlight addEventHandler ["Deleted", {
    params["_object"];
    {deletevehicle _x}forEach attachedObjects _object;
    private _player = _object getVariable ["PIG_lantern_playerRefer", player];
    _player call PIG_fnc_lantern_createAcc;
}];

// Removal of ace inventory interaction (taken from ace_interact_menu_fnc_removeactionfromclass)
[{
    private _actionTrees = ace_interact_menu_ActNamespace getOrDefault [typeof _this, []];
    private _parentNode = [_actionTrees, ["ACE_MainActions", "ace_interaction_Gear"]] call ace_interact_menu_fnc_findActionNode;

    {
        if (_x # 0 == "ace_interaction_Gear") then {
            // Force action condition to false
            _x set [4, {false}]
        };
    }forEach _parentNode;
}, _flashlight, 1] call CBA_fnc_waitAndExecute;