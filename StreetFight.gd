extends Node2D
var player
var opponent
enum STStates {Idle, Attacking, Blocking, Damaged}
var _state : int = STStates.Idle
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	player = self.get_child(0)
	opponent = self.get_child(1)
	punch_routine()

func _process(delta):
	#attacking if player is idle
	if Input.is_action_pressed("ui_up") && _state == STStates.Idle:
		_state = STStates.Attacking
		player.position.y -= 50
		await get_tree().create_timer(.3).timeout
		player.position.y += 50
		await get_tree().create_timer(.7).timeout
		_state = STStates.Idle
	if Input.is_action_pressed("ui_down") && _state == STStates.Idle:
		_state = STStates.Blocking
		player.rotation_degrees += 90
		await get_tree().create_timer(.7).timeout
		player.rotation_degrees -= 90
		_state = STStates.Idle

func punch_routine():
	var waitTime = rng.randf_range(1.0, 5.0)
	print(waitTime)
	await get_tree().create_timer(waitTime).timeout
	opponent.position.y -= 50
	await get_tree().create_timer(1).timeout
	opponent.position.y += 50
	punch_routine()


func _on_phone_scroll(type):
	pass # Replace with function body.
