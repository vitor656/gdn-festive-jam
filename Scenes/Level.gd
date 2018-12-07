extends Node

export (bool) var isHotPotatoEnabled = false
export var HOT_POTATO_TIME = 60

onready var hotPotatoTimer = $Camera/GUI/HBoxContainer/HotPotatoTimerBar
onready var hotPotatoTimerLabel = $Camera/GUI/HBoxContainer/HotPotatoTimerBar/Counter

func _ready():	
	hotPotatoTimer.visible = isHotPotatoEnabled
	hotPotatoTimer.max_value = HOT_POTATO_TIME
	hotPotatoTimer.value = HOT_POTATO_TIME
	pass

func _process(delta):
	if isHotPotatoEnabled && hotPotatoTimer.value > 0:
		if int(hotPotatoTimer.value) == int(HOT_POTATO_TIME/3):
			hotPotatoTimerLabel.add_color_override("font_color",Color(.7,0,0))
		hotPotatoTimer.value -= delta
	pass


func _on_StartGameTimer_timeout():
	$Camera/ScreenShake.start(1)
	$Map/Objects/Doors/Door0.open()
	$PrepareToStart/StartShake.play()
