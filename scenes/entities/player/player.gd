extends CharacterBody2D
class_name Player

@onready var state_machine: StateMachine = %PlayerStateMachine
@export var move_speed: float = 300.0

var id: int;
var game_board: GameBoard;

var current_tile_index: int;

func _ready() -> void:
	
	id = 0;
	game_board = Locator.get_game_board();
	
	TransitionEvents.transition_started.connect(\
	_on_transition_started);
	
	game_board.player_position_updated.connect(_on_player_position_updated);
	
func _on_transition_started():
	state_machine.transition_state(PlayerStateMachine.States.immobile);

func _on_player_position_updated(player_id: int, new_tile_index: int):
	if (player_id == id):
		current_tile_index = new_tile_index;

func move_character(spaces: int) -> void:
	var play_tiles_list: Array[PlayTile] = await game_board.get_play_tiles()
	
	var tile_destination_index: int = clamp(current_tile_index + spaces, 0, play_tiles_list.size() - 1)

	var step: int
	if spaces > 0:
		step = 1
	else:
		step = -1
	
	var tween: Tween = get_tree().create_tween()
	var move_speed: float = 700.0
	var hop_pause: float = 0.2

	var current_pos: Vector2 = global_position

	for i in range(current_tile_index + step, tile_destination_index + step, step):
		var destination_tile: PlayTile = play_tiles_list[i]
		var distance: float = current_pos.distance_to(destination_tile.global_position)
		var duration: float = distance / move_speed

		tween.tween_property(self, ^"global_position", destination_tile.global_position, duration ).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
		tween.tween_callback(func(): current_tile_index = i)

		current_pos = destination_tile.global_position
		tween.tween_interval(hop_pause)
	
