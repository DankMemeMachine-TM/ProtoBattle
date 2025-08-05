'''
player.gd

!NOTE: Currently, this entire file is a WIP.
This file contains functions for player characters, such as override functions to make sure their equipment
gets factored into their stats.
'''
#TODO: change stat functions to be based off equipment
extends unitCharacter

var _player_current_equipment: Array[RefCounted] = [null, null, null, null];

####################
## STAT FUNCTIONS ##
####################
func calculate_max_hp() -> int:
	var value: int = self.base_max_hp;
	return clamp(value, gCharacter.UNIT_MIN_HP, gCharacter.PLAYER_MAX_HP);
	
func calculate_max_sp() -> int:
	var value: int = self.base_max_sp;
	return clamp(value, gCharacter.UNIT_MIN_SP, gCharacter.PLAYER_MAX_SP);
	
func calculate_raw_stats() -> PackedByteArray:
	var _raw_array: PackedByteArray = [0,0,0,0,0];
	for n in 5:
		var _equip_raw_stat: int = 0;
		for x in 4:
			if(self._player_current_equipment[x] != null): _equip_raw_stat += self._player_current_equipment[x].get_raw_stat(n);
		_raw_array[n] = self.base_raw_stats[n] + _equip_raw_stat;
	return _raw_array;
	
func calculate_attack() -> PackedInt32Array:
	var _attack_array: PackedInt32Array = [0,0,0,0,0,0];
	for n in 6:
		_attack_array[n] = self.base_attack[n];
	return _attack_array;
	
func calculate_hit_rate() -> PackedByteArray:
	#var _hit_array: PackedByteArray = [0,0,0,0,0,0];
	return self.base_hit_rate;
	
func calculate_crit_rate() -> PackedByteArray:
	#var _crit_array: PackedByteArray = [0,0,0,0,0,0];
	return self.base_crit_rate;
	
func calculate_evasion() -> int:
	var _total: int = self.base_evasion;
	var _equip_evasion: int = 0;
	for x in 4:
		if(self._player_current_equipment[x] != null): _equip_evasion += self._player_current_equipment[x].get_evasion();
	_total += _equip_evasion;
	return clamp(_total, gCharacter.UNIT_MIN_EVASION, gCharacter.UNIT_MAX_EVASION);
