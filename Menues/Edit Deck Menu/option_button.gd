extends OptionButton

@export var parent:EditDeck

func _ready() -> void:
	var delimiterDict:Dictionary = parent.delimiterDict
	# 1. Get the primary dropdown popup menu of the OptionButton
	var main_menu: PopupMenu = get_popup()
	# 2. Add regular items to the main menu
	for item in delimiterDict:
		var newItem:String = delimiterDict[item].display
		main_menu.add_item(newItem)
	select(0)
