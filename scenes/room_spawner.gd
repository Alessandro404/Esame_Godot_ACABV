extends Node3D

#@export var id : int
@export var res_room: String
@export var neighbors:Array[NodePath] = []

var loaded : bool = false


func spawn_room():
	if !loaded :
		ResourceLoader.load_threaded_request(res_room)
		var room = ResourceLoader.load_threaded_get(res_room).instantiate()
		add_child(room)
		move_child(room, 0)
		loaded = true

func make_main():
	get_child(0).stanza_attuale = true
	#print("resa main la room " + str(get_child(0)) + ", " + str(get_child(0).stanza_attuale) )

func make_neighbour():
	if loaded:
		get_child(0).stanza_attuale = false


func unload_room():  #move_child assicura che sia sempre a 0
	if loaded:
		get_child(0).queue_free()
		#remove_child(get_child(0))
		loaded = false

#TODO Ottimizzare il preload, facendo precaricare i vicini e costringendo il load solo al tp
func preload_room():
	if !loaded:
		ResourceLoader.load_threaded_request(res_room)
