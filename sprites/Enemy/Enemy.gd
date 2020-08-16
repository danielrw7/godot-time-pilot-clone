extends "res://scripts/Plane.gd"
class_name Enemy

onready var dogfight = get_parent()
onready var player = dogfight.get_node("Player")
func _init():
	use_frames = false
	group = "enemy"

var can_shoot = true
func _physics_process(delta):
	var col = move(delta)
	if col:
		if not col.collider.dead:
			col.collider.die()
		return die()
	
	if not player:
		return
	#global_position = get_global_mouse_position()
	if can_turn:
		pathfind(player.position)
	if abs(to_turn) < 2 and can_shoot:
		shoot()
		$ShootTimer.start()
		can_shoot = false

func die(inc_score = false):
	dead = true
	if inc_score:
		player.inc_score()
	queue_free()

func _on_ShootTimer_timeout():
	can_shoot = true
	$ShootTimer.set_wait_time(randf() * 2.0 + 2)
	# $ShootTimer.stop()
