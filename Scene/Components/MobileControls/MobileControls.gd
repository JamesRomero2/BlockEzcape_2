extends CanvasLayer

signal buttonPressed

onready var grabNDropButtonComponent = $Container/ButtonContainer/GrabNDropButton
onready var grabNDropButton = $Container/ButtonContainer/GrabNDropButton/GNDButton
onready var joyStick = $Container/JoyStickContainer/JoyStick/TouchScreenButton

var letGoTexture = preload("res://Assets/Images/LetGoButton.png")
var grabTexture = preload("res://Assets/Images/GrabButton.png")

# For Directions
var inputVector: Vector2 = Vector2.ZERO setget , _getInputVector

# If the button is clickable
var buttonClickable: bool = false setget _setButtonClickable, _getButtonClickable

# For Toggling Button States
var grabbingState: bool = false setget _setGrabbingState, _getGrabbingState

# PRE-DEFINED FUNCTIONS
func _ready():
	grabNDropButton.connect("pressed", self, "_onGNDButtonPressed")

# USER-DEFINE FUNCTIONS
func _onGNDButtonPressed():
	if _getButtonClickable():
		_buttonUIToggle()
		_setGrabbingState(!_getGrabbingState())
		emit_signal("buttonPressed", _getGrabbingState())

func _buttonUIToggle():
	var tween := create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	grabNDropButtonComponent.scale = Vector2(.9, .9)
	tween.tween_property(grabNDropButtonComponent, "scale", Vector2.ONE, 0.7)
	
	if _getGrabbingState():
		grabNDropButton.normal = letGoTexture
	else:
		grabNDropButton.normal = grabTexture


# INPUT VECTOR - For Player Movement
func _getInputVector():
	return joyStick._getValue()

# SETGET FUNCTIONS
func _setButtonClickable(value):
	buttonClickable = value

func _getButtonClickable():
	return buttonClickable

func _setGrabbingState(value):
	grabbingState = value

func _getGrabbingState():
	return grabbingState
