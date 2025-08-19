'''
player.gd

!NOTE: Currently, this entire file is a WIP.
This file contains functions for player characters, such as override functions to make sure their equipment
gets factored into their stats.
'''
#TODO: change stat functions to be based off equipment
class_name unitPlayer
extends unitCharacter

var _player_current_equipment: Array[RefCounted] = [null, null, null, null];

####################
## INITIALIZATION ##
####################
func init(name: String = "", desc: String = "", sex := gCharacter.Sex.NONE, innate := gCharacter.Innate.FIRE,
	max_hp: int = 1, max_sp: int = 0, raw_stats: PackedByteArray = [0,0,0,0,0],
	attack: PackedInt32Array = [0,0,0,0,0,0], hit: PackedByteArray = [0,0,0,0,0,0], crit: PackedByteArray = [0,0,0,0,0,0],
	evasion: int = 0, e_prop: PackedByteArray = gCharacter.DEFAULT_ELEMENT_PROPERTY.duplicate(),
	e_weak_mod: PackedInt32Array = gCharacter.DEFAULT_WEAK_MOD.duplicate(),
	e_resist_mod: PackedInt32Array = gCharacter.DEFAULT_RESIST_MOD.duplicate(),
	element_armor: PackedInt32Array = gCharacter.DEFAULT_ELEMENT_ARMOR.duplicate(),
	attack_armor: PackedInt32Array = gCharacter.DEFAULT_ATTACK_ARMOR.duplicate()) -> unitCharacter:
	self.base_name = name;
	self.base_desc = desc;
	self.base_sex = sex;
	self.base_innate = innate;
	self.base_max_hp = max_hp;
	self.base_max_sp = max_sp;
	self.base_raw_stats = raw_stats;
	self.base_attack = attack;
	self.base_hit_rate = hit;
	self.base_crit_rate = crit;
	self.base_evasion = evasion;
	self.base_element_property = e_prop;
	self.base_weak_mod = e_weak_mod;
	self.base_resist_mod = e_resist_mod;
	self.base_element_armor = element_armor;
	self.base_attack_armor = attack_armor;
	recalculate_stats();
	self.current_hp = self.total_max_hp;
	self.current_sp = self.total_max_sp;
	return self;

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
