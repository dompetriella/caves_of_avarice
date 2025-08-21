extends Control
class_name InfoMenu

var title_menu: PackedScene = load("uid://l6xve34c75ym");

func _ready() -> void:
	UiEvents.show_UI.emit(true);

func _on_return_button_pressed() -> void:
	var title_menu_instance: TitleMenu = title_menu.instantiate();
	Locator.get_scaffold().scaffold_new_node_tree(title_menu_instance);
