extends Area2D

var speed
var source: String

func init(_source: String, _speed):
	source = _source
	add_to_group("source_" + source)
	speed = _speed

func _on_Timer_timeout():
	queue_free()

func _physics_process(delta):
	$Hitbox.rotation_degrees = -rotation_degrees
	position -= transform.y * speed * delta

func _on_Bullet_body_entered(body):
	if not body.is_in_group(source):
		body.die(1)
	queue_free()
