extends Node2D
var player
var opponent
@export var game_time = 100
@export var opponent_health = 8
@export var opponent_windup_seconds = .6
enum STStates {Idle, Attacking, Blocking, Damaged}
var _state : int = STStates.Idle
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	#get references to nodes
	player = self.get_child(0)
	opponent = self.get_child(1)
	#start opponent punch loop
	opponent_punch_routine()

func _process(delta):
	#attacking(up arrow) if player is idle
	if Input.is_action_pressed("ui_up") && _state == STStates.Idle:
		attack()
	#blocking(down arrow) if player is idle
	if Input.is_action_pressed("ui_down") && _state == STStates.Idle:
		block()
	#opponent death
	if opponent_health <=0:
		opponent.rotation_degrees = 120

#player attack
func attack():
	#set state machine to attacking
	_state = STStates.Attacking
	opponent_health -= 1
	#animate player with delays
	player.position.y -= 50
	await get_tree().create_timer(.3).timeout
	player.position.y += 50
	await get_tree().create_timer(.7).timeout
	#set state to idle
	_state = STStates.Idle

#player block
func block():
	#set block state
	_state = STStates.Blocking
	#rotate player with delay in between
	player.rotation_degrees += 90
	await get_tree().create_timer(.7).timeout
	player.rotation_degrees -= 90
	await get_tree().create_timer(.5).timeout
	#set idle state
	_state = STStates.Idle

#function for opponent punching state
func opponent_punch_routine():
	#calculate random time between punches
	var waitTime = rng.randf_range(2.0, 5.0)
	await get_tree().create_timer(waitTime).timeout
	#punch animation
	opponent.position.y -= 50

	await get_tree().create_timer(opponent_windup_seconds).timeout
	#deal damage to player(decrease timer) if not blocking
	if (_state != STStates.Blocking):
		game_time -= 10;
	opponent.position.y += 70
	await get_tree().create_timer(.2).timeout
	opponent.position.y -= 20
	#loop to punch in intervals
	opponent_punch_routine()
func _on_phone_scroll(type):
	pass # Replace with function body.
