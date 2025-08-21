extends CharacterBody2D
class_name Player

@onready var state_machine: StateMachine = %PlayerStateMachine
@export var move_speed: float = 300.0

func _ready() -> void:
#For Template Only
	BumperEvents.bumper_collided.connect(_on_bumper_collision);
	
	TransitionEvents.transition_started.connect(\
	_on_transition_started)
	TransitionEvents.transition_ended.connect(\
	_on_transition_ended)

func _physics_process(delta: float) -> void:
	move_and_slide()

# For Template Only
var bumper_collisions: int = 0;

func _on_bumper_collision():
	bumper_collisions += 1;
	UiEvents.update_bumper_number.emit(bumper_collisions);
	
func _on_transition_started():
	state_machine.transition_state(PlayerStateMachine.States.immobile);
	
func _on_transition_ended():
	state_machine.transition_state(PlayerStateMachine.States.idle);
