extends Node
	
func get_transition() -> Transition:
	var transition: Transition = get_tree().get_first_node_in_group("Transition");
	if (transition == null):
		print_debug("WARNING - Transition Node is Null")
	return transition;

func get_scaffold() -> Scaffold:
	var scaffold: Scaffold = get_tree().get_first_node_in_group("Scaffold");
	if (scaffold == null):
		print_debug("WARNING - Scaffold Node is Null")
	return scaffold;

func get_player() -> Player:
	var player: Player = get_tree().get_first_node_in_group("Player");
	if (player == null):
		print_debug("WARNING - Player Node is Null")
	return player;
