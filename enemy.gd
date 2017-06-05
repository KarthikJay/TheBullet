extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var bullet = preload("res://enemyBullet.tscn")
onready var root_node = get_node(".")
export var isAlive = true
var aggro = false;
export var reloadMax = 90
export var reload = 90
var pLoc
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	set_process_input(true)
	get_node("RayCast2D").add_exception(get_node("CollisionShape2D"))
	pass
func _fixed_process(delta):
	#print(get_node("RayCast2D").get_collision_point())
	#if we want bullet to collide we need to add player code
	_checkAggro()
	if(aggro && (reload <= 0)):
		_shoot()
	#death
	reload = reload - 1
func _shoot():
	
	reload = reloadMax
	var bulletVector = pLoc - get_pos()
	bulletVector.normalized()
	var cur = bullet.instance()
	cur.set_dir(get_pos(), pLoc)
	root_node.get_owner().add_child(cur)

func _checkAggro():
	var space_state = get_world_2d().get_direct_space_state()
	pLoc = playervariables.get("playerLocation")
	var result =space_state.intersect_ray(get_pos(), pLoc, [self])#.linear_interpolate(get_pos(),2.0) )#need to add thrid paramater of own ri
	if(result.size() && result.rid.get_id() == playervariables.get("playerRID") ):
		#interpolatedLine = result.position
		var angle = get_pos().angle_to_point(pLoc)
		set_rot(angle)
		aggro = true
	else: 
		aggro = false