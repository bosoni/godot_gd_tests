class_name RandomMap

var mapInfos = [];

func getRandomPos(halfMapSize):
	var space_state = Globals.root.get_world().direct_space_state;
	var SIZE = halfMapSize;
	
	for qq in 100:
		var x = randf() * SIZE - SIZE/2;
		var z = randf() * SIZE - SIZE/2;
		var from = Vector3(x, 1000, z);
		var to = Vector3(x, -1000, z);

		var col = space_state.intersect_ray(from, to, [self]);
		if(col.empty()==false):
			if(col.position==null): continue;
			return col.position;
	
	return null;

func createRandomMap(where, numOfObjects, halfMapSize):
	var positions = [];
	var space_state = Globals.root.get_world().direct_space_state;
	
	# random paikka kartalla
	var SIZE = halfMapSize;
	for _c in range(numOfObjects):
		var x = randf() * SIZE - SIZE/2;
		var z = randf() * SIZE - SIZE/2;
		var from = Vector3(x, 1000, z);
		var to = Vector3(x, -1000, z);

		var col = space_state.intersect_ray(from, to, [self]);
		if(col.empty()==false):
			if(col.collider==null): return;
			if(col.position.y <= 0): continue;
			positions.push_back(col.position);
		
	for p in positions:
		var model : PackedScene;
		var rnd  = randi()%5;
		if(rnd==0): 
			model = load("res://prefabs/tree1_RB.tscn");
		if(rnd==1): 
			model = load("res://prefabs/tree2_RB.tscn");
		if(rnd==2): 
			model = load("res://prefabs/rock1_RB.tscn");
		if(rnd==3): 
			model = load("res://prefabs/rock2_RB.tscn");
		if(rnd==4): 
			model = load("res://prefabs/mushroom_RB.tscn");

		var ins : RigidBody = model.instance();
		ins.set_translation(p + ins.get_translation());
		where.add_child(ins);
		#add_child(ins);
		
		mapInfos.push_back(ins);

