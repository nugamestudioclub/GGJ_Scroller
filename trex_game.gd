extends Node

enum ActionRequest {None, Jump, Duck}

# "constants"
@export var GAME_TYPE = "trex"
@export var JUMP_INPUT_BINDING = "ui_up"
@export var DUCK_INPUT_BINDING = "ui_down"
@export var BOUNCE_HEIGHT = 65
@export var BOUNCE_DURATION = 0.4

# mutatables
@export var is_game_running = true # true for debug purposes
var state = ActionRequest.None
var jump_tween : Tween
var initial_position : Vector2
var is_jumping : bool = false
var is_ducking : bool = false

# signals
signal done

# awake
@onready var box : CollisionShape2D = $Anim/Area2D/Collider
@onready var animator : AnimatedSprite2D = $Anim

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position = animator.position
	make_jump_tween()

func make_jump_tween():
	jump_tween = create_tween()    
	jump_tween.stop()
	jump_tween.set_ease(Tween.EASE_OUT)
	jump_tween.set_trans(Tween.TRANS_CUBIC)
	jump_tween.tween_property(animator, "position:y", initial_position.y - BOUNCE_HEIGHT, BOUNCE_DURATION)
	jump_tween.tween_property(animator, "position:y", initial_position.y, BOUNCE_DURATION)

func gather_input() -> ActionRequest:
	var request = ActionRequest.None
	
	if (Input.is_action_just_pressed(JUMP_INPUT_BINDING)):
		request = ActionRequest.Jump
	if (Input.is_action_just_pressed(DUCK_INPUT_BINDING) or Input.is_action_just_released(DUCK_INPUT_BINDING)):
		request = ActionRequest.Duck
	
	return request

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var frame_request = gather_input()
	
	if (frame_request == ActionRequest.Jump):
		_handle_jump()
	
	pass

func _handle_jump():
	if (jump_tween.is_running()):
		return
	
	jump_tween.kill()
	make_jump_tween()
	
	is_ducking = false
	jump_tween.play()
	
func _handle_duck():
	is_ducking = !is_ducking
	
	
	
# connected to area
func _handle_hit(area):
	pass

func _on_phone_scroll(type):
	if type == GAME_TYPE:
		is_game_running = true;

func end_game():
	done.emit()
