extends NinePatchRect

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
#Downgrades
const HASTY = 0
const SLIPPERY = 1
const HOTPOTATO = 2

#Upgrades
const SLOWFALL = 10

func _ready():
	
	pass

func _setModifier(modifier):
	if modifier >=10:
		region_rect = Rect2(100,0,50,50)
	else:
		region_rect = Rect2(50,0,50,50)
		
	if modifier == HASTY:
		$Title.text = "HASTY"
	elif modifier == SLIPPERY:
		$Title.text = "SLIPPERY"
	elif modifier == HOTPOTATO:
		$Title.text = "HOT POTATO"
	elif modifier == SLOWFALL:
		$Title.text = "SLOWFALL"
	pass
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
