'''
skill.gd

This contains the basic data for skills, such as actions, techs, etc. 
'''
class_name skill
extends RefCounted

var base_name: String = "";
var base_desc: String = ""; # Explains what exactly the skill does
var base_flavor: String = ""; # Flavor text with no gameplay mechanics mentioned

var skill_type := gSkill.AttackType.MELEE; # Melee/Gun/Psyonic
var skill_arm := gSkill.Armed.UNARMED; # Doesn't matter for Psyonic attacks (default to Unarmed)
var skill_element := gSkill.Element.TYPELESS;
var skill_range := gSkill.SkillRange.MELEE;

var skill_base_power: int = 0;
var skill_crit_power: int = 0; # If an attack crits, use this power instead
var skill_base_hit: int = 0;
var skill_base_crit: int = 0;
var skill_ailments: Array = [];

var skill_sp_cost: int = 0;

func init() -> skill:
	return self;
