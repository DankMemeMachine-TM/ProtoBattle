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
var skill_target;

var skill_base_power: int = 0;
var skill_crit_power: int = 0; # If an attack crits, use this power instead
var skill_base_hit: int = 0;
var skill_base_crit: int = 0;
var skill_total_hits := Vector2i(1,1);
var skill_sp_cost: int = 0;
var skill_death_type;
var skill_priority: int = 0; # Used for determining turn order, in "brackets"
var skill_ailments: Array = [];
var skill_effects: Array = [];
var skill_stat_changes := Vector3i(0,0,0); # Each value can range from -8 to 8

var skill_after_use;

var skill_anim_base;
var skill_anim_fx;

func init(name: String = "") -> skill:
	self.base_name = name;
	return self;
