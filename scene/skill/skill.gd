'''
skill.gd

This contains the basic class for skills, such as actions, techs, etc. 
Probably not the most efficient way to do this, but it'll at least work
for a small prototype like this. Will definitely be looking into
possibly better solutions for bigger projects...
'''
class_name skill
extends RefCounted

var skill_base_name: String = "";
var skill_base_desc: String = ""; # Explains what exactly the skill does
var skill_base_flavor: String = ""; # Flavor text with no gameplay mechanics mentioned

var skill_type := gSkill.AttackType.MELEE; # Melee/Gun/Psyonic
var skill_arm := gSkill.Armed.UNARMED; # Doesn't matter for Psyonic attacks (default to Unarmed)
var skill_element := gSkill.Element.TYPELESS;
var skill_range := gSkill.SkillRange.MELEE;
var skill_target := gSkill.SkillTarget.ONE_FOE;

var skill_base_power: int = 0;
var skill_crit_power: int = 0; # If an attack crits, use this power instead
var skill_base_hit: int = 0; # 255: Always hit
var skill_base_crit: int = 0; # 255: Always crit, 0: Never crit
var skill_total_hits := Vector2i(1,1); # Base average is used during damage calculation
var skill_sp_cost: int = 0;
var skill_death_type := gSkill.DeathType.NONE; # Play an animation if target is KO'd under certain conditions
var skill_priority: int = 0; # Used for determining turn order, in "brackets"
var skill_ailments: Array = []; # [Ailment, base rate]
var skill_effects: Array = []; # [Effect]
var skill_remove_ailments: Array = []; # [Ailment]
var skill_remove_effects: Array = []; # [Effect]
var skill_extra: Array = []; #[Extra effect, extra value];
var skill_stat_changes := Vector3i(0,0,0); # Each value can range from -8 to 8

var skill_after_use; # If defined, use skill after this one concludes

var skill_anim_base; # Which character animation to use
var skill_anim_fx; # Additional visual effects

func init(name: String = "", desc: String = "", flavor: String = "", type := gSkill.AttackType.MELEE, arm := gSkill.Armed.UNARMED,
element := gSkill.Element.TYPELESS, srange := gSkill.SkillRange.MELEE, target := gSkill.SkillTarget.ONE_FOE,
base_power: int = 0, crit_power: int = 0, base_hit: int = 0, base_crit: int = 0, hits := Vector2i(1,1), sp_cost: int = 0,
death := gSkill.DeathType.NONE, priority: int = 0, add_ailment: Array = [], add_effect: Array = [], remove_ailment: Array = [], remove_effect: Array = [],
extra: Array = [], stat_change := Vector3i(0,0,0), after: skill = null) -> skill:
	self.skill_base_name = name;
	self.skill_base_desc = desc;
	self.skill_base_flavor = flavor;
	self.skill_base_type = type;
	self.skill_base_arm = arm;
	self.skill_base_element = element;
	self.skill_base_range = srange;
	self.skill_base_target = target;
	self.skill_base_power = base_power;
	self.skill_crit_power = crit_power;
	self.skill_base_hit = base_hit;
	self.skill_base_crit = base_crit;
	self.skill_total_hits = hits;
	self.skill_sp_cost = sp_cost;
	self.skill_death_type = death;
	self.skill_priority = priority;
	self.skill_ailments = add_ailment;
	self.skill_effects = add_effect;
	self.skill_remove_ailments = remove_ailment;
	self.skill_remove_effects = remove_effect;
	self.skill_extra = extra;
	self.skill_stat_changes = stat_change;
	self.skill_after_use = after;
	self.skill_anim_base;
	self.skill_anim_fx;
	return self;
