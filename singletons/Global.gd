extends Node

@onready var player: CharacterBody3D = get_tree().get_nodes_in_group("player")[0]
@onready var EndCamera: Node3D


@onready var dialogue_playing : bool = false:
	set(value):
		if !value:
			await get_tree().create_timer(0.5).timeout
		dialogue_playing = value
