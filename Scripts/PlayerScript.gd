extends KinematicBody2D

onready var mobileControls = $MobileController as CanvasLayer

const MAXSPEED = 80.00
const ACCELERATION = 500.00
const FRICTION = 500.00

var velocity : Vector2 = Vector2.ZERO

func _process(delta):
	var inputVector : Vector2 = Vector2.ZERO
	inputVector = mobileControls._getInputVector()
	
	if inputVector != Vector2.ZERO:
		velocity = velocity.move_toward(inputVector * MAXSPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta) 
	
	velocity = move_and_slide(velocity)
