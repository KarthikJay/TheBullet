extends Area2D

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	connect("body_enter", self, "on_pickup")
	pass

func on_pickup(body):
	if (body.is_in_group("pickupable") ):
		#get_node("parent").isAlive = false
		print("DEAD")
		#get_node("parent").free()
