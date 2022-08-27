extends KinematicBody2D

onready var mobileControls = $MobileController as CanvasLayer
onready var playerLooking = $RayCast2D

const MAXSPEED = .50
const ACCELERATION = 1.00
const FRICTION = 3.00
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
		
	var objectCollided = playerLooking.get_collider()
	if playerLooking.is_colliding():
		if playerLooking.get_collider().is_in_group("Blocks") and _getPlayerIsInHandle():
			mobileControls._setButtonActiveState(true)
			if mobileControls._getGrabbingState():
				objectCollided._setPickedUp(true)
				objectCollided._setBlocksVelocity(velocity)
			print("Second Checks Approve")
		else:
			mobileControls._setButtonActiveState(false)
			mobileControls._setGrabbingState(false)
			objectCollided._setPickedUp(false)
			objectCollided._setBlocksVelocity(Vector2.ZERO)
			print("Button Unactive")

# SETGET METHODS
func _setPlayerIsInHandle(value):
	playerIsInHandle = value

func _getPlayerIsInHandle():
	return playerIsInHandle
