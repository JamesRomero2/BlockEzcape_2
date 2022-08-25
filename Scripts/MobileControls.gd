extends CanvasLayer

onready var grabNDropButton = $Container/Control/GrabNDropButton as TouchScreenButton
onready var joyStick = $Container/JoyStick/TouchScreenButton

var grabbing : bool = false setget _setGrabbing, _getGrabbing
var letGoTexture = preload("res://Assets/Images/LetGoButton.png")
var grabTexture = preload("res://Assets/Images/GrabButton.png")

func _getInputVector():
	return joyStick._getValue()

func _on_TouchScreenButton_pressed():
	_setGrabbing(!grabbing)

func _setGrabbing(value):
	grabbing = value
	displayButton(grabbing)
	
func _getGrabbing():
	return grabbing

func displayButton(grabbingState: bool):
	if grabbingState:
		grabNDropButton.normal = letGoTexture
	else:
		grabNDropButton.normal = grabTexture
