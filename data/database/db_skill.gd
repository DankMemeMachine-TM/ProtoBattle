class_name dbSkill
extends RefCounted

static var data: Dictionary[int, skill] = {
	gSklName.Name.sklNONE: skill.new().init(),
	gSklName.Name.sklACT_ATTACK_WEAPON: skill.new().init(),
	gSklName.Name.sklACT_ATTACK_UNARMED: skill.new().init(),
	gSklName.Name.sklACT_SHOOT_WEAPON: skill.new().init(),
	gSklName.Name.sklACT_SHOOT_UNARMED: skill.new().init(),
	gSklName.Name.sklACT_DEFEND: skill.new().init(),
}
