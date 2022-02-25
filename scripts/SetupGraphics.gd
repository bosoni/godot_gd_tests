extends Node

func _ready():
	Globals.env = get_node_or_null("../WorldEnvironment"); # WorldEnvironment node

func _process(_delta):
	if(Input.is_action_just_released("f1")):
		Globals.env.environment.ssao_enabled =! Globals.env.environment.ssao_enabled;
		Globals.debug("ssao " + str(Globals.env.environment.ssao_enabled));
		
	if(Input.is_action_just_released("f2")):
		Globals.env.environment.fog_enabled =! Globals.env.environment.fog_enabled;
		Globals.debug("fog " + str(Globals.env.environment.fog_enabled));

