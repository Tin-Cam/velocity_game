extends Node2D

var _bullet = preload("res://player/bullet/Bullet.tscn")
export var _bullet_speed : int = 1000
export var _bullet_force : int = 200
export var _fire_rate : float = 0.1
var _shot_timer : float = 0

onready var _player = get_node("../../Player")

func _process(delta):
	look_at(get_global_mouse_position())
	_shot_timer += delta
	
	if Input.is_action_pressed("shoot"):
		shoot()

func shoot():
	# Handles firerate
	if(_shot_timer < _fire_rate) :
		return
	else :
		_shot_timer = 0
	
	# Calculate direction vector
	var direction = get_global_mouse_position() - global_position
	#Shoot bullet
	var bullet_instance = _bullet.instance()
	bullet_instance.position = get_global_position()
	bullet_instance.rotation_degrees = rad2deg(atan2(direction.x, direction.y))
	bullet_instance.apply_impulse(Vector2(), Vector2(_bullet_speed, 0).rotated(rotation))
	get_tree().get_root().add_child(bullet_instance)
	# Apply force
	var force = -direction.normalized()
	_player.AddForce(force * _bullet_force)
