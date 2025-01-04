extends Node3D

@onready var player = Global.player
@onready var camera = $Cameras/CameraRoot

signal player_changed_room
var portals: Array[Node]
var stanza_attuale : bool :
	get:
		return stanza_attuale
	set(value):
		player_changed_room.emit()
		stanza_attuale = value

func _ready():
	portals = $Interactive/Portals.get_children()




func _on_player_changed_room() -> void:
	#print("cambiato stato della stanza " + str(self) + ". orea è " + str(stanza_attuale))
	await get_tree().process_frame
	if stanza_attuale:
		#print($Cameras.get_child_count())
		if (camera.get_child_count()) > 0:
			$Cameras.get_child(0).get_child(0).camera_3d.current = true 
		else:
			#no camera, giocatore
			player.own_camera.current = true
