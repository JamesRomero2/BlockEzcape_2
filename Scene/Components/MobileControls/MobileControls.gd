extends CanvasLayer

onready var grabNDropButtonComponent = $Container/ButtonContainer/GrabNDropButton
onready var grabNDropButton = $Container/ButtonContainer/GrabNDropButton/GNDButton
onready var joyStick = $Container/JoyStickContainer/JoyStick/TouchScreenButton

var letGoTexture = preload("res://Assets/Images/LetGoButton.png")
var grabTexture = preload("res://Assets/Images/GrabButton.png")

var inputVector: Vector2 = Vector2.ZERO setget , _getInputVector
var buttonActiveState: bool = false setget _setButtonActiveState, _getButtonActiveState
var grabbingState: bool = false setget _setGrabbingState, _getGrabbingState

# PRE-DEFINED FUNCTIONS
func _ready():
	grabNDropButton.connect("pressed", self, "_onGNDButtonPressed")

# USER-DEFINE FUNCTIONS
func _onGNDButtonPressed():
	if !_getButtonActiveState(): return
	
	var tween := create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	grabNDropButtonComponent.scale = Vector2(.9, .9)
	tween.tween_property(grabNDropButtonComponent, "scale", Vector2.ONE, 0.7)
	
	_setGrabbingState(!_getGrabbingState())
	

# INPUT VECTOR - For Player Movement
func _getInputVector():
	return joyStick._getValue()

# SETGET FUNCTIONS
func _setButtonActiveState(value):
	buttonActiveState = value
	
	if !_getButtonActiveState():
		grabNDropButton.normal = grabTexture

func _getButtonActiveState():
	return buttonActiveState

func _setGrabbingState(value):
	grabbingState = value
	
	if _getGrabbingState():
		grabNDropButton.normal = letGoTexture
	else:
		grabNDropButton.normal = grabTexture

func _getGrabbingState():
	return grabbingState


