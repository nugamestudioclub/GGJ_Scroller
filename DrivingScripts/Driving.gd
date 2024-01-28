extends Node2D

var cars
@export var speed = 300
enum CarStates {Idle, Moving}
var _state : int = CarStates.Idle
@export var is_game_running = false
var can_start_game = true
var moving_car
var start_time
var elapsed_time
var hit_detected
signal done
# Called when the node enters the scene tree for the first time.
func _ready():
	cars = [self.get_child(0), self.get_child(1), self.get_child(2)] 
	start_time = Time.get_ticks_msec() 
	# Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_game_running:
		self.show()
		elapsed_time = Time.get_ticks_msec() - start_time
		if can_start_game == true:
			can_start_game = false
		if _state == CarStates.Idle:
			_state = CarStates.Moving
			moving_car = cars[randi() % 3]
		if _state == CarStates.Moving:
			_drive_car(moving_car, delta)
		if elapsed_time >= 10000 && _state == CarStates.Idle:
			can_start_game = true
			is_game_running = false
			done.emit()
			self.hide()
			
			
func _drive_car(car, delta):
	car.position.y += speed * delta
	if car.position.y >= 1000:
		car.position.y = 350
		_state = CarStates.Idle

func _on_phone_scroll(type):
	if type == "drive":
		is_game_running = true;

func _on_area_2d_area_entered(area):
	can_start_game = true
	is_game_running = false
	done.emit()
	self.hide()
