class_name EditDeck extends Control

@onready var deck:Deck = Global.data.activeDeck
@export var deck_name: LineEdit
@export var cards_container: VBoxContainer
@export var delimiterButton: OptionButton
@export var string_parce_text_edit: TextEdit
const CARD_DISPLAY = preload("uid://bdstxtccagjn3")
const DEFAULT_DELIMITER:String = ";"
var selectedDelimiter: String = DEFAULT_DELIMITER
const delimitersList:Array[String] = [";", ":", "|", ","]
const delimiterDict:Dictionary = {
	"semi-colin": {
		"display" : '";" (Semi-colin)',
		"delimiter" : ";",
	},
	"comma": {
		"display" : '"," (comma)',
		"delimiter" : ",",
	},
	"pipe": {
		"display" : '"|" (Pipe)',
		"delimiter" : "|",
	},
	"colin": {
		"display" : '":" (Colin)',
		"delimiter" : ":",
	},
}

func _ready() -> void:
	deck_name.text = deck.deckName
	reDrawCards()

func _on_back_pressed() -> void:
	Global.saveData()
	SceneManager.changeSceneTo(SceneManager.DECKS_MENU)

func _on_deck_name_text_changed(new_text: String) -> void:
	deck.deckName = new_text

func _on_add_card_pressed() -> void:
	deck.cards.append(Card.new())
	Global.saveData()
	reDrawCards()

func reDrawCards() -> void:
	for card:CardDisplay in cards_container.get_children():
		card.queue_free()
	for card:Card in deck.cards:
		var newCardDisplay:CardDisplay = CARD_DISPLAY.instantiate()
		cards_container.add_child(newCardDisplay)
		newCardDisplay.setData(card)
		newCardDisplay.removeCard.connect(removeCard)

func removeCard(cardToRemove:Card):
	deck.cards.erase(cardToRemove)
	Global.saveData()
	reDrawCards()

func _on_option_button_item_selected(index: int) -> void:
	selectedDelimiter = delimitersList[index]

func _on_parce_string_add_pressed() -> void:
	var parced_by_card: = string_parce_text_edit.text.split("\n", false)
	for line:String in parced_by_card:
		var parced_by_qa = line.split(selectedDelimiter)
		var newCard:Card = Card.new(parced_by_qa[0].strip_edges(), parced_by_qa[1].strip_edges())
		deck.cards.append(newCard)
	Global.saveData()
	string_parce_text_edit.clear()
	reDrawCards()

func _on_parce_string_clear_pressed() -> void:
	string_parce_text_edit.clear()
