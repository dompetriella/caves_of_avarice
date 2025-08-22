extends CharacterBody2D
class_name Player

@onready var state_machine: StateMachine = %PlayerStateMachine
@export var move_speed: float = 300.0

var id: int;
var game_board: GameBoard;

var current_tile_index: int;

func _ready() -> void:
	
	id = 0;
	game_board = Locator.get_game_board().get_play_tiles();
	
	TransitionEvents.transition_started.connect(\
	_on_transition_started);
	
	game_board.player_position_updated.connect(_on_player_position_updated);
	
func _on_transition_started():
	state_machine.transition_state(PlayerStateMachine.States.immobile);

func _on_player_position_updated(player_id: int, new_tile_index: int):
	if (player_id == id):
		current_tile_index = new_tile_index;

func move_character(spaces: int):
	var play_tiles_list: Array[PlayTile] = game_board.get_play_tiles();
	
