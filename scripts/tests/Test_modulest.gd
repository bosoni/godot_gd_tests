extends Spatial

var rain = false;
var rainNode;

func _ready():
	Globals.gameRunning = true;


func _process(_delta):

	if(Input.is_action_just_released("f12")):
		rain = !rain;
		if(rain):
			rainNode = Globals.Module.add("weather", Globals.root, "res://scripts/tests/Mod_Weather.gd");
		else:
			Globals.Module.remove(rainNode);

		Globals.showTree();
		Globals.root.get_node("weather/script").update(rain);
