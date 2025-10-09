extends Node

var total_battlers: Array = []; # Every initial battler in the fight (for revival purposes)
var reinforcement_battlers: Array = []; # Reinforcements, preloaded to reduce loadtimes
var battlefield: Array[Array] = [ # Determines some attack ranges (left: player | right: enemy)
	[null, null], [null, null],
	[null, null], [null, null],
	[null, null], [null, null],
	[null, null], [null, null],
	[null, null], [null, null],
];
var _current_turn: int = 0; # Battle turn count, increments by one at the start of a new turn
var _turn_queue: Array = []; # Turn order to process
var _active_battlers: Array = []; # Battlers who are currently not KO'd
## Players and Enemies are separate so they can be placed in the right spot in the Battlefield array
var _player_battlers: Array[unitPlayer] = []; # Player battlers, both alive and KO'd
var _enemy_battlers: Array[unitEnemy] = []; # Enemy battlers, both alive and KO'd
@onready var debug_node = get_node("/root/Debug");

####################
## INPUT HANDLING ##
####################
func _process(_delta: float) -> void:
	pass;

############################
## BATTLE START FUNCTIONS ##
############################
func init(player: Array[unitPlayer], enemy: Array[unitEnemy]):
	debug_setup();
	_player_battlers = player;
	_enemy_battlers = enemy;
	total_battlers = _player_battlers + _enemy_battlers;
	start_battle();
	
func debug_setup() -> void:
	if(debug_node == null):
		print("Debug Mode not active");
		return;
	debug_node.debug_key.connect(_on_debug_debug_key);

func start_battle() -> void:
	_current_turn = 0;
	new_turn();

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
	
func check_alive_battlers(input: Array) -> Array:
	var _array: Array = [];
	for n in input:
		if (!n.check_for_ailment(dbAilment.data[gAilment.Name.aDEATH])):
			_array.append(n);
	return _array;
	
func create_turn_queue() -> void:
	_turn_queue = _active_battlers.duplicate();
	_turn_queue.sort_custom(effective_speed_sort);
	
func effective_speed_sort(a, b) -> bool:
	var _result: bool = a.get_effective_speed() > b.get_effective_speed();
	if(_result == true):
		return true;
	# The clusterfuck below basically makes it so players have priority over enemies, but will be sorted by
	# their order in _active_battlers if a player speed ties a player; a similar thing happens for
	# enemies with a speed tie
	if(_result == false and a.get_effective_speed() == b.get_effective_speed()):
		if((a is unitPlayer or b is unitPlayer) and (a is not unitPlayer or b is not unitPlayer)): # Player units get priority over enemies
			return true;
		if(a is unitEnemy and b is unitEnemy): # This should group enemies in _active_battlers order
			return true;
	return false;

func add_enemy_reinforcement(input: int) -> void:
	self._enemy_battlers.append(_enemy_battlers[input]);

#####################
## DEBUG FUNCTIONS ##
#####################
func _on_debug_debug_key(key):
	if(key == KEY_1):
		$BattleSFX.play_sound($BattleSFX/Damage);
	if(key == KEY_2):
		$BattleSFX.play_sound($BattleSFX/Critical);
	if(key == KEY_3):
		$BattleSFX.play_sound($BattleSFX/PlayerKO);
