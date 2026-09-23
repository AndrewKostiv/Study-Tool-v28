class_name Deck extends Resource

@export var deckName:String
@export var cards:Array[Card] = []

func _init(newDeckName:String = "", newCards:Array[Card] = []) -> void:
	deckName = newDeckName
	cards = newCards

func getCard() -> Card:
	return cards.pick_random()
