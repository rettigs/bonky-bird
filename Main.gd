extends Node

export(PackedScene) var start_screen_scene
export(PackedScene) var game_scene

var start_screen
var game

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	start_screen = $StartScreen
	start_screen.get_node("StartButton").connect("pressed", self, "_on_StartButton_pressed")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_StartButton_pressed():
	start_screen.queue_free()
	game = game_scene.instance()
	add_child(game)
	game.get_node("Bird/VisibilityNotifier2D").connect("screen_exited", self, "on_bird_leave_screen")
	game.get_node("ScoreTimer").connect("timeout", self, "increase_score")

func increase_score():
	score += 1
	game.get_node("ScoreLabel").text = str(score)

func on_bird_leave_screen():
	pass

