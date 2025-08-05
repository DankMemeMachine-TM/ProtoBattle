class_name unitCharacter
extends Node2D

const MAX_STAT_CHANGE = 4;
const MIN_STAT_CHANGE = -4;

var base_name: String = "";
var base_desc: String = "";
var base_sex := gCharacter.Sex.NONE;
var base_innate := gCharacter.Innate.ALPHA;

var base_max_hp: int = 0;
var base_max_sp: int = 0;
var base_raw_stats: PackedByteArray = [0,0,0,0,0];
var base_attack: PackedInt32Array = [0,0,0,0,0,0];
var base_hit_rate: PackedByteArray = [0,0,0,0,0,0];
var base_crit_rate: PackedByteArray = [0,0,0,0,0,0];
var base_evasion: int = 0;
var base_element_property: PackedByteArray = gInnate.INNATE_NONE;
var base_weak_mod: PackedInt32Array = gCharacter.DEFAULT_WEAK_MOD;
var base_resist_mod: PackedInt32Array = gCharacter.DEFAULT_RESIST_MOD;
var base_element_armor: PackedInt32Array = gCharacter.DEFAULT_ELEMENT_ARMOR;
var base_attack_armor: PackedInt32Array = gCharacter.DEFAULT_ATTACK_ARMOR;

var total_max_hp: int = 0;
var total_max_sp: int = 0;
var total_raw_stats: PackedByteArray = [0,0,0,0,0];
var total_attack: PackedInt32Array = [0,0,0,0,0,0];
var total_hit_rate: PackedByteArray = [0,0,0,0,0,0];
var total_crit_rate: PackedByteArray = [0,0,0,0,0,0];
var total_evasion: int = 0;
var total_element_property: PackedByteArray = gInnate.INNATE_NONE;
var total_weak_mod: PackedInt32Array = gCharacter.DEFAULT_WEAK_MOD;
var total_resist_mod: PackedInt32Array = gCharacter.DEFAULT_RESIST_MOD;
var total_element_armor: PackedInt32Array = gCharacter.DEFAULT_ELEMENT_ARMOR;
var total_attack_armor: PackedInt32Array = gCharacter.DEFAULT_ATTACK_ARMOR;

var current_level: int = 0;
var current_hp: int = 0;
var current_sp: int = 0;
var current_attack_power: PackedInt32Array = [0,0,0,0,0,0]; # Stored here so it does not need to be re-calculated every time
var _current_ailments: Array = []; #TODO
var _current_effects: Array = []; #TODO
var _stat_changes := Vector3i(0,0,0);

func _ready() -> void:
	recalculate_stats();
	print(self.get_stat_change(0));
	print(self.get_stat_change(1));
	print(self.get_stat_change(2));
	print(self.get_stat_change(3));

func init() -> void:
	recalculate_stats();
	self.current_hp = self.total_max_hp;
	self.current_sp = self.total_max_sp;
	
#####################
## HP/SP FUNCTIONS ##
#####################
func reduce_hp(value: int) -> void:
	self.current_hp = clamp(self.current_hp - value, 0, self.total_max_hp);
	if(self.current_hp <= 0):
		die();
		
# FUNCTION USED FOR HANDLING SP COSTS
func reduce_sp(value: int) -> void:
	self.current_sp = clamp(self.current_sp - value, 0, self.total_max_sp);
	
func die() -> void:
	self.current_hp = 0;
	#self.add_ailment(ailmData.DEATH);
	#TODO: add death logic

####################
## STAT FUNCTIONS ##
####################
func recalculate_stats() -> void:
	self.total_max_hp = calculate_max_hp();
	self.total_max_sp = calculate_max_sp();
	self.total_raw_stats = calculate_raw_stats();
	self.total_attack = calculate_attack();
	self.total_hit_rate = calculate_hit_rate();
	self.total_crit_rate = calculate_crit_rate();
	self.total_evasion = calculate_evasion();
	
func calculate_max_hp() -> int:
	var value: int = self.base_max_hp;
	return value if (value > 0) else 1;
	
func calculate_max_sp() -> int:
	var value: int = self.base_max_sp;
	return value if (value >= 0) else 0;
	
func calculate_raw_stats() -> PackedByteArray:
	var _raw_array: PackedByteArray = [0,0,0,0,0];
	for n in 5:
		_raw_array[n] = self.base_raw_stats[n];
	return _raw_array;
	
func calculate_attack() -> PackedInt32Array:
	var _attack_array: PackedInt32Array = [0,0,0,0,0,0];
	for n in 6:
		_attack_array[n] = self.base_attack[n];
	return _attack_array;
	
func calculate_hit_rate() -> PackedByteArray:
	return self.base_hit_rate;
	
func calculate_crit_rate() -> PackedByteArray:
	return self.base_crit_rate;
	
func calculate_evasion() -> int:
	return clamp(self.base_evasion, gCharacter.UNIT_MIN_EVASION, gCharacter.UNIT_MAX_EVASION);
	
