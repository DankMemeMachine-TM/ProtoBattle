class_name unitCharacter
extends Node2D

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
var base_element_property: PackedByteArray; #TODO
var base_weak_mod: PackedInt32Array; #TODO
var base_resist_mod: PackedInt32Array; #TODO
var base_element_armor: PackedInt32Array; #TODO
var base_attack_armor: PackedInt32Array; #TODO

var total_max_hp: int = 0;
var total_max_sp: int = 0;
var total_raw_stats: PackedByteArray = [0,0,0,0,0];
var total_attack: PackedInt32Array = [0,0,0,0,0,0];
var total_hit_rate: PackedByteArray = [0,0,0,0,0,0];
var total_crit_rate: PackedByteArray = [0,0,0,0,0,0];
var total_evasion: int = 0;
var total_element_property: PackedByteArray; #TODO
var total_weak_mod: PackedInt32Array; #TODO
var total_resist_mod: PackedInt32Array; #TODO
var total_element_armor: PackedInt32Array; #TODO
var total_attack_armor: PackedInt32Array; #TODO

var current_hp: int = 0;
var current_sp: int = 0;
var current_ailemnts: Array = []; #TODO
var current_effects: Array = []; #TODO
var stat_changes := Vector3i(0,0,0);

func _ready() -> void:
	recalculate_stats();
	print(self.total_max_hp);

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
	return value if (value > 0) else 1;
	
func calculate_raw_stats() -> PackedByteArray:
	return self.base_raw_stats;
	
func calculate_attack() -> PackedInt32Array:
	return self.base_attack;
	
func calculate_hit_rate() -> PackedByteArray:
	return self.base_hit_rate;
	
func calculate_crit_rate() -> PackedByteArray:
	return self.base_crit_rate;
	
func calculate_evasion() -> int:
	return self.base_evasion;
