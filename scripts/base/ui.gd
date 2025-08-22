extends Control
class_name UI


func _ready() -> void:
	UiEvents.show_UI.connect(_on_show_ui);

func _on_show_ui(should_show_ui: bool):
	self.visible = should_show_ui;
