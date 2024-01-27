extends Sprite2D

@export var carSpeed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += carSpeed * delta
	if position.y > 1000:
		position.y = 100
