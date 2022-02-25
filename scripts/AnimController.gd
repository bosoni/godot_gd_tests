extends Node

var animPlayer : AnimationPlayer;
var isMoving := false;
var speed = 0;

func _ready():
	# jos modelilla animationtree, poista se (muuten ei animaatiot näy)
	# (mutta jos modelilla on animationtree niin olis parempi käyttää AnimBlendingController skriptiä)
	var animtree = get_node_or_null("../AnimationTree");
	if(animtree != null):
		get_node("../AnimationTree").queue_free();
		Globals.debug("animationtree removed");

	animPlayer = get_node("../AnimationPlayer");
	if(animPlayer==null): Globals.debug("cant find animplayer");

func _process(_delta):
	if(animPlayer != null):
		var anim_to_play = "Idle";
		if(isMoving):
			anim_to_play = "Walk";
			
		var current_anim = animPlayer.get_current_animation();
		if(current_anim != anim_to_play):
			animPlayer.play(anim_to_play);
