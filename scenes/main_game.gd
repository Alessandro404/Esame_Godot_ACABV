extends Node3D

@export var starting_room_path: NodePath = "LevelsRoot/RoomSpawner00"

var current_room_path: NodePath
var current_loaded_rooms: Array[Node3D]
var old_room_path: NodePath
var old_loaded_rooms: Array[Node3D]

@onready var player= Global.player

@export_group("Level Fade")
@export var fade_speed :float = 1.0
#@export var fade_out_durata = 1.0
#@export var fade_in_durata = 1.2
@onready var fade_out_timer = 1.0
@onready var fade_in_timer = 1.0

var fading_out :bool = false
var fading_in :bool = false

func _ready() -> void:
	current_room_path = starting_room_path
	change_room_state(current_room_path)
	current_loaded_rooms[0].make_main()

#TODO il fade node del player blocca la rotazione freeroam della camera. fixare bene e non rendendo il nodo invisibile

func _process(delta):
	if fading_out:
		player.fade.visible = true
		fade_out_timer -= delta*fade_speed
		player.fade.color = Color(0,0,0,1.0-fade_out_timer)
		if fade_out_timer <= 0.0:
			fading_out = false
			fade_out_timer = fade_speed

	if fading_in:
		player.fade.visible = false
		player.fade.color = Color(0,0,0,fade_in_timer)
		fade_in_timer -= delta*fade_speed
		if fade_in_timer <= 0.0:
			fading_in = false
			fade_in_timer = fade_speed

func load_rooms():
	for i in current_loaded_rooms.size():
			current_loaded_rooms[i].spawn_room() #poi riattiva la stanza
			#current_loaded_rooms[i].make_neighbour() #poi riattiva la stanza



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
	fading_in = true

func teleport(room_id : int, portal_id : int):
	player.teleporting = true
	fading_out = true
	await get_tree().create_timer(fade_speed).timeout
	var teleport_coordinates: Array
	teleport_coordinates.insert(0, get_room_from_id(room_id))
	teleport_coordinates.append(get_portal_from_id(teleport_coordinates[0], portal_id))
	#print(teleport_coordinates)
	change_room_state(teleport_coordinates[0])
	player.global_position = teleport_coordinates[1].find_child("PlayerSpawn").global_position
	player.move_direction = teleport_coordinates[1].find_child("PlayerSpawn").global_basis.z
	player.teleporting = false
	activate_room(teleport_coordinates[0])
	

func get_room_from_id(room_id: int):
	var id : String = "LevelsRoot/RoomSpawner"
	if room_id < 10:
		id = id + "0" + str(room_id)
	else:
		id = id + str(room_id)
	#print(id)
	return id

func get_portal_from_id(room_id: String, portal_id: int):
	var available_portals = get_node(room_id).get_child(0).portals
	for i in available_portals.size():
		if available_portals[i].local_id == portal_id:
			#print("agganciato")
			return available_portals[i]
	print("Non trovato portali")

func activate_room(room_id):
	#print(get_node(room_id))
	get_node(room_id).make_main()
