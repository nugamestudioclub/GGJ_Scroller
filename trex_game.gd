extends Node

enum ActionRequest {None, Jump, Duck}

# "constants"
@export var GAME_TYPE = "trex"
@export var JUMP_INPUT_BINDING = "ui_up"
@export var DUCK_INPUT_BINDING = "ui_down"

# mutatables
@export var is_game_running = true # true for debug purposes
var state = ActionRequest.None

# signals
signal done

# awake
@onready var trex = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func gather_input() -> ActionRequest:
	var request = ActionRequest.None
	
	if (Input.is_action_just_pressed(JUMP_INPUT_BINDING)):
		request = ActionRequest.Jump
	if (Input.is_action_just_pressed(DUCK_INPUT_BINDING)):
		request = ActionRequest.Duck
	
	return request

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var frame_request = gather_input()
	
	
	pass

func _on_phone_scroll(type):
	if type == GAME_TYPE:
		is_game_running = true;

func end_game():
	done.emit()
