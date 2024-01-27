extends Sprite2D

@export var characterCarSpeed = 300

func _process(delta):
	if Input.is_action_pressed("ui_left") && position.x >= 400:
		position.x -= characterCarSpeed * delta
	if Input.is_action_pressed("ui_right") && position.x <= 700 :
		position.x += characterCarSpeed * delta
	
