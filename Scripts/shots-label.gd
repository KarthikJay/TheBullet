extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var shots = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	set_text("Shots: " + str(shots))
	
	pass

func _incrementShot():
	shots = shots + 1
	set_text("Shots: " + str(shots))
