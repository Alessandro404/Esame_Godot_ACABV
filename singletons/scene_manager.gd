extends Node

var stages = [preload("res://scenes/area_01.tscn"), preload("res://scenes/area_02.tscn")]
#[preload("res://scenes/world.tscn"),preload("res://scenes/world_2.tscn"),preload("res://scenes/world_3.tscn")]

var current_stage_id = 0
var next_stage_id = 0
var next_portal_id = 0

var player:CharacterBody3D

func teleport(stage_id,portal_id):
	print(stage_id)
	next_stage_id = stage_id
	next_portal_id = portal_id
	get_tree().change_scene_to_packed(stages[next_stage_id])

func new_scene_loaded(portals,current_player):
	player = current_player;
	for portal in portals:
		if portal.id == next_portal_id:
			player.position = portal.spawn_point.global_position
	
