extends Area2D

var speed = 150

var gr: String
func init(group: String):
	gr = group

func _physics_process(delta):
	$CollisionShape2D.rotation_degrees = -rotation_degrees
	position -= transform.y * speed * delta

func _on_Bullet_body_entered(body):
	if body.is_in_group(gr):
		get_parent().remove_child(self)
		body.queue_free()
	queue_free()
