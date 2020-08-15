extends Node2D

func _ready():
	center()
	get_tree().get_root().connect("size_changed", self, "center")

func center():
	var size = OS.get_window_size()
	position[0] = size[0] / 2
	position[1] = size[1] / 2
	print(position)
