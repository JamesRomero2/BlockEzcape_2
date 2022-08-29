extends KinematicBody2D

signal PlayerEnteredInteractableArea

var pickedUp : bool = false setget _setPickedUp, _getPickedUp
var blocksVelocity : Vector2 = Vector2.ZERO setget _setBlocksVelocity, _getBlocksVelocity
var playerInHandle: bool = false setget _setPlayerInHandle, _getPlayerInHandle
var velocity : Vector2 = Vector2.ZERO

func _process(delta):
	if _getPlayerInHandle() and _getPickedUp():
		print("Player Connection Established")
		move_and_collide(_getBlocksVelocity())
	else:
		print("Player Connection Lost")
		position = position

func _setBlocksVelocity(value):
	blocksVelocity = value

func _getBlocksVelocity():
	return blocksVelocity

# IF PLAYER IS IN THE HANDLE AREA
func _setPlayerInHandle(value):
	playerInHandle = value

func _getPlayerInHandle():
	return playerInHandle

# IF THE PLAYER TOGGLE THE PICKED BUTTON
func _setPickedUp(value):
	pickedUp = value

func _getPickedUp():
	return pickedUp

func _on_InteractableArea_body_entered(body):
	if body.name == "Player":
		print("First Checks Approve")
		_setPlayerInHandle(true)
