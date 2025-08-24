extends Node
class_name PlayTilesManager

signal player_position_changed(player_id: int, tile_index: int);

const PLAY_TILE = preload("uid://rp2qvpbxv8jx");

const ui_border_width: int = 128;

const generation_x_min: int = ui_border_width * 2;
const generation_x_max: int = GlobalConstants.SCREEN_WIDTH - (ui_border_width * 2);

const y_min_gap: float = 128;
const y_max_gap: float = 256;

var play_tiles_list: Array[PlayTile] = [];

func generate_base_play_tiles(tile_number: int):
	
	var current_base_y: int = GlobalConstants.SCREEN_HEIGHT * 2;
	
	for i in range(0, tile_number):
		var play_tile_instance: PlayTile = PLAY_TILE.instantiate();
		play_tile_instance.index = i;
		play_tile_instance.player_entered_tile.connect(_on_player_entered_tile);
		
		var positioned_play_tile: PlayTile = _set_tile_position(play_tile_instance, i, current_base_y);
		
		self.add_child(positioned_play_tile);
		play_tiles_list.append(positioned_play_tile);
		
		current_base_y = positioned_play_tile.position.y;
		
func _set_tile_position(play_tile: PlayTile, index: int, current_y: int) -> PlayTile:
	if index == 0:
		play_tile.position = Vector2i(GlobalConstants.SCREEN_WIDTH / 2, current_y)
	else:
		var y_position: int = current_y + randi_range(y_min_gap, y_max_gap)
		var x_position: int = randi_range(generation_x_min, generation_x_max)
		play_tile.position = Vector2i(x_position, y_position)
	return play_tile;
		

func _on_player_entered_tile(player_id: int, tile_index: int):
	self.player_position_changed.emit(player_id, tile_index);
