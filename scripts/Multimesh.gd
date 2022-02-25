class_name Multimesh

var nodeList = [];
var lists = [];
var mmlists = [];
var pathMM : Node;
var fileName;

func beginMultiMesh(where, filename):
	Globals.debug("  beginMultiMesh "+filename);
	nodeList.clear();
	pathMM = where;
	fileName = filename;

# jos halutaan multimeshissä esim fysiikat niin laita toScenetree=true
func add(node, toScenetree):
	nodeList.push_back(node); # pos,rot,scale

	if(Globals.USE_MULTIMESH==false):
		var model = load(fileName);
		var ins = model.instance();
		ins.transform = node.transform;
		pathMM.add_child(ins);
	
	elif(toScenetree): # jos halutaan multimeshissä esim fysiikat ni lisätään obu myös scenetreehen
		var model = load(fileName);
		var ins = model.instance();
		ins.transform = node.transform;
		pathMM.add_child(ins);
		ins.hide(); # piilota koska multimeshrendaus rendaa

func endMultiMesh():
	if(Globals.USE_MULTIMESH==false): return;

	var multiMesh = MultiMesh.new()
	multiMesh.transform_format = MultiMesh.TRANSFORM_3D
	multiMesh.custom_data_format = MultiMesh.CUSTOM_DATA_NONE
	#multiMesh.color_format = MultiMesh.COLOR_FLOAT
	# TODO en saanu eri värejä toimimaan

	var model = load(fileName);
	var ins = model.instance();
	var mi : MeshInstance = ins.find_node("*");
	multiMesh.mesh = mi.mesh;
	multiMesh.instance_count = nodeList.size();
	multiMesh.visible_instance_count = nodeList.size();
	
	for i in multiMesh.visible_instance_count:
		setTransform(multiMesh, nodeList, i);

	var mmi = MultiMeshInstance.new()
	mmi.multimesh = multiMesh;
	pathMM.add_child(mmi)
	
	lists.push_back(nodeList);
	mmlists.push_back(mmi);

func setTransform(multiMesh, nodes, i):
		#multiMesh.set_instance_color(i, colors[i])
		#multiMesh.set_instance_color(i, Color(randf(), randf(), randf()));
		# ??? TODO

		var pos = nodes[i].get_translation();
		var rot = nodes[i].get_rotation();
		var scl = nodes[i].get_scale();
		var q = Quat();
		q.set_euler(rot);
		var t = Transform(q);
		var s = t.scaled(scl);
		var basis = s.basis;
		multiMesh.set_instance_transform(i, Transform(basis, pos));
		#Globals.debug(nodes[i].name + " scl: "+str(scl.x)+" "+str(scl.y)+" "+str(scl.z))

func updateMultiMesh(name, scale):
	#if(name.find("tree1")==-1 && name.find("tree2")==-1):
	#Globals.debug(" debug mm update only trees");
	#return;

	var multiMesh;
	var c=0;

	for nodelist in lists:
		multiMesh = mmlists[c];
		c += 1;
		
		for index in nodelist.size():
			if(nodelist[index] != null):
				if(nodelist[index].name == name):
					nodelist[index].set_scale(scale);
					setTransform(multiMesh, nodelist, index);
					#nodelist[index] = null; ?? TODO miks tää tääl?
					break;
