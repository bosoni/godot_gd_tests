extends "res://scripts/objects/BaseObjectInfoClass.gd"

func _init():
	name = "Campfire";
	modelName = "campfireSB.tscn";

	rot = Vector3(0, deg2rad(randi()%360), 0);

	life = 50.0;
	var sc = life / 1000.0;
	scale = Vector3(sc, sc, sc);

