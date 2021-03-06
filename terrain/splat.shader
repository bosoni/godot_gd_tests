// https://www.youtube.com/watch?v=RLAG4RbT-5U

shader_type spatial;

uniform sampler2D splatmap;
uniform sampler2D sand;
uniform sampler2D earth;
uniform sampler2D rock;

uniform float sandres = 10;
uniform float earthres = 10;
uniform float rockres = 10;

void fragment() 
{
	vec3 sandcolor;
	vec3 earthcolor;
	vec3 rockcolor;
	vec3 splatmapcolor;
	 
	splatmapcolor = texture(splatmap, UV).rgb;
	 
	sandcolor = texture(sand, UV * sandres).rgb * splatmapcolor.r;
	earthcolor = texture(earth, UV * earthres).rgb * splatmapcolor.g;
	rockcolor = texture(rock, UV * rockres).rgb * splatmapcolor.b;
	 
	ALBEDO = sandcolor + earthcolor + rockcolor;
}
