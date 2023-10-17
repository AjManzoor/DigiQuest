extends Scene

@export var dialogPath = ""
@export var textSpeed : float = 0.05
@export var Name : RichTextLabel
@export var Text : RichTextLabel
#@export var PortraitSprite : Sprite2D
@export var PortaitRect : TextureRect
@export var TextTimer : Timer
#@export var Indicator : Polygon2D

var dialog
 
var phraseNum = 0
var finished = false
 
func _ready():
	TextTimer.wait_time = textSpeed
	dialog = getDialog()
	assert(dialog, "Dialog not found")
	nextPhrase()
	#print("done")
 
func _process(_delta):
	#Indicator.visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			nextPhrase()
		else:
			Text.visible_characters = len(Text.text)
 
func getDialog() -> Array:
	var output = [{"Name": "Aj","Emotion":"Happy"  ,"Text": "wawa"}, {"Name": "Aj","Emotion":"Neutral"  ,"Text": "hahah"}, {"Name": "Aj","Emotion":"Happy"  ,"Text": "wawa"}, {"Name": "Aj","Emotion":"Neutral"  ,"Text": "asdasd asdasdasdad"},]
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []
 
func nextPhrase() -> void:
	if phraseNum >= len(dialog):
		queue_free()
		print("done")
		return
	
	finished = false
	
	Name.bbcode_text = dialog[phraseNum]["Name"]
	Text.bbcode_text = dialog[phraseNum]["Text"]
	
	Text.visible_characters = 0
	
	
	var img =dialog[phraseNum]["Name"] + "/" + dialog[phraseNum]["Name"]+ "/" + dialog[phraseNum]["Name"] + ".png"
	print(img)
	
	var path_to_image = "res://DigimonImages/" + img
	var image = Image.new()
	image.load(path_to_image)
	image.resize(200,400)
	PortaitRect.texture = ImageTexture.create_from_image(image)
	
	while Text.visible_characters < len(Text.text):
		Text.visible_characters += 1
		TextTimer.start()
		await TextTimer.timeout
	
	finished = true
	phraseNum += 1
	return
