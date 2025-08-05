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
enum AttackType {
	MELEE,
	GUN,
	PSYONIC,
}

enum AttackStat {
	MELEE_WEAPON = 0,  # Weapon-based melee attack
	MELEE_UNARMED = 1, # Melee attack without a weapon
	GUN_WEAPON = 2,	   # Weapon-based gun attack
	GUN_UNARMED = 3,   # Gun attack without a weapon
	PSYONIC_TECH = 4,  # Psyonic as learned tech, or via Psyonic shard bag item
	PSYONIC_SHARD = 5, # Psyonic equipped on ring
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
	# SUPPORT
	# AILMENT
	# MISC
}

enum Effective {
	NEUTRAL,
	WEAK,
	RESIST,
	NULL,
	ABSORB,
	REFLECT,
}
