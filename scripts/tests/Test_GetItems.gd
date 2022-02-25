extends Spatial

var map;

func _ready():
	map = RandomMap.new();

	var CNT = 1000;

	# 1.tapa
	#for q in CNT: map.createRandomMap(get_node("."), 1, 150);

	# 2.tapa
	map.createRandomMap(get_node("."), CNT, 150);


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

 TODO
"""
	tsekataan pelaaja osuuko sieneen ja otetaan se sit..
	
	lasketaanko etäisyys ite vai käytetäänkö bulletin tsekkaust,
	miten tein  muumissa  sen?


"""
