hint "Click on the map where you'd like to HALO jump.";
openMap true;

onMapSingleClick {
	onMapSingleClick {};
	player setpos _pos; 
	[player, 2000, false, false, true] call COB_fnc_HALO;
	hint '';
	openMap false;
	true
};