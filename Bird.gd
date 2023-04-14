extends RigidBody2D

export var flap_strength = 1
export var boost_length = 5

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var is_alive = false # whether bird is allowed to flap

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $PowerupEffect.visible:
		$PowerupEffect.set_rotation($PowerupEffect.get_rotation() + deg2rad(2000) * delta)
	
	if is_alive && Input.is_action_just_pressed("flap_keypress"):
		self.linear_velocity = Vector2.UP * flap_strength
		# Flap upward
		#self.linear_velocity.y = (Vector2.UP * flap_strength).y
		# Also stop all backward velocity when they flap, while preserving forward velocity
		#self.linear_velocity.x = max(0, self.linear_velocity.x)
	
	# If they have forward velocity, damp it. This allows me to adjust the damping for forward velocity only without affecting the damping in other directions.
	#if self.linear_velocity.x > 0:
	#	self.linear_velocity.x = self.linear_velocity.x * .99

func _on_Bird_body_entered(body):
	if body.is_in_group("pipes"):
		$BonkSound.pitch_scale = rand_range(0.4, 0.7)
		$BonkSound.play()
	if body.is_in_group("powerups"):
		body.queue_free()
		activate_powerup()
		$PowerupTimer.start(boost_length)

func activate_powerup():
	print("starting powerup")
	self.mass = 1000
	$AnimatedSprite.speed_scale = 4
	$PowerupEffect.visible = true
	# Don't restart the sound if it's already playing, e.g. we already have a powerup and are extending the time
	if !$PowerupSound.playing:
		$PowerupSound.play()
	
	# If they're behind, give them a boost forward. More boost the farther back you are.
	self.apply_central_impulse(Vector2.RIGHT * (1920-self.position.x)/2)
	
	# Also try to make the bird right-side up again. Kinda shitty implementation, but it works ok.
	self.apply_torque_impulse(-get_rotation()*300)

func deactivate_powerup():
	print("powerup over")
	self.mass = 1
	$AnimatedSprite.speed_scale = 1
	$PowerupEffect.visible = false
	$PowerupSound.stop()
