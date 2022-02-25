extends Spatial

var rightMouseClicked = false;
var ray_length = 1000;
var spaceState;
var camera;
var DECIMALS=2;

var groundName = "Ground2SB";

var modelNames = ["Target",
	"Mushroom2SB","Mushroom2SB","Mushroom2SB",
	"Tree1","Tree2",
	"RockSB"]
var scriptNames = ["",
	"ObjectInfo_Mushroom1", "ObjectInfo_Mushroom2", "ObjectInfo_Mushroom3",
	"ObjectInfo_Tree1", "ObjectInfo_Tree2",
	"ObjectInfo_Rock1"]
	
var models = []
var map = []
var types = {}
var selected = 1;
var target;

var sscale = 1;
var rot = 0;
var spawnMode = 1; # 1=to ground, 2=modelei voi pistää toistensa päälle
var init=false;

func _ready():
	pass
	
func initEditor():
	var gm = load("res://models/"+groundName+".tscn"); # lataa ja aseta maasto
	var ins = gm.instance();
	ins.name = "Ground";
	get_node("..").add_child(ins);
	
	camera = get_node("../Player/Rotation_Helper/Camera");
	spaceState = get_world().direct_space_state;
	var c=0;
	for s in modelNames:
		Globals.debug("load "+s);
		var model = load("res://models/" + s + ".tscn");
		models.push_back(model);

	target = models[1].instance();
	get_node("../Ground").add_child(target);
	showSelected();

func showSelected():
	var strr = "Selected: "+str(selected)+ "/"+str(models.size()-1) + ": " + modelNames[selected];
	get_node("../selectedLabel").text = strr;

func _process(delta):
	if(init==false):
		initEditor();
		init=true;

	if(Input.is_action_just_released("f5")):
		save();
	
	if(Input.is_action_just_released("f1")):
		if(spawnMode==1):
			spawnMode=2;
		else:
			spawnMode=1;
	
	if(Input.is_key_pressed(KEY_Z)):
		sscale-=delta * 1.5;
	if(Input.is_key_pressed(KEY_X)):
		sscale+=delta * 1.5;
	sscale = clamp(sscale, 0.01, 10);

	if(Input.is_key_pressed(KEY_C)):
		rot-=delta * 100;
	if(Input.is_key_pressed(KEY_V)):
		rot+=delta * 100;
	#rot = clamp(rot, 0, 360);

	get_node("../scaleLabel").text = "[X,Z] Scale: "+str(sscale).pad_decimals(DECIMALS);
	get_node("../rotLabel").text = "[C,V] RotateY: "+str(rot).pad_decimals(DECIMALS);
	var strr="[F1] SpawnMode: ";
	if(spawnMode==1):
		strr += "to ground";
	else:
		strr += "everywhere"
	get_node("../spawnLabel").text =strr;
	
	
	Globals.mouseClicked = false;
	if(Input.is_action_just_released("click")): # Left mouse button released.
		Globals.mouseClicked = true;
	if(Input.is_action_just_released("rightmouse")): # Right mouse button released.
		rightMouseClicked = true;
	
	var mpos = get_viewport().get_mouse_position();
	var from = camera.project_ray_origin(mpos);
	var to = from + camera.project_ray_normal(mpos) * ray_length;
	var result;
	if(spawnMode==1):
		map.push_back(target);
		result = spaceState.intersect_ray(from, to, map);
		map.erase(target);
	else:
		result = spaceState.intersect_ray(from, to, [target]);
		
	if(result):
		target.set_translation(result.position);
		target.set_scale(Vector3(sscale, sscale, sscale));
		target.set_rotation(Vector3(0, deg2rad(rot), 0));
		if(Globals.mouseClicked):
			var ins = models[selected].instance();
			ins.set_translation(result.position);
			ins.set_scale(Vector3(sscale, sscale, sscale));
			ins.set_rotation(Vector3(0, deg2rad(rot), 0));

			map.push_back(ins);
			get_node("../Ground").add_child(ins);
			Globals.debug(ins.name + " added");
			
			types[ins.name] = selected;
				
		if(rightMouseClicked): # remove
			rightMouseClicked=false;
			if(spawnMode==1):
				# tämä koska eka raycast ei löytänyt kuin maaston tällä modella
				result = spaceState.intersect_ray(from, to, [target]); 
			var n : String = result.collider.name;
			Globals.debug("Remove "+n);
			if(n.find("Plane")==-1):
				map.erase(result.collider);
				types.erase(result.collider.name);
				result.collider.queue_free();

				Globals.debug("Removed.");
		
	# vaihda obua
	var add=0;
	if(Input.is_action_just_released("plus")):
		add = 1;
	if(Input.is_action_just_released("minus")):
		add = -1;
	if(add!=0):
		selected += add;
		selected = clamp(selected, 0, models.size()-1);
		if(selected == 0):
			selected = 1;
		showSelected();
		
		# vanha pois
		get_node("../Ground/" + target.name).queue_free();
		target = models[selected].instance();
		# uus tilalle
		get_node("../Ground").add_child(target);
		
		

func save():
	Globals.debug("Saving map.txt");
	var strr = "";
	
	strr += "res://models/"+groundName+".tscn #scene";
	
	var c=0;
	for n in map:
		c+=1;
		strr += modelNames[types[n.name]] + str(c) +"\n";
		strr += scriptNames[types[n.name]] + str(c) +"\n";
		var v = n.get_translation();
		strr += str(v.x)+" "+str(v.y).pad_decimals(DECIMALS)+" "+str(v.z).pad_decimals(DECIMALS)+" #pos\n";
		v = n.get_rotation();
		strr += str(v.x)+" "+str(v.y).pad_decimals(DECIMALS)+" "+str(v.z).pad_decimals(DECIMALS)+" #rot\n";
		v = n.get_scale();
		strr += str(v.x)+" "+str(v.y).pad_decimals(DECIMALS)+" "+str(v.z).pad_decimals(DECIMALS)+" #scale\n";

	Globals.debug(strr);

	var f = File.new()
	f.open("map.txt", File.WRITE);
	f.store_string(strr);
	f.close();
	Globals.debug("Saved.");
