extends Node

func _ready():
	pass
	
func _physics_process(_delta):
	pass	

func _process(_delta):
	if(Input.is_action_pressed("ui_cancel")): # ESC
		get_tree().quit();

	if(Input.is_action_just_released("f11")):
		Globals.showTree();
