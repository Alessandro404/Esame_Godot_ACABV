extends Node3D

@onready var player = Global.player
@onready var camera = $Cameras/CameraRoot

var portals: Array[Node]
var stanza_attuale : bool = false

func _ready():
	portals = $Interactive/Portals.get_children()

	if stanza_attuale:
		if camera.get_child(0) != null:
			print(camera.get_child(0).camera_3d)
			player.own_camera.current = false
			camera.get_child(0).camera_3d.current = true 

		else:
			print("no camera, giocatore")
			player.own_camera.current = true
