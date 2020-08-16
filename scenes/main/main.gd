extends Node2D

var Dogfight = preload("res://scenes/Dogfight/Dogfight.tscn")

var scene
func load_scene():
	if scene:
		scene.queue_free()
	scene = Dogfight.instance()
	scene.get_node("Menu").connect("reload", self, "load_scene")
	add_child(scene)

func _ready():
	load_scene()
