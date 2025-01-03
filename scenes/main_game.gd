extends Node3D

@export var starting_room_path: NodePath = "LevelsRoot/RoomSpawner00"

var current_room_path: NodePath
var current_loaded_rooms: Array[Node3D]
var old_room_path: NodePath
var old_loaded_rooms: Array[Node3D]

var player= Global.player

@export_group("Level Fade")
@export var fade_speed :float = 2.0
@export var fade_out_durata = 1.0
@export var fade_in_durata = 1.2
@onready var fade_out_timer = fade_out_durata
@onready var fade_in_timer = fade_in_durata

var fading_out = false;
var fading_in = false

func _ready() -> void:
	current_room_path = starting_room_path
	change_room_state(current_room_path)
	await get_tree().create_timer(4).timeout 
	change_room_state("LevelsRoot/RoomSpawner01")
	await get_tree().create_timer(4).timeout 
	change_room_state("LevelsRoot/RoomSpawner02")
	await get_tree().create_timer(4).timeout 
	change_room_state("LevelsRoot/RoomSpawner03")

func _process(delta):
	if fading_out:
		fade_out_timer -= delta*fade_speed
		player.fade.color = Color(0,0,0,1.0-fade_out_timer)
		if fade_out_timer <= 0.0:
			fade_out_timer = fade_out_durata
			fading_out = false
			
	if fading_in:
		player.fade.color = Color(0,0,0,fade_in_timer)
		fade_in_timer -= delta
		if fade_in_timer <= 0.0:
			fading_in = false
			fade_in_timer = fade_in_durata

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
			#print("elimina " + item.name)
			item.unload_room()
	load_rooms()
