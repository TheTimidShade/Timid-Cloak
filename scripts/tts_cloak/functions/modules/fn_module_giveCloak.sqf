// ZEUS ENHANCED ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if (isClass (configFile >> "CfgPatches" >> "zen_main")) then {
	["TTS Cloaking", "Give Cloak",
	{
		params [["_position", [0,0,0], [[]], 3], ["_attachedObject", objNull, [objNull]]];

		if (isNull _attachedObject || !isPlayer _attachedObject) exitWith {
			["Must be placed on a player unit!"] call zen_common_fnc_showMessage;
		};

		[
			"Give Unit Cloak", // title
		 	[ // array of controls for dialog
				["EDIT", ["Cloak max duration", "Maximum time unit can be cloaked before uncloaking"],
					[ // control args
						str 30, // default text
						{}, // sanitise function
						1 // edit box height (only for multi line)
					],
					false // force default
				],
				["EDIT", ["Cloak cooldown", "Cooldown period required after uncloak before unit can cloak again"],
					[ // control args
						str 60, // default text
						{}, // sanitise function
						1 // edit box height (only for multi line)
					],
					false // force default
				]
			],
			{ // code run on dialog closed (only run if OK is clicked)
				params ["_dialogResult", "_args"];
				_args params ["_attachedObject"];
				
				[_attachedObject, parseNumber (_dialogResult#0), parseNumber (_dialogResult#1)] remoteExec ["tts_cloak_fnc_giveCloak", _attachedObject, false];
			}, {}, [_attachedObject] // args
		] call zen_dialog_fnc_create;
	}, "scripts\tts_cloak\icons\cloak_man.paa"] call zen_custom_modules_fnc_register;
};