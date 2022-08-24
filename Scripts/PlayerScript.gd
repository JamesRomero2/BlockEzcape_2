extends KinematicBody2D

onready var mobileControls = $MobileController

func _process(delta):
	move_and_slide(mobileControls._getVelocity() * 50)
