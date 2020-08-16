extends Node2D
class_name Menu

signal reload
func _on_Button_pressed():
	emit_signal('reload')

func open(pos: Vector2):
	visible = true
	position.x = pos[0]
	position.y = pos[1]
	$Camera2D.current = true
