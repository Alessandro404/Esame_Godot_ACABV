extends Node3D

@export var camera_3d : Node3D


func _on_area_3d_body_entered(body: Node3D) -> void:
	camera_3d.activate()
