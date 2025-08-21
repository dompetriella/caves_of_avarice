extends Control
class_name TitleMenu

var info_menu: PackedScene = load("uid://cbp88s7ly7d5m");
var starting_music: AudioStream = load("uid://b15bhxr4h3bkx");

func _ready() -> void:
	UiEvents.show_UI.emit(false);

func _on_start_button_pressed() -> void:
	var info_menu_instance: InfoMenu = info_menu.instantiate();
	Locator.get_scaffold().scaffold_new_node_tree(info_menu_instance);

func _on_quit_button_pressed() -> void:
	self.get_tree().quit();
