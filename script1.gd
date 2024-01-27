extends Sprite2D

var input = Vector2(0, 0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#How to do inputs for all your minigames!
func inputs():
	if Input.is_action_pressed("Up"):
		position.y+=1
	input.x = Input.get_action_strength("Left") - Input.get_action_strength("Right")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	inputs()
	
	
	
