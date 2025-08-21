extends Node
class_name State

signal transition_state(current_state: State, new_state_name: String);

func enter(): pass;

func exit(): pass;
	
func update(delta: float): pass;

func physics_update(delta: float): pass;
