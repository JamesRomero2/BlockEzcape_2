extends KinematicBody2D

onready var mobileControls = $MobileController as CanvasLayer
onready var playerLooking = $RayCast2D

const MOVESPEED = 100.00
const LOOKLENGTH = 15

var velocity: Vector2 = Vector2.ZERO

func _ready():
	mobileControls.connect("buttonPressed", self, "_onButtonToggle")
	playerLooking.set_cast_to(Vector2.DOWN * LOOKLENGTH)

func _process(delta):
	var inputDirection : Vector2 = Vector2.ZERO
	inputDirection = mobileControls._getInputVector()
	
	_rotateRaycast(inputDirection)
	
	velocity = inputDirection * MOVESPEED
	
	velocity = move_and_slide(velocity)

func _rotateRaycast(vector: Vector2):
	if vector == Vector2.ZERO or mobileControls._getGrabbingState():
		playerLooking.set_cast_to(playerLooking.get_cast_to())
	else:
		playerLooking.set_cast_to(vector * LOOKLENGTH)
	
#	if playerLooking.is_colliding():
#		if playerLooking.get_collider().is_in_group("Blocks") and _getPlayerIsInHandle():
#			playerLooking.get_collider()._setBlocksVelocity(vector)
#			mobileControls._setButtonActiveState(true)
#			print("Second Checks Approve")
#	else:
#		mobileControls._setButtonActiveState(false)

func _onButtonToggle(passedValue: bool):
	pass
