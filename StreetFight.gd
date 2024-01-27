extends Node2D
var player
var opponent
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	player = self.get_child(0)
	opponent = self.get_child(1)
	punch_routine()

func _process(delta):
	pass

func punch_routine():
	var waitTime = rng.randf_range(1.0, 5.0)
	print(waitTime)
	await get_tree().create_timer(waitTime).timeout
	opponent.position.y -= 50
	await get_tree().create_timer(1).timeout
	opponent.position.y += 50
	punch_routine()
