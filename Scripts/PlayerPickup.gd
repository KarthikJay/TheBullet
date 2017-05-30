extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	connect("body_enter", self, "on_pickup")
	pass

func on_pickup(body):
	if (body.is_in_group("pickupable")):
		get_parent().count += 1
		body.free()