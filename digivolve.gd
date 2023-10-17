extends Scene

@export var current_digimon_texture : TextureRect
@export var next_digimon_texture : TextureRect
@export var hide_image_timer : Timer
@export var digivolve_timer : Timer

@onready var digivolve_label : RichTextLabel = $DigivolveLabel
@onready var next_button : Button = $NextButton

signal level_changed() 

var is_current_digimon : bool = true
var is_digivolving : bool

func hide_items():
	digivolve_label.hide()
	next_button.hide()
	
func show_items():
	digivolve_label.show()
	next_button.show()
	
func  update_text():
	digivolve_label.bbcode_text = "Your " + current_digimon + " has digivolved to " + next_digimon

func on_enter():
	hide_items()
	is_digivolving = true
	digivolve_timer.start()
	print("enter")
	set_texture(current_digimon, current_digimon_texture)
	
func set_texture(digimon, texture):
	hide_image_timer.start()
	var image = load_digimon_texture(digimon)
	image = set_image_to_white(image)
	texture.texture = ImageTexture.create_from_image(image)

func _ready():
	print(current_digimon)


func load_digimon_texture(digimon) -> Image:
	var path_to_image = "res://DigimonImages/" + digimon +"/"+ digimon+".png"
	var image = Image.new()
	image.load(path_to_image)
	image.resize(100,100)
	return image

func set_image_to_white(image) -> Image:
	for x in range(image.get_width()):
		for y in range(image.get_height()):
			var pixel = image.get_pixel(x, y)
			pixel.r = 1.0
			pixel.g = 1.0
			pixel.b = 1.0
			image.set_pixel(x, y, pixel)
	
	return image

func _on_hide_image_timer_timeout():
	if(!is_digivolving): return
	
	if(is_current_digimon):
		current_digimon_texture.hide()
		set_texture(next_digimon, next_digimon_texture)
		is_current_digimon = false;
		next_digimon_texture.show()
	else:
		next_digimon_texture.hide()
		set_texture(current_digimon, current_digimon_texture)
		is_current_digimon = true
		current_digimon_texture.show()

func _on_digivolve_timer_timeout():
	is_digivolving = false
	var image = load_digimon_texture(next_digimon)
	next_digimon_texture.texture = ImageTexture.create_from_image(image)
	show_items()
	update_text()
	
func go_to_next_scene():
	emit_signal("level_changed", "DigiEvo")

func _on_button_pressed():
	print("clicked")
	go_to_next_scene()
