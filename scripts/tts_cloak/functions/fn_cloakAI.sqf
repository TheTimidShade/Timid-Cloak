/*
	Author: TheTimidShade

	Description:
		Puts an AI unit in cloaked state for the given number of seconds.

	Parameters:
		0: OBJECT - Unit to be cloaked.
		1: (OPTIONAL) NUMBER - Duration of cloak state in seconds. (Default 30s)
		
	Returns:
		NOTHING

	Execution:
		Should be executed on server or host player but can be executed from any client in MP game.
	
	Example:
		[unit_1, 10] spawn tts_cloak_fnc_cloakAI;
*/

params [
	["_unit", objNull, [objNull]],
	["_duration", 30, [0]]
];

if (isNull _unit) exitWith {};

if (_unit getVariable ["tts_cloak_isCloaked", false]) exitWith {}; // if the unit is already cloaked exit

_unit setVariable ["tts_cloak_isCloaked", true, true]; // set cloak variable to true
[_unit, true] remoteExec ["hideObjectGlobal", 2, false]; // make the unit invisible
_unit setCaptive true; // prevent AI from targeting invisible unit

// play cloak in sound
if (tts_cloak_playSounds) then {
	[_unit, "cloak_engage"] remoteExec ["say3D", 0, false];
};

// create cloak transition particles
[_unit] remoteExec ["tts_cloak_fnc_cloakTransition", 0, false];

// create cloak particles
[_unit] remoteExec ["tts_cloak_fnc_cloakParticles", 0, false];

sleep _duration;

_unit setVariable ["tts_cloak_isCloaked", false, true]; // decloak unit

// create cloak transition particles
[_unit] remoteExec ["tts_cloak_fnc_cloakTransition", 0, false];

// play cloak out sound
if (tts_cloak_playSounds) then {
	[_unit, "cloak_disengage_hot"] remoteExec ["say3D", 0, false];
};

[_unit, false] remoteExec ["hideObjectGlobal", 2, false]; // make the unit visible
_unit setCaptive false; // allow AI targeting again