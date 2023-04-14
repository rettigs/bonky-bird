extends Node

export var pipe_speed = 1
var velocity_last_tick = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	self.linear_velocity = Vector2.LEFT * pipe_speed

func _physics_process(delta):
	self.velocity_last_tick = self.linear_velocity

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Pipe_body_entered(body):
	if body.is_in_group("bird"):
		# Only let bonk sound play if collision was hard enough, and make it louder for harder collisions
		var velocity_diff_x = abs(self.linear_velocity.x - velocity_last_tick.x)
		var velocity_diff_y = abs(self.linear_velocity.y - velocity_last_tick.y)
		var velocity_diff_sum = velocity_diff_x + velocity_diff_y
		#print("velocity diff sum: %s" % str(velocity_diff_sum))
		if velocity_diff_sum > 50:
			# 10 is good "normal" volume, 20 should be max or you get clipping (it usually goes over 20 when using a powerup)
			var bonk_db = clamp(range_lerp(velocity_diff_sum, 0, 200, 0, 10), 0, 20)
			$BonkSound.volume_db = bonk_db
			$BonkSound.pitch_scale = rand_range(0.4, 0.7)
			$BonkSound.play()
	if body.is_in_group("pipes"):
		$BongSound.pitch_scale = rand_range(0.5, 0.9)
		$BongSound.play()
