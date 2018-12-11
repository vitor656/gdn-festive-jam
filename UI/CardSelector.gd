extends MarginContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var cards = [0,0,0,0,0,0]
var upgrades = []
var downgrades = []
func _ready():
	for x in range(3):
		cards.insert(x, randi()%3) 
		cards.insert(x+3, 10)
	var i = 1
	while i <= 3:
		upgrades.insert(i-1, get_node("VBoxContainer/Upgrades/Card" + str(i)))
		upgrades[i-1]._setModifier(cards[i])
		downgrades.insert(i-1 ,get_node("VBoxContainer/Downgrades/Card" + str(i+3)))
		downgrades[i-1]._setModifier(cards[i+3])
		i += 1
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
