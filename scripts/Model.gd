class_name Model

# monenko framen välein päivitetään objektit (tsekataan näkyykö vai ei)
var UPDATE_OBJECTS = 2;
var MAXLEN = 10*10; # len^2  kuinka kaukana olevat objektit piilotetaan
var hidden = [] # temp taulukko objekteille
var rcounter=0;

static func load(modelName, pos, rot, scale, parent):
	Globals.debug("load " + modelName);
	
	var model;
	if(Globals.modelCache.has(modelName)):
		model = Globals.modelCache[modelName];
	else:
		model = load(modelName);
		Globals.modelCache[modelName] = model;

	var ins = model.instance();
	ins.name = modelName;
	ins.set_translation(pos + ins.get_translation());
	ins.set_rotation(rot);
	ins.set_scale(scale);
	parent.add_child(ins);
		
static func changeTexture(ins, newTextureName, instanceName=""):
	var mat = SpatialMaterial.new();
	var tex = load("res://" + newTextureName);
	mat.albedo_texture = tex;
	
	var mi : MeshInstance;
	if(instanceName!=""):
		mi = ins.find_node(instanceName);
	else:
		for c in ins.get_child_count():
			mi = ins.get_child(c);
			mi.material_override = mat;

func changeColor(ins, newColor, instanceName=""):
	var mat = SpatialMaterial.new();
	mat.albedo_color = newColor;
	
	var mi : MeshInstance;
	if(instanceName!=""):
		mi = ins.find_node(instanceName);
	else:
		for c in ins.get_child_count():
			mi = ins.get_child(c);
			mi.material_override = mat;

func makeLists(renderOnlyNearObjects:bool, useLOD:bool):
	"""
		lod?   miten tää ees toteutettais?
		   nyt on  modelCache ni pitäiskö olla myös  modelCacheLOD1, modelCacheLOD2,
		   ja rendatessa lasketaan etäisyys kameraan ja tsekataan löytyykö noist modelCacheLOD* dicteistä model, ellei ni rendataan normimodel.
		   
		   ja kaukana olevat valot vois himmentää ja poistaa kokonaan jos tarpeeks kaukana.

	valot löytää?
		var n = gn.get_node("/root/objs").find_node("light*", true, false);
		if(n==null):
			continue;

TODO

	"""	
	pass

func renderOnlyNearObjects():
	rcounter+=1;
	if(rcounter >= UPDATE_OBJECTS): # ei tsekata joka framella
		rcounter=0;
	else:
		return;
	var gn = Globals.root.get_node("/root/objs");
	if(Globals.player.alive == false):
		for p in gn.get_children():
			p.show();
	else:
		var camera = Globals.player.bodyKB.get_node("3rdCamera/InnerGimbal/Camera");
		for p in gn.get_children():
			var l = p.get_translation() - Globals.player.pos;
			var llen = l.length_squared();
			if(llen >= MAXLEN):
				p.hide();
			else:
				p.show();


func renderOnlyNearObjects_RemoveHidden(camera):
	rcounter+=1;
	if(rcounter >= UPDATE_OBJECTS): # ei tsekata joka framella
		rcounter=0;
	else:
		return;
	var gn = Globals.root.get_node("/root/objs");
	if(Globals.player.alive == false):
		for p in hidden:
			gn.add_child(p);
			hidden.erase(p);
		for p in gn.get_children():
			p.show();
	else:
		"""
		tsekkaa kaik obut hidden taulukosta onko lähellä ja kameran edessä,
		jos on, lisää takas sceneen.
		"""
		for p in hidden:
			var l2 = p.get_translation() - Globals.player.pos;
			var llen2 = l2.length_squared();
			if(llen2 < MAXLEN && !camera.is_position_behind(p.get_translation())):
				gn.add_child(p);
				hidden.erase(p);
	
		"""
		jos objekti liian kaukana kamerasta tai kameran takana,
		laita se hidden taulukkoon ja poista se scenestä.
		"""
		for p in gn.get_children():
			var l = p.get_translation() - Globals.player.pos;
			var llen = l.length_squared();
			if(llen >= MAXLEN || camera.is_position_behind(p.get_translation())):
				hidden.push_back(p);
				gn.remove_child(p);
