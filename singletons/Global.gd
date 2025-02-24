extends Node

@onready var player: CharacterBody3D = get_tree().get_nodes_in_group("player")[0]
@onready var startfinale : bool = false   ##ORRIBILE ACCROCCHIO  #TODO
@onready var startinizio: bool = true  #TODO 

##Variabili Antonia una per personaggio
@onready var pres_slasher : bool = false
#@onready var npc_dict = {"kalyani" = false, "iconic" = false, "slasher" = false, "captchas" = false, "mia" = false, "josh" = false, "catburger" = false, "avocadoguy" = false, "astronatur" = false, "kiwi" = false, "baccurate" = false, "chemtrails" = false, "maneki" = false}
@onready var npc_dict = {"kalyani" = false}
##@onready var npc_array = [pres_slasher] #TODO 
##funzione per creare array per controllare se abbiamo parlato
##con tutti alla fine del mondo



@onready var dialogue_playing : bool = false:
	set(value):
		if !value:
			await get_tree().create_timer(0.5).timeout
		dialogue_playing = value

func dialogue_counter() -> bool:
	#TODO ## orribile da togliere appena possibile
	for element in Global.npc_dict : 
		var value = Global.npc_dict[element]
		print(Global.npc_dict[element])
		if value == false :
			return false
	#print("tutto")
	return true
	Global.startfinale = true
