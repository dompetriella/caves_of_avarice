extends Node
class_name StateMachine

signal state_has_changed;

@export var default_state: State;
var current_state: State;
var states: Dictionary[String, State] = {};

func _ready() -> void:
	for child in self.get_children():
		if (child is State):
			states[child.name] = child;	child.transition_state.connect(_on_transition_state)
		
	if (default_state != null):
		print_debug('Entering Initial State: ' + states.find_key(default_state))	
		default_state.enter();
		current_state = default_state;

func _process(delta: float) -> void:
	if (current_state):
		current_state.update(delta);
		
func _physics_process(delta: float) -> void:
	if (current_state):
		current_state.physics_update(delta);

func transition_state(new_state_name: String):
	_on_transition_state(current_state, new_state_name);

func _on_transition_state(old_state: State, new_state_name: String):
		
	var new_state: State = states[new_state_name];
	
	if (!new_state):
		push_error("No state found with name " + new_state_name + ". Exiting...")
		return;
	
	if (new_state == self.current_state):
		return;
		
	current_state.exit();
	
	new_state.enter();
	
	current_state = new_state;
	
	self.state_has_changed.emit(current_state);
