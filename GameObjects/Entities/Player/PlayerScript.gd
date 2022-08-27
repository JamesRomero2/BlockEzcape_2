extends KinematicBody2D

onready var mobileControls = $MobileController as CanvasLayer
onready var playerLooking = $RayCast2D

const MAXSPEED = .3
const ACCELERATION = 1.00
const FRICTION = 4.00
const PICKUPRADIUS = 16
const LOOKLENGTH = 15

var velocity: Vector2 = Vector2.ZERO
var playerIsInHandle: bool = false setget _setPlayerIsInHandle, _getPlayerIsInHandle

func _ready():
	playerLooking.set_cast_to(Vector2.DOWN * LOOKLENGTH)

func _process(delta):
	var inputVector : Vector2 = Vector2.ZERO
	inputVector = mobileControls._getInputVector()
	
	_rotateRaycast(inputVector)
	
	if inputVector != Vector2.ZERO:
		velocity = velocity.move_toward(inputVector * MAXSPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta) 
	
	move_and_collide(velocity)

func _rotateRaycast(vector: Vector2):
	if vector == Vector2.ZERO or mobileControls._getGrabbingState():
		playerLooking.set_cast_to(playerLooking.get_cast_to())
	else:
		playerLooking.set_cast_to(vector * LOOKLENGTH)
	
	if playerLooking.is_colliding():
		if playerLooking.get_collider().is_in_group("Blocks") and _getPlayerIsInHandle():
#			print("Second Checks Approve")
			mobileControls._setButtonActiveState(true)
			if mobileControls._getGrabbingState():
				var pickedUpBox = playerLooking.get_collider()
				pickedUpBox._setBlocksVelocity(velocity)
				pickedUpBox._setPickedUp(true)
	else:
		mobileControls._setButtonActiveState(false)

# SETGET METHODS
func _setPlayerIsInHandle(value):
	playerIsInHandle = value

func _getPlayerIsInHandle():
	return playerIsInHandle
