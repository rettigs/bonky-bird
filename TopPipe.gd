extends RigidBody2D

export var pipe_speed = 1


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.linear_velocity = Vector2.LEFT * pipe_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
