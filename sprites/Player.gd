extends "res://scripts/Plane.gd"
class_name Player

signal dead

func _init():
	speed = 300
	bullet_speed = 300
	use_frames = true
	group = "player"

func _ready():
	set_process_input(true)
	turn(0)

var score = 0
func _physics_process(delta):
	if dead:
		return
	if move(delta):
		return die()

	if not can_turn: return
	var turned = false
	if Input.is_action_pressed("ui_left"):
		turn(-1)
		turned = true
	if Input.is_action_pressed("ui_right"):
		turn(1)
		turned = true
	if not turned: return
	$Score.rotation_degrees = -rotation_degrees

func inc_score():
	score += 1
	set_score_label()

func set_score_label():
	$Score/Text.text = "%03d" % score

func _input(event):
	if event.is_action_pressed("ui_select"):
		shoot()

func die():
	dead = true
	emit_signal("dead")
	$Sprite.queue_free()
	$Hitbox.queue_free()
	$Turret.queue_free()
