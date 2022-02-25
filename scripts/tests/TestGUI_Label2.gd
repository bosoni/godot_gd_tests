extends Label

var txt = "Moro dorkki. Tää o tämmöne dork testi jou!";
var pos = 0;

func _ready():
	pass

func _process(delta):
	pos += delta*8;
	var t = txt.substr(0, pos);
	text = t;
	
	if(pos > txt.length()+10):
		pos=0;

	Globals.debug("" + t);
