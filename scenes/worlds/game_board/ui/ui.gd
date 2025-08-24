extends Control

@onready var roll_die_button: Button = $VBoxContainer/HBoxContainer/RollDieButton
@onready var move_total_label: Label = $VBoxContainer/MoveTotalLabel
@onready var move_up: Button = $VBoxContainer/HBoxContainer2/MoveUp
@onready var move_down: Button = $VBoxContainer/HBoxContainer2/MoveDown

var player: Player;
var movement_sum;

func _ready() -> void:
	player = Locator.get_player();

func _on_roll_die_pressed() -> void:
	var result: Array[int] = _get_player_movement_amount();
	movement_sum = result[0] + result[1];
	move_total_label.text = "%d + %d = %d Movement" % [result[0], result[1], movement_sum];

func _get_player_movement_amount() -> Array[int]:
	var die_1: int = randi_range(1,3);
	var die_2: int = randi_range(1,3);
	return [die_1, die_2];


func _on_move_up_pressed() -> void:
	if (movement_sum != null):
		player.move_character(movement_sum * -1);
		movement_sum = null;
		move_total_label.text = ""; 


func _on_move_down_pressed() -> void:
	if (movement_sum != null):
		player.move_character(movement_sum);
		movement_sum = null;
		move_total_label.text = ""; 
