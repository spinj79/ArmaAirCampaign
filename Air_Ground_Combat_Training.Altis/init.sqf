[] execVM "bon_recruit_units\init.sqf";
fn_ftravel = compile preprocessFile "scripts\fn_ftravel.sqf";



//Setting Up Parameters
_Ocast 	= 0;
_Rain 	= 0;
_Fog 	= 0;
_TOD 	= 0;
_weather= 0;

//Grabbing parameter values
_TOD = (paramsarray select 0);
_weather = (paramsarray select 1);
_fatigue = (paramsarray select 2);
_maxView = (paramsarray select 3);
//_locationParam = (paramsarray select 4);
_timeMult = (paramsarray select 5);
_civEnable = (paramsarray select 4);





if (_TOD == 24) then {_TOD = (floor random 23) +1};			//If random is selected this chooses a random value
if (_weather == 5) then {_weather = (floor random 4) + 1};  //If random is selected this chooses a random value

//Setting new Time of Day
skipTime (((_TOD) - daytime + 24) % 24);

setTimeMultiplier _timeMult;

setViewDistance _maxView;
setObjectViewDistance _maxView;

	
//Dealing with weather bullshit GOD DAMN fog
sleep 1;
0 setFog [0,0,0];
sleep 1;



switch (_weather) do {
	case 1: {skipTime -24; 86400 setOvercast 0;skipTime 24};
	case 2: {skipTime -24; 86400 setOvercast 1; skipTime 24};
	case 3: {skipTime -24; 86400 setOvercast .75;skipTime 24};
	case 4; {0 setFog 1};

};
if (_weather == 1) then {0 setFog [0,0,0]}; //Attemping to fix the damn fog


//New Respawn Stuff


_WestCarrierPos = getPos WCarrier;
_WestCarrierPos = [(_WestCarrierPos select 0),(_WestCarrierPos select 1),(_WestCarrierPos select 2) + 24];
_EastCarrierPos = getPos ECarrier;
_EastCarrierPos = [(_EastCarrierPos select 0),(_EastCarrierPos select 1),(_EastCarrierPos select 2) + 24];


//[getPos WCarrier select 0, getPos WCarrier select 1, getPos WCarrier select 2, +20]
if (isServer) then{
[west,_WestCarrierPos , "USS Freedom"] call BIS_fnc_addRespawnPosition;
[west,_EastCarrierPos , "USS Democracy"] call BIS_fnc_addRespawnPosition;
[west, "ftravel_PassengerTerminal", "Passenger Terminal"] call BIS_fnc_addRespawnPosition;
[west, "comm_outpost", "Comm Station"] call BIS_fnc_addRespawnPosition;
[west, "ftravel_groundwar", "Ground War Center"] call BIS_fnc_addRespawnPosition;
};


//Civilian Shit

call compile preprocessFileLineNumbers "Engima\Civilians\Common\Common.sqf";
call compile preprocessFileLineNumbers "Engima\Civilians\Common\Debug.sqf";

// The following constants may be used to tweak behaviour

ENGIMA_CIVILIANS_SIDE = civilian;      // If you for some reason want the units to spawn into another side.
ENGIMA_CIVILIANS_MINSKILL = 0.4;       // If you spawn something other than civilians, you may want to set another skill level of the spawned units.
ENGIMA_CIVILIANS_MAXSKILL = 0.6;       // If you spawn something other than civilians, you may want to set another skill level of the spawned units.

ENGIMA_CIVILIANS_MAXWAITINGTIME = 300; // Maximum standing still time in seconds
ENGIMA_CIVILIANS_RUNNINGCHANCE = 0.05; // Chance of running instead of walking

// Civilian personalities
ENGIMA_CIVILIANS_BEHAVIOURS = [
	["CITIZEN", 100] // Default citizen with ordinary behaviour. Spawns in a house and walks to another house, and so on...
];

// Do not edit anything beneath this line!

ENGIMA_CIVILIANS_INSTANCE_NO = 0;

if ((isServer) && (_civEnable == 1)) then {
	call compile preprocessFileLineNumbers "Engima\Civilians\Server\ServerFunctions.sqf";
	call compile preprocessFileLineNumbers "Engima\Civilians\ConfigAndStart.sqf";
};


//End Civilian Shit






