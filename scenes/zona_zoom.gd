extends Node3D

@export var camera_rig_zoomed : Node3D
@export var camera_rig_esterno : Node3D
@onready var lato1 := $cambio_esterno1
@onready var lato2 := $cambio_esterno2
@onready var lato3 := $cambio_esterno3
@onready var lato4 := $cambio_esterno4
@onready var interno := $cambio_interno

func _ready():
	interno.camera_rig = camera_rig_zoomed
	lato1.camera_rig = camera_rig_esterno
	lato2.camera_rig = camera_rig_esterno
	lato3.camera_rig = camera_rig_esterno
	lato4.camera_rig = camera_rig_esterno
