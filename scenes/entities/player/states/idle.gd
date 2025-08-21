extends State

@export var player: CharacterBody2D;

func update(delta: float):
	if (player.velocity != Vector2.ZERO):
		transition_state.emit(self, PlayerStateMachine.States.moving);

func physics_update(delta: float):
	var input_vector: Vector2 = PlayerStateMachine.get_input_vector();
	player.velocity = input_vector * player.move_speed
