#TODO: turn this into a base class which Ailment and Effect inherit from to improve modularity
class_name unitAilment
extends RefCounted

var ailm_name: String = "";
var ailm_desc: String = "";

# AILMENT PROPERTIES
var ailm_turn_range := Vector2i(2, 6);
var ailm_hp_damage: int = 0;
var ailm_sp_damage: int = 0;
var ailm_damage_dealt_multiplier: int = 100;
var ailm_damage_taken_multiplier: int = 100;
var ailm_raw_stat_multiplier: PackedInt32Array = [100,100,100,100,100];
var ailm_hit_multiplier: PackedInt32Array = [100,100,100,100,100,100];
var ailm_crit_multiplier: PackedInt32Array = [100,100,100,100,100,100];
var ailm_eva_multiplier: int = 100;
var ailm_on_expire: int = 0;

# CURRENT VARIABLES (rename?)
var _turns_left: int = 0;

func get_turn_counter() -> int:
	return max(0, self._turns_left); # Ensure that _turns_left can't go below 0
	
func turn_count_expired_effects() -> void:
	if(self.ailm_on_expire == 0):
		return;
	else:
		print("TO DO: " + self.ailm_name + " expired effect");

func decrement_counter() -> void:
	self._turns_left -= 1;
