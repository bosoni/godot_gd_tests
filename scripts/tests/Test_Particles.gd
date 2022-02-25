extends Spatial

func _ready():
	blood(Vector3(-1,0,0));
	fire(Vector3(1,0,0));

func _process(_delta):
	pass

func blood(pos):
	var part = preload("res://particles/bloodParticles.tscn");
	var ins : Particles = part.instance();
	ins.set_translation(pos);
	var SC = 2; #0.5;
	ins.set_scale(Vector3(SC, SC, SC));
	#get_node("..").add_child(ins);
	add_child(ins);
	
	#ins.set_emitting(true);
	

func fire(pos):
	var part = preload("res://particles/fireParticles.tscn");
	var ins : Particles = part.instance();
	ins.set_translation(pos);
	#var SC = 3; #0.5;
	#ins.set_scale(Vector3(SC, SC, SC));
	#get_node("..").add_child(ins);
	add_child(ins);
		
	#ins.set_emitting(true);
		
