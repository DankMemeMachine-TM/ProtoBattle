extends Node

var total_battlers: Array[unitCharacter] = []; # Every initial battler in the fight (for revival purposes)
var reinforcement_battlers: Array[unitCharacter] = []; # Reinforcements, preloaded to reduce loadtimes
var battlefield: Array[Array] = [ # Determines some attack ranges (left: player | right: enemy)
	[null, null], [null, null],
	[null, null], [null, null],
	[null, null], [null, null],
	[null, null], [null, null],
	[null, null], [null, null],
];
var _current_turn: int = 0; # Battle turn count, increments by one at the start of a new turn
var _turn_queue: Array[unitCharacter] = []; # Turn order to process
var _active_battlers: Array[unitCharacter] = []; # Battlers who are currently not KO'd
## Players and Enemies are separate so they can be placed in the right spot in the Battlefield array
var _player_battlers: Array[unitCharacter] = []; # Player battlers, both alive and KO'd
var _enemy_battlers: Array[unitCharacter] = []; # Enemy battlers, both alive and KO'd

############################
## BATTLE START FUNCTIONS ##
############################
func _ready():
	start_battle();

func start_battle() -> void:
	initialize_active_battlers();
	new_turn();

func initialize_active_battlers() -> void:
	for n in total_battlers.size():
		var _battler = total_battlers[n];
		if(_battler is unitPlayer):
			_player_battlers.append(_battler);
		elif (_battler is unitEnemy):
			_enemy_battlers.append(_battler);
		else:
			print("Battle.tscn initialize_active_battlers(): input ", _battler, " does not appear to be valid. Skipping . . .");
			continue;

##########################
## CONTINUOUS FUNCTIONS ##
##########################
func new_turn() -> void:
	_active_battlers = []; # Empty queue so it can account for KO'd characters (kinda sloppy, ngl)
	get_active_battlers();
	create_turn_queue();
	self._current_turn += 1;

func get_active_battlers() -> void:
	var _player = check_alive_battlers(_player_battlers);
	var _enemy = check_alive_battlers(_enemy_battlers);
	_active_battlers.append_array(_player);
	_active_battlers.append_array(_enemy);
	
func check_alive_battlers(input: Array[unitCharacter]):
	var _array: Array[unitCharacter] = [];
	for n in input:
		var _unit = input[n];
		if (!_unit.get_ailment(dbAilment.data.DEATH)):
			_array.append(_unit);
	return _array;
	
func create_turn_queue() -> void: #TODO
	var _agi_array: Array[unitCharacter] = []; # Array with all battlers sorted by effective speed
	for n in _active_battlers.size():
		_agi_array.append(_active_battlers[n]);
	return;

func add_enemy_reinforcement(input: int) -> void:
	self._enemy_battlers.append(_enemy_battlers[input]);
