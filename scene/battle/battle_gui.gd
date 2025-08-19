extends Control

var turn_started: bool = false;
var player_cache: unitPlayer; # Used to get player Techs/Psyonic/targeting(?)
#var skill_cache; # Used to get skill data to display relevant information
	
func _on_display_timer_timeout() -> void:
	display_menu($Buttons/ActionButtons);

func display_menu(menu) -> void:
	hide_all_menus();
	menu.show();

func hide_all_menus() -> void:
	$Buttons/ActionButtons.hide();
	$Buttons/BagButtons.hide();
	$Buttons/SpecialButtons.hide();

# Get the current player character to select actions.
func get_player_cache() -> void:
	pass; #TODO

# Adds/sorts buttons, used for Tech/Psyonic/Bag menus.
func populate_button_field():
	pass; #TODO
