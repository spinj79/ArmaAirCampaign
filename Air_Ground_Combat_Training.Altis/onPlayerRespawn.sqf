if ((paramsArray select 2) == 0) then {

	player addEventHandler ["Respawn", {player enableFatigue false}]; 
	player enableFatigue false;
	}; 

	
[player, [missionNamespace, "inventory_var"]] call BIS_fnc_loadInventory;
