extends Node

export(PackedScene) var start_screen_scene
export(PackedScene) var game_scene

var start_screen
var game

var is_game_active = false
var score = 0
var high_score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	start_screen = $StartScreen
	start_screen.get_node("StartButton").connect("pressed", self, "_on_StartButton_pressed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_StartButton_pressed():
	# Clear out the previous game object first if it existed
	if game:
		game.queue_free()
	
	is_game_active = true
	score = 0
	start_screen.queue_free()
	game = game_scene.instance()
	add_child(game)
	game.get_node("Bird/VisibilityNotifier2D").connect("screen_exited", self, "on_bird_leave_screen")
	game.get_node("ScoreTimer").connect("timeout", self, "increase_score")

func increase_score():
	if is_game_active:
		score += 1
		game.get_node("ScoreLabel").text = str(score)

func on_bird_leave_screen():
	is_game_active = false
	start_screen = start_screen_scene.instance()
	add_child(start_screen)
	start_screen.get_node("StartButton").connect("pressed", self, "_on_StartButton_pressed")
	
	if score > high_score:
		high_score = score
		start_screen.get_node("Message").text = "New high score!\nYou got: %s\nTry again?" % high_score
	else:
		start_screen.get_node("Message").text = "Too bad!\nHigh score is: %s\nTry again?" % high_score


