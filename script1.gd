extends Sprite2D

var input = Vector2(0, 0)
var funny_types = ["plat", "fight", "trex", "drive"]
signal scroll(type)
var last_picked = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#How to do inputs for all your minigames!
func inputs():
	if Input.is_action_pressed("enter"):
		var random = funny_types.pick_random()
		while random == last_picked:
			random = funny_types.pick_random()
		scroll.emit(random)
		last_picked = random

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	inputs()
	
	
	


func _on_street_fight_done():
	pass # Replace with function body.
