extends Scene
@export var brave_choice_node:Label
@export var love_choice_node: Label
@export var evil_choice_node: Label

signal level_changed() 
signal digivolve()

func _ready():
	current_digimon = "Egg"
	brave_choice_node.connect("cursor_selected", _on_brave_choice_cursor_selected)
	love_choice_node.connect("cursor_selected", _on_love_choice_cursor_selected)
	evil_choice_node.connect("cursor_selected", _on_evil_choice_cursor_selected)

func on_enter():
	print("Enter")

func _on_brave_choice_cursor_selected():
	next_digimon = "Chibomon"
	emit_signal("digivolve")

func _on_love_choice_cursor_selected():
	print("love")
	next_digimon = "Puttimon"
	emit_signal("digivolve")
	#emit_signal("level_changed", "DigiEvo")
		
func _on_evil_choice_cursor_selected():
	next_digimon = "Kuramon"
	emit_signal("digivolve")
