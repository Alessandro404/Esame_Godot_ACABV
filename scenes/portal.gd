extends Node3D

@export var local_id:int
@export var destination_room_id: int
@export var destination_portal_id:int

@export var spawn_point:Node3D


func _on_area_3d_body_entered(_body):
	get_tree().current_scene.teleport(destination_room_id,destination_portal_id)
