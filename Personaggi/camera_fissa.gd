extends Node3D

@onready var player:CharacterBody3D = Global.player
@onready var camera_3d = $Camera3D

@export var stage_dimentions:Vector2

func _process(delta):
	position = lerp(position,player.position,delta*10.0)
	position.x = clampf(position.x,-stage_dimentions.x/2,stage_dimentions.x/2)
	position.z = clampf(position.z,-stage_dimentions.y/2,stage_dimentions.y/2)
	
	camera_3d.look_at(((player.position+global_position)/2)+Vector3.UP,Vector3.UP)
	
	$MeshInstance3D2.position = ((player.position+position)/2)+Vector3.UP

func activate():
	camera_3d.make_current()
