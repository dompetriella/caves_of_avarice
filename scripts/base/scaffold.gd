extends Node
class_name Scaffold

func scaffold_new_node_tree(
	new_scene_node: Node,
	data_to_load: Callable = Callable(),
	transition_on_exit_current_scene: String = Transition.TransitionType.fade_out,
	transition_on_enter_new_scene: String = Transition.TransitionType.fade_in,
	transition_speed_factor: float = 1
) -> void:

	TransitionEvents.transition_started.emit();	
	var transition_animator: AnimationPlayer = Locator.get_transition().transition_player;
	transition_animator.play(transition_on_exit_current_scene, -1, transition_speed_factor);

	await transition_animator.animation_finished;
	
	for child in get_children():
		child.queue_free();

	await get_tree().process_frame;

	add_child(new_scene_node);
	
	if data_to_load.is_valid():
		await data_to_load.call();
	
	transition_animator.play(transition_on_enter_new_scene, -1, transition_speed_factor);
	await transition_animator.animation_finished;
	TransitionEvents.transition_ended.emit();
