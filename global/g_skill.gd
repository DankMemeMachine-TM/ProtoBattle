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
