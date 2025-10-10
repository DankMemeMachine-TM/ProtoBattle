'''
BattleCalcs.tscn

For organizational purposes, all main battle calculations are included in their own node. Otherwise,
Battle.tscn would be like a quadrillion lines and an utter pain to work with.
'''
extends Node

var charge_mod: int = 1; # Increased by effects (Charge: +1.5)

## skill: The skill being used for calculations.
## attacker: The unit using skill.
## defenders: Every unit being targeted by the attack. TODO: what to do for random attacks
func attack_init(use_skill, attacker, defenders: Array) -> void:
	for n in defenders:
		damage_processing(use_skill, attacker, n);
	
func damage_processing(use_skill, active, passive):
	get_attack_mod(use_skill, active);
	calculate_base_damage(use_skill, active, passive);
	pass; #TODO
	
func get_attack_mod(use_skill, active):
	return 0;

func calculate_base_damage(use_skill, active, passive) -> int:
	var _skill_power = 16; #TODO
	var _base_damage = (_skill_power * 7) / 192;
	return _base_damage;
