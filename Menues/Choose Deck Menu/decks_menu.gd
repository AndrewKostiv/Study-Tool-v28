class_name DecksMenu extends Control

@onready var user_input: UserInput = %UserInput
@onready var deck_buttons_container: VBoxContainer = %"Deck Buttons container"
const DECK_BUTTON = preload("uid://cxwtdnvuepgt3")

func _ready() -> void:
	drawDeckButtons()

func _on_user_input_text_submitted(newName: String) -> void:
	addDeck(newName)

func addDeck(newName:String) -> void:
	var newDeck = Deck.new(newName)
	Global.data.decks.append(newDeck)
	Global.saveData()
	drawDeckButtons()

func removeDeck(deck:Deck) -> void:
	Global.data.decks.erase(deck)
	Global.saveData()
	drawDeckButtons()

func drawDeckButtons():
	_clearDeckButtons()
	for deck:Deck in Global.data.decks:
		var newDeckButton:DeckButton = DECK_BUTTON.instantiate()
		deck_buttons_container.add_child(newDeckButton)
		newDeckButton.setData(deck)
		newDeckButton.removeDeck.connect(removeDeck)

func _clearDeckButtons():
	for deckButton:DeckButton in deck_buttons_container.get_children(0):
		deckButton.queue_free()
