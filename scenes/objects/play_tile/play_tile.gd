extends Area2D
class_name PlayTile

signal player_entered_tile(player_id: int, tile_index: int)

var index: int;

func _on_body_entered(body: Node2D) -> void:
	if (body is Player):
		player_entered_tile.emit(body.id, index);
