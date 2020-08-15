extends KinematicBody2D

var pos = 0
const div = 16

func turn(change):
	pos += change
	pos = (16 + pos) % 16
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
	rotation_degrees = 180 + pos * 360 / 16
	$Sprite.rotation_degrees = -rotation_degrees
	$Sprite.scale[0] = mir[0]
	$Sprite.scale[1] = mir[1]

	
var can_action = true
func _ready():
	set_process_input(true)
	turn(0)
	$Timer.connect("timeout", self, "_on_Timer_timeout")

const speed = 50
func _physics_process(delta):
	var collision = move_and_collide(- transform.y * speed * delta)
	if collision:
		queue_free()

	if not can_action: return
	var has_action = false
	if Input.is_action_pressed("ui_left"):
		turn(-1)
		has_action = true
	if Input.is_action_pressed("ui_right"):
		turn(1)
		has_action = true
	if has_action:
		$Timer.set_wait_time(1.0 / 15)
		$Timer.start()
		can_action = false

func _on_Timer_timeout():
	can_action = true

func _input(event):
	if event.is_action_pressed("ui_select"):
		shoot()

# export (PackedScene) var Bullet
var Bullet = preload("res://scenes/Bullet/Bullet.tscn")
func shoot():
	var b = Bullet.instance(pos)
	b.init("enemy")
	owner.add_child(b)

	b.global_transform = $BulletSpawn.global_transform
