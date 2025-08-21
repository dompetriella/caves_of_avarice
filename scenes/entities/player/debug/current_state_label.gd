extends Label

@onready var state_machine: StateMachine = %PlayerStateMachine

func _ready() -> void:
	state_machine.state_has_changed.connect(_on_state_has_changed);
	
	if (state_machine.current_state != null):
		self.text = state_machine.states.find_key(state_machine.current_state).to_upper();

func _on_state_has_changed(currentState: State):
	var state_name: String =  state_machine.states.find_key(currentState)
	self.text = state_name.to_upper();
