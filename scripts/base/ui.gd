extends Control
class_name UI

@onready var bumper_counter_label: Label = %BumperCounterLabel

func _ready() -> void:
	UiEvents.show_UI.connect(_on_show_ui);
	UiEvents.update_bumper_number.connect(_on_update_bumper_counter);

func _on_show_ui(should_show_ui: bool):
	self.visible = should_show_ui;

func _on_update_bumper_counter(current_count: int):
	bumper_counter_label.text = str(current_count);
