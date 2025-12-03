class_name gSkill

###############
## CONSTANTS ##
###############
const ALWAYS_HIT = 255;
const NO_CRIT = 0;
const ALWAYS_CRIT = 255;

#################
## ENUMERATORS ##
#################
enum AttackType { # Used with Armed to determine weapon needed
	MELEE,
	GUN,
	PSYONIC,
}

enum AttackStat { # Determines which attack stat to use
	MELEE_WEAPON = 0,  # Weapon-based melee attack
	MELEE_UNARMED = 1, # Melee attack without a weapon
	GUN_WEAPON = 2,	   # Weapon-based gun attack
	GUN_UNARMED = 3,   # Gun attack without a weapon
	PSYONIC_TECH = 4,  # Psyonic as learned tech, or via Psyonic shard bag item
	PSYONIC_SHARD = 5, # Psyonic equipped on ring
}

enum SkillRange {
	MELEE,
	RANGED,
}

enum SkillTarget {
	ONE_FOE,
	ONE_ROW,
	ONE_LINE,
	ALL_FOES,
	ONE_ALLY,
	ONE_ALLY_ROW,
	ONE_ALLY_LINE,
	ALL_ALLIES,
	ONE_ALLY_KOD,
	ALL_ALLIES_KOD,
	SELF,
	EVERYONE_BUT_SELF,
	EVERYONE,
}

enum Armed { # Determines if a weapon is needed to use a skill
	UNARMED,
	ARMED,
}

enum DeathType { # If the right conditions are met, play a special animation upon death
	NONE,
	DECAPITATION,
}

enum Element {
	TYPELESS,
	## ATTACK ##
	PHYSICAL,
	GUN,
	FIRE,
	ICE,
	HOLY,
	SHADOW,
	ALPHA,
	OMEGA,
	## AILMENT ##
	BODY,
	NERVE,
	MIND,
	POTENTIAL,
	DEATH,
	STUN,
	DISABLE,
	AFRAID,
	## MISC ##
	RECOVERY,
}

enum Effective {
	NEUTRAL,
	WEAK,
	RESIST,
	NULL,
	ABSORB,
	REFLECT,
}
