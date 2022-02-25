extends "res://scripts/objects/BaseObjectInfoClass.gd"

func _init():
	name = "Tree1";
	modelName = "Tree1.tscn";

	rot = Vector3(0, deg2rad(randi()%360), 0);

	# eri pituisia puita
	var sc = 0.6 + randf()*0.3;
	var yscale = randf() * 0.3; 
	scale = Vector3(sc, sc + yscale, sc);
	
	life = 30.0;

func action():
	return "Chopped tree with " + Globals.player.weapon.name + ".";

func getObject():
	Globals.player.wood += 1;
	return "You took some wood.";
