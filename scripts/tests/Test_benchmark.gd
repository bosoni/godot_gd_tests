# TODO
# tsekkaa multimesh, siel 3 erilaist tapaa luoda kartta.
# luo niillä tavolla, ota aika.
#
#

extends Node

var numOfObjects = 0;
var map = RandomMap.new();

func _ready():

	var nn = Node.new();
	nn.name = "objs";
	add_child(nn);
	
	var t1 = OS.get_ticks_msec();
	map.createRandomMap(nn, 100, 80);
	numOfObjects += 100;
	var t2 = OS.get_ticks_msec();
	Globals.debug("map creation time: "+str(t2-t1));
	
	get_node("../Stats").get_node("Label").debugEnabled = true;
	
func _physics_process(_delta):
	pass	

func _process(_delta):
	if(Input.is_action_just_released("ui_accept")): # enter
		var t1 = OS.get_ticks_msec();
		map.createRandomMap(get_node("objs"), 100, 80);
		numOfObjects += 100;
		var t2 = OS.get_ticks_msec();
		Globals.debug("map creation time: "+str(t2-t1));

	get_node("../Stats").get_node("Label").text += \
	"\n\nPress ENTER to add objects.\nNum of objects: " + str(numOfObjects) + \
	"\n\nF1 ssao on/off\nF2 fog on/off";
	
