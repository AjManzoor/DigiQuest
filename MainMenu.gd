extends Scene
@export var start_label_node:Label
@export var exit_label_node: Label
@export var level_name : String = "MainMenu"
signal level_changed() 
	
func _ready():
	current_digimon = "DigiEgg"
	start_label_node.connect("cursor_selected", _on_start_cursor_selected)
	exit_label_node.connect("cursor_selected", _on_quit_cursor_selected)

# Define the method that will be called when the signal is emitted
func _on_start_cursor_selected():
	# Handle the signal here
	emit_signal("level_changed", level_name)

func on_enter():
	print("Enter")

func _on_quit_cursor_selected():
	get_tree().quit()
