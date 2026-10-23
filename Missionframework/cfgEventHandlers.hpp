class Extended_PreInit_EventHandlers
{
    PIG_lantern_postInit = "PIG_fnc_lantern_postInit = compile preprocessFileLineNumbers 'Functions\Lantern\fn_lantern_postInit.sqf'";
};
class Extended_PostInit_EventHandlers {
    class Custom_Lantern {
        init = "[] call PIG_fnc_lantern_postInit";
    };
};