extends KinematicBody2D

var pos = 0
var speed = 150
var bullet_speed = 150
var div = 16
var use_frames = true
var base_deg = 180.0
var dead = false
var group

onready var timer

var can_turn = true
func _ready():
	timer = Timer.new()
	timer.set_wait_time(1.0 / 15)
	add_child(timer)
	timer.connect("timeout", self, "_on_Timer_timeout")

func _on_Timer_timeout():
	can_turn = true
	timer.stop()

func pos_rotation_deg(_pos) -> float:
	return base_deg + _pos * 360 / div

func turn(change):
	if not can_turn:
		return
	can_turn = false
	timer.start()
	
	pos += change
	pos = (16 + pos) % 16
	rotation_degrees = pos_rotation_deg(pos)
	if not use_frames:
		return
	var mir = [1, 1]
	var _frame
	if pos < 8:
		_frame = pos
		mir[0] = -1
	elif pos == 8:
		_frame = 0
		mir[1] = -1
	else:
		_frame = 16 - pos
	$Sprite.frame = _frame
	$Sprite.rotation_degrees = -rotation_degrees
	$Sprite.scale[0] = mir[0]
	$Sprite.scale[1] = mir[1]

func move(delta):
	return move_and_collide(- transform.y * speed * delta)
	pass

var to_turn = 0
func pathfind(target: Vector2):
	#var val = randi() % 10
	#if val <= 2:
	#	turn(val - 1)
	var new_pos = round((int(position.angle_to_point(target) * 57.29578 + 360 + 90) % 360) / (360 / div))
	to_turn = new_pos - pos
	if to_turn > 8:
		to_turn -= 16
	if to_turn >= 1:
		turn(1)
	elif to_turn <= -1:
		turn(-1)

var Bullet = preload("res://sprites/Bullet/Bullet.tscn")
func shoot():
	var b = Bullet.instance()
	b.init(group, bullet_speed)
	get_parent().add_child(b)

	if not has_node("Turret"):
		return b.queue_free()

	b.global_transform = $Turret.global_transform
