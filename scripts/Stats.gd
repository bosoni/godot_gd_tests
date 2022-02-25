extends Label

var debugEnabled = false;

func _process(_delta):
	if(Input.is_action_just_released("f12")):
		debugEnabled = !debugEnabled;

	if(debugEnabled):
		show();
		var s1 ="\n FPS: " + str(Performance.get_monitor(Performance.TIME_FPS))+"\n"
		var s2 =" RENDER_OBJECTS_IN_FRAME: " + str(Performance.get_monitor(Performance.RENDER_OBJECTS_IN_FRAME))+"\n"
		var s3 =" RENDER_VERTICES_IN_FRAME: " + str(Performance.get_monitor(Performance.RENDER_VERTICES_IN_FRAME))+"\n"
		var s4 =" RENDER_DRAW_CALLS_IN_FRAME: " + str(Performance.get_monitor(Performance.RENDER_DRAW_CALLS_IN_FRAME))+"\n"
		var s5 ="  OBJECT_COUNT: " + str(Performance.get_monitor(Performance.OBJECT_COUNT))+"\n"
		var s6 ="  OBJECT_RESOURCE_COUNT: " + str(Performance.get_monitor(Performance.OBJECT_RESOURCE_COUNT))+"\n"
		var s7 ="  OBJECT_NODE_COUNT: " + str(Performance.get_monitor(Performance.OBJECT_NODE_COUNT))+"\n\n";
		var out = s1+s2+s3+s4+s5+s6+s7;
		text = out;
	else:
		hide();
