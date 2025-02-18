extends Node

@onready var player: CharacterBody3D = get_tree().get_nodes_in_group("player")[0]
@onready var startfinale : bool = false   ##ORRIBILE ACCROCCHIO  #TODO

##Variabili Antonia una per personaggio
@onready var pres_slasher : bool = false
@onready var npc_dict = {"slasher" = false, "maneki" = false}
##@onready var npc_array = [pres_slasher] #TODO 
##funzione per creare array per controllare se abbiamo parlato
##con tutti alla fine del mondo




@onready var dialogue_playing : bool = false:
	set(value):
		if !value:
			await get_tree().create_timer(0.5).timeout
		dialogue_playing = value
