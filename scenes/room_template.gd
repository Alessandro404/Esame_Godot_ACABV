extends Node3D

@onready var player = Global.player

var portals: Array[Node]

func _ready():
	portals = $Interactive/Portals.get_children()
	#print(portals)
