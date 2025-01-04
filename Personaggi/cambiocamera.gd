extends Node3D

@export var camera_rig : Node3D


func _on_area_3d_body_entered(_body: Node3D) -> void:
	camera_rig.activate()
