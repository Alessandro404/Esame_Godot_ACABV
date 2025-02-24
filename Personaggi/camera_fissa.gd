extends Node3D

var player:CharacterBody3D = Global.player
@onready var camera_3d = $Camera3D

@export var stage_dimentions:Vector2
var starting_pos: Vector3

func _ready():
	starting_pos = global_position

func _process(delta):
	global_position = lerp(global_position,player.position,delta*10.0)
	global_position.x = clampf(global_position.x,starting_pos.x-stage_dimentions.x/2,starting_pos.x+stage_dimentions.x/2)
	global_position.z = clampf(global_position.z,starting_pos.z-stage_dimentions.y/2,starting_pos.z+stage_dimentions.y/2)
	#position.y = 0
	global_position.y = lerp(global_position.y,player.position.y,delta*10.0)
	
	camera_3d.look_at(((player.global_position+global_position)/2)+Vector3.UP,Vector3.UP)
	
	$MeshInstance3D2.global_position = ((player.global_position+global_position)/2)+Vector3.UP
	

func activate():
	camera_3d.make_current()
