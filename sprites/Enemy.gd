extends KinematicBody2D

const speed = 50
func _physics_process(delta):
	var collision = move_and_collide(- transform.y * speed * delta)
	if collision:
		queue_free()
		
