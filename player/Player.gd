extends KinematicBody2D

# Physics
export(int) var _move_speed = 20000
export(int) var _resistance = 1000

export(int) var _jump_force = 1000
export(int) var _gravity = 50

const MAX_GRAVITY = 1000
const MAX_INPUT_SPEED = 300
const MAX_TOTAL_SPEED = 4000

var _velocity : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	DebugStats.add_property(self, "_velocity", "length")


func _physics_process(delta):
	_player_input(delta)
	_velocity.x = _calculateResistance(_velocity.x, delta)
	
	_velocity.y += _gravity
	if _velocity.y > MAX_GRAVITY :
		_velocity.y = MAX_GRAVITY
	
	_velocity = move_and_slide(_velocity, Vector2.UP)


func _player_input(delta):
	# Jump
	if Input.is_action_pressed("player_move_up") and is_on_floor():
		_velocity.y = -_jump_force
		
	# Moving left and right
	var x = 0
	# Left
	if Input.is_action_pressed("player_move_left") and _velocity.x > -_move_speed :
		x = -1
	# Right
	if Input.is_action_pressed("player_move_right") and _velocity.x < _move_speed :
		x = 1
	if x != 0 :
		_velocity.x += _move_speed * x * delta
		
		
func _calculateResistance(value, delta):
	var friction = 1
	
	if is_on_floor() :
		friction = 1.2
	
	var result = abs(value)
	
	result -= _resistance * friction * delta
	
	if (result < 0) :
		result = 0
		
	result *= sign(value)
	
	return result
	
func AddForce(force):
	_velocity += force
