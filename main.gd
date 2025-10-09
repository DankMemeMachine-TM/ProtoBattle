'''
Main.tscn

For this project's case, all this file does is set up the test battle environment.
'''
extends Node

var battle_scene = preload("res://scene/battle/Battle.tscn");
var player_units: Array[unitPlayer] = [];
var enemy_units: Array[unitEnemy] = [];
var player_test_ids: Array[int] = [1]; # IDs of player dictionary units
var enemy_test_ids: Array[int] = [1]; #IDs of enemy dictionary units

func _ready():
	player_units = get_player_unit_data();
	enemy_units = get_enemy_unit_data();
	add_child(battle_scene.instantiate());

func get_player_unit_data() -> Array[unitPlayer]:
	var array: Array[unitPlayer];
	for n in player_test_ids.size():
		var temp = load_unit_from_dic(player_test_ids[n], dbPlayer.data);
		if(temp != null):
			array.append(temp);
	return array;
	
func get_enemy_unit_data() -> Array[unitEnemy]:
	var array: Array[unitEnemy];
	for n in enemy_test_ids.size():
		var temp = load_unit_from_dic(enemy_test_ids[n], dbEnemy.data);
		if(temp != null):
			array.append(temp);
	return array;

func load_unit_from_dic(input: int, dic: Dictionary):
	return dic[input];
