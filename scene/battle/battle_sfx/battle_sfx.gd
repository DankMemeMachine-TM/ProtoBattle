extends Node

func _on_battle_debug_key(key: Variant) -> void:
	if(key == KEY_1):
		play_sound($Damage);
	if(key == KEY_2):
		play_sound($Critical);
	if(key == KEY_3):
		play_sound($PlayerKO)

# Function to ensure a sound only plays once; most likely just going to be a debug function.
func play_sound(sound: AudioStreamPlayer) -> void:
	if(!sound.playing):
		sound.play();
