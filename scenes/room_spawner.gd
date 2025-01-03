extends Node3D

@export var id : int
@export var res_room: Resource
@export var neighbors:Array[NodePath] = []

var loaded : bool = false

func spawn_room():
	if !loaded :
		var room = res_room.instantiate()
		add_child(room)
		move_child(room, 0)
		loaded = true

func unload_room():  #move_child assicura che sia sempre a 0
	if loaded:
		get_child(0).queue_free()
		#remove_child(get_child(0))
		loaded = false
