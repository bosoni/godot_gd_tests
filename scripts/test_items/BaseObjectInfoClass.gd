class_name BaseObjectInfoClass

var name := "";
var modelName := "";
var scriptName := "";

var pos := Vector3();
var rot := Vector3();
var scale := Vector3(1,1,1);

var color = null;

# tätä vähennetään kun hakataan esim puuta. myös nuotion koko
var life := 0.0; 

var weight := 1;

func _init():
	scriptName = get_script().get_path();

func action():
	pass

func getObject():
	pass
