extends Node

@export var current_level : Node2D

func _ready():
	current_level.connect("level_changed", handle_level_changed)

func digivolve():
	transition_to_next_level("digivolve")

func transfer_data_between_scences(old_scene, new_scene):
	new_scene.current_digimon = old_scene.current_digimon
	new_scene.next_digimon = old_scene.next_digimon

func handle_level_changed(current_level_name):
	var next_level_name : String
	match current_level_name:
		"MainMenu":
			next_level_name = "digi_quest"
		"DigiEvo":
			print("digivlve")
			next_level_name = "main_menu"
	transition_to_next_level(next_level_name)

func transition_to_next_level(next_level_name):
	var next_level = load("res://"+next_level_name+".tscn").instantiate()
	add_child(next_level)
	transfer_data_between_scences(current_level, next_level)
	current_level.queue_free()
	current_level = next_level 
	current_level.connect("level_changed", handle_level_changed)
	current_level.connect("digivolve", digivolve)
	current_level.on_enter()
