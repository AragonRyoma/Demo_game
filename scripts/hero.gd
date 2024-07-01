extends Node

class_name hero

var inventory: Array = []

@onready var health: int 
@onready var strength: int
@onready var wisdom: int
@onready var agility: int


func pickup_item(item : Item):
	inventory.append(item)

func remove_inventory(item : Item):
	inventory.erase(item)
	

func inventory_name() -> String:
	if inventory.size() == 0:
				return "Your pockets are empty"
	
	var item_string = ""
	for item in inventory:
		item_string += "  " + item.item_name + "\n"
		
	return item_string


