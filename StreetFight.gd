extends Node2D
var player
var opponent
var opponent_bar
var progress_bar
@export var game_time = 100
@export var opponent_health = 8
@export var opponent_windup_seconds = .6
@export var is_game_running = false
var can_start_game = true
var max_opponent_health
enum STStates {Idle, Attacking, Blocking, Damaged}
var _state : int = STStates.Idle
var rng = RandomNumberGenerator.new()
signal done

# Called when the node enters the scene tree for the first time.
func _ready():
	#get references to nodes
	player = self.get_child(0)
	opponent = self.get_child(1)
	opponent_bar = self.get_child(2)
	progress_bar = self.get_child(3)
	max_opponent_health = opponent_health

func _process(delta):
	#only update when game is running
	if is_game_running:
		#this happens once on game start
		if can_start_game == true:
			can_start_game = false
			#start opponent punch loop
			opponent_punch_routine()
		#attacking(up arrow) if player is idle
		if Input.is_action_pressed("ui_up") && _state == STStates.Idle:
			#set state machine to attacking
			_state = STStates.Attacking
			attack()
		#blocking(down arrow) if player is idle
		if Input.is_action_pressed("ui_down") && _state == STStates.Idle:
			#set block state
			_state = STStates.Blocking
			block()
		#opponent death
		if opponent_health <=0:
			opponent.rotation_degrees = 120
			await get_tree().create_timer(2).timeout
			end_game()
		opponent_bar.set_value((float(opponent_health) / float(max_opponent_health)) * 100)

func end_game():
	is_game_running = false;
	can_start_game = true;
	done.emit()

#player attack
func attack():
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
	opponent.position.y += 80
	await get_tree().create_timer(.2).timeout
	opponent.position.y -= 30
	#loop to punch in intervals
	if (opponent_health > 0):
		opponent_punch_routine()

func _on_phone_scroll(type):
	if type == "fight":
		is_game_running = true;
