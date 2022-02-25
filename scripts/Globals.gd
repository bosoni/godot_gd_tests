extends Node

const VERSION := "0.1.211222"; # year month day

onready var root : Node = get_tree().get_root();
onready var env : WorldEnvironment = root.get_node_or_null("Test/WorldEnvironment"); # WorldEnvironment node

onready var Module = load("res://scripts/Module.gd").new();

var USE_MULTIMESH = true;

var gameRunning := false;
var mouseClicked := false;

var modelCache = {}

static func showTree():
	Globals.root.print_tree_pretty();
	
static func debug(msg):
	print("[DEBUG]: ", msg);
	

func loadTxt(name):
	var f = File.new()
	if(f.open(name, File.READ)!=OK):
		Globals.debug("Can't open file: "+name);
		return "";
	var strr = f.get_line();
	f.close();
	return strr;

func saveTxt(name, strr):
	var f = File.new()
	if(f.open(name, File.WRITE)!=OK):
		Globals.debug("Can't save file: "+name);
		return;
	f.store_string(strr);
	f.close();
