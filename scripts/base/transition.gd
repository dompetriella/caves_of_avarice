extends Control
class_name Transition

@onready var canvas_layer: CanvasLayer = %CanvasLayer
@onready var transition_mask: ColorRect = %TransitionMask
@onready var transition_player: AnimationPlayer = %TransitionPlayer

func _ready() -> void:
	TransitionEvents.transition_started.connect(_on_transition_started);
	TransitionEvents.transition_ended.connect(_on_transition_ended);

func _on_transition_started():
	canvas_layer.layer = 1;

func _on_transition_ended():
	canvas_layer.layer = 0;
	
class TransitionType:
	static var fade_in: String = "fade_in";
	static var fade_out: String = "fade_out";
