class_name dbEnemy
extends RefCounted

static var data: Dictionary[int, unitEnemy] = {
	gEnemy.Name.eTEKI: unitEnemy.new().init(
		"Teki", "TekiDesc", gCharacter.Sex.MALE, gCharacter.Innate.HOLY,
		25, 10, [10, 3, 7, 6, 5], [0,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,0], 0,
		gInnate.INNATE_HOLY.duplicate(), gCharacter.DEFAULT_WEAK_MOD.duplicate(),
		gCharacter.DEFAULT_RESIST_MOD.duplicate(), gCharacter.DEFAULT_ELEMENT_ARMOR.duplicate(),
		gCharacter.DEFAULT_ATTACK_ARMOR.duplicate(),
	),
	gEnemy.Name.eAITE: unitEnemy.new().init(
		"Aite", "AiteDesc", gCharacter.Sex.MALE, gCharacter.Innate.FIRE,
		25, 10, [10, 3, 7, 6, 5], [0,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,0], 0,
		gInnate.INNATE_HOLY.duplicate(), gCharacter.DEFAULT_WEAK_MOD.duplicate(),
		gCharacter.DEFAULT_RESIST_MOD.duplicate(), gCharacter.DEFAULT_ELEMENT_ARMOR.duplicate(),
		gCharacter.DEFAULT_ATTACK_ARMOR.duplicate(),
	),
}
