extends Node

export(PackedScene) var bird_scene
export(PackedScene) var pipe_spawner_scene

var bird
var pipe_spawner

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD/StartButton.connect("pressed", self, "_on_StartButton_pressed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_StartButton_pressed():
	start_game()

func start_game():
	$HUD/StartButton.hide()
	$HUD/ScoreLabel/ScoreTimer.start()
	bird = bird_scene.instance()
	add_child(bird)
	pipe_spawner = pipe_spawner_scene.instance()
	add_child(pipe_spawner)
	

func show_restart_screen():
	bird.queue_free()
	pipe_spawner.queue_free()
	
