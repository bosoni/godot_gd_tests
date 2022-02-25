extends Node

func update(rain):
		
	if(rain==false):
		get_node("../rain").queue_free();

	if(rain==true):
		var rainPart = load("res://particles/rainParticles.tscn");
		var ins = rainPart.instance();
		ins.set_translation(Vector3(0,2,0));
		var SC = 1;
		ins.set_scale(Vector3(SC, SC, SC));
		ins.name = "rain";
		get_node("..").add_child(ins);
