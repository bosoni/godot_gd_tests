extends Node

var map;

func _ready():
	map = RandomMap.new();

	var CNT = 1000;

	# luo kartta (3 eri tapaa):

	# 1.tapa
	#for q in CNT: map.createRandomMap(get_node("."), 1, 150);

	# 2.tapa
	#map.createRandomMap(get_node("."), CNT, 150);

	# 3.tapa
	#Globals.USE_MULTIMESH = false;

	var mm = Multimesh.new();
	mm.beginMultiMesh(get_node("."), "res://prefabs/tree1_RB.tscn");

	for q in CNT:
		var p = map.getRandomPos(150);
		if(p==null):
			continue;
			
		var nd = Spatial.new();
		nd.translate(p);
		
		nd.rotate_y(randf() * 360);
		
		var r = randf()+0.6;
		var scale = Vector3(r,r,r);
		nd.set_scale(scale);
		
		mm.add(nd, true); #scenetreehen eli myös fyssat (SLOW)
		#mm.add(nd, false); #ei scenetreehen, pelkkä rendaus (FAST)

	mm.endMultiMesh();
