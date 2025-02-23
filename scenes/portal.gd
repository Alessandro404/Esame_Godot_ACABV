extends Node3D

@export var local_id:int
@export var destination_room_id: int
@export var destination_portal_id:int

@export var spawn_point:Node3D
@onready var light = $OmniLight3D

@export var tint_color: Color
@onready var portal_sprites = $Area3D/AnimatedSprite3D

func _on_area_3d_body_entered(_body):
	get_tree().current_scene.teleport(destination_room_id,destination_portal_id)


func _ready():
	portal_sprites.modulate = tint_color
	light.set_color(tint_color)
