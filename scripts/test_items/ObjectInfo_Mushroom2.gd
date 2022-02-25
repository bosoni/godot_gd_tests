extends "res://scripts/objects/BaseObjectInfoClass.gd"

func _init():
	name = "Mushroom2";
	modelName = "Mushroom2SB.tscn";

	rot = Vector3(0, deg2rad(randi()%360), 0);

	var sc = 0.02 + randf()*0.02;
	scale = Vector3(sc, sc, sc);

	color = Color(1, 0, 0); # red

func getObject():
	var poison = 80;
	Globals.player.energy -= poison;
	var tst = ["shit", "poison"]
	var strr = "You ate a mushroom. It tasted like "+tst[randi()%2]+". Energy -" + str(poison);
	if(Globals.player.energy <= 0):
		Globals.player.energy = 0;
		var deathtxt = "You ate too much poison and died.";
		strr += "\n" + deathtxt;
					
		Globals.player.alive = false;
		
		Globals.game.deadToRigidBody();
		
		Globals.env.get_environment().ambient_light_energy = 0.5;
		Globals.scriptNode.get_node("../UI/deathInfo/Label").text = deathtxt;
		Globals.scriptNode.get_node("../UI/deathInfo").show();
	
	return strr;
