extends Node2D
class_name GameBoard

signal player_position_updated(player_id: int, new_tile_position: int);

@onready var player: Player = $Player
@onready var play_tiles_manager: PlayTilesManager = %PlayTilesManager

var player_position_dictionary: Dictionary[int, int];

func _ready() -> void:
	play_tiles_manager.player_position_changed.connect(_on_player_position_changed);
	
	play_tiles_manager.generate_base_play_tiles(20);
	player.global_position = play_tiles_manager.play_tiles_list[0].global_position;
	
func get_play_tiles():
	return play_tiles_manager.play_tiles_list;

func get_player_tile_index_by_player_id(player_id: int) -> int:
	return player_position_dictionary[player_id];

func _on_player_position_changed(player_id: int, tile_index: int):
	player_position_dictionary[player_id] = tile_index;
	self.player_position_updated.emit(player_id, tile_index);
