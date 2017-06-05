extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"\
export var MOTION_SPEED = 300 #export means public? means that the node extends will be shown
# TODO(kjayakum): Update the path of the bullet to the bullet scene or group
onready var bullet = preload("res://Bullet.tscn")
onready var root_node = get_node(".")

var RayNode
var mouseLoc
var count
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	set_process_input(true)
	count = 1
	RayNode = get_node("RayCast2D")
	#get_node("pickupArea").connect("area_enter", self, "_on_enemy_body_enter")
	playervariables.set("playerLocation", get_pos())
	playervariables.set("playerRID", get_rid().get_id())
	#get_node("pickupArea").set_contact_monitor(true)
	#get_node("pickupArea").set_max_contacts_reported(5)

	pass


func _on_enemy_body_enter(body):
    print("Collision2")
# Note: _input is only used when set_process_input(true) is set to true
func _input(event):
	if(event.type == InputEvent.MOUSE_BUTTON):
		if(event.button_index == 1):
			if(count > 0):
				var bulletVector = mouseLoc - get_pos()
				bulletVector.normalized()
				var cur = bullet.instance()
				cur.set_dir(get_pos(), mouseLoc)
				root_node.get_parent().add_child(cur)
				count = count - 1

func _fixed_process(delta):
	# every frame execution
	var motion = Vector2()
	#motion
	
#	if(is_colliding()):
		# TODO(kjayakum): Have the bullet object kill the player, not the enemy!!!
#		var shape = get_collider()
#		if (shape != null && shape.is_in_group("pickupable")):
#			count = 1
#			shape.free()
	
	if(Input.is_action_pressed("ui_up")):
		motion += Vector2(0, -1) #add 0 to x and -1 to y
		#RayNode.set_rotd(180)
		
	if(Input.is_action_pressed("ui_down")):
		motion+= Vector2(0, 1)
		#RayNode.set_rotd(0)
	if(Input.is_action_pressed("ui_right")):
		motion+= Vector2(1, 0)
		#RayNode.set_rotd(90)
	if(Input.is_action_pressed("ui_left")):
		motion+= Vector2(-1, 0)
		#RayNode.set_rotd(-90)
		
	# This is using project setting custom UI Control 
	#if(Input.is_action_pressed("ui_mouse_left")):
		#motion+= Vector2(200,0)
		#var bullet1 = bullet.instance()
		#root_node.add_child(bullet.instance())

	motion = motion.normalized() * MOTION_SPEED * delta
	move(motion)
	mouseLoc = get_node("Camera2D").get_global_mouse_pos()
	var angle = get_pos().angle_to_point(mouseLoc)
	get_node("Shadow").set_rot(angle)
	playervariables.set("playerLocation", get_pos())
	
	#Collision with bullet
	#if is_colliding():
		##var collider = get_collider()
		#if collider extends bullet:
		#	print("penis");