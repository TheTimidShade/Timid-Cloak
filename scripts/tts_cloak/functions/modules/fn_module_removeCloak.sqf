// ZEUS ENHANCED ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if (isClass (configFile >> "CfgPatches" >> "zen_main")) then {
	["TTS Cloaking", "Remove Cloak",
	{
		params [["_position", [0,0,0], [[]], 3], ["_attachedObject", objNull, [objNull]]];

		if (isNull _attachedObject || !(_attachedObject isKindOf "AllVehicles")) exitWith {
			["Must be placed on a unit or vehicle!"] call zen_common_fnc_showMessage;
		};

		[_attachedObject] remoteExec ["tts_cloak_fnc_removeCloak", _attachedObject, false];
	}, "scripts\tts_cloak\icons\cloak_remove.paa"] call zen_custom_modules_fnc_register;
};