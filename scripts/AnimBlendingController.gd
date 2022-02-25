extends Node

var animtree : AnimationTree;
var isMoving := false;
var speed = 0;
var playerCameraNode;

func _ready():
	animtree = get_node_or_null("../AnimationTree");
	playerCameraNode = get_node_or_null("../../../TPSCamera");

	var animPlayer = get_node_or_null("../AnimationPlayer");
	animPlayer.get_animation("Idle").set_loop(true);
	animPlayer.get_animation("Walk").set_loop(true);
	
func _process(_delta):
	if(animtree != null):
		
		if(playerCameraNode != null):
			speed = playerCameraNode.vel.length() / 5;  # MAX_SPEED 
		
		animtree.set("parameters/Blend2/blend_amount", speed);
		
		#Globals.debug("speed = " + str(speed));
