extends Position2D
class_name Spawner

var Enemy = preload("res://sprites/Enemy/Enemy.tscn")

var dogfight
var player
func _ready():
	dogfight = get_node("/root/Main").scene
	player = dogfight.get_node("Player")
#-168
func _on_Timer_timeout():
	$Timer.set_wait_time(randf() * 1.0)
	# $Timer.stop()
	
	var e = Enemy.instance()
	dogfight.add_child(e)
	e.global_position = global_position
	e.position.x += 50 - randf() * 100
	e.pos = (8 + player.pos) % 16
	#e.transform -= e.transform.y * 100
