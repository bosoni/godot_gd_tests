extends Spatial

var bullet : Model;

func _ready():
	""""
		var tmp = preload("res://prefabs/rock1_RB.tscn");
		#var tmp = preload("res://prefabs/tree1_RB.tscn");
		
		var ins : RigidBody = tmp.instance();
		ins.mode = RigidBody.MODE_RIGID;
		
		var V = 5;
		ins.set_translation(Vector3(rand_range(-V, V), rand_range(3, V), rand_range(-V, V)));
		ins.set_scale(Vector3(0.2, 0.2, 0.2));
	"""

func _process(delta):
	if(Input.is_action_pressed("ui_select")): # space
		
		#load(modelName, pos, rot, scale, parent):
		bullet.load("res://prefabs/rock1_RB.tscn", );
		
* TEST: ampuu kiven katsomissuuntaan (hiiren koordinaateista target ja sinne)
	Globals.player.forward = Player.get_global_transform().basis.z;
		
		
		# TODO  
		pass

