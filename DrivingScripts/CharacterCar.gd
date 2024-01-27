extends Sprite2D

@export var characterCarSpeed = 300

func _ready():
	position.x = 400
	position.y = 650
	
func _process(delta):
	if Input.is_action_pressed("ui_left") && position.x >= 250:
		position.x -= characterCarSpeed * delta
	if Input.is_action_pressed("ui_right") && position.x <= 550:
		position.x += characterCarSpeed * delta
