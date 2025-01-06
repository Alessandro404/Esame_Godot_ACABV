extends Area3D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String =  "start"

func action() -> void:
	if !Global.dialogue_playing:
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	Global.dialogue_playing = true
