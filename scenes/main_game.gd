extends Node3D

@export var starting_room_path: NodePath = "LevelsRoot/RoomSpawner00"

var current_room_path: NodePath
var current_loaded_rooms: Array[Node3D]

var old_room_path: NodePath
var old_loaded_rooms: Array[Node3D]


func _ready() -> void:
	current_room_path = starting_room_path
	change_room_state(current_room_path)
	await get_tree().create_timer(4).timeout 
	change_room_state("LevelsRoot/RoomSpawner01")
	await get_tree().create_timer(4).timeout 
	change_room_state("LevelsRoot/RoomSpawner02")


func load_rooms():
	for i in current_loaded_rooms.size():
		current_loaded_rooms[i].spawn_room()


func parse_paths_make_array() -> void:
	current_loaded_rooms.clear()
	current_loaded_rooms.append(get_node(current_room_path))
	for i in get_node(current_room_path).neighbors.size():
		current_loaded_rooms.append(get_node(NodePath("LevelsRoot/"  + get_node(current_room_path).neighbors[i].get_name(1))))


func change_room_state(new_room_path : NodePath) -> void:
	old_loaded_rooms.clear()
	old_loaded_rooms = current_loaded_rooms.duplicate()
	
	current_room_path = new_room_path
	parse_paths_make_array()
	
	for item in old_loaded_rooms:
		if !current_loaded_rooms.has(item):
			print("elimina " + item.name)
			item.unload_room()
	load_rooms()
