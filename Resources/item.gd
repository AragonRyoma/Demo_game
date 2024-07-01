extends Resource

class_name Item

@export var item_name := "Item name"
@export var item_type := Types.ItemTypes.KEY

var item_use = null

func initialize(item_name: String, item_type: Types.ItemTypes, item_use ):
	self.item_name = item_name
	self.item_type = item_type
	self.item_use = item_use


func item_key(item_use):
	return item_use