func calculate_attack_powers() -> void:
	var _level_mod: float = self.current_level * 0.7;
	self.calculate_strength_attack_powers(_level_mod);
	self.calculate_skill_attack_powers(_level_mod);
	self.calculate_psyonic_attack_powers(_level_mod);
	
func calculate_strength_attack_powers(level_mod: float = 0.0) -> void:
	var _str_mod: float = (self.total_raw_stats[gCharacter.Raw.STR] * 2);
	self.current_attack_power[gSkill.AttackStat.MELEE_WEAPON] = floor(_str_mod + level_mod + self.total_attack[gSkill.AttackStat.MELEE_WEAPON]);
	self.current_attack_power[gSkill.AttackStat.MELEE_UNARMED] = floor(_str_mod + level_mod + self.total_attack[gSkill.AttackStat.MELEE_UNARMED]);
	
func calculate_skill_attack_powers(level_mod: float = 0.0) -> void:
	var _skl_mod: float = (self.total_raw_stats[gCharacter.Raw.SKL] * 1.5);
	self.current_attack_power[gSkill.AttackStat.GUN_WEAPON] = floor(_skl_mod + level_mod + self.total_attack[gSkill.AttackStat.GUN_WEAPON]);
	self.current_attack_power[gSkill.AttackStat.GUN_UNARMED] = floor(_skl_mod + level_mod + self.total_attack[gSkill.AttackStat.GUN_UNARMED]);
	
func calculate_psyonic_attack_powers(level_mod: float = 0.0) -> void:
	var _psy_mod: float = (self.total_raw_stats[gCharacter.Raw.PSY] * 2);
	self.current_attack_power[gSkill.AttackStat.PSYONIC_TECH] = floor(_psy_mod + level_mod + self.total_attack[gSkill.AttackStat.PSYONIC_TECH]);
	self.current_attack_power[gSkill.AttackStat.PSYONIC_SHARD] = floor(_psy_mod + level_mod + self.total_attack[gSkill.AttackStat.PSYONIC_SHARD]);
	
######################
## BATTLE FUNCTIONS ##
######################
# AILMENTS #
func check_for_ailment(input: unitAilment) -> bool:
	if(self._current_ailments.has(input)):
		return true;
	return false;
	
func add_ailment(input: unitAilment) -> void:
	if(!self.check_for_ailment(input)):
		self._current_ailments.append(input);
		
func remove_ailment(input: unitAilment) -> void:
	if(!self.check_for_ailment(input)):
		self._current_ailments.erase(input);
		
func decrement_ailment_turn_counters() -> void:
	var _counter = 0;
	while _counter < self._current_ailments.size():
		var temp = _current_ailments[_counter];
		temp.decrement_counter();
		if (temp.get_turn_counter() <= 0):
			temp.turn_count_expired_effects();
			self.remove_ailment(temp);
		else:
			_counter += 1;
		
func clear_ailments() -> void:
	self._current_ailments.clear();
	
# EFFECTS #
#TODO: Replace "Object" with "unitEffect" once it is implemented
func check_for_effect(input: Object) -> bool:
	if(self._current_effects.has(input)):
		return true;
	return false;
	
func add_effect(input: unitAilment) -> void:
	if(!self.check_for_effect(input)):
		self._current_effects.append(input);
		
func remove_effect(input: unitAilment) -> void:
	if(!self.check_for_effect(input)):
		self._current_effects.erase(input);
		
func decrement_effect_turn_counters() -> void:
	var _counter = 0;
	while _counter < self._current_effects.size():
		var temp = _current_effects[_counter];
		temp.decrement_counter();
		if (temp.get_turn_counter() <= 0):
			temp.turn_count_expired_effects();
			self.remove_ailment(temp);
		else:
			_counter += 1;
		
func clear_effects() -> void:
	self._current_effects.clear();
	
# STAT CHANGES #
func get_stat_change(input: int) -> int:
	match(input):
		0:
			return clamp(self._stat_changes.x, -4, 4);
		1:
			return clamp(self._stat_changes.y, -4, 4);
		2:
			return clamp(self._stat_changes.z, -4, 4);
		_:
			print("Node Character: get_stat_change(): ", input, " is out of range. Returing 0...");
			return 0;
		
	
func change_stat(input := Vector3i(0,0,0)):
	self._stat_changes.x = clamp(self.stat_changes.x + input.x, MIN_STAT_CHANGE, MAX_STAT_CHANGE);
	self._stat_changes.y = clamp(self.stat_changes.y + input.y, MIN_STAT_CHANGE, MAX_STAT_CHANGE);
	self._stat_changes.z = clamp(self.stat_changes.z + input.z, MIN_STAT_CHANGE, MAX_STAT_CHANGE);

func clear_stat_changes() -> void:
	self._stat_changes.x = 0;
	self._stat_changes.y = 0;
	self._stat_changes.z = 0;
