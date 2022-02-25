extends Particles

func _ready():
	#get_node("Timer").connect("timeout", self, "dispose");
	$Timer.connect("timeout", self, "dispose");
	set_emitting(true);
	
func dispose():
	Globals.debug("dispose blood particles");
	queue_free();
