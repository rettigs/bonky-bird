extends CanvasLayer

export var score = 0
export var isCounting = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	# Also allow pressing spacebar to do the same thing as pressing the button
	if Input.is_action_just_released("flap_keypress"):
		$StartButton.emit_signal("pressed")

func _on_ScoreTimer_timeout():
	score += 1
