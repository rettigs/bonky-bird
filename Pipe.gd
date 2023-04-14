extends Node

export var pipe_speed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	self.linear_velocity = Vector2.LEFT * pipe_speed

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Pipe_body_entered(body):
	if body.is_in_group("pipes"):
		$BongSound.pitch_scale = rand_range(0.5, 0.9)
		$BongSound.play()
