class_name dbPlayer
extends RefCounted

static var data: Dictionary[int, unitPlayer] = {
	gPlayer.Name.pSHUJI: unitPlayer.new().init(
		"Shuji", "ShujiDesc", gCharacter.Sex.MALE, gCharacter.Innate.SHADOW,
		25, 10, [10, 3, 7, 9, 5], [0,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,0], 0,
		gInnate.INNATE_SHADOW.duplicate(), gCharacter.DEFAULT_WEAK_MOD.duplicate(),
		gCharacter.DEFAULT_RESIST_MOD.duplicate(), gCharacter.DEFAULT_ELEMENT_ARMOR.duplicate(),
		gCharacter.DEFAULT_ATTACK_ARMOR.duplicate(),
	),
}
