extends CanvasLayer

onready var joyStick = $JoyStick
onready var backgroundCircle = $JoyStick/Background
onready var foregroundCircle = $JoyStick/Background/Foreground
onready var maxDistance = $JoyStick/CollisionShape2D.shape.radius

var joyStickActive = false

func _input(event):
	if event is InputEventScreenTouch and event.index == 0:
		var distance = event.position.distance_to(backgroundCircle.global_position)
		if not joyStickActive:
			if distance < maxDistance:
				joyStickActive = true
				foregroundCircle.visible = true
		else:
			foregroundCircle.position = Vector2.ZERO
			joyStickActive = false	
			foregroundCircle.visible = false

func _process(delta):
	if joyStickActive:
		foregroundCircle.global_position = joyStick.get_global_mouse_position()
		foregroundCircle.position = backgroundCircle.position + (foregroundCircle.position - backgroundCircle.position).clamped(maxDistance)

func _getVelocity():
	var joystickVelocity = Vector2.ZERO
	joystickVelocity.x = foregroundCircle.position.x / maxDistance
	joystickVelocity.y = foregroundCircle.position.y / maxDistance
	return joystickVelocity

#
#onready var maxDistance = $TouchScreenButton.shape.radius
#
#var moveVector = Vector2.ZERO
#var joyStickActive = false
#
#
#func _input(event):
#	if event is InputEventScreenTouch or event is InputEventScreenDrag:
#		if $TouchScreenButton.is_pressed() and event.index == 0:
#			moveVector = _calculateMoveVector(event.position)
#			joyStickActive = true
#			$InnerJoyStick.position = event.position
#			$InnerJoyStick.position.clamped(maxDistance)
#			$InnerJoyStick.visible = true
#
#	if event is InputEventScreenTouch:
#		if event.pressed == false:
#			joyStickActive = false
#			$InnerJoyStick.visible = false
#
#func _physics_process(delta):
#	if joyStickActive:
#		emit_signal("useMoveVector", moveVector)
#
#func _calculateMoveVector(eventPosition):
#	var texture_center = $TouchScreenButton.position + Vector2(38.4, 38.4)
#	return(eventPosition - texture_center).normalized()
