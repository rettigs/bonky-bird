extends Node

export(PackedScene) var pipe_scene
export(PackedScene) var powerup_scene

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func spawn_pipe_pair():
	var top_pipe = pipe_scene.instance() 
	var bottom_pipe = pipe_scene.instance()
	
	randomize()
	var opening_size = rand_range(100,700)
	
	# Screen goes from 0 to 1080, top to bottom. Cut off 80 so you can always see the pipe.
	var opening_top_location = rand_range(80, 1000 - opening_size)
	
	var opening_bottom_location = opening_top_location + opening_size
	# Top pipe goes from -600 to 480 (top to bottom) when just barely off screen
	top_pipe.position.y = opening_top_location - 600
	# Bottom pipe goes from 600 to 1680 (top to bottom) when just barely off screen
	bottom_pipe.position.y = opening_bottom_location + 600
	
	add_child(top_pipe)
	add_child(bottom_pipe)
	
	# Randomly spawn a powerup between the pipes
	if rand_range(0, 100) <= 10:
		var powerup = powerup_scene.instance()
		powerup.position.y = opening_top_location + (opening_size/2)
		powerup.position.x = top_pipe.position.x
		add_child(powerup)
