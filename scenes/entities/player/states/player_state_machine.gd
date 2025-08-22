extends StateMachine
class_name PlayerStateMachine

class States:
	const immobile: String = 'Immobile';
	const playing: String = 'Playing'

#region Shared State Functions
static func get_input_vector():
	var input_vector := Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
	
	input_vector = input_vector.normalized();
	return input_vector;
#endregion
