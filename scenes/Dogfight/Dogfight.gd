extends Node2D

func _ready():
	$Player.connect("dead", self, "_on_Player_dead")

func _on_Player_dead():
	$Menu.visible = true
	$Menu.global_position = get_node("Player/Camera2D").global_position + (Vector2(-112, -128) * 3)
