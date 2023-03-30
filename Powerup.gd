extends RigidBody2D

export var speed = 1


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.linear_velocity = Vector2.LEFT * speed
